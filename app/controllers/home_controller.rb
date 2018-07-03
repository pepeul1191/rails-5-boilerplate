class HomeController < ApplicationController
  include LoginHelper
  before_action :session_true_view, only: [:index, ]
  def index
    @locals = {
      :title => 'Home',
      :css => HomeHelper::index_css,
      :js => HomeHelper::index_js,
      :modulos => MenuHelper::menu_modulos(),
  		:items => MenuHelper::menu_items('Agricultores'),
  		:js_bottom => 'dist/agricultores.min.js',
  		:data => {
  			:mensaje => false,
  			:titulo_pagina => 'Gestión de Agricultores',
  			:modulo => 'Agricultores',
  		}.to_json,
    }
    render template: 'home/index', layout: 'hbs_app'
  end
end
