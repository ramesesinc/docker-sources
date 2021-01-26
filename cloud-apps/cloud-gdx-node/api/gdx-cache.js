const {promisify} = require('util');
const redis = require('redis');
const cache = redis.createClient(process.env.REDIS_URL);
const getAsync = promisify(cache.get).bind(cache);
const setAsync = promisify(cache.set).bind(cache);
const keysAsync = promisify(cache.keys).bind(cache);

cache.on('error', (err) => {
    console.log('Redis [ERROR] ' + err);
});



const saveServices = (services) => {
    services.forEach(service => {
        cache.set(service.name, JSON.stringify(service));
    });
};

const findService = async (serviceName) => {
    const service = await getAsync(serviceName);
    return JSON.parse(service);
};

const loadKeys = async (pattern) => {
    return await keysAsync(pattern);
};

const getPartners = async (pattern) => {
    let partners = [];
    let keys = await loadKeys(pattern);
    if (keys.length > 0) {
        keys.forEach(key => {
            let tokens = key.split(':');
            if (tokens.length == 2) {
                let channel = tokens[1];
                partners.push({name: channel, channel: channel});
            }
        });
    }
    return partners;
};

const activatePartner = async (channel, cb) => {
    let key = 'partner:' + channel;
    let calls = parseInt(await getAsync(key), 10);
    if (calls == NaN) {
        calls = 0;
    }
    calls += 1;
    await setAsync(key, calls);
    cb(calls);
}

const deactivatePartner = async (channel, cb) => {
    let key = 'partner:' + channel;
    let calls = parseInt(await getAsync(key), 10);
    if (calls === NaN) {
        calls = 0;
    } else if (calls > 0) {
        calls -= 1;
    }
    await setAsync(key, calls);
    cb(calls);
}

const initPartner = async (partner) => {
    let key = 'partner:' + partner.channel;
    setAsync(key, 0);
}


module.exports = {
    saveServices: saveServices,
    findService: findService,
    getPartners: getPartners,
    activatePartner: activatePartner,
    deactivatePartner: deactivatePartner,
    initPartner: initPartner
}