module AccesosHelper
  def self.index_css
    rpta = nil
    if CONSTANTS[:ambiente] == 'desarrollo'
      rpta = [
        CONSTANTS[:static][:accesos] + 'bower_components/bootstrap/dist/css/bootstrap.min',
        CONSTANTS[:static][:accesos] + 'bower_components/font-awesome/css/font-awesome.min',
        CONSTANTS[:static][:accesos] + 'bower_components/swp-backbone/assets/css/constants',
        CONSTANTS[:static][:accesos] + 'bower_components/swp-backbone/assets/css/dashboard',
        CONSTANTS[:static][:accesos] + 'bower_components/swp-backbone/assets/css/table',
        CONSTANTS[:static][:accesos] + 'bower_components/swp-backbone/assets/css/autocomplete',
        CONSTANTS[:STATIC_URL] + 'assets/css/constants',
        CONSTANTS[:STATIC_URL] + 'assets/css/styles',
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
        CONSTANTS[:static][:accesos] + 'bower_components/jquery/dist/jquery.min',
        CONSTANTS[:static][:accesos] + 'bower_components/bootstrap/dist/js/bootstrap.min',
        CONSTANTS[:static][:accesos] + 'bower_components/underscore/underscore-min',
        CONSTANTS[:static][:accesos] + 'bower_components/backbone/backbone-min',
        CONSTANTS[:static][:accesos] + 'bower_components/handlebars/handlebars.min',
        CONSTANTS[:static][:accesos] + 'bower_components/swp-backbone/layouts/application',
        CONSTANTS[:static][:accesos] + 'bower_components/swp-backbone/views/table',
        CONSTANTS[:static][:accesos] + 'bower_components/swp-backbone/views/modal',
        CONSTANTS[:static][:accesos] + 'bower_components/swp-backbone/views/upload',
        CONSTANTS[:static][:accesos] + 'bower_components/swp-backbone/views/autocomplete',
        CONSTANTS[:static][:accesos] + 'models/sistema',
        CONSTANTS[:static][:accesos] + 'models/modulo',
        CONSTANTS[:static][:accesos] + 'models/subtitulo',
        CONSTANTS[:static][:accesos] + 'models/item',
        CONSTANTS[:static][:accesos] + 'models/permiso',
        CONSTANTS[:static][:accesos] + 'models/rol',
        CONSTANTS[:static][:accesos] + 'models/usuario',
        CONSTANTS[:static][:accesos] + 'models/estado_usuario',
        CONSTANTS[:static][:accesos] + 'collections/estado_usuario_collection',
        CONSTANTS[:static][:accesos] + 'collections/sistema_collection',
        CONSTANTS[:static][:accesos] + 'collections/modulo_collection',
        CONSTANTS[:static][:accesos] + 'collections/subtitulo_collection',
        CONSTANTS[:static][:accesos] + 'collections/item_collection',
        CONSTANTS[:static][:accesos] + 'collections/permiso_collection',
        CONSTANTS[:static][:accesos] + 'collections/rol_collection',
        CONSTANTS[:static][:accesos] + 'collections/usuario_collection',
        CONSTANTS[:static][:accesos] + 'data/tabla_sistema_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_sistema_permiso_data',
        CONSTANTS[:static][:accesos] + 'data/modal_sistema_menu_data',
        CONSTANTS[:static][:accesos] + 'data/modal_sistema_permiso_data',
        CONSTANTS[:static][:accesos] + 'data/modal_sistema_rol_data',
        CONSTANTS[:static][:accesos] + 'data/modal_usuario_detalle_data',
        CONSTANTS[:static][:accesos] + 'data/modal_usuario_sistema_data',
        CONSTANTS[:static][:accesos] + 'data/modal_usuario_log_data',
        CONSTANTS[:static][:accesos] + 'data/modal_usuario_rol_permiso_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_sistema_modulo_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_modulo_subtitulo_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_subtitulo_item_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_sistema_rol_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_rol_permiso_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_usuario_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_usuario_sistema_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_usuario_rol_data',
        CONSTANTS[:static][:accesos] + 'data/tabla_usuario_permiso_data',
        CONSTANTS[:static][:accesos] + 'views/sistema_view',
        CONSTANTS[:static][:accesos] + 'views/sistema_menu_view',
        CONSTANTS[:static][:accesos] + 'views/sistema_permiso_view',
        CONSTANTS[:static][:accesos] + 'views/sistema_rol_view',
        CONSTANTS[:static][:accesos] + 'views/usuario_view',
        CONSTANTS[:static][:accesos] + 'views/usuario_log_view',
        CONSTANTS[:static][:accesos] + 'views/usuario_detalle_view',
        CONSTANTS[:static][:accesos] + 'views/usuario_sistema_view',
        CONSTANTS[:static][:accesos] + 'views/usuario_rol_permiso_view',
        CONSTANTS[:static][:accesos] + 'routes/accesos',
      ]
    else
      rpta = [
        CONSTANTS[:BASE_URL] + 'dist/accesos.min',
      ]
    end
    rpta
  end
end
