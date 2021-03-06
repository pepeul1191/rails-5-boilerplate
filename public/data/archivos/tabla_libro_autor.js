var dataLibroAutor = new TableView({
  el: "#formTableAutorLibro",
  idTable: "tablaAutorLibro",
  targetMensaje: "mensajeRptaAutorLibro",
  mensajes: {
    errorListarAjax: "Error en listar los datos del servidor",
    errorGuardarAjax: "Error en guardar los datos en el servidor",
    success: "Se cargado guardo las asociaciones a los autores",
  },
  //urlListar: BASE_URL + "distrito/listar/" + provinciaId,
  urlGuardar: BASE_URL + "archivos/libro/guardar/autor",
  urlListar: BASE_URL + "archivos/libro/listar/autores/",
  fila: {
    id: { // llave de REST
      tipo: "td_id",
      estilos: "color: blue; display:none",
      edicion: false,
    },
    autor_id: { // llave de REST
      tipo: "autocomplete",
      estilos: "width: 200px;",
      edicion: true,
      url: BASE_URL + "archivos/autor/buscar",
      collection: new AutoresCollection(),
      model: "Autor",
      mensajeError: "Ha ocurrido un error al buscar los autores",
      keyModeloInput: "autor_nombre",
      keyModeloCelda: "autor_id",
    },
    filaBotones: {
      estilos: "width: 80px"
    },
  },
  filaBotones: [
    {
      tipo: "i",
      claseOperacion: "quitar-fila",
      clase: "fa-times",
      estilos: "padding-left: 15px;",
    },
  ],
  collection: new AutoresCollection(),
  model: "Autor",
});
