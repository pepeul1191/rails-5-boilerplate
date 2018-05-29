var dataVideoUpload = {
  el: "#formUploadVideo",
  imagenId: "imagen_id",
  inputFileId: "inputVideo",
  buscarBtnId: "buscarVideo",
  subirBtnId: "subirVideo",
  verBtnId: "verVideo",
  fileName: "myFile",
  lblMensaje: "lblMensajeUpload",
  mensajes: {
    "formatoNoValido": "Archivo formato no válido",
    "tamanioNoValido": "Tamaño de archivo no válido",
    "errorAjax": "Error de comunicación con el servidor",
    "success": "Se cargado el archivo",
  },
  url: BASE_URL + "archivos/video/subir",
  extraData: [
    {"llave": "nombre", "domId": "txtNombreArchivo"},
  ],
  maxSize: 3545850, //bytes
  allowTypes: ["application/pdf"],
  model: new Archivo(),
};
