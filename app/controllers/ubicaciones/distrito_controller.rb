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

	def guardar
		rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		nuevos = data['nuevos']
		editados = data['editados']
		eliminados = data['eliminados']
		usuario_id = data['extra']
		provincia_id = data['extra']['provincia_id']
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_UBICACIONES.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Ubicaciones::Distrito.new(:nombre => nuevo['nombre'], :provincia_id => provincia_id)
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Ubicaciones::Distrito.where(:id => editado['id']).first
						e.nombre = editado['nombre']
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Ubicaciones::Distrito.where(:id => eliminado).delete
					end
				end
			rescue Exception => e
				Sequel::Rollback
				error = true
				execption = e
			end
		end
		if error == false
			rpta = {
				:tipo_mensaje => 'success',
				:mensaje => [
					'Se ha registrado los cambios en los distritos',
					array_nuevos
					]
				}.to_json
		else
			status 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en guardar la tabla de distritos',
					execption.message
					]
				}.to_json
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
			temp = Ubicaciones::DistritoProvinciaDepartamento.select(:nombre).where(:id => params[:distrito_id]).first
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
