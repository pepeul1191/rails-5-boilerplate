module ArchivosHelper
  def self.index_css
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        'bower_components/bootstrap/dist/css/bootstrap.min',
        'bower_components/font-awesome/css/font-awesome.min',
        'bower_components/swp-backbone/assets/css/constants',
        'bower_components/swp-backbone/assets/css/dashboard',
        'bower_components/swp-backbone/assets/css/table',
        'assets/css/constants',
        'assets/css/styles',
      ]
    else
      rpta = [
        'dist/home.min',
      ]
    end
    rpta
  end

  def self.index_js
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        'bower_components/jquery/dist/jquery.min',
        'bower_components/bootstrap/dist/js/bootstrap.min',
        'bower_components/underscore/underscore-min',
        'bower_components/backbone/backbone-min',
        'bower_components/handlebars/handlebars.min',
        'bower_components/swp-backbone/layouts/application',
        'bower_components/swp-backbone/views/table',
        'bower_components/swp-backbone/views/modal',
        'bower_components/swp-backbone/views/upload',
        'models/archivos/extension',
        'models/archivos/autor',
        'models/archivos/categoria',
        'models/archivos/libro',
        'models/archivos/archivo',
        'collections/archivos/extension_collection',
        'collections/archivos/autor_collection',
        'collections/archivos/categoria_collection',
        'collections/archivos/libro_collection',
        'data/archivos/tabla_extension',
        'data/archivos/tabla_autor',
        'data/archivos/tabla_categoria',
        'data/archivos/tabla_libro',
        'data/archivos/libro_detalle',
        'data/archivos/libro_upload',
        'views/archivos/autor_view',
        'views/archivos/extension_view',
        'views/archivos/categoria_view',
        'views/archivos/libro_view',
        'views/archivos/libro_detalle_view',
        'routes/archivos',
      ]
    else
      rpta = [
        'dist/home.min',
      ]
    end
    rpta
  end
end
