class Archivos::ViewController < ApplicationController
  include ArchivosHelper
  def index
    @locals = {
      :title => 'Archivos',
      :css => ArchivosHelper::index_css,
      :js => ArchivosHelper::index_js,
      :modulos => MenuHelper::menu_modulos(),
  		:items => MenuHelper::menu_items('Archivos'),
  		:js_bottom => 'dist/agricultores.min.js',
      :static_url => CONSTANTS[:STATIC_URL],
  		:data => {
  			:mensaje => false,
  			:titulo_pagina => 'Gestión de Archivos',
  			:modulo => 'Archivos',
  		}.to_json,
    }
    render template: 'ubicaciones/index', layout: 'hbs_app'
  end
end
