Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  # login y sessiones
  get 'login' => 'login#index'
  # ubicaciones
  get 'maestros' => 'ubicaciones/view#index'
  get 'ubicaciones/departamento/listar' => 'ubicaciones/departamento#listar'
  post 'ubicaciones/departamento/guardar' => 'ubicaciones/departamento#guardar'
  get 'ubicaciones/provincia/listar/:departamento_id' => 'ubicaciones/provincia#listar'
  post 'ubicaciones/provincia/guardar' => 'ubicaciones/provincia#guardar'
  get 'ubicaciones/distrito/listar/:provincia_id' => 'ubicaciones/distrito#listar'
  post 'ubicaciones/distrito/guardar' => 'ubicaciones/distrito#guardar'
  get 'ubicaciones/distrito/buscar' => 'ubicaciones/distrito#buscar'
  get 'ubicaciones/distrito/nombre/:distrito_id' => 'ubicaciones/distrito#nombre'
  # archivos
  get 'archivos/extension/listar' => 'archivos/extension#listar'
  post 'archivos/extension/guardar' => 'archivos/extension#guardar'
  get 'archivos/extension/nombre_mime/:extension_id' => 'archivos/extension#nombre_mime'
  # errores
  get 'error/access/:id' => 'error#access'
  #get '*unmatched_route' => 'application#not_found'
  post '*unmatched_route' => 'application#not_found'
end
