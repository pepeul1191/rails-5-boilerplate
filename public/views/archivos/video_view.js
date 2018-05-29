var VideoView = Backbone.View.extend({
	el: '#workspace',
	initialize: function(){
		//this.render();
		//console.log("initialize");
		this.events = this.events || {};
		this.tablaVideo = new TableView(dataTablaVideo);
	},
	events: {
		// se está usando asignacion dinamica de eventos en el constructor
    //eventos tabla de departamentos
    "click #tablaVideo > tfoot > tr > td > button.agregar-fila": "agregarFilaVideo",
		"click #tablaVideo > tfoot > tr > td > button.guardar-tabla": "guardarTablaVideo",
		"keyup #tablaVideo > tbody > tr > td > input.text": "inputTextEscribirVideo",
		"click #tablaVideo > tbody > tr > td > i.quitar-fila": "quitarFilaVideo",
	},
	render: function() {
		this.$el.html(this.getTemplate());
		return this;
	},
	getTemplate: function() {
		var data = { };
		var template_compiled = null;
		$.ajax({
		   url: STATICS_URL + 'templates/archivos/video.html',
		   type: "GET",
		   async: false,
		   success: function(source) {
		   	var template = Handlebars.compile(source);
		   	template_compiled = template(data);
		   }
		});
		return template_compiled;
	},
	tabVideo:function(video_id){
		var url = null;
		$.ajax({
			url: BASE_URL + 'archivos/video/ruta/' +  video_id,
			type: "GET",
			async: false,
			success: function(ruta) {
				url = ruta;
			},
      error: function(error) {
        console.log(error);
				$("#mensajeRptaVideo").removeClass("color-success");
        $("#mensajeRptaVideo").removeClass("color-warning");
        $("#mensajeRptaVideo").addClass("color-danger");
        $("#mensajeRptaVideo").html("Error en mostrar el video en una nueva pestaña del navegador");
      }
		});
		console.log(url);
		window.open(url, '_blank');
	},
	mostrarTabla: function(){
		this.tabla.listar();
	},
  //evnetos tabla de departamentos
  inputTextEscribirVideo: function(event){
    this.tablaVideo.inputTextEscribir(event);
  },
  quitarFilaVideo: function(event){
    this.tablaVideo.quitarFila(event);
  },
  guardarTablaVideo: function(event){
    this.tablaVideo.guardarTabla(event);
  },
  agregarFilaVideo: function(event){
    this.tablaVideo.agregarFila(event);
  },
  paginacionIrPrimero: function(){
    this.tablaVideo.paginacionIrPrimero();
  },
  paginacionIrAnteior: function(){
    this.tablaVideo.paginacionIrAnteior();
  },
  paginacionIrSiguiente: function(){
    this.tablaVideo.paginacionIrSiguiente();
  },
  paginacionIrUltimo: function(){
    this.tablaVideo.paginacionIrUltimo();
  },
});
