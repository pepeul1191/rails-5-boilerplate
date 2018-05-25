class Archivos::ViewController < ApplicationController
  include ArchivosHelper
  def index
    @locals = {
      :title => 'Archivos',
      :css => ArchivosHelper::index_css,
      :js => ArchivosHelper::index_js,
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
          :url => 'archivos/',
          :nombre => 'Archivos',
        },
      ].to_json,
  		:items => [
        {
          :subtitulo => 'Opciones',
          :items => [
            {
              :item => 'Gestión de Extensiones',
              :url => 'archivos/#/extension',
            },
          ],
        },{
          :subtitulo => 'Libros',
          :items => [
            {
              :item => 'Gestión de Autores',
              :url => 'archivos/#/autor',
            },
            {
              :item => 'Gestión de Categorías',
              :url => 'archivos/#/categoria',
            },
            {
              :item => 'Gestión de Libros',
              :url => 'archivos/#/libro',
            },
          ],
        },{
          :subtitulo => 'Videos',
          :items => [
            {
              :item => 'Gestión de Videos',
              :url => 'archivos/#/video',
            },
          ],
        }
      ].to_json,
  		:js_bottom => 'dist/agricultores.min.js',
  		:data => {
  			:mensaje => false,
  			:titulo_pagina => 'Gestión de Archivos',
  			:modulo => 'Archivos',
  		}.to_json,
    }
    render template: 'ubicaciones/index', layout: 'hbs_app'
  end
end
