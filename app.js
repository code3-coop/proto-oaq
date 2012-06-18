require('coffee-script');

/**
 * Module dependencies.
 */

var express = require('express'),
    mongo = require('mongodb');

require('express-namespace');

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(require('connect-assets')());
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

var db = new mongo.Db('oaqdemo', new mongo.Server('localhost', 27017, {}), {native_parser:false});

db.open(function (err, db) {

  // Routes
  require('./routes/index')(app);
  require('./routes/api')(app, db);

  app.listen(3000, function(){
    console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
  });
});
