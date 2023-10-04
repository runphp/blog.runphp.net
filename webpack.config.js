const path = require('path');
const CopyPlugin = require("copy-webpack-plugin");

module.exports = {
    mode: process.env.NODE_ENV,
    entry: {
        anchor: ['./js/anchor.js'],
        color_modes: ['./js/color_modes.js'],
        common: ['./js/common.js'],
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