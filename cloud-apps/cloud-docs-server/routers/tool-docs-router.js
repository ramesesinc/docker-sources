const express = require('express');
const router = express.Router();
const docs = require('../api/rameses-docs');

router.get('/build', function (req, res) {
    console.log('Rebuilding documentation...');
    docs.build();
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({status: 'success'}));
})

module.exports = router