var archivosRouter = Backbone.Router.extend({
  extensionViewInstance: null,
  autorViewInstance: null,
  initialize: function() {
  },
  routes: {
    "": "index",
    "extension": "extension",
    "autor": "autor",
    "categoria": "categoria",
    "*actions" : "default",
  },
  index: function(){
    window.location.href = BASE_URL + "archivos/#/";
  },
  extension: function() {
    if(this.extensionViewInstance == null){
      this.extensionViewInstance = new ExtensionView();
    }
    this.extensionViewInstance.render();
    this.extensionViewInstance.tablaExtension.listar();
  },
  autor: function() {
    if(this.autorViewInstance == null){
      this.autorViewInstance = new AutorView();
    }
    this.autorViewInstance.render();
    this.autorViewInstance.tablaAutor.listar();
  },
  categoria: function() {
    if(this.categoriaViewInstance == null){
      this.categoriaViewInstance = new CategoriaView();
    }
    this.categoriaViewInstance.render();
    this.categoriaViewInstance.tablaCategoria.listar();
  },
  default: function() {
    window.location.href = BASE_URL + "error/access/404";
  },
});

$(document).ready(function(){
  router = new archivosRouter();
  Backbone.history.start();
})
