const Path = require('path');

let manifestPath = './config/development';

if (typeof process.env.NODE_ENV === 'string') {
    manifestPath = Path.join(__dirname, 'config', process.env.NODE_ENV + '.js');
}

const GetManifest = require(manifestPath);

module.exports = {
    get: GetManifest
};
