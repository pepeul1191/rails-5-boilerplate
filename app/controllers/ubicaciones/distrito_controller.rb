class Ubicaciones::DistritoController < ApplicationController
	#protect_from_forgery except: :listar
	def listar
		rpta = nil
		status = 200
		begin
      #Item.select(:id, :nombre, :url).where(:subtitulo_id => params['subtitulo_id']).all().to_a.to_json
			rpta = Ubicaciones::Distrito.select(:id, :nombre).where(:provincia_id => params[:provincia_id]).all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los distritos de la provincia',
					e.message
				]
			}.to_json
		end
		render :plain => rpta, :status => status
	end
end
