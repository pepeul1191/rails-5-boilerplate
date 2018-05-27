class Archivos::AutorController < ApplicationController
	#protect_from_forgery except: :listar
	def listar
		rpta = nil
		status = 200
		begin
			rpta = Archivos::Autor.all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los autores',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def buscar_pagina
		rpta = nil
		status = 200
		begin
			data = JSON.parse(params['data'])
		  step = data['step']
		  page = data['page']
			inicio = (page - 1) * step
			rpta = Archivos::Autor.order(:id).limit(step, inicio).to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los autores',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def count
		rpta = nil
		status = 200
		begin
			rpta = Archivos::Autor.all().count
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en contar los autores',
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
		DB_ARCHIVOS.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Archivos::Autor.new(:nombre => nuevo['nombre'],)
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Archivos::Autor.where(:id => editado['id']).first
						e.nombre = editado['nombre']
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Archivos::Autor.where(:id => eliminado).delete
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
					'Se ha registrado los cambios en los autores',
					array_nuevos
					]
				}.to_json
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en guardar la tabla de autores',
					execption.message]
				}.to_json
		end
		render :plain => rpta, :status => status
	end

  def nombre
    rpta = nil
    status = 200
    begin
      temp = Archivos::Autor.select(:nombre).where(:id => params[:autor_id]).first
      rpta = temp.nombre
    rescue Exception => e
      rpta = {
        :tipo_mensaje => 'error',
        :mensaje => [
          'Se ha producido un error el nombre del autor',
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
			rpta = Archivos::Autor.where(Sequel.like(:nombre, params[:nombre] + '%')).limit(10).to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en buscar coincidencias en los nombres de los autores',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end
end
