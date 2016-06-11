var riot = require('riot');
var guid = require('./guid');

var http = require('./services/http');
var ajax = http.ajax;

var session = require('./services/session');

var P = require("bluebird/js/browser/bluebird.core");

var store = function(config, storage, reducer) {
  if(!storage) throw Error("Storage is not set");

  riot.observable(this);
  var self = this;

  this.config = config;

  this.events = {};

  this.guid = guid;

  this.init = function(callback, failure) {
   return session.fetch().then(function(data) {
      self.events = data.Item.data.events || events;
      self.config = data.Item.data.config || config;
      self.trigger('digest');
    });
  };

  this.on('clearEvents', function() {
    localStorage.setItem("events", "{}");
    self.events = {};
    self.trigger('digest');
  });

  this.on('updateEvents', function(events) {
    if(events instanceof Array === false) {
      events = [events];
    }

    events.forEach(function(event) {
      event = Object.assign({}, event);
      event.updated = new Date().getTime();

      if(!self.events[event.key]) {
        event.created = new Date().getTime();
      }

      self.events[event.key] = event;
    });
    
   // self.events = JSON.parse(JSON.stringify(self.events));
    
    //self.events = Object.assign({}, self.events);

    self.trigger('digest');
  });

  this.on('persist', function() {
    var lastUpdated = new Date();
    storage.set('events', this.events);
    return session.store({
      events: this.events,
      config: this.config,
      lastUpdated: lastUpdated
    }).then(function(e) {
      self.trigger('persistSuccess', e);
      localStorage.setItem('lastUpdated', lastUpdated);
    }, function(e) {
      self.trigger('persistFailure', e);
    });
  });

  this.on('reduce', function() {
    reducer.reduce(self);
  });

  this.on('digest', function() {
    //self.trigger('reduce');
    self.trigger('persist');
  });
};

module.exports = store;
