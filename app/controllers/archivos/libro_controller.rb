class Archivos::LibroController < ApplicationController
	#protect_from_forgery except: :listar
	def guardar_detalle
		rpta = nil
		status = 200
		data = JSON.parse(params[:data])
		begin
			if data['id'] == 'E'
				libro = Archivos::Libro.new(:nombre => data['nombre'], :paginas => data['paginas'], :anio => data['anio'])
				libro.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha registrado el detalle de un nuevo libro',
						libro.id,
					]
				}.to_json
			else
				archivo = Archivos::Libro.where(:id => data['id']).first
				archivo.nombre = data['nombre']
				archivo.paginas = data['paginas']
				archivo.anio = data['anio']
				archivo.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha editado el detalle de libro',
					]
				}.to_json
			end
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en registrar el detalle del libro',
					e.message
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
						'Debe primeo guardar el detalle del libro',
						libro.id,
					]
				}.to_json
			else
				archivo = Archivos::Libro.where(:id => data['id']).first
				archivo.archivo_id = data['archivo_id']
				archivo.save
				rpta = {
					:tipo_mensaje => 'success',
					:mensaje => [
						'Se ha agregado el documento al libro',
					]
				}.to_json
			end
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en anexar el archivo al libro',
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
			ruta = 'public/libros/'
			# mover el archivo
      FileUtils.mv(params[:myFile].path, ruta + nombre + '.' + extension)
			archivo = Archivos::Archivo.new(:nombre => (nombre + '.' + extension), :ruta => ruta, :extension_id => extension_id)
			archivo.save
      rpta = {
				:tipo_mensaje => 'success',
				:mensaje => [
					'Se ha cargado un nuevo libro',
					archivo.id,
          CONSTANTS[:STATIC_URL] + 'libros/' + params[:nombre] + '.' + extension
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
			#rpta = Archivos::Libro.select(:id, :nombre, :paginas).order(:id).limit(step, inicio).to_a.to_json
			libros = Archivos::Libro.select(:id, :nombre, :paginas).order(:id).limit(step, inicio).to_a
			rpta = []
			libros.each do |libro|
				temp = Hash.new
				temp[:id] = libro.id
				temp[:nombre] = libro.nombre
				temp[:paginas] = libro.paginas
				temp[:autores] = ''
				temp[:categorias] = ''
				k = 0
				autores = Archivos::VWLibroAutor.select(:autor_nombre).where(:libro_id => libro.id).to_a
				autores.each do |autor|
					if k == 0
						temp[:autores] = autor.autor_nombre
					else
						temp[:autores] = temp[:autores] + ', ' + autor.autor_nombre
					end
					k = k + 1
				end
				k = 0
				categorias = Archivos::VWLibroCategoria.select(:categoria_nombre).where(:libro_id => libro.id).to_a
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
					'Se ha producido un error en listar los libros',
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
			rpta = Archivos::Libro.all().count
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en contar los libros',
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
			rpta = Archivos::VWLibroCategoria.select(:libro_id, :categoria_id, :categoria_nombre).where(:libro_id => params[:libro_id]).all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar las categorias del libro',
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
		libro_id = data['extra']['libro_id']
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_ARCHIVOS.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Archivos::LibroCategoria.new(:libro_id => libro_id, :categoria_id => nuevo['categoria_id'])
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Archivos::LibroCategoria.where(:id => editado['id']).first
						e.categoria_id = editado['categoria_id']
						e.libro_id = editado['libro_id']
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Archivos::LibroCategoria.where(:id => eliminado).delete
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
					'Se ha registrado los cambios en las asociaciones de las categorias al libro',
					array_nuevos
					]
				}.to_json
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en asociar las categorias al libro',
					execption.message]
				}.to_json
		end
		render :plain => rpta, :status => status
	end

	def listar_autores
		rpta = nil
		status = 200
		begin
			rpta = Archivos::VWLibroAutor.select(:autor_id, :autor_nombre).where(:libro_id => params[:libro_id]).all().to_a.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en listar los autores del libro',
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
		libro_id = data['extra']['libro_id']
		rpta = []
		array_nuevos = []
		error = false
		execption = nil
		DB_ARCHIVOS.transaction do
			begin
				if nuevos.length != 0
					nuevos.each do |nuevo|
						n = Archivos::LibroAutor.new(:libro_id => libro_id, :autor_id => nuevo['autor_id'])
						n.save
						t = {:temporal => nuevo['id'], :nuevo_id => n.id}
						array_nuevos.push(t)
					end
				end
				if editados.length != 0
					editados.each do |editado|
						e = Archivos::LibroAutor.where(:id => editado['id']).first
						e.autor_id = editado['autor_id']
						e.libro_id = editado['libro_id']
						e.save
					end
				end
				if eliminados.length != 0
					eliminados.each do |eliminado|
						Archivos::LibroAutor.where(:id => eliminado).delete
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
					'Se ha registrado los cambios en las asociaciones de los autores al libro',
					array_nuevos
					]
				}.to_json
		else
			status = 500
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en asociar los autores al libro',
					execption.message]
				}.to_json
		end
		render :plain => rpta, :status => status
	end

	def obtener
		rpta = nil
		status = 200
		begin
			rpta = Archivos::Libro.where(:id => params[:libro_id]).first.to_json
		rescue Exception => e
			rpta = {
				:tipo_mensaje => 'error',
				:mensaje => [
					'Se ha producido un error en obtener los datos del libro',
					e.message
				]
			}.to_json
			status = 500
		end
		render :plain => rpta, :status => status
	end
end
