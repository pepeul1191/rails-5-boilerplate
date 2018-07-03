Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  # login y sessiones
  get 'login' => 'login#index'
  post 'login/acceder' => 'login#acceder'
  get 'login/cerrar' => 'login#cerrar'
  get 'login/ver' => 'login#ver'
  # accesos
  get 'accesos' => 'accesos/view#index'
  get 'sistema/listar' => 'accesos/sistema#listar'
  post 'sistema/guardar' => 'accesos/sistema#guardar'
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
  get 'archivos/autor/buscar' => 'archivos/autor#buscar'
  # archivos/categoria
  get 'archivos/categoria/listar' => 'archivos/categoria#listar'
  post 'archivos/categoria/guardar' => 'archivos/categoria#guardar'
  get 'archivos/categoria/nombre/:categoria_id' => 'archivos/categoria#nombre'
  get 'archivos/categoria/buscar' => 'archivos/categoria#buscar'
  # archivos/libro
  post 'archivos/libro/guardar_detalle' => 'archivos/libro#guardar_detalle'
  post 'archivos/libro/guardar_archivo' => 'archivos/libro#guardar_archivo'
  get 'archivos/libro/buscar_pagina' => 'archivos/libro#buscar_pagina'
  get 'archivos/libro/count' => 'archivos/libro#count'
  put 'archivos/libro/subir' => 'archivos/libro#subir'
  post 'archivos/libro/guardar' => 'archivos/libro#guardar'
  get 'archivos/libro/listar/autores/:libro_id' => 'archivos/libro#listar_autores'
  get 'archivos/libro/listar/categorias/:libro_id' => 'archivos/libro#listar_categorias'
  post 'archivos/libro/guardar/categoria' => 'archivos/libro#guardar_categoria'
  post 'archivos/libro/guardar/autor' => 'archivos/libro#guardar_autor'
  get 'archivos/libro/obtener/:libro_id' => 'archivos/libro#obtener'
  get 'archivos/libro/ruta/:libro_id' => 'archivos/libro#ruta'
  # archivos/video
  post 'archivos/video/guardar_detalle' => 'archivos/video#guardar_detalle'
  post 'archivos/video/guardar_archivo' => 'archivos/video#guardar_archivo'
  get 'archivos/video/buscar_pagina' => 'archivos/video#buscar_pagina'
  get 'archivos/video/count' => 'archivos/video#count'
  put 'archivos/video/subir' => 'archivos/video#subir'
  post 'archivos/video/guardar' => 'archivos/video#guardar'
  get 'archivos/video/listar/autores/:video_id' => 'archivos/video#listar_autores'
  get 'archivos/video/listar/categorias/:video_id' => 'archivos/video#listar_categorias'
  post 'archivos/video/guardar/categoria' => 'archivos/video#guardar_categoria'
  post 'archivos/video/guardar/autor' => 'archivos/video#guardar_autor'
  get 'archivos/video/obtener/:video_id' => 'archivos/video#obtener'
  get 'archivos/video/ruta/:video_id' => 'archivos/video#ruta'
  # errores
  get 'error/access/:id' => 'error#access'
  get '*unmatched_route' => 'application#not_found'
  post '*unmatched_route' => 'application#not_found'
end
