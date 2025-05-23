const path = require('path');
const CopyPlugin = require("copy-webpack-plugin");
const TerserPlugin = require('terser-webpack-plugin');
module.exports = {
    mode: process.env.NODE_ENV,
    entry: {
        anchor: ['./js/anchor.js'],
        color_modes: ['./js/color_modes.js'],
        common: ['./js/common.js'],
    },
    output: {
        filename: 'js/[name].js',
        path: path.resolve(__dirname, '_site/dist'),
    },
    plugins: [
        new CopyPlugin({
            patterns: [
                { from: "node_modules/gitalk/dist", to: "gitalk"},
                { from: "node_modules/mathjax/unpacked", to: "mathjax"},
                { from: "node_modules/bootstrap-icons/font/fonts", to: "fonts"}
            ],
        }),
    ],
    optimization: {
        minimizer: [
            new TerserPlugin({
                exclude: /mathjax/, // 排除 mathjax 文件，使其不被压缩
            }),
        ],
    },
};