const express = require('express');
const app = express();
const http = require('http').createServer(app);
const cors = require('cors');
const io = require('socket.io')(http);
const gdx = require('./api/gdx-server');
const gdxSvc = require('./api/gdx-node-service');
const cache = require('./api/gdx-cache');
const bodyParser = require('body-parser');
const path = require('path')
const debug = require('debug')('http');

const port = process.env.port || 3000;

global.appRoot = path.resolve(__dirname);

app.use(cors());
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.set('view engine', 'pug');

gdx.setIo(io);
gdx.registerPartners(io);

app.get('/', (req, res) => {
    res.render('index', {partners: gdx.getPartners()});
}); 

app.get('/service/:name', async (req, res, ) => {
	debug(req.method + ' loading service ' + req.params.name);
    let service = await cache.findService(req.params.name);
    res.send(service);
});

app.post('/osiris3/services/gdx/:service', (req, res) => {
	try {
		let tokens = req.params.service.split('.');
		if (tokens.length == 2) {
			let service = gdxSvc[tokens[0]];
			if (service === undefined) {
				throw 'Service does not exist';
			}
			let method = service[tokens[1]];
			method(req.body);
			res.send({status: 'OK'});
		} else {
			throw 'Invalid service format.'
		}
	} catch (error) {
		debug(req.method + ' ' + error);
		res.send({status: 'ERROR', msg: error});
	}
});

http.listen(port, (err) => {
    if (err) {
        console.error(err);
    } else {
        console.log(`Server listening on port ${port}`);
    }
});


