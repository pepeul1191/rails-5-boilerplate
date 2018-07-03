class HomeController < ApplicationController
  include LoginHelper
  before_action :session_true_view, only: [:index, ]
  def index
    @locals = {
      :title => 'Home',
      :css => HomeHelper::index_css,
      :js => HomeHelper::index_js,
      :modulos => [
        {
          :url => 'accesos/',
          :nombre => 'Accesos',
        },
        {
          :url => 'maestros/',
          :nombre => 'Maestros',
        },
        {
          :url => 'agricultores/',
          :nombre => 'Agricultores',
        },
        {
          :url => 'estaciones/',
          :nombre => 'Estaciones',
        },
      ].to_json,
  		:items => [
        {
          :subtitulo => 'Opciones',
          :items => [
            {
              :item => 'Gestión de Responsables',
              :url => 'agricultores/#/responsable',
            },
            {
              :item => 'Gestión de Asociaciones',
              :url => 'agricultores/#/asociacion',
            },
          ],
        },
      ].to_json,
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
