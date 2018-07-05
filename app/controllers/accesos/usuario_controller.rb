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

  def contrasenia_repetida
    rpta = nil
    status = 200
    begin
      r = HTTParty.post(
        CONSTANTS[:servicios][:accesos][:url] + 'usuario/contrasenia_repetida',
        headers:{
          CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        },
        body:{
          :data => params[:data],
        })
      status = r.code
      rpta = r.body
		rescue Exception => e
      rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error realizar validar la contrasenia repetida del servicio',
					e.message
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end

  def correo_repetido
    rpta = nil
    status = 200
    begin
      r = HTTParty.post(
        CONSTANTS[:servicios][:accesos][:url] + 'usuario/correo_repetido',
        headers:{
          CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        },
        body:{
          :data => params[:data],
        })
      status = r.code
      rpta = r.body
		rescue Exception => e
      rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error realizar validar el correo de usuario del servicio',
					e.message
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end

  def guardar_usuario_correo
    rpta = nil
    status = 200
    begin
      r = HTTParty.post(
        CONSTANTS[:servicios][:accesos][:url] + 'usuario/guardar_usuario_correo',
        headers:{
          CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        },
        body:{
          :usuario => params[:usuario],
        })
      status = r.code
      rpta = r.body
		rescue Exception => e
      rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error realizar guardar de usuario del servicio',
					e.message
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end

  def guardar_contrasenia
    rpta = nil
    status = 200
    begin
      r = HTTParty.post(
        CONSTANTS[:servicios][:accesos][:url] + 'usuario/guardar_contrasenia',
        headers:{
          CONSTANTS[:servicios][:accesos][:csrf_key] => CONSTANTS[:servicios][:accesos][:csrf_value],
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        },
        body:{
          :contrasenia => params[:contrasenia],
        })
      status = r.code
      rpta = r.body
		rescue Exception => e
      rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error actualizar la contraseña del usuario con el servicio',
					e.message
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end
end
