var Router = Marionette.AppRouter.extend({
    routes: {
      'email/:email': 'showEmail',
      "" : "index",
      "ubicacion": "ubicacion",
      "*actions" : "index"
    },
    showEmail: function(email) {
        // show the email
      alert(email);
    },
    ubicacion: function() {
      //renderizar vista
      var ubicacicionView = new UbicacionView({});
      ubicacicionView.render();
      //renderizar tabla
      ubicacicionView.tablaDepartamento.listar();
    },
    index: function() {
        // show the email
    },
});


var App = Marionette.Application.extend({
  region: '#body-app',
  onStart() {
    var router = new Router();
    Backbone.history.start();
  }
});

var myApp = new App();
myApp.start();
