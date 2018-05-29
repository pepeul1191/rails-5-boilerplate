class Archivos::VideoController < ApplicationController
	#protect_from_forgery except: :listar
	def guardar_detalle
		rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		begin
			if data['id'] == 'E'
				video = Archivos::Video.new(:nombre => data['nombre'], :duracion => data['duracion'], :anio => data['anio'])
				video.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha registrado el detalle de un nuevo video',
						video.id,
					]
				}.to_json
			else
				archivo = Archivos::Video.where(:id => data['id']).first
				archivo.nombre = data['nombre']
				archivo.duracion = data['duracion']
				archivo.anio = data['anio']
				archivo.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha editado el detalle de video',
					]
				}.to_json
			end
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en registrar el detalle del video',
					e
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def guardar_archivo
		rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		begin
			if data['id'] == 'E'
				status = 500
				rpta = {
					:tipo_mensaje => 'error',
					:mensaje => [
						'Debe primeo guardar el detalle del video',
						video.id,
					]
				}.to_json
			else
				archivo = Archivos::Video.where(:id => data['id']).first
				archivo.archivo_id = data['archivo_id']
				archivo.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha agregado el documento al video',
					]
				}.to_json
			end
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en anexar el archivo al video',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def subir
		rpta = nil
		status = 200
		begin
      file_name_array = params[:myFile].path.split('.')
      extension = file_name_array[file_name_array.length - 1].strip
			extension_id = Archivos::Extension.select(:id).where(:nombre => extension).first.id
			Archivos::Extension.select(:nombre, :mime).where(:id => params[:extension_id]).first.to_json
			nombre = params[:nombre]
			ruta = 'public/videos/'
			# mover el archivo
      FileUtils.mv(params[:myFile].path, ruta + nombre + '.' + extension)
			archivo = Archivos::Archivo.new(:nombre => nombre, :ruta => 'videos/', :extension_id => extension_id)
			archivo.save
      rpta = {
				:tipo_mensaje => 'success',
				:mensaje => [
					'Se ha cargado un nuevo video',
					archivo.id,
          CONSTANTS[:STATIC_URL] + 'videos/' + params[:nombre] + '.' + extension
				]
			}.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en cargar el archivo',
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
			#rpta = Archivos::Video.select(:id, :nombre, :duracion).order(:id).limit(step, inicio).to_a.to_json
			videos = Archivos::Video.select(:id, :nombre, :duracion, :anio).order(:id).limit(step, inicio).to_a
			rpta = []
			videos.each do |video|
				temp = Hash.new
				temp[:id] = video.id
				temp[:nombre] = video.nombre
				temp[:duracion] = video.duracion
				temp[:anio] = video.anio
				temp[:autores] = ''
				temp[:categorias] = ''
				k = 0
				autores = Archivos::VWVideoAutor.select(:autor_nombre).where(:video_id => video.id).to_a
        puts autores
				autores.each do |autor|

					if k == 0
						temp[:autores] = autor.autor_nombre
					else
						temp[:autores] = temp[:autores] + ', ' + autor.autor_nombre
					end
					k = k + 1
				end
				k = 0
				categorias = Archivos::VWVideoCategoria.select(:categoria_nombre).where(:video_id => video.id).to_a
				categorias.each do |categoria|
					if k == 0
						temp[:categorias] = categoria.categoria_nombre
					else
						temp[:categorias] = temp[:categorias] + ', ' + categoria.categoria_nombre
					end
					k = k +1
				end
				rpta.push(temp)
			end
			rpta = rpta.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los videos',
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
			rpta = Archivos::Video.all().count
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en contar los videos',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def listar_categorias
		rpta = nil
		status = 200
		begin
			rpta = Archivos::VWVideoCategoria.select(:id, :video_id, :categoria_id, :categoria_nombre).where(:video_id => params[:video_id]).all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar las categorias del video',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def guardar_categoria
		rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		nuevos = data['nuevos']
		editados = data['editados']
		eliminados = data['eliminados']
		video_id = data['extra']['video_id']
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_ARCHIVOS.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Archivos::VideoCategoria.new(:video_id => video_id, :categoria_id => nuevo['categoria_id'])
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Archivos::VideoCategoria.where(:id => editado['id']).first
						e.categoria_id = editado['categoria_id']
						e.video_id = video_id
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Archivos::VideoCategoria.where(:id => eliminado).delete
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
					'Se ha registrado los cambios en las asociaciones de las categorias al video',
					array_nuevos
					]
				}.to_json
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en asociar las categorias al video',
					execption.message]
				}.to_json
		end
		render :plain => rpta, :status => status
	end

	def listar_autores
		rpta = nil
		status = 200
		begin
			rpta = Archivos::VWVideoAutor.select(:id, :autor_id, :autor_nombre).where(:video_id => params[:video_id]).all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los autores del video',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end

	def guardar_autor
		rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		nuevos = data['nuevos']
		editados = data['editados']
		eliminados = data['eliminados']
		video_id = data['extra']['video_id']
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_ARCHIVOS.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Archivos::VideoAutor.new(:video_id => video_id, :autor_id => nuevo['autor_id'])
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Archivos::VideoAutor.where(:id => editado['id']).first
						e.autor_id = editado['autor_id']
						e.video_id = video_id
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Archivos::VideoAutor.where(:id => eliminado).delete
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
					'Se ha registrado los cambios en las asociaciones de los autores al video',
					array_nuevos
					]
				}.to_json
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en asociar los autores al video',
					execption.message]
				}.to_json
		end
		render :plain => rpta, :status => status
	end

	def obtener
		rpta = nil
		status = 200
		begin
			rpta = Archivos::VWVideoArchivo.where(:id => params[:video_id]).first.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en obtener los datos del video',
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
		eliminados = data['eliminados']
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_ARCHIVOS.transaction do
			begin
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Archivos::VideoAutor.where(:video_id => eliminado).delete
						Archivos::VideoCategoria.where(:video_id => eliminado).delete
						Archivos::Video.where(:id => eliminado).delete
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
					'Se ha registrado los cambios en los videos',
					array_nuevos
					]
				}.to_json
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en guardar la tabla de videos',
					execption.message]
				}.to_json
		end
		render :plain => rpta, :status => status
	end

	def ruta
		rpta = nil
		status = 200
		begin
			temp = Archivos::VWVideoArchivo.where(:id => params[:video_id]).first
			rpta = CONSTANTS[:BASE_URL] + temp.video_ruta
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en mostrar el video',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end
end
