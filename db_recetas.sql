-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.favorito_receta_usuario
(
    id serial NOT NULL,
    id_receta integer,
    valoracion integer,
    descripcion character varying COLLATE pg_catalog."default",
    id_usuario integer,
    CONSTRAINT favorito_receta_usuario_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.ingrediente_receta
(
    id serial NOT NULL,
    id_ingrediente integer,
    cantidad integer,
    CONSTRAINT ingrediente_receta_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.ingrediente_usuario
(
    id serial NOT NULL,
    id_ingrediente integer,
    id_usuario double precision,
    CONSTRAINT ingrediente_usuario_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.ingredientes
(
    id serial NOT NULL,
    descripcion character varying COLLATE pg_catalog."default",
    CONSTRAINT ingredientes_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.perfiles
(
    id serial NOT NULL,
    descripcion character varying COLLATE pg_catalog."default",
    CONSTRAINT perfiles_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.procedimiento_receta
(
    id serial NOT NULL,
    id_receta integer,
    descripcion character varying COLLATE pg_catalog."default",
    tiempo double precision,
    CONSTRAINT "PK_228546c949ba4463d865755ab4f" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.procedimientos
(
    id serial NOT NULL,
    descripcion character varying COLLATE pg_catalog."default",
    tiempo double precision,
    CONSTRAINT procedimientos_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.recetas
(
    id serial NOT NULL,
    id_usuario integer,
    descripcion character varying COLLATE pg_catalog."default",
    CONSTRAINT recetas_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.usuarios
(
    id serial NOT NULL,
    nombre_completo character varying COLLATE pg_catalog."default",
    username character varying COLLATE pg_catalog."default",
    password character varying COLLATE pg_catalog."default",
    id_perfil integer,
    CONSTRAINT usuarios_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.valoracion_receta
(
    id serial NOT NULL,
    id_receta integer,
    valoracion integer,
    CONSTRAINT valoracion_receta_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.valoracion_receta
    ADD CONSTRAINT fk_receta FOREIGN KEY (id_receta)
    REFERENCES public.recetas (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE SET NULL;

END;