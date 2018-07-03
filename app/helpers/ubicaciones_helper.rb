module UbicacionesHelper
  def self.index_css
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:BASE_URL] + 'bower_components/bootstrap/dist/css/bootstrap.min',
        CONSTANTS[:BASE_URL] + 'bower_components/font-awesome/css/font-awesome.min',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/assets/css/constants',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/assets/css/dashboard',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/assets/css/table',
        CONSTANTS[:BASE_URL] + 'assets/css/constants',
        CONSTANTS[:BASE_URL] + 'assets/css/styles',
      ]
    else
      rpta = [
        CONSTANTS[:BASE_URL] + 'dist/home.min',
      ]
    end
    rpta
  end

  def self.index_js
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:BASE_URL] + 'bower_components/jquery/dist/jquery.min',
        CONSTANTS[:BASE_URL] + 'bower_components/bootstrap/dist/js/bootstrap.min',
        CONSTANTS[:BASE_URL] + 'bower_components/underscore/underscore-min',
        CONSTANTS[:BASE_URL] + 'bower_components/backbone/backbone-min',
        CONSTANTS[:BASE_URL] + 'bower_components/backbone.marionette/lib/backbone.marionette.min',
        CONSTANTS[:BASE_URL] + 'bower_components/handlebars/handlebars.min',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/layouts/application',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/views/table',
        CONSTANTS[:BASE_URL] + 'bower_components/swp-backbone/views/modal',
        CONSTANTS[:BASE_URL] + 'models/ubicaciones/departamento',
        CONSTANTS[:BASE_URL] + 'models/ubicaciones/provincia',
        CONSTANTS[:BASE_URL] + 'collections/ubicaciones/departamento_collection',
        CONSTANTS[:BASE_URL] + 'collections/ubicaciones/provincia_collection',
        CONSTANTS[:BASE_URL] + 'data/ubicaciones/tabla_distrito',
        CONSTANTS[:BASE_URL] + 'data/ubicaciones/tabla_provincia',
        CONSTANTS[:BASE_URL] + 'data/ubicaciones/tabla_departamento',
        CONSTANTS[:BASE_URL] + 'views/ubicaciones/tabla_provincia_view',
        CONSTANTS[:BASE_URL] + 'views/ubicaciones/tabla_departamento_view',
        CONSTANTS[:BASE_URL] + 'views/ubicaciones/ubicacion_view',
        CONSTANTS[:BASE_URL] + 'routes/ubicaciones',
      ]
    else
      rpta = [
        CONSTANTS[:BASE_URL] + 'dist/home.min',
      ]
    end
    rpta
  end
end
