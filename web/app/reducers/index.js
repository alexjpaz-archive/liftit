

var reducers = [
  require('./ConsoleReducer'),
  require('./LastAttemptedLift')
];

var composite = function() {
  var self = this;
  this.reduce = function(state) {
    reducers.forEach(function(reducer) {
      reducer(state);
    });
  };
};

module.exports = composite;
