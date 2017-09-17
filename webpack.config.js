const path = require('path');

module.exports = {
  entry: './lib/client/',
  output: {
    filename: 'build/bundle.js'
  },
  module: {
    rules: [
      {
        test: /.jsx?$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              presets: [
                ['es2015'],
                'react',
              ],
            }
          }
        ]
      },
    ]
  }
}