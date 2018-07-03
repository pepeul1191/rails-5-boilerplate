class Ubicaciones::ViewController < ApplicationController
  include UbicacionesHelper
  def index
    @locals = {
      :title => 'Ubicaciones',
      :css => UbicacionesHelper::index_css,
      :js => UbicacionesHelper::index_js,
      :modulos => MenuHelper::menu_modulos(),
  		:items => MenuHelper::menu_items('Maestros'),
  		:js_bottom => 'dist/agricultores.min.js',
      :static_url => CONSTANTS[:STATIC_URL],
  		:data => {
  			:mensaje => false,
  			:titulo_pagina => 'Gestión de Agricultores',
  			:modulo => 'Maestros',
  		}.to_json,
    }
    render template: 'ubicaciones/index', layout: 'hbs_app'
  end
end
