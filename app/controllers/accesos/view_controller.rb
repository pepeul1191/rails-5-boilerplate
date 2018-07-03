class Accesos::ViewController < ApplicationController
  include AccesosHelper
  def index
    @locals = {
      :title => 'Accesos',
      :css => AccesosHelper::index_css,
      :js => AccesosHelper::index_js,
      :modulos => MenuHelper::menu_modulos(),
  		:items => MenuHelper::menu_items('Accesos'),
  		:js_bottom => 'dist/agricultores.min.js',
  		:data => {
  			:mensaje => false,
  			:titulo_pagina => 'Gestión de Accesos',
  			:modulo => 'Accesos',
  		}.to_json,
    }
    render template: 'accesos/index', layout: 'hbs_app'
  end
end
