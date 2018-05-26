Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  # login y sessiones
  get 'login' => 'login#index'
  # maestros/ubicaciones
  get 'maestros' => 'ubicaciones/view#index'
  get 'ubicaciones/departamento/listar' => 'ubicaciones/departamento#listar'
  post 'ubicaciones/departamento/guardar' => 'ubicaciones/departamento#guardar'
  get 'ubicaciones/provincia/listar/:departamento_id' => 'ubicaciones/provincia#listar'
  post 'ubicaciones/provincia/guardar' => 'ubicaciones/provincia#guardar'
  get 'ubicaciones/distrito/listar/:provincia_id' => 'ubicaciones/distrito#listar'
  post 'ubicaciones/distrito/guardar' => 'ubicaciones/distrito#guardar'
  get 'ubicaciones/distrito/buscar' => 'ubicaciones/distrito#buscar'
  get 'ubicaciones/distrito/nombre/:distrito_id' => 'ubicaciones/distrito#nombre'
  # archivos/extension
  get 'archivos' => 'archivos/view#index'
  get 'archivos/extension/listar' => 'archivos/extension#listar'
  get 'archivos/extension/buscar_pagina' => 'archivos/extension#buscar_pagina'
  get 'archivos/extension/count' => 'archivos/extension#count'
  post 'archivos/extension/guardar' => 'archivos/extension#guardar'
  get 'archivos/extension/nombre_mime/:extension_id' => 'archivos/extension#nombre_mime'
  # archivos/autor
  get 'archivos/autor/listar' => 'archivos/autor#listar'
  get 'archivos/autor/buscar_pagina' => 'archivos/autor#buscar_pagina'
  get 'archivos/autor/count' => 'archivos/autor#count'
  post 'archivos/autor/guardar' => 'archivos/autor#guardar'
  get 'archivos/autor/nombre_mime/:autor_id' => 'archivos/autor#nombre_mime'
  # archivos/categoria
  get 'archivos/categoria/listar' => 'archivos/categoria#listar'
  post 'archivos/categoria/guardar' => 'archivos/categoria#guardar'
  get 'archivos/categoria/nombre/:categoria_id' => 'archivos/categoria#nombre'
  # archivos/libro
  put 'archivos/libro/subir' => 'archivos/libro#subir'
  # errores
  get 'error/access/:id' => 'error#access'
  #get '*unmatched_route' => 'application#not_found'
  post '*unmatched_route' => 'application#not_found'
end
