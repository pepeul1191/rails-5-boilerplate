var LibroDetalleView = ModalView.extend({
  initialize: function(options){
    this.targetMensaje = options["targetMensaje"];
    // herencia de atributos, móetodos y eventos
    ModalView.prototype.initialize.apply(this, [options])
    this.inheritEvents(ModalView);
    // delegación de eventos
    this.delegateEvents();
    this.uploadLibro = new UploadView(dataLibroUpload);
    /*
    this.tipoSedesSelect = new TipoSedesCollection({
      targetMensaje: "defaultTargetMensajes",
    });
    this.sedesSelect = new SedesCollection({
      targetMensaje: "defaultTargetMensajes",
    });
    this.especialidadesSelect = new EspecialidadesCollection({
      targetMensaje: "defaultTargetMensajes",
    });
    */
    this.model = new Libro();
  },
  events: {
    // se está usando asignacion dinamica de eventos en el constructor
    "change #cbmTipoSede": "refrescarSedes",
    "click #btnGuardarDetalleDoctor": "guardarDoctor",
    "click #buscarLibro": "buscarLibro",
    "click #subirLibro" : "subirLibro",
    "click #btnGuardarDetalleLibroArchivo": "guardarDetalleLibroArchivo",
    "click #btnGuardarDetalleLibro": "guardarDetalleLibro",
  },
  buscarLibro: function(){
    this.uploadLibro.triggerInputFile();
  },
  subirLibro: function(){
    this.uploadLibro.subirFile();
  },
  guardarDetalleLibro: function(){
    var viewInstance = this;
    this.model.set("nombre", $("#txtNombre").val());
    this.model.set("anio", $("#txtAnio").val());
    this.model.set("paginas", $("#txtPaginas").val());
    $.ajax({
      type: "POST",
      url: BASE_URL + "archivos/libro/guardar_detalle",
      data: {csrfmiddlewaretoken: CSRF, data: JSON.stringify(viewInstance.model.toJSON())},
      async: false,
      success: function(data){
        var responseData = JSON.parse(data);
        if(responseData.tipo_mensaje == "success"){
          $("#" + viewInstance.targetMensaje).removeClass("color-danger");
          $("#" + viewInstance.targetMensaje).removeClass("color-warning");
          $("#" + viewInstance.targetMensaje).addClass("color-success");
          $("#" + viewInstance.targetMensaje).html(responseData.mensaje[0]);
          $("html, body").animate({ scrollTop: $("#" + viewInstance.targetMensaje).offset().top }, 1000);
          if(responseData.mensaje[1] !== undefined){ // se está recibiendo un id, osea nuevo registro
            viewInstance.model.set("id", responseData.mensaje[1]);
          }
        }
      },
      error: function(error){
        $("#" + viewInstance.targetMensaje).removeClass("color-success");
        $("#" + viewInstance.targetMensaje).removeClass("color-warning");
        $("#" + viewInstance.targetMensaje).addClass("color-danger");
        $("#" + viewInstance.targetMensaje).html("Error en guardar al doctor de turno");
        $("html, body").animate({ scrollTop: $("#" + viewInstance.targetMensaje).offset().top }, 1000);
        console.log(error);
      }
    });
  },
  guardarDetalleLibroArchivo: function(){
    var viewInstance = this;
    this.model.set("archivo_id", this.uploadLibro.model.id);
    $.ajax({
      type: "POST",
      url: BASE_URL + "archivos/libro/guardar_archivo",
      data: {csrfmiddlewaretoken: CSRF, data: JSON.stringify(viewInstance.model.toJSON())},
      async: false,
      success: function(data){
        var responseData = JSON.parse(data);
        if(responseData.tipo_mensaje == "success"){
          $("#" + viewInstance.targetMensaje).removeClass("color-danger");
          $("#" + viewInstance.targetMensaje).removeClass("color-warning");
          $("#" + viewInstance.targetMensaje).addClass("color-success");
          $("#" + viewInstance.targetMensaje).html(responseData.mensaje[0]);
          $("html, body").animate({ scrollTop: $("#" + viewInstance.targetMensaje).offset().top }, 1000);
        }
      },
      error: function(error){
        $("#" + viewInstance.targetMensaje).removeClass("color-success");
        $("#" + viewInstance.targetMensaje).removeClass("color-warning");
        $("#" + viewInstance.targetMensaje).addClass("color-danger");
        $("#" + viewInstance.targetMensaje).html("Error en guardar al doctor de turno");
        $("html, body").animate({ scrollTop: $("#" + viewInstance.targetMensaje).offset().top }, 1000);
        console.log(error);
      }
    });
  },
});
