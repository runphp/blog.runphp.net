const path = require('path');
const CopyPlugin = require("copy-webpack-plugin");

module.exports = {
    mode: process.env.NODE_ENV,
    entry: {
        common: ['./js/common.js'],
        anchor: ['./js/anchor.js'],
    },
    output: {
        filename: '[name].js',
        path: path.resolve(__dirname, '_site/dist'),
    },
    plugins: [
        new CopyPlugin({
            patterns: [
                { from: "node_modules/gitalk/dist" },
                { from: "node_modules/bootstrap-icons/font/fonts", to: "fonts"}
            ],
        }),
    ],
};