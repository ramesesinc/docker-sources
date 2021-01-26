const cache = require('./gdx-cache');
const debug = require('debug')('gdx');
const gdxChannel = 'gdx';

let io; 
let partners;

const EVENT = {
    connection: 'connection',
    disconnection: 'disconnection',
    activate: 'activate',
    deactivate: 'deactivate',
    invoke: 'invoke',
    register_service: 'register_service',
    get_service: 'get_service',
    register_partner: 'register_partner',
    get_partners: 'get_partners',
};

const setIo = (sio) => {
    io = sio;
};

const getIo = () => {
    return io;
}

const log = (channel, action) => {
    debug('logging ' + action + ' on channel ' + channel);
    let partner = partners.find(p => p.channel === channel);
    if (partner) {
        switch(action) {
            case EVENT.connection: 
                partner.consumer += 1;
                break;
            case EVENT.disconnection:
                if (partner.consumer > 0) {
                    partner.consumer -= 1;
                }
                break;
        }
    }
}

const invokeAction = (io, socket, params, callback) => {
    let nsp = '/' + params.channel;
    let targetSockets = io.of(nsp).sockets;
    if (Object.keys(targetSockets).length == 0) {
        throw {
            status: 'ERROR',
            msg: 'Partner server is currently not available'
        }
    }

    for (let prop in targetSockets) {
        if (Object.prototype.hasOwnProperty.call(targetSockets, prop)) {
            let targetSocket = targetSockets[prop];
            debug('invoking ' + params.service + '.' + params.method + ' on partner ' + targetSocket.nsp.name);
            targetSocket.emit(EVENT.invoke, params, (res) => {
                if (res.status === 'OK') {
                    res.data = JSON.parse(res.data);
                }
                callback(res);
            }); 
        }
    }
};

const registerPartner = (io, partner) => {
    cache.initPartner(partner);

    let channel = '/' + partner.channel;
    debug('Channel ' + channel + ' created');

    let nsp = io.of(channel);
    nsp.on(EVENT.connection, (socket) => {
        const channel = socket.nsp.name.replace('/', '');
        log(channel, EVENT.connection);
        debug('Partner ' + channel + ' connected');
        socket.on(EVENT.invoke, async (params, callback) => {
            try {
                invokeAction(io, socket, params, callback);
            } catch (error) {
                debug(error);
                callback(error);
            }
        }); 

        socket.on(EVENT.register_service, async (data) => {
            cache.saveServices(data);
            debug('service registration completed');
        });

        socket.on(EVENT.get_service, async (name, callback) => {
            let service = await cache.findService(name);
            callback(service);
        });

        socket.on('disconnect', (info) => {
            log(channel, EVENT.disconnection);
            debug('Partner ' + channel + ' disconneted');

            cache.deactivatePartner(channel, (calls) => {
                if (calls == 0) {
                    io.of(`/${gdxChannel}`).emit(EVENT.deactivate, channel);
                    debug('broadcast partner ' + channel + ' deactivation');
                }
            });
        });

        cache.activatePartner(channel, (calls) => {
            io.of(`/${gdxChannel}`).emit(EVENT.activate, channel);    
            debug('broadcast partner ' + channel + ' activation');
        });
    });
};

const registerPartners = async (io) => {
    partners = await cache.getPartners('partner:*');
    partners.forEach((partner) => {
        partner.consumer = 0;
        registerPartner(io, partner);
    });

    let gdx = partners.find(partner => partner.channel === gdxChannel);
    if (gdx == undefined) {
    	gdx = {name: gdxChannel, channel: gdxChannel, consumer: 0}
    	registerPartner(io, gdx); 
    }
    debug('Partners are successfully registered');
};

const getPartners = () => {
    return partners;
}

module.exports = {
    registerPartners: registerPartners,
    registerPartner: registerPartner,
    setIo: setIo,
    getIo: getIo,
    getPartners: getPartners
};


