const gdx = require('./gdx-server');
const debug = require('debug')('gdx');

const GdxNodeService = new function() {
	this.register = function(partner) {
		if (!partner) throw 'Partner info is invalid';
		let channel = partner.channel
		if (!channel) throw 'The channel parameter must be specified.';
		
		let io = gdx.getIo();
		let nsps = Object.keys(io.nsps);
		let nsp = '/' + channel;

		let found = nsps.find((item) => {
			return item === nsp;
		});

		if (!found) {
			gdx.registerPartner(io, partner);
			debug('Partner ' + partner.channel + ' registered');
		}
	}

	this.unregister = function(partner) {
		if (partner && partner.channel) {
			debug('Partner ' + partner.channel + ' unregistered');	
		}
	}
}

module.exports = {
	GdxNodeService: GdxNodeService
}