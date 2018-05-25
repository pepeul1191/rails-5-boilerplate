var Router = Marionette.AppRouter.extend({
    routes: {
      'email/:email': 'showEmail',
      "" : "index",
      "extension": "extension",
      "autor": "autor",
      "*actions" : "index"
    },
    showEmail: function(email) {
        // show the email
      alert(email);
    },
    extension: function() {
      this.extensionViewInstan = "hola";
      var extensionView = new ExtensionView({});
      extensionView.render();
      extensionView.tablaExtension.listar();
    },
    autor: function() {
      var autorView = new AutorView({});
      autorView.render();
      autorView.tablaAutor.listar();
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
