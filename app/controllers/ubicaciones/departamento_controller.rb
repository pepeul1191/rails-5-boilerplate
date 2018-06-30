class Ubicaciones::DepartamentoController < ApplicationController
	#protect_from_forgery except: :listar
	before_action :validate_csrf
	def listar
		rpta = nil
		status = 200
		begin
			rpta = Ubicaciones::Departamento.all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los departamento',
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
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_UBICACIONES.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Ubicaciones::Departamento.new(:nombre => nuevo['nombre'])
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Ubicaciones::Departamento.where(:id => editado['id']).first
						e.nombre = editado['nombre']
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Ubicaciones::Departamento.where(:id => eliminado).delete
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
					'Se ha registrado los cambios en los departamentos',
					array_nuevos
					]
				}.to_json
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en guardar la tabla de departamentos',
					execption.message]
				}.to_json
		end
		render :plain => rpta, :status => status
	end
end
