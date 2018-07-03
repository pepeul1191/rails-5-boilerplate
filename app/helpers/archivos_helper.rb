module ArchivosHelper
  def self.index_css
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:STATIC_URL] + 'bower_components/bootstrap/dist/css/bootstrap.min',
        CONSTANTS[:STATIC_URL] + 'bower_components/font-awesome/css/font-awesome.min',
        CONSTANTS[:STATIC_URL] + 'bower_components/swp-backbone/assets/css/constants',
        CONSTANTS[:STATIC_URL] + 'bower_components/swp-backbone/assets/css/dashboard',
        CONSTANTS[:STATIC_URL] + 'bower_components/swp-backbone/assets/css/table',
        CONSTANTS[:STATIC_URL] + 'bower_components/swp-backbone/assets/css/autocomplete',
        CONSTANTS[:STATIC_URL] + 'assets/css/constants',
        CONSTANTS[:STATIC_URL] + 'assets/css/styles',
      ]
    else
      rpta = [
        CONSTANTS[:STATIC_URL] + 'dist/archivos.min',
      ]
    end
    rpta
  end

  def self.index_js
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:STATIC_URL] + 'bower_components/jquery/dist/jquery.min',
        CONSTANTS[:STATIC_URL] + 'bower_components/bootstrap/dist/js/bootstrap.min',
        CONSTANTS[:STATIC_URL] + 'bower_components/underscore/underscore-min',
        CONSTANTS[:STATIC_URL] + 'bower_components/backbone/backbone-min',
        CONSTANTS[:STATIC_URL] + 'bower_components/handlebars/handlebars.min',
        CONSTANTS[:STATIC_URL] + 'bower_components/swp-backbone/layouts/application',
        CONSTANTS[:STATIC_URL] + 'bower_components/swp-backbone/views/table',
        CONSTANTS[:STATIC_URL] + 'bower_components/swp-backbone/views/modal',
        CONSTANTS[:STATIC_URL] + 'bower_components/swp-backbone/views/upload',
        CONSTANTS[:STATIC_URL] + 'bower_components/swp-backbone/views/autocomplete',
        CONSTANTS[:STATIC_URL] + 'models/archivos/extension',
        CONSTANTS[:STATIC_URL] + 'models/archivos/autor',
        CONSTANTS[:STATIC_URL] + 'models/archivos/categoria',
        CONSTANTS[:STATIC_URL] + 'models/archivos/libro',
        CONSTANTS[:STATIC_URL] + 'models/archivos/video',
        CONSTANTS[:STATIC_URL] + 'models/archivos/archivo',
        CONSTANTS[:STATIC_URL] + 'collections/archivos/extension_collection',
        CONSTANTS[:STATIC_URL] + 'collections/archivos/autor_collection',
        CONSTANTS[:STATIC_URL] + 'collections/archivos/categoria_collection',
        CONSTANTS[:STATIC_URL] + 'collections/archivos/libro_collection',
        CONSTANTS[:STATIC_URL] + 'collections/archivos/video_collection',
        CONSTANTS[:STATIC_URL] + 'data/archivos/tabla_extension',
        CONSTANTS[:STATIC_URL] + 'data/archivos/tabla_autor',
        CONSTANTS[:STATIC_URL] + 'data/archivos/tabla_categoria',
        CONSTANTS[:STATIC_URL] + 'data/archivos/tabla_libro',
        CONSTANTS[:STATIC_URL] + 'data/archivos/tabla_libro_autor',
        CONSTANTS[:STATIC_URL] + 'data/archivos/tabla_libro_categoria',
        CONSTANTS[:STATIC_URL] + 'data/archivos/tabla_video',
        CONSTANTS[:STATIC_URL] + 'data/archivos/tabla_video_autor',
        CONSTANTS[:STATIC_URL] + 'data/archivos/tabla_video_categoria',
        CONSTANTS[:STATIC_URL] + 'data/archivos/video_detalle',
        CONSTANTS[:STATIC_URL] + 'data/archivos/libro_detalle',
        CONSTANTS[:STATIC_URL] + 'data/archivos/libro_upload',
        CONSTANTS[:STATIC_URL] + 'data/archivos/video_upload',
        CONSTANTS[:STATIC_URL] + 'views/archivos/autor_view',
        CONSTANTS[:STATIC_URL] + 'views/archivos/extension_view',
        CONSTANTS[:STATIC_URL] + 'views/archivos/categoria_view',
        CONSTANTS[:STATIC_URL] + 'views/archivos/libro_view',
        CONSTANTS[:STATIC_URL] + 'views/archivos/libro_detalle_view',
        CONSTANTS[:STATIC_URL] + 'views/archivos/video_detalle_view',
        CONSTANTS[:STATIC_URL] + 'views/archivos/video_view',
        CONSTANTS[:STATIC_URL] + 'routes/archivos',
      ]
    else
      rpta = [
        CONSTANTS[:STATIC_URL] + 'dist/archivos.min',
      ]
    end
    rpta
  end
end
