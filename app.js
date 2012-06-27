require('coffee-script');

/**
 * Module dependencies.
 */

var express = require('express');


require('express-namespace');

var app = module.exports = express.createServer(),
    sio = require('socket.io').listen(app);

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.set('sio', sio);
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(require('connect-assets')());
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.set('mongoPort', 27017);
  app.set('mongoHost', 'localhost');
  app.set('mongoDB', 'oaqdemo');
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.set('mongoPort', 27017);
  app.set('mongoHost', 'localhost');
  app.set('mongoDB', 'oaqdemo');
  app.use(express.errorHandler());
});


mongo = require('mongodb');
var serverOptions = {
    'auto_reconnect': true,
      'poolSize': 5
};
var server = new mongo.Server(app.set('mongoHost'), app.set('mongoPort'), serverOptions);
var dbManager = new mongo.Db(app.set('mongoDB'), server);
dbManager.open(function (error, db) {
  require('./routes/index')(app, db);
  dossiers = require('./routes/dossiers')(db);
  queries = require('./routes/queries')(db);
  messages = require('./routes/messages')(app, db, mongo.BSONPure);
  require('./routes/api')(app, dossiers, queries, messages);


  app.listen(3000, function(){
    console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
  });

  process.on('exit', function() {
    console.log("Closing connections, bye!");
    db.close();
  });
});
