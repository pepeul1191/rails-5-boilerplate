class Ubicaciones::DistritoController < ApplicationController
	#protect_from_forgery except: :listar
	def listar
		rpta = nil
		status = 200
		begin
			rpta = Ubicaciones::Distrito.select(:id, :nombre).where(:provincia_id => params[:provincia_id]).all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los distritos de la provincia',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

  def buscar
		rpta = nil
		status = 200
		begin
			rpta = Ubicaciones::DistritoProvinciaDepartamento.where(Sequel.like(:nombre, params[:nombre] + '%')).limit(10).to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en buscar coincidencias en los nombres de los distritos',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def nombre
		rpta = nil
		status = 200
		begin
			temp = DistritoProvinciaDepartamento.select(:nombre).where(:id => params[:distrito_id]).first
			rpta = temp.nombre
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en buscar coincidencias en los nombres de los distritos',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end
end
