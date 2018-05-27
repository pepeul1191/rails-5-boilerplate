var archivosRouter = Backbone.Router.extend({
  extensionViewInstance: null,
  autorViewInstance: null,
  categoriaViewInstance: null,
  libroViewInstance: null,
  libroDetalleViewInstance: null,
  initialize: function() {
  },
  routes: {
    "": "index",
    "extension": "extension",
    "autor": "autor",
    "categoria": "categoria",
    "libro": "libro",
    "libro/crear": "libroCrear",
    "libro/editar/:libro_id": "libroEditar",
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
  libro: function() {
    if(this.libroViewInstance == null){
      this.libroViewInstance = new LibroView();
    }
    this.libroViewInstance.render();
    this.libroViewInstance.tablaLibro.listar();
  },
  libroCrear: function() {
    $("#btnModal").click();
    if(this.libroDetalleViewInstance == null){
      this.libroDetalleViewInstance = new LibroDetalleView(dataLibroDetalle);
    }
    this.libroDetalleViewInstance.extraData = {libro_id: "E"};
    this.libroDetalleViewInstance.context.titulo_modal = "Crear Libro";
    this.libroDetalleViewInstance.render();
    //tabla de categoria libro
    this.libroDetalleViewInstance.tablaCategoriaLibro.urlListar =
      this.libroDetalleViewInstance.tablaCategoriaLibro.urlListar + "E";
    this.libroDetalleViewInstance.tablaCategoriaLibro.listar();
    this.libroDetalleViewInstance.tablaCategoriaLibro.urlListar =
      this.libroDetalleViewInstance.tablaCategoriaLibro.urlListar.slice(0, -1);
    //tabla de autor libro
    this.libroDetalleViewInstance.tablaAutorLibro.urlListar =
      this.libroDetalleViewInstance.tablaAutorLibro.urlListar + "E";
    this.libroDetalleViewInstance.tablaAutorLibro.listar();
    this.libroDetalleViewInstance.tablaAutorLibro.urlListar =
      this.libroDetalleViewInstance.tablaAutorLibro.urlListar.slice(0, -1);
  },
  libroEditar: function(libro_id) {
    $("#btnModal").click();
    if(this.libroDetalleViewInstance == null){
      this.libroDetalleViewInstance = new LibroDetalleView(dataLibroDetalle);
    }
    this.libroDetalleViewInstance.set("libro_id", libro_id);
    this.libroDetalleViewInstance.context.titulo_modal = "Editar Libro";
    this.libroDetalleViewInstance.tablaCategoriaLibro.urlListar =
      this.libroDetalleViewInstance.tablaCategoriaLibro.urlListar + libro_id;
    this.libroDetalleViewInstance.tablaCategoriaLibro.listar();
    this.libroDetalleViewInstance.tablaCategoriaLibro.urlListar =
      this.libroDetalleViewInstance.tablaCategoriaLibro.urlListar.replace(libro_id, '');
    this.libroDetalleViewInstance.render();
  },
  default: function() {
    //window.location.href = BASE_URL + "error/access/404";
  },
});

$(document).ready(function(){
  router = new archivosRouter();
  Backbone.history.start();
})
