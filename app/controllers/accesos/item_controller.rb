class Accesos::ItemController < ApplicationController
  def listar
    rpta = nil
    status = 200
    begin
      r = HTTParty.get(
        CONSTANTS[:servicios][:accesos][:url] + 'item/listar/' + params[:subtitulo_id],
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
					'Se ha producido un error obtener el listado de items del servicio',
					e.message
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
        CONSTANTS[:servicios][:accesos][:url] + 'item/guardar',
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
					'Se ha producido un error realizar los cambios de items del servicio',
					e.message
				]
			}.to_json
			status = 500
		end
    render :plain => rpta, :status => status
  end
end
