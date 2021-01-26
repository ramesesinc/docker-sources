const {exec} = require('child_process');
const path = require('path');
const fs = require('fs');
const appRoot = require('app-root-path');

const docsFolder = path.join(appRoot.path, '_docs');

const init =() => {
    if (fs.exists(docsFolder, (exists) => {
        if (!exists) {
            build();
        } else {
            fs.promises.readdir(docsFolder).then(files => {
                if (files.length === 0) {
                    build();
                }
            });
        }
    }));
};

const build = () => {
    exec("npm run docs", (error, stdout, stderr) => {
        if (error) {
            console.log(`error: ${error.message}`);
            return;
        }
        if (stderr) {
            console.log(`stderr: ${stderr}`);
            return;
        }
        console.log(`stdout: ${stdout}`);
    });
};

module.exports = {
    init: init,
    build: build,
};