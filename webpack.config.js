const path = require('path');

module.exports = {
    mode: process.env.NODE_ENV,
    entry: {
        common: ['./js/common.js'],
        gitalk: ['./js/gitalk.js']
    },
    output: {
        filename: '[name].js',
        path: path.resolve(__dirname, '_site/dist'),
    }
};