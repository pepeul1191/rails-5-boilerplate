var dataTablaCategoria = {
  el: "#formTableCategoria",
  idTable: "tablaCategoria",
  targetMensaje: "mensajeRptaCategoria",
  mensajes: {
    errorListarAjax: "Error en listar los datos del servidor",
    errorGuardarAjax: "Error en guardar los datos en el servidor",
    success: "Se cargado guardo los cambios en los categorias",
  },
  //urlListar: BASE_URL + "distrito/listar/" + provinciaId,
  urlGuardar: BASE_URL + "archivos/categoria/guardar",
  urlListar: BASE_URL + "archivos/categoria/listar",
  fila: {
    id: { // llave de REST
      tipo: "td_id",
      estilos: "color: blue; display:none",
      edicion: false,
    },
    nombre: { // llave de REST
      tipo: "text",
      estilos: "width: 300px;",
      edicion: true,
    },
    filaBotones: {
      estilos: "width: 80px; padding-left: 7px;"
    },
  },
  filaBotones: [
    {
      tipo: "i",
      claseOperacion: "quitar-fila",
      clase: "fa-times",
      estilos: "padding-left: 10px;",
    },
  ],
  collection: new CategoriasCollection(),
  model: "Categoria",
};
