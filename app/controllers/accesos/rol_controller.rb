class Accesos::RolController < ApplicationController
  def listar
    rpta = nil
    status = 200
    begin
      r = HTTParty.get(
        CONSTANTS[:servicios][:accesos][:url] + 'rol/listar/' + params[:sistema_id],
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
					'No se pudo obtener la lista de roles del sistema',
					'Se ha producido un error de comunicación con el servicio de accesos'
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end

  def guardar
    rpta = nil
    status = 200
    begin
      r = HTTParty.post(
        CONSTANTS[:servicios][:accesos][:url] + 'rol/guardar',
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
					'No se ha podido grabar los cambios de los roles',
					'Se ha producido un error de comunicación con el servicio de accesos'
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end

  def listar_permiso
    rpta = nil
    status = 200
    begin
      r = HTTParty.get(
        CONSTANTS[:servicios][:accesos][:url] + 'rol/permiso/listar/' + params[:sistema_id] + '/' + params[:rol_id],
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
					'No se pudo obtener la lista de permisos del rol',
					'Se ha producido un error de comunicación con el servicio de accesos'
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end

  def guardar_permiso
    rpta = nil
    status = 200
    begin
      r = HTTParty.post(
        CONSTANTS[:servicios][:accesos][:url] + 'rol/permiso/guardar',
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
          'No se ha podido grabar los cambios de los permisos del rol',
          'Se ha producido un error de comunicación con el servicio de accesos'
        ]
      }.to_json
      status = 500
    end
    render :plain => rpta, :status => status
  end
end
