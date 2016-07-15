var DateUtils = {};

DateUtils.sort = function(a,b) {
    if(a.date > b.date) return -1;
    if(a.date == b.date) return 0;
    if(a.date < b.date) return 1;
};

DateUtils.string = function(date) {
    return [
      date.getFullYear(),
      pad(''+(date.getMonth() + 1)),
      pad(''+date.getDate())
    ].join('-');
};

DateUtils.compare = function(a,b) {
  var ad = new Date(a);
  var bd = new Date(b);

  if(ad == bd) return 0;
  if(ad > bd) return 1;
  if(ad < bd) return -1;
};

DateUtils.before = function(date) {
};

DateUtils.create = function() {
  var today = new Date();
  today.setHours(0,0,0,0);
  return new Date(today).toISOString();
};

function pad(str) {
  var pad = "00"
  var ans = pad.substring(0, pad.length - str.length) + str
  return ans;
}

module.exports = DateUtils;
