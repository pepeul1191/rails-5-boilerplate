class Accesos::UsuarioController < ApplicationController
  def listar
    rpta = nil
    status = 200
    begin
      r = HTTParty.get(
        CONSTANTS[:servicios][:accesos][:url] + 'usuario/listar',
        headers:{
          CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        },
        query:{})
      status = r.code
      rpta = r.body
		rescue Exception => e
      rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error obtener el listado de usuarios del servicio',
					e.message
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end

  def obtener_usuario_correo
    rpta = nil
    status = 200
    begin
      r = HTTParty.get(
        CONSTANTS[:servicios][:accesos][:url] + 'usuario/obtener_usuario_correo/' + params[:usuario_id],
        headers:{
          CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        },
        query:{})
      status = r.code
      rpta = r.body
		rescue Exception => e
      rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error obtener el usuario del servicio',
					e.message
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end
end
