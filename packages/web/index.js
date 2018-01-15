const config = require('config');

require('./server').listen(3000, () => {
});

if(config.devmode !== false) {
  console.warn("dev mode enabled")
  const webpack = require('webpack');
  const WebpackDevServer= require('webpack-dev-server');
  var compiler = webpack(require('./webpack.config.js'));

  var server = new WebpackDevServer(compiler, {
    hot: true,
  });

  server.listen(8080);
  console.log('Open http://localhost:8080')
}