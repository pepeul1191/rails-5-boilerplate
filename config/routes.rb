Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'ubicaciones/departamento/listar' => 'ubicaciones/departamento#listar'
  get 'ubicaciones/provincia/listar/:departamento_id' => 'ubicaciones/provincia#listar'
end
