
var Organization = require("./Organization");

module.exports = Backbone.Collection.extend({

  model: Organization,

  url: function(){
    return aeolus.rootURL + "/organizations"; 
  },

  changeSort: function(prop, order) {
    order = typeof order !== 'undefined' ? order : 'asc';
    order = order === "asc" ? -1 : 1;

    this.comparator = function(a, b){
      if(a.get(prop) > b.get(prop)) { return -order; }
      if(a.get(prop) < b.get(prop)) { return order; }
      return 0;
    };

    this.sort().trigger('reset');
  }

});