class Ubicaciones::ViewController < ApplicationController
  include UbicacionesHelper
  def index
    @locals = {
      :title => 'Ubicaciones',
      :css => UbicacionesHelper::index_css,
      :js => UbicacionesHelper::index_js,
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
          :subtitulo => 'Maestros',
          :items => [
            {
              :item => 'Gestión de Ubicaciones',
              :url => 'maestros/#/ubicacion',
            },
            {
              :item => 'Gestión de Extensiones',
              :url => 'maestros/#/extension',
            },
          ],
        },
      ].to_json,
  		:js_bottom => 'dist/agricultores.min.js',
  		:data => {
  			:mensaje => false,
  			:titulo_pagina => 'Gestión de Agricultores',
  			:modulo => 'Maestros',
  		}.to_json,
    }
    render template: 'ubicaciones/index', layout: 'hbs_app'
  end
end
