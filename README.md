## Rails 5.2 Boilerplate

### Instalar Dependencias

    $ bundler install
    $ bower install
    $ npm install

### Migraciones

Ejecutar migración

    $ sequel -m db/migrations -M #version postgres://host/database
    $ sequel -m db/migrations -M #version sqlite://db/gestion.db
    $ sequel -m db/migrations -M #version mysql://root:123@localhost/gestion

Ejecutar el 'down' de las migraciones de la última a la primera:

    $ sequel -m db/migrations -M 0 mysql://root:123@localhost/gestion

Ejecutar el 'up' de las migraciones hasta un versión especifica:

    $ sequel -m db/migrations -M #version mysql://root:123@localhost/gestion

Crear migración de ubicaciones:

    $ sequel -m db/migrations_ubicaciones -M 2 sqlite://db/ubicaciones.db

Crear Vista de distrito/provincia/departamento

    MySQL
    >> CREATE VIEW vw_distrito_provincia_departamento AS select DI.id AS id, PA.id AS pais_id, concat(DI.nombre,', ',PR.nombre,', ',DE.nombre) AS nombre from ((distritos DI join provincias PR on((DI.provincia_id = PR.id))) join departamentos DE on((PR.departamento_id = DE.id))) join paises PA on((DE.pais_id = PA.id)) limit 2000;

    SQLite
    >> CREATE VIEW vw_distrito_provincia_departamentos AS select DI.id AS id,  DI.nombre || ', '  || PR.nombre || ', '  || DE.nombre AS nombre
    from distritos DI join provincias PR on DI.provincia_id = PR.id join departamentos DE on PR.departamento_id = DE.id limit 2000;

    >> DROP VIEW IF EXISTS vw_libros_categorias;
    CREATE VIEW vw_libros_categorias AS SELECT
    LC.id, C.id AS categoria_id, C.nombre AS categoria_nombre,  L.id AS libro_id, L.nombre as libro_nombre FROM
    libros_categorias LC
    INNER JOIN categorias C ON C.id = LC.categoria_id  
    INNER JOIN libros L ON  LC.libro_id = L.id
    LIMIT 2000;

    >> DROP VIEW IF EXISTS vw_libros_autores;
    CREATE VIEW vw_libros_autores AS SELECT
    LA.id, A.id AS autor_id, A.nombre AS autor_nombre, L.id AS libro_id, L.nombre as libro_nombre FROM
    libros_autores LA
    INNER JOIN autores A ON A.id = LA.autor_id  
    INNER JOIN libros L ON  LA.libro_id = L.id
    LIMIT 2000;

    >>DROP VIEW IF EXISTS vw_libros_archivos;
    CREATE VIEW vw_libros_archivos AS SELECT
    L.id, L.nombre, L.anio, L.paginas, L.archivo_id, A.nombre as libro_nombre, A.ruta || A.nombre || '.' || E.nombre AS libro_ruta FROM
    libros L
    INNER JOIN archivos A ON A.id = L.archivo_id  
    INNER JOIN extensiones E ON A.extension_id = E.id  
    LIMIT 2000;

    >> DROP VIEW IF EXISTS vw_videos_categorias;
    CREATE VIEW vw_videos_categorias AS SELECT
    VC.id, C.id AS categoria_id, C.nombre AS categoria_nombre, V.id AS video_id, V.nombre as video_nombre FROM
    videos_categorias VC
    INNER JOIN categorias C ON C.id = VC.categoria_id  
    INNER JOIN videos V ON  VC.video_id = V.id
    LIMIT 2000;

    >> DROP VIEW IF EXISTS vw_videos_autores;
    CREATE VIEW vw_videos_autores AS SELECT
    VA.id AS id, A.id AS autor_id, A.nombre AS autor_nombre, V.id AS video_id, V.nombre as video_nombre FROM
    videos_autores VA
    INNER JOIN autores A ON A.id = VA.autor_id  
    INNER JOIN videos V ON  VA.video_id = V.id
    LIMIT 2000;

    >> DROP VIEW IF EXISTS vw_videos_archivos;
    CREATE VIEW vw_videos_archivos AS SELECT
    V.id, V.nombre, V.anio, V.paginas, V.archivo_id, A.nombre as libro_nombre, A.ruta || A.nombre || '.' || E.nombre AS video_ruta FROM
    videos V
    INNER JOIN archivos A ON A.id = V.archivo_id  
    INNER JOIN extensiones E ON A.extension_id = E.id  
    LIMIT 2000;

Crear migración de archivos:

    $ sequel -m db/migrations_archivos -M 11 sqlite://db/archivos.db

Tipos de Datos de Columnas

+ :string=>String
+ :integer=>Integer
+ :date=>Date
+ :datetime=>[Time, DateTime].freeze,
+ :time=>Sequel::SQLTime,
+ :boolean=>[TrueClass, FalseClass].freeze,
+ :float=>Float
+ :decimal=>BigDecimal
+ :blob=>Sequel::SQL::Blob

Si se presenta el siguiente error:

  > $ FATAL: Listen error: unable to monitor directories for changes.

---

Se corrige con el siguiente código:

  $ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

---

Fuentes:

+ https://github.com/pepeul1191/rails-pp-mono
+ https://github.com/pepeul1191/ruby-gestion.git
+ https://stackoverflow.com/questions/42225677/listen-error-unable-to-monitor-directories-for-changes?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
