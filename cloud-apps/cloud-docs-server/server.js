const express = require('express');
const app = express();
const http = require('http').createServer(app);
const path = require('path');
const docs = require('./api/rameses-docs');
const docsRouter = require('./routers/tool-docs-router');

const port = process.env.port || 4000;

app.use('/', express.static('_docs'));
app.use('/res/', express.static('./res'));
app.use('/tool/docs', docsRouter);

app.use(function (req, res, next) {
    res.status(404).sendFile(path.join(__dirname,'/res/404.html'));
})

docs.init();

http.listen(port, (err) => {
    if (err) {
        console.log(err);
    } else {
        console.log(`Server listening on port ${port}`);
    }
});