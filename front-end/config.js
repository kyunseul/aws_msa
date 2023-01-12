(function (){
  'use strict';
  const tracer = require('dd-trace').init({logInjection: true})
  var session      = require("express-session"),
      RedisStore   = require('connect-redis')(session)

  module.exports = {
    session: {
      name: 'md.sid',
      secret: 'sooper secret',
      resave: false,
      saveUninitialized: true
    },

    session_redis: {
      store: new RedisStore({host: "session-db.zjlfuk.ng.0001.apn2.cache.amazonaws.com"}),
      name: 'md.sid',
      secret: 'sooper secret',
      resave: false,
      saveUninitialized: true
    }
  };
}());
