-- Table: public.activo_riesgo_medidas

-- DROP TABLE IF EXISTS public.activo_riesgo_medidas;

CREATE TABLE IF NOT EXISTS asset_risk_measures
(
    asset_risk_measures_id integer NOT NULL AUTO_INCREMENT,
    asset_risk_measures_company_id integer,
    asset_risk_measures_asset_id integer,
    asset_risk_measures_asset_type varchar(250),
    asset_risk_measures_risk_id integer,
    asset_risk_measures_measure_id integer,
    asset_risk_measures_status integer,
    asset_risk_measures_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    asset_risk_measures_updated_at TIMESTAMP,
    CONSTRAINT PRIMARY KEY (asset_risk_measuresasset_risk_measures_id)
    #CONSTRAINT companies.company_id FOREIGN KEY REFERENCES (asset_risk_measure_company_id),
    #CONSTRAINT asset.asset_id FOREIGN KEY REFERENCES (asset_risk_measure_asset_id),
    #CONSTRAINT risk.risk_id FOREIGN KEY REFERENCES (asset_risk_measures_risk_id),
    #CONSTRAINT measure.measure_id FOREIGN KEY REFERENCES (asset_risk_measures_measure_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.activo_riesgo_medidas
    OWNER to compaas_app;
-- Index: index_activo_riesgo_control_on_emp_act_ri_and_ct

-- DROP INDEX IF EXISTS public.index_activo_riesgo_control_on_emp_act_ri_and_ct;

CREATE INDEX IF NOT EXISTS index_activo_riesgo_control_on_emp_act_ri_and_ct
    ON public.activo_riesgo_medidas USING btree
    (empresa_id ASC NULLS LAST, activo_type COLLATE pg_catalog."default" ASC NULLS LAST, activo_id ASC NULLS LAST, riesgo_id ASC NULLS LAST, medida_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_activo_riesgo_medidas_on_activo_type_and_activo_id

-- DROP INDEX IF EXISTS public.index_activo_riesgo_medidas_on_activo_type_and_activo_id;

CREATE INDEX IF NOT EXISTS index_activo_riesgo_medidas_on_activo_type_and_activo_id
    ON public.activo_riesgo_medidas USING btree
    (activo_type COLLATE pg_catalog."default" ASC NULLS LAST, activo_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_activo_riesgo_medidas_on_empresa_id

-- DROP INDEX IF EXISTS public.index_activo_riesgo_medidas_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_activo_riesgo_medidas_on_empresa_id
    ON public.activo_riesgo_medidas USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_activo_riesgo_medidas_on_empresa_id_and_medida_id

-- DROP INDEX IF EXISTS public.index_activo_riesgo_medidas_on_empresa_id_and_medida_id;

CREATE INDEX IF NOT EXISTS index_activo_riesgo_medidas_on_empresa_id_and_medida_id
    ON public.activo_riesgo_medidas USING btree
    (empresa_id ASC NULLS LAST, medida_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_activo_riesgo_medidas_on_medida_id

-- DROP INDEX IF EXISTS public.index_activo_riesgo_medidas_on_medida_id;

CREATE INDEX IF NOT EXISTS index_activo_riesgo_medidas_on_medida_id
    ON public.activo_riesgo_medidas USING btree
    (medida_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_activo_riesgo_medidas_on_riesgo_id

-- DROP INDEX IF EXISTS public.index_activo_riesgo_medidas_on_riesgo_id;

CREATE INDEX IF NOT EXISTS index_activo_riesgo_medidas_on_riesgo_id
    ON public.activo_riesgo_medidas USING btree
    (riesgo_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.articulos

-- DROP TABLE IF EXISTS public.articulos;

CREATE TABLE IF NOT EXISTS public.articulos
(
    id integer NOT NULL DEFAULT nextval('articulos_id_seq'::regclass),
    descripcion text COLLATE pg_catalog."default",
    norma_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    referencia character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT articulos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.articulos
    OWNER to compaas_app;
-- Index: index_articulos_on_norma_id

-- DROP INDEX IF EXISTS public.index_articulos_on_norma_id;

CREATE INDEX IF NOT EXISTS index_articulos_on_norma_id
    ON public.articulos USING btree
    (norma_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.auditoria_normas

-- DROP TABLE IF EXISTS public.auditoria_normas;

CREATE TABLE IF NOT EXISTS public.auditoria_normas
(
    id integer NOT NULL DEFAULT nextval('auditoria_normas_id_seq'::regclass),
    auditoria_id integer,
    norma_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT auditoria_normas_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_8498ee424f FOREIGN KEY (auditoria_id)
        REFERENCES public.auditorias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_a9dd4780c8 FOREIGN KEY (norma_id)
        REFERENCES public.normas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.auditoria_normas
    OWNER to compaas_app;
-- Index: index_auditoria_normas_on_auditoria_id

-- DROP INDEX IF EXISTS public.index_auditoria_normas_on_auditoria_id;

CREATE INDEX IF NOT EXISTS index_auditoria_normas_on_auditoria_id
    ON public.auditoria_normas USING btree
    (auditoria_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_auditoria_normas_on_norma_id

-- DROP INDEX IF EXISTS public.index_auditoria_normas_on_norma_id;

CREATE INDEX IF NOT EXISTS index_auditoria_normas_on_norma_id
    ON public.auditoria_normas USING btree
    (norma_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.auditoria_tratamientos

-- DROP TABLE IF EXISTS public.auditoria_tratamientos;

CREATE TABLE IF NOT EXISTS public.auditoria_tratamientos
(
    id integer NOT NULL DEFAULT nextval('auditoria_tratamientos_id_seq'::regclass),
    auditoria_id integer,
    tratamiento_id integer,
    licitud character varying COLLATE pg_catalog."default",
    licitud_acciones text COLLATE pg_catalog."default",
    licitud_recomendaciones text COLLATE pg_catalog."default",
    lealtad character varying COLLATE pg_catalog."default",
    lealtad_acciones text COLLATE pg_catalog."default",
    lealtad_recomendaciones text COLLATE pg_catalog."default",
    transparencia boolean,
    transparencia_acciones text COLLATE pg_catalog."default",
    transparencia_recomendaciones text COLLATE pg_catalog."default",
    limitacion boolean,
    limitacion_recomendaciones text COLLATE pg_catalog."default",
    minimizacion boolean,
    minimizacion_recomendaciones text COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT auditoria_tratamientos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_8542351611 FOREIGN KEY (tratamiento_id)
        REFERENCES public.proceso_tratamientos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_8f9345a331 FOREIGN KEY (auditoria_id)
        REFERENCES public.auditorias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.auditoria_tratamientos
    OWNER to compaas_app;
-- Index: index_auditoria_tratamientos_on_auditoria_id

-- DROP INDEX IF EXISTS public.index_auditoria_tratamientos_on_auditoria_id;

CREATE INDEX IF NOT EXISTS index_auditoria_tratamientos_on_auditoria_id
    ON public.auditoria_tratamientos USING btree
    (auditoria_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_auditoria_tratamientos_on_tratamiento_id

-- DROP INDEX IF EXISTS public.index_auditoria_tratamientos_on_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_auditoria_tratamientos_on_tratamiento_id
    ON public.auditoria_tratamientos USING btree
    (tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.auditorias

-- DROP TABLE IF EXISTS public.auditorias;

CREATE TABLE IF NOT EXISTS public.auditorias
(
    id integer NOT NULL DEFAULT nextval('auditorias_id_seq'::regclass),
    empresa_id integer,
    fecha_inicio date,
    fecha_informe_preliminar date,
    fecha_informe_definitivo date,
    destinatarios text COLLATE pg_catalog."default",
    redactor_id integer,
    responsable_id integer,
    lugar character varying COLLATE pg_catalog."default",
    responsabilidad_proactiva boolean,
    recomendaciones_responsabilidad text COLLATE pg_catalog."default",
    procedimiento_ejercicio_derechos boolean,
    nombre_procedimiento_ejercicio_derechos character varying COLLATE pg_catalog."default",
    recomendaciones_derechos text COLLATE pg_catalog."default",
    procedimiento_notificacion boolean,
    nombre_procedimiento_notificacion character varying COLLATE pg_catalog."default",
    recomendaciones_violaciones text COLLATE pg_catalog."default",
    completed_at timestamp without time zone,
    CONSTRAINT auditorias_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_4eb52d0cdb FOREIGN KEY (empresa_id)
        REFERENCES public.empresas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_692b005b4f FOREIGN KEY (responsable_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_df6faffb18 FOREIGN KEY (redactor_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.auditorias
    OWNER to compaas_app;
-- Index: index_auditorias_on_empresa_id

-- DROP INDEX IF EXISTS public.index_auditorias_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_auditorias_on_empresa_id
    ON public.auditorias USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_auditorias_on_redactor_id

-- DROP INDEX IF EXISTS public.index_auditorias_on_redactor_id;

CREATE INDEX IF NOT EXISTS index_auditorias_on_redactor_id
    ON public.auditorias USING btree
    (redactor_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_auditorias_on_responsable_id

-- DROP INDEX IF EXISTS public.index_auditorias_on_responsable_id;

CREATE INDEX IF NOT EXISTS index_auditorias_on_responsable_id
    ON public.auditorias USING btree
    (responsable_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.campos

-- DROP TABLE IF EXISTS public.campos;

CREATE TABLE IF NOT EXISTS public.campos
(
    id integer NOT NULL DEFAULT nextval('campos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    fichero_juridico_id integer,
    CONSTRAINT campos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.campos
    OWNER to compaas_app;
-- Index: index_campos_on_fichero_juridico_id

-- DROP INDEX IF EXISTS public.index_campos_on_fichero_juridico_id;

CREATE INDEX IF NOT EXISTS index_campos_on_fichero_juridico_id
    ON public.campos USING btree
    (fichero_juridico_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.campos_ficheros

-- DROP TABLE IF EXISTS public.campos_ficheros;

CREATE TABLE IF NOT EXISTS public.campos_ficheros
(
    id integer NOT NULL DEFAULT nextval('campos_ficheros_id_seq'::regclass),
    campo_id integer,
    fichero_juridico_id integer,
    CONSTRAINT campos_ficheros_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.campos_ficheros
    OWNER to compaas_app;


-- Table: public.categoria_criterios

-- DROP TABLE IF EXISTS public.categoria_criterios;

CREATE TABLE IF NOT EXISTS public.categoria_criterios
(
    id integer NOT NULL DEFAULT nextval('categoria_criterios_id_seq'::regclass),
    categoria_id integer,
    criterio_id integer,
    impacto integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT categoria_criterios_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_09b7ed37f8 FOREIGN KEY (criterio_id)
        REFERENCES public.criterios (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_1bc39a2f4a FOREIGN KEY (categoria_id)
        REFERENCES public.categorias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categoria_criterios
    OWNER to compaas_app;
-- Index: index_categoria_criterios_on_categoria_id

-- DROP INDEX IF EXISTS public.index_categoria_criterios_on_categoria_id;

CREATE INDEX IF NOT EXISTS index_categoria_criterios_on_categoria_id
    ON public.categoria_criterios USING btree
    (categoria_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_categoria_criterios_on_criterio_id

-- DROP INDEX IF EXISTS public.index_categoria_criterios_on_criterio_id;

CREATE INDEX IF NOT EXISTS index_categoria_criterios_on_criterio_id
    ON public.categoria_criterios USING btree
    (criterio_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.categoria_proceso_tratamientos

-- DROP TABLE IF EXISTS public.categoria_proceso_tratamientos;

CREATE TABLE IF NOT EXISTS public.categoria_proceso_tratamientos
(
    id integer NOT NULL DEFAULT nextval('categoria_proceso_tratamientos_id_seq'::regclass),
    categoria_id integer,
    proceso_tratamiento_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT categoria_proceso_tratamientos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_d96540adee FOREIGN KEY (proceso_tratamiento_id)
        REFERENCES public.proceso_tratamientos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_fd6a9b4aca FOREIGN KEY (categoria_id)
        REFERENCES public.categorias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categoria_proceso_tratamientos
    OWNER to compaas_app;
-- Index: index_categoria_proceso_tratamientos_on_categoria_id

-- DROP INDEX IF EXISTS public.index_categoria_proceso_tratamientos_on_categoria_id;

CREATE INDEX IF NOT EXISTS index_categoria_proceso_tratamientos_on_categoria_id
    ON public.categoria_proceso_tratamientos USING btree
    (categoria_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_categoria_proceso_tratamientos_on_proceso_tratamiento_id

-- DROP INDEX IF EXISTS public.index_categoria_proceso_tratamientos_on_proceso_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_categoria_proceso_tratamientos_on_proceso_tratamiento_id
    ON public.categoria_proceso_tratamientos USING btree
    (proceso_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.categorias

-- DROP TABLE IF EXISTS public.categorias;

CREATE TABLE IF NOT EXISTS public.categorias
(
    id integer NOT NULL DEFAULT nextval('categorias_id_seq'::regclass),
    type character varying COLLATE pg_catalog."default",
    nombre character varying COLLATE pg_catalog."default",
    descripcion character varying COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT categorias_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categorias
    OWNER to compaas_app;


-- Table: public.centro_tratamiento_externos

-- DROP TABLE IF EXISTS public.centro_tratamiento_externos;

CREATE TABLE IF NOT EXISTS public.centro_tratamiento_externos
(
    id integer NOT NULL DEFAULT nextval('centro_tratamiento_externos_id_seq'::regclass),
    inicio_contrato date,
    fin_contrato date,
    objeto_servicio character varying(255) COLLATE pg_catalog."default",
    contrato character varying(255) COLLATE pg_catalog."default",
    subcontratistas character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT centro_tratamiento_externos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.centro_tratamiento_externos
    OWNER to compaas_app;

-- Table: public.centro_tratamiento_internos

-- DROP TABLE IF EXISTS public.centro_tratamiento_internos;

CREATE TABLE IF NOT EXISTS public.centro_tratamiento_internos
(
    id integer NOT NULL DEFAULT nextval('centro_tratamiento_internos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    descripcion character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT centro_tratamiento_internos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.centro_tratamiento_internos
    OWNER to compaas_app;

-- Table: public.centro_tratamientos

-- DROP TABLE IF EXISTS public.centro_tratamientos;

CREATE TABLE IF NOT EXISTS public.centro_tratamientos
(
    id integer NOT NULL DEFAULT nextval('centro_tratamientos_id_seq'::regclass),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    nombre text COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    tipo character varying(255) COLLATE pg_catalog."default",
    direccion_id integer,
    responsable_id integer,
    empresa_id integer,
    fecha_ultima_auditoria date,
    nivel_criticidad integer DEFAULT 0,
    CONSTRAINT centro_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.centro_tratamientos
    OWNER to compaas_app;
-- Index: index_centro_tratamientos_on_direccion_id

-- DROP INDEX IF EXISTS public.index_centro_tratamientos_on_direccion_id;

CREATE INDEX IF NOT EXISTS index_centro_tratamientos_on_direccion_id
    ON public.centro_tratamientos USING btree
    (direccion_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_centro_tratamientos_on_empresa_id

-- DROP INDEX IF EXISTS public.index_centro_tratamientos_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_centro_tratamientos_on_empresa_id
    ON public.centro_tratamientos USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_centro_tratamientos_on_responsable_id

-- DROP INDEX IF EXISTS public.index_centro_tratamientos_on_responsable_id;

CREATE INDEX IF NOT EXISTS index_centro_tratamientos_on_responsable_id
    ON public.centro_tratamientos USING btree
    (responsable_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.centro_tratamientos_incidencias

-- DROP TABLE IF EXISTS public.centro_tratamientos_incidencias;

CREATE TABLE IF NOT EXISTS public.centro_tratamientos_incidencias
(
    centro_tratamiento_id integer,
    incidencia_id integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.centro_tratamientos_incidencias
    OWNER to compaas_app;
-- Index: centro_tratamientos_incidencias_index

-- DROP INDEX IF EXISTS public.centro_tratamientos_incidencias_index;

CREATE INDEX IF NOT EXISTS centro_tratamientos_incidencias_index
    ON public.centro_tratamientos_incidencias USING btree
    (centro_tratamiento_id ASC NULLS LAST, incidencia_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.certificacions

-- DROP TABLE IF EXISTS public.certificacions;

CREATE TABLE IF NOT EXISTS public.certificacions
(
    id integer NOT NULL DEFAULT nextval('certificacions_id_seq'::regclass),
    type character varying COLLATE pg_catalog."default",
    nombre character varying COLLATE pg_catalog."default",
    group_id integer,
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT certificacions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.certificacions
    OWNER to compaas_app;
-- Index: index_certificacions_on_group_id

-- DROP INDEX IF EXISTS public.index_certificacions_on_group_id;

CREATE INDEX IF NOT EXISTS index_certificacions_on_group_id
    ON public.certificacions USING btree
    (group_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.cesions

-- DROP TABLE IF EXISTS public.cesions;

CREATE TABLE IF NOT EXISTS public.cesions
(
    id integer NOT NULL DEFAULT nextval('cesions_id_seq'::regclass),
    inicio date,
    fin date,
    fichero_juridico_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    receptor character varying(255) COLLATE pg_catalog."default",
    observaciones text COLLATE pg_catalog."default",
    proceso_tratamiento_id integer,
    CONSTRAINT cesions_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_5ef9e9ee78 FOREIGN KEY (proceso_tratamiento_id)
        REFERENCES public.proceso_tratamientos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cesions
    OWNER to compaas_app;
-- Index: index_cesions_on_fichero_juridico_id

-- DROP INDEX IF EXISTS public.index_cesions_on_fichero_juridico_id;

CREATE INDEX IF NOT EXISTS index_cesions_on_fichero_juridico_id
    ON public.cesions USING btree
    (fichero_juridico_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_cesions_on_proceso_tratamiento_id

-- DROP INDEX IF EXISTS public.index_cesions_on_proceso_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_cesions_on_proceso_tratamiento_id
    ON public.cesions USING btree
    (proceso_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.checklist_debida_diligencias

-- DROP TABLE IF EXISTS public.checklist_debida_diligencias;

CREATE TABLE IF NOT EXISTS public.checklist_debida_diligencias
(
    id integer NOT NULL DEFAULT nextval('checklist_debida_diligencias_id_seq'::regclass),
    empresa_id integer,
    expediente_id integer,
    nombre_proveedor character varying COLLATE pg_catalog."default",
    nombre_receptor character varying COLLATE pg_catalog."default",
    email character varying COLLATE pg_catalog."default",
    nombre_responsable character varying COLLATE pg_catalog."default",
    cargo_responsable character varying COLLATE pg_catalog."default",
    fecha_apertura_cuestionario timestamp without time zone,
    fecha_completado_cuestionario timestamp without time zone,
    ip character varying COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT checklist_debida_diligencias_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_e54ab996a7 FOREIGN KEY (empresa_id)
        REFERENCES public.empresas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_f983ab74d7 FOREIGN KEY (expediente_id)
        REFERENCES public.expedientes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.checklist_debida_diligencias
    OWNER to compaas_app;
-- Index: index_checklist_debida_diligencias_on_empresa_id

-- DROP INDEX IF EXISTS public.index_checklist_debida_diligencias_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_checklist_debida_diligencias_on_empresa_id
    ON public.checklist_debida_diligencias USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_checklist_debida_diligencias_on_expediente_id

-- DROP INDEX IF EXISTS public.index_checklist_debida_diligencias_on_expediente_id;

CREATE INDEX IF NOT EXISTS index_checklist_debida_diligencias_on_expediente_id
    ON public.checklist_debida_diligencias USING btree
    (expediente_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.clientes

-- DROP TABLE IF EXISTS public.clientes;

CREATE TABLE IF NOT EXISTS public.clientes
(
    id integer NOT NULL DEFAULT nextval('clientes_id_seq'::regclass),
    razon_social character varying(255) COLLATE pg_catalog."default",
    fecha_inicio_servicio date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    logo_file_name character varying(255) COLLATE pg_catalog."default",
    logo_content_type character varying(255) COLLATE pg_catalog."default",
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    fecha_fin_servicio date,
    descripcion text COLLATE pg_catalog."default",
    cif character varying(255) COLLATE pg_catalog."default",
    licencias integer,
    direccion_id integer,
    activated boolean DEFAULT true,
    cuota_mes numeric,
    oferta_link character varying(1000) COLLATE pg_catalog."default",
    oferta_adjunto_file_name character varying COLLATE pg_catalog."default",
    oferta_adjunto_content_type character varying COLLATE pg_catalog."default",
    oferta_adjunto_file_size integer,
    oferta_adjunto_updated_at timestamp without time zone,
    responsable_id integer,
    CONSTRAINT clientes_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_c9a69400e9 FOREIGN KEY (responsable_id)
        REFERENCES public.responsables (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.clientes
    OWNER to compaas_app;
-- Index: index_clientes_on_direccion_id

-- DROP INDEX IF EXISTS public.index_clientes_on_direccion_id;

CREATE INDEX IF NOT EXISTS index_clientes_on_direccion_id
    ON public.clientes USING btree
    (direccion_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_clientes_on_responsable_id

-- DROP INDEX IF EXISTS public.index_clientes_on_responsable_id;

CREATE INDEX IF NOT EXISTS index_clientes_on_responsable_id
    ON public.clientes USING btree
    (responsable_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.consulta

-- DROP TABLE IF EXISTS public.consulta;

CREATE TABLE IF NOT EXISTS public.consulta
(
    id integer NOT NULL DEFAULT nextval('consulta_id_seq'::regclass),
    descripcion character varying(255) COLLATE pg_catalog."default",
    fecha timestamp without time zone,
    tipo_consulta_id integer,
    estado_consulta_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT consulta_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.consulta
    OWNER to compaas_app;
-- Index: index_consulta_on_estado_consulta_id

-- DROP INDEX IF EXISTS public.index_consulta_on_estado_consulta_id;

CREATE INDEX IF NOT EXISTS index_consulta_on_estado_consulta_id
    ON public.consulta USING btree
    (estado_consulta_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_consulta_on_tipo_consulta_id

-- DROP INDEX IF EXISTS public.index_consulta_on_tipo_consulta_id;

CREATE INDEX IF NOT EXISTS index_consulta_on_tipo_consulta_id
    ON public.consulta USING btree
    (tipo_consulta_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.contacto_empresas

-- DROP TABLE IF EXISTS public.contacto_empresas;

CREATE TABLE IF NOT EXISTS public.contacto_empresas
(
    id integer NOT NULL DEFAULT nextval('contacto_empresas_id_seq'::regclass),
    contacto_id integer,
    empresa_id integer,
    CONSTRAINT contacto_empresas_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.contacto_empresas
    OWNER to compaas_app;
-- Index: index_contacto_empresas_on_contacto_id

-- DROP INDEX IF EXISTS public.index_contacto_empresas_on_contacto_id;

CREATE INDEX IF NOT EXISTS index_contacto_empresas_on_contacto_id
    ON public.contacto_empresas USING btree
    (contacto_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_contacto_empresas_on_empresa_id

-- DROP INDEX IF EXISTS public.index_contacto_empresas_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_contacto_empresas_on_empresa_id
    ON public.contacto_empresas USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.contactos

-- DROP TABLE IF EXISTS public.contactos;

CREATE TABLE IF NOT EXISTS public.contactos
(
    id integer NOT NULL DEFAULT nextval('contactos_id_seq'::regclass),
    email character varying(255) COLLATE pg_catalog."default",
    email_2 character varying(255) COLLATE pg_catalog."default",
    telefono character varying(255) COLLATE pg_catalog."default",
    telefono_2 character varying(255) COLLATE pg_catalog."default",
    fax character varying(255) COLLATE pg_catalog."default",
    web character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    tipo character varying(255) COLLATE pg_catalog."default",
    nombre character varying(255) COLLATE pg_catalog."default",
    fecha_designacion date,
    CONSTRAINT contactos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.contactos
    OWNER to compaas_app;

-- Table: public.contrato_activos

-- DROP TABLE IF EXISTS public.contrato_activos;

CREATE TABLE IF NOT EXISTS public.contrato_activos
(
    id integer NOT NULL DEFAULT nextval('contrato_activos_id_seq'::regclass),
    contrato_id integer,
    activo_id integer,
    activo_type character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT contrato_activos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.contrato_activos
    OWNER to compaas_app;
-- Index: index_contrato_activos_on_contrato_id

-- DROP INDEX IF EXISTS public.index_contrato_activos_on_contrato_id;

CREATE INDEX IF NOT EXISTS index_contrato_activos_on_contrato_id
    ON public.contrato_activos USING btree
    (contrato_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.contratos

-- DROP TABLE IF EXISTS public.contratos;

CREATE TABLE IF NOT EXISTS public.contratos
(
    id integer NOT NULL DEFAULT nextval('contratos_id_seq'::regclass),
    ref character varying(255) COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    fecha_firma date,
    fecha_inicio date,
    fecha_fin date,
    proveedor_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    responsable_proveedor character varying(255) COLLATE pg_catalog."default",
    email_proveedor character varying(255) COLLATE pg_catalog."default",
    empresa_id integer,
    responsable_empresa character varying(255) COLLATE pg_catalog."default",
    email_empresa character varying(255) COLLATE pg_catalog."default",
    tipo integer,
    responsable_fichero text COLLATE pg_catalog."default",
    tratamiento character varying(255) COLLATE pg_catalog."default",
    autorizacion_carga_datos boolean,
    id_tratamiento character varying(255) COLLATE pg_catalog."default",
    pdf_contrato_file_name character varying(255) COLLATE pg_catalog."default",
    pdf_contrato_content_type character varying(255) COLLATE pg_catalog."default",
    pdf_contrato_file_size integer,
    pdf_contrato_updated_at timestamp without time zone,
    duracion_prevista character varying(255) COLLATE pg_catalog."default",
    confidencialidad_trabajadores boolean,
    almacenamiento_servidores_encargado integer,
    nombre_empresa_subcontratada character varying COLLATE pg_catalog."default",
    medidas_diligencias_debidas text COLLATE pg_catalog."default",
    CONSTRAINT contratos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.contratos
    OWNER to compaas_app;
-- Index: index_contratos_on_empresa_id

-- DROP INDEX IF EXISTS public.index_contratos_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_contratos_on_empresa_id
    ON public.contratos USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_contratos_on_proveedor_id

-- DROP INDEX IF EXISTS public.index_contratos_on_proveedor_id;

CREATE INDEX IF NOT EXISTS index_contratos_on_proveedor_id
    ON public.contratos USING btree
    (proveedor_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.criterios

-- DROP TABLE IF EXISTS public.criterios;

CREATE TABLE IF NOT EXISTS public.criterios
(
    id integer NOT NULL DEFAULT nextval('criterios_id_seq'::regclass),
    empresa_id integer,
    prob_0 integer,
    prob_0_intervalo integer,
    prob_1 integer,
    prob_1_intervalo integer,
    prob_2 integer,
    prob_2_intervalo integer,
    prob_3 integer,
    prob_3_intervalo integer,
    prob_4 integer,
    prob_4_intervalo integer,
    imp_0_union character varying COLLATE pg_catalog."default",
    imp_1_union character varying COLLATE pg_catalog."default",
    imp_2_union character varying COLLATE pg_catalog."default",
    imp_3_union character varying COLLATE pg_catalog."default",
    imp_4_union character varying COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT criterios_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_684fc0f466 FOREIGN KEY (empresa_id)
        REFERENCES public.empresas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.criterios
    OWNER to compaas_app;
-- Index: index_criterios_on_empresa_id

-- DROP INDEX IF EXISTS public.index_criterios_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_criterios_on_empresa_id
    ON public.criterios USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.cuestionario_riesgo_legals

-- DROP TABLE IF EXISTS public.cuestionario_riesgo_legals;

CREATE TABLE IF NOT EXISTS public.cuestionario_riesgo_legals
(
    id integer NOT NULL DEFAULT nextval('cuestionario_riesgo_legals_id_seq'::regclass),
    riesgo_legal_id integer,
    tipo_pregunta integer,
    tipo_respuesta integer,
    respuesta_default integer,
    key_respuesta integer,
    padre_id integer,
    cuestionable_type character varying COLLATE pg_catalog."default",
    pregunta character varying COLLATE pg_catalog."default",
    posicion integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT cuestionario_riesgo_legals_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_0e9bc73dd5 FOREIGN KEY (riesgo_legal_id)
        REFERENCES public.riesgo_legals (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_7f8601d23d FOREIGN KEY (padre_id)
        REFERENCES public.cuestionario_riesgo_legals (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cuestionario_riesgo_legals
    OWNER to compaas_app;
-- Index: index_cuestionario_riesgo_legals_on_padre_id

-- DROP INDEX IF EXISTS public.index_cuestionario_riesgo_legals_on_padre_id;

CREATE INDEX IF NOT EXISTS index_cuestionario_riesgo_legals_on_padre_id
    ON public.cuestionario_riesgo_legals USING btree
    (padre_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_cuestionario_riesgo_legals_on_riesgo_legal_id

-- DROP INDEX IF EXISTS public.index_cuestionario_riesgo_legals_on_riesgo_legal_id;

CREATE INDEX IF NOT EXISTS index_cuestionario_riesgo_legals_on_riesgo_legal_id
    ON public.cuestionario_riesgo_legals USING btree
    (riesgo_legal_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.departamentos

-- DROP TABLE IF EXISTS public.departamentos;

CREATE TABLE IF NOT EXISTS public.departamentos
(
    id integer NOT NULL DEFAULT nextval('departamentos_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT departamentos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.departamentos
    OWNER to compaas_app;

-- Table: public.direccions

-- DROP TABLE IF EXISTS public.direccions;

CREATE TABLE IF NOT EXISTS public.direccions
(
    id integer NOT NULL DEFAULT nextval('direccions_id_seq'::regclass),
    direccion_postal character varying(255) COLLATE pg_catalog."default",
    cp character varying(255) COLLATE pg_catalog."default",
    poblacion_id integer,
    provincia_id integer,
    pais_id integer,
    latitude double precision,
    longitude double precision,
    CONSTRAINT direccions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.direccions
    OWNER to compaas_app;
-- Index: index_direccions_on_pais_id

-- DROP INDEX IF EXISTS public.index_direccions_on_pais_id;

CREATE INDEX IF NOT EXISTS index_direccions_on_pais_id
    ON public.direccions USING btree
    (pais_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_direccions_on_poblacion_id

-- DROP INDEX IF EXISTS public.index_direccions_on_poblacion_id;

CREATE INDEX IF NOT EXISTS index_direccions_on_poblacion_id
    ON public.direccions USING btree
    (poblacion_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_direccions_on_provincia_id

-- DROP INDEX IF EXISTS public.index_direccions_on_provincia_id;

CREATE INDEX IF NOT EXISTS index_direccions_on_provincia_id
    ON public.direccions USING btree
    (provincia_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.empresas

-- DROP TABLE IF EXISTS public.empresas;

CREATE TABLE IF NOT EXISTS public.empresas
(
    id integer NOT NULL DEFAULT nextval('empresas_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    cif character varying(255) COLLATE pg_catalog."default",
    cliente_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    logo_file_name character varying(255) COLLATE pg_catalog."default",
    logo_content_type character varying(255) COLLATE pg_catalog."default",
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    descripcion text COLLATE pg_catalog."default",
    web character varying(255) COLLATE pg_catalog."default",
    direccion_id integer,
    activated boolean DEFAULT true,
    nombre_fiscal character varying COLLATE pg_catalog."default",
    datos_registro character varying COLLATE pg_catalog."default",
    controladora boolean,
    slug character varying COLLATE pg_catalog."default",
    background_image_file_name character varying COLLATE pg_catalog."default",
    background_image_content_type character varying COLLATE pg_catalog."default",
    background_image_file_size integer,
    background_image_updated_at timestamp without time zone,
    categoria_controles integer,
    CONSTRAINT empresas_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.empresas
    OWNER to compaas_app;
-- Index: index_empresas_on_cliente_id

-- DROP INDEX IF EXISTS public.index_empresas_on_cliente_id;

CREATE INDEX IF NOT EXISTS index_empresas_on_cliente_id
    ON public.empresas USING btree
    (cliente_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_empresas_on_direccion_id

-- DROP INDEX IF EXISTS public.index_empresas_on_direccion_id;

CREATE INDEX IF NOT EXISTS index_empresas_on_direccion_id
    ON public.empresas USING btree
    (direccion_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.empresas_users

-- DROP TABLE IF EXISTS public.empresas_users;

CREATE TABLE IF NOT EXISTS public.empresas_users
(
    empresa_id integer,
    user_id integer,
    id integer NOT NULL DEFAULT nextval('empresas_users_id_seq'::regclass),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT empresas_users_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.empresas_users
    OWNER to compaas_app;
-- Index: index_empresas_users_on_empresa_id_and_user_id

-- DROP INDEX IF EXISTS public.index_empresas_users_on_empresa_id_and_user_id;

CREATE INDEX IF NOT EXISTS index_empresas_users_on_empresa_id_and_user_id
    ON public.empresas_users USING btree
    (empresa_id ASC NULLS LAST, user_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_empresas_users_on_user_id_and_empresa_id

-- DROP INDEX IF EXISTS public.index_empresas_users_on_user_id_and_empresa_id;

CREATE INDEX IF NOT EXISTS index_empresas_users_on_user_id_and_empresa_id
    ON public.empresas_users USING btree
    (user_id ASC NULLS LAST, empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.encargado_tratamientos

-- DROP TABLE IF EXISTS public.encargado_tratamientos;

CREATE TABLE IF NOT EXISTS public.encargado_tratamientos
(
    id integer NOT NULL DEFAULT nextval('encargado_tratamientos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    cif character varying(255) COLLATE pg_catalog."default",
    direccion_id integer,
    contacto_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT encargado_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.encargado_tratamientos
    OWNER to compaas_app;
-- Index: index_encargado_tratamientos_on_contacto_id

-- DROP INDEX IF EXISTS public.index_encargado_tratamientos_on_contacto_id;

CREATE INDEX IF NOT EXISTS index_encargado_tratamientos_on_contacto_id
    ON public.encargado_tratamientos USING btree
    (contacto_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_encargado_tratamientos_on_direccion_id

-- DROP INDEX IF EXISTS public.index_encargado_tratamientos_on_direccion_id;

CREATE INDEX IF NOT EXISTS index_encargado_tratamientos_on_direccion_id
    ON public.encargado_tratamientos USING btree
    (direccion_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.estado_cesions

-- DROP TABLE IF EXISTS public.estado_cesions;

CREATE TABLE IF NOT EXISTS public.estado_cesions
(
    id integer NOT NULL DEFAULT nextval('estado_cesions_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_cesions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_cesions
    OWNER to compaas_app;

-- Table: public.estado_consulta

-- DROP TABLE IF EXISTS public.estado_consulta;

CREATE TABLE IF NOT EXISTS public.estado_consulta
(
    id integer NOT NULL DEFAULT nextval('estado_consulta_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_consulta_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_consulta
    OWNER to compaas_app;

-- Table: public.estado_ficha_servicios

-- DROP TABLE IF EXISTS public.estado_ficha_servicios;

CREATE TABLE IF NOT EXISTS public.estado_ficha_servicios
(
    id integer NOT NULL DEFAULT nextval('estado_ficha_servicios_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_ficha_servicios_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_ficha_servicios
    OWNER to compaas_app;

-- Table: public.estado_fichero_juridicos

-- DROP TABLE IF EXISTS public.estado_fichero_juridicos;

CREATE TABLE IF NOT EXISTS public.estado_fichero_juridicos
(
    id integer NOT NULL DEFAULT nextval('estado_fichero_juridicos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_fichero_juridicos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_fichero_juridicos
    OWNER to compaas_app;

-- Table: public.estado_medida_seguridads

-- DROP TABLE IF EXISTS public.estado_medida_seguridads;

CREATE TABLE IF NOT EXISTS public.estado_medida_seguridads
(
    id integer NOT NULL DEFAULT nextval('estado_medida_seguridads_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_medida_seguridads_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_medida_seguridads
    OWNER to compaas_app;

-- Table: public.estado_peticions

-- DROP TABLE IF EXISTS public.estado_peticions;

CREATE TABLE IF NOT EXISTS public.estado_peticions
(
    id integer NOT NULL DEFAULT nextval('estado_peticions_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_peticions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_peticions
    OWNER to compaas_app;

-- Table: public.estado_pia

-- DROP TABLE IF EXISTS public.estado_pia;

CREATE TABLE IF NOT EXISTS public.estado_pia
(
    id integer NOT NULL DEFAULT nextval('estado_pia_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_pia_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_pia
    OWNER to compaas_app;

-- Table: public.estado_proveedors

-- DROP TABLE IF EXISTS public.estado_proveedors;

CREATE TABLE IF NOT EXISTS public.estado_proveedors
(
    id integer NOT NULL DEFAULT nextval('estado_proveedors_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_proveedors_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_proveedors
    OWNER to compaas_app;

-- Table: public.estado_soportes

-- DROP TABLE IF EXISTS public.estado_soportes;

CREATE TABLE IF NOT EXISTS public.estado_soportes
(
    id integer NOT NULL DEFAULT nextval('estado_soportes_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_soportes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_soportes
    OWNER to compaas_app;

-- Table: public.estado_tarea_recurrentes

-- DROP TABLE IF EXISTS public.estado_tarea_recurrentes;

CREATE TABLE IF NOT EXISTS public.estado_tarea_recurrentes
(
    id integer NOT NULL DEFAULT nextval('estado_tarea_recurrentes_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_tarea_recurrentes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_tarea_recurrentes
    OWNER to compaas_app;

-- Table: public.estado_transferencia_internacionals

-- DROP TABLE IF EXISTS public.estado_transferencia_internacionals;

CREATE TABLE IF NOT EXISTS public.estado_transferencia_internacionals
(
    id integer NOT NULL DEFAULT nextval('estado_transferencia_internacionals_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT estado_transferencia_internacionals_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estado_transferencia_internacionals
    OWNER to compaas_app;

-- Table: public.evaluacion_impacto_tratamientos

-- DROP TABLE IF EXISTS public.evaluacion_impacto_tratamientos;

CREATE TABLE IF NOT EXISTS public.evaluacion_impacto_tratamientos
(
    id integer NOT NULL DEFAULT nextval('evaluacion_impacto_tratamientos_id_seq'::regclass),
    tratamiento_id integer,
    checklist_done_at timestamp without time zone,
    evaluacion_done_at timestamp without time zone,
    a_perfilado boolean,
    a_decisiones_automatizadas boolean,
    a_observacion_monitorizacion boolean,
    a_categorias_especiales boolean,
    a_datos_biometricos boolean,
    a_datos_genericos boolean,
    a_datos_gran_escala boolean,
    a_finalidades_diferentes boolean,
    a_sujetos_vulnerables boolean,
    a_nuevas_tecnologias boolean,
    a_impedir_ejercer_derechos boolean,
    b_directrices_establecidas boolean,
    b_codigos_conducta boolean,
    b_obligacion_legal boolean,
    b_labor_profesional boolean,
    b_gestion_interna boolean,
    b_comunidades_propietarios boolean,
    b_colegios_profesionales boolean,
    descripcion_operacion_recogida text COLLATE pg_catalog."default",
    descripcion_operacion_almacenamiento text COLLATE pg_catalog."default",
    descripcion_operacion_distribucion text COLLATE pg_catalog."default",
    descripcion_operacion_tratamiento text COLLATE pg_catalog."default",
    descripcion_operacion_comunicacion text COLLATE pg_catalog."default",
    descripcion_operacion_supresion text COLLATE pg_catalog."default",
    proporcionalidad_operacion_recogida text COLLATE pg_catalog."default",
    proporcionalidad_operacion_almacenamiento text COLLATE pg_catalog."default",
    proporcionalidad_operacion_distribucion text COLLATE pg_catalog."default",
    proporcionalidad_operacion_tratamiento text COLLATE pg_catalog."default",
    proporcionalidad_operacion_comunicacion text COLLATE pg_catalog."default",
    proporcionalidad_operacion_supresion text COLLATE pg_catalog."default",
    proporcionalidad_actividad_recogida text COLLATE pg_catalog."default",
    proporcionalidad_actividad_finalidad text COLLATE pg_catalog."default",
    proporcionalidad_actividad_tecnologias text COLLATE pg_catalog."default",
    identificacion_riesgos text COLLATE pg_catalog."default",
    conclusiones text COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fecha_eipd date,
    CONSTRAINT evaluacion_impacto_tratamientos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_19b389a762 FOREIGN KEY (tratamiento_id)
        REFERENCES public.proceso_tratamientos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.evaluacion_impacto_tratamientos
    OWNER to compaas_app;
-- Index: index_evaluacion_impacto_tratamientos_on_tratamiento_id

-- DROP INDEX IF EXISTS public.index_evaluacion_impacto_tratamientos_on_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_evaluacion_impacto_tratamientos_on_tratamiento_id
    ON public.evaluacion_impacto_tratamientos USING btree
    (tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.expedientes

-- DROP TABLE IF EXISTS public.expedientes;

CREATE TABLE IF NOT EXISTS public.expedientes
(
    id integer NOT NULL DEFAULT nextval('expedientes_id_seq'::regclass),
    empresa_id integer,
    codigo character varying COLLATE pg_catalog."default",
    referencia character varying COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    id_usuario_apertura integer,
    email_usuario_apertura character varying COLLATE pg_catalog."default",
    descripcion_usuario_apertura character varying COLLATE pg_catalog."default",
    solicitante text COLLATE pg_catalog."default",
    email_solicitante character varying COLLATE pg_catalog."default",
    tlf_solicitante character varying COLLATE pg_catalog."default",
    fecha_inicio_expediente timestamp without time zone,
    estado integer,
    tipo integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    proxima_tarea text COLLATE pg_catalog."default",
    fecha_proxima_tarea date,
    prioridad integer,
    fecha_cierre timestamp without time zone,
    id_usuario_responsable integer,
    email_usuario_responsable character varying COLLATE pg_catalog."default",
    descripcion_usuario_responsable character varying COLLATE pg_catalog."default",
    fecha_asignacion_responsable timestamp without time zone,
    tercero_responsable boolean,
    nombre_tercero_responsable character varying COLLATE pg_catalog."default",
    email_tercero_responsable character varying COLLATE pg_catalog."default",
    notification_sent_at timestamp without time zone,
    recordar_en integer,
    reminder_sent_at timestamp without time zone,
    auto_generado boolean DEFAULT false,
    cuestionario_empresa boolean DEFAULT false,
    cuestionario_tratamiento boolean DEFAULT false,
    respuesta_cuestionario_riesgo_legal_id integer,
    CONSTRAINT expedientes_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_8272822a94 FOREIGN KEY (empresa_id)
        REFERENCES public.empresas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.expedientes
    OWNER to compaas_app;
-- Index: index_expedientes_on_empresa_id

-- DROP INDEX IF EXISTS public.index_expedientes_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_expedientes_on_empresa_id
    ON public.expedientes USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_expedientes_on_respuesta_cuestionario_riesgo_legal_id

-- DROP INDEX IF EXISTS public.index_expedientes_on_respuesta_cuestionario_riesgo_legal_id;

CREATE INDEX IF NOT EXISTS index_expedientes_on_respuesta_cuestionario_riesgo_legal_id
    ON public.expedientes USING btree
    (respuesta_cuestionario_riesgo_legal_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.ficha_servicios

-- DROP TABLE IF EXISTS public.ficha_servicios;

CREATE TABLE IF NOT EXISTS public.ficha_servicios
(
    id integer NOT NULL DEFAULT nextval('ficha_servicios_id_seq'::regclass),
    descripcion character varying(255) COLLATE pg_catalog."default",
    horas_estimadas integer,
    inicio timestamp without time zone,
    fin timestamp without time zone,
    porcentaje integer,
    horas_realizadas integer,
    cierre timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT ficha_servicios_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.ficha_servicios
    OWNER to compaas_app;

-- Table: public.fichas

-- DROP TABLE IF EXISTS public.fichas;

CREATE TABLE IF NOT EXISTS public.fichas
(
    id integer NOT NULL DEFAULT nextval('fichas_id_seq'::regclass),
    expediente_id integer,
    referencia character varying COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    estado integer,
    fecha_cambio_estado timestamp without time zone,
    id_usuario_apertura integer,
    email_usuario_apertura character varying COLLATE pg_catalog."default",
    descripcion_usuario_apertura character varying COLLATE pg_catalog."default",
    solicitante text COLLATE pg_catalog."default",
    email_solicitante character varying COLLATE pg_catalog."default",
    tlf_solicitante character varying COLLATE pg_catalog."default",
    fecha_inicio_expediente timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fecha_cierre timestamp without time zone,
    id_usuario_responsable integer,
    email_usuario_responsable character varying COLLATE pg_catalog."default",
    descripcion_usuario_responsable character varying COLLATE pg_catalog."default",
    fecha_asignacion_responsable timestamp without time zone,
    CONSTRAINT fichas_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_33430e55de FOREIGN KEY (expediente_id)
        REFERENCES public.expedientes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fichas
    OWNER to compaas_app;
-- Index: index_fichas_on_expediente_id

-- DROP INDEX IF EXISTS public.index_fichas_on_expediente_id;

CREATE INDEX IF NOT EXISTS index_fichas_on_expediente_id
    ON public.fichas USING btree
    (expediente_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.fichas

-- DROP TABLE IF EXISTS public.fichas;

CREATE TABLE IF NOT EXISTS public.fichas
(
    id integer NOT NULL DEFAULT nextval('fichas_id_seq'::regclass),
    expediente_id integer,
    referencia character varying COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    estado integer,
    fecha_cambio_estado timestamp without time zone,
    id_usuario_apertura integer,
    email_usuario_apertura character varying COLLATE pg_catalog."default",
    descripcion_usuario_apertura character varying COLLATE pg_catalog."default",
    solicitante text COLLATE pg_catalog."default",
    email_solicitante character varying COLLATE pg_catalog."default",
    tlf_solicitante character varying COLLATE pg_catalog."default",
    fecha_inicio_expediente timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fecha_cierre timestamp without time zone,
    id_usuario_responsable integer,
    email_usuario_responsable character varying COLLATE pg_catalog."default",
    descripcion_usuario_responsable character varying COLLATE pg_catalog."default",
    fecha_asignacion_responsable timestamp without time zone,
    CONSTRAINT fichas_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_33430e55de FOREIGN KEY (expediente_id)
        REFERENCES public.expedientes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fichas
    OWNER to compaas_app;
-- Index: index_fichas_on_expediente_id

-- DROP INDEX IF EXISTS public.index_fichas_on_expediente_id;

CREATE INDEX IF NOT EXISTS index_fichas_on_expediente_id
    ON public.fichas USING btree
    (expediente_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.ficheros_procesos_tratamientos

-- DROP TABLE IF EXISTS public.ficheros_procesos_tratamientos;

CREATE TABLE IF NOT EXISTS public.ficheros_procesos_tratamientos
(
    id integer NOT NULL DEFAULT nextval('ficheros_procesos_tratamientos_id_seq'::regclass),
    fichero_juridico_id integer,
    proceso_tratamiento_id integer,
    CONSTRAINT ficheros_procesos_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.ficheros_procesos_tratamientos
    OWNER to compaas_app;
-- Index: ficheros_procesos_tratamientos_index

-- DROP INDEX IF EXISTS public.ficheros_procesos_tratamientos_index;

CREATE INDEX IF NOT EXISTS ficheros_procesos_tratamientos_index
    ON public.ficheros_procesos_tratamientos USING btree
    (fichero_juridico_id ASC NULLS LAST, proceso_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: procesos_tratamientos_ficheros_index

-- DROP INDEX IF EXISTS public.procesos_tratamientos_ficheros_index;

CREATE INDEX IF NOT EXISTS procesos_tratamientos_ficheros_index
    ON public.ficheros_procesos_tratamientos USING btree
    (proceso_tratamiento_id ASC NULLS LAST, fichero_juridico_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.grupo_pregunta_checklist_debida_diligencias

-- DROP TABLE IF EXISTS public.grupo_pregunta_checklist_debida_diligencias;

CREATE TABLE IF NOT EXISTS public.grupo_pregunta_checklist_debida_diligencias
(
    id integer NOT NULL DEFAULT nextval('grupo_pregunta_checklist_debida_diligencias_id_seq'::regclass),
    "position" integer,
    nombre character varying COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT grupo_pregunta_checklist_debida_diligencias_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.grupo_pregunta_checklist_debida_diligencias
    OWNER to compaas_app;


-- Table: public.in_out_soportes

-- DROP TABLE IF EXISTS public.in_out_soportes;

CREATE TABLE IF NOT EXISTS public.in_out_soportes
(
    id integer NOT NULL DEFAULT nextval('in_out_soportes_id_seq'::regclass),
    proveedor character varying(255) COLLATE pg_catalog."default",
    operador character varying(255) COLLATE pg_catalog."default",
    fecha_soporte date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT in_out_soportes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.in_out_soportes
    OWNER to compaas_app;


-- Table: public.incidencia

-- DROP TABLE IF EXISTS public.incidencia;

CREATE TABLE IF NOT EXISTS public.incidencia
(
    id integer NOT NULL DEFAULT nextval('incidencia_id_seq'::regclass),
    fecha_deteccion timestamp without time zone,
    fecha_resolucion timestamp without time zone,
    medidas character varying(255) COLLATE pg_catalog."default",
    consecuencias character varying(255) COLLATE pg_catalog."default",
    recomendaciones character varying(255) COLLATE pg_catalog."default",
    tipo_incidencia_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT incidencia_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.incidencia
    OWNER to compaas_app;
-- Index: index_incidencia_on_tipo_incidencia_id

-- DROP INDEX IF EXISTS public.index_incidencia_on_tipo_incidencia_id;

CREATE INDEX IF NOT EXISTS index_incidencia_on_tipo_incidencia_id
    ON public.incidencia USING btree
    (tipo_incidencia_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.indicadors

-- DROP TABLE IF EXISTS public.indicadors;

CREATE TABLE IF NOT EXISTS public.indicadors
(
    id integer NOT NULL DEFAULT nextval('indicadors_id_seq'::regclass),
    empresa_id integer,
    year integer,
    nombre character varying COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    tipo_objetivo integer,
    objetivo integer,
    t1 integer,
    t2 integer,
    t3 integer,
    t4 integer,
    conclusion text COLLATE pg_catalog."default",
    responsable character varying COLLATE pg_catalog."default",
    objetivo_rango integer,
    color_objetivo integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT indicadors_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_b06c07b73e FOREIGN KEY (empresa_id)
        REFERENCES public.empresas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.indicadors
    OWNER to compaas_app;
-- Index: index_indicadors_on_empresa_id

-- DROP INDEX IF EXISTS public.index_indicadors_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_indicadors_on_empresa_id
    ON public.indicadors USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.intervinientes

-- DROP TABLE IF EXISTS public.intervinientes;

CREATE TABLE IF NOT EXISTS public.intervinientes
(
    id integer NOT NULL DEFAULT nextval('intervinientes_id_seq'::regclass),
    auditoria_id integer,
    nombre character varying COLLATE pg_catalog."default",
    departamento_id integer,
    email character varying COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT intervinientes_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_165e166a60 FOREIGN KEY (auditoria_id)
        REFERENCES public.auditorias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_b5e51aaef9 FOREIGN KEY (departamento_id)
        REFERENCES public.departamentos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.intervinientes
    OWNER to compaas_app;
-- Index: index_intervinientes_on_auditoria_id

-- DROP INDEX IF EXISTS public.index_intervinientes_on_auditoria_id;

CREATE INDEX IF NOT EXISTS index_intervinientes_on_auditoria_id
    ON public.intervinientes USING btree
    (auditoria_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_intervinientes_on_departamento_id

-- DROP INDEX IF EXISTS public.index_intervinientes_on_departamento_id;

CREATE INDEX IF NOT EXISTS index_intervinientes_on_departamento_id
    ON public.intervinientes USING btree
    (departamento_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.inventario_soportes

-- DROP TABLE IF EXISTS public.inventario_soportes;

CREATE TABLE IF NOT EXISTS public.inventario_soportes
(
    id integer NOT NULL DEFAULT nextval('inventario_soportes_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    descripcion character varying(255) COLLATE pg_catalog."default",
    numero_serie character varying(255) COLLATE pg_catalog."default",
    comentario_baja character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT inventario_soportes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.inventario_soportes
    OWNER to compaas_app;

-- Table: public.log_usuario_usos

-- DROP TABLE IF EXISTS public.log_usuario_usos;

CREATE TABLE IF NOT EXISTS public.log_usuario_usos
(
    id integer NOT NULL DEFAULT nextval('log_usuario_usos_id_seq'::regclass),
    empresa_id integer,
    empresas_ids text COLLATE pg_catalog."default",
    empresas_name text COLLATE pg_catalog."default",
    user_id integer,
    email character varying(255) COLLATE pg_catalog."default",
    role_id integer,
    role_name character varying(255) COLLATE pg_catalog."default",
    ip character varying(255) COLLATE pg_catalog."default",
    http_user_agent character varying(255) COLLATE pg_catalog."default",
    controller character varying(255) COLLATE pg_catalog."default",
    action character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT log_usuario_usos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.log_usuario_usos
    OWNER to compaas_app;
-- Index: index_log_usuario_usos_on_empresa_id

-- DROP INDEX IF EXISTS public.index_log_usuario_usos_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_log_usuario_usos_on_empresa_id
    ON public.log_usuario_usos USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_log_usuario_usos_on_role_id

-- DROP INDEX IF EXISTS public.index_log_usuario_usos_on_role_id;

CREATE INDEX IF NOT EXISTS index_log_usuario_usos_on_role_id
    ON public.log_usuario_usos USING btree
    (role_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_log_usuario_usos_on_user_id

-- DROP INDEX IF EXISTS public.index_log_usuario_usos_on_user_id;

CREATE INDEX IF NOT EXISTS index_log_usuario_usos_on_user_id
    ON public.log_usuario_usos USING btree
    (user_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.matriz_criticidad_masters

-- DROP TABLE IF EXISTS public.matriz_criticidad_masters;

CREATE TABLE IF NOT EXISTS public.matriz_criticidad_masters
(
    id integer NOT NULL DEFAULT nextval('matriz_criticidad_masters_id_seq'::regclass),
    activo character varying(255) COLLATE pg_catalog."default",
    nivel_seguridad character varying(255) COLLATE pg_catalog."default",
    criticidad character varying(255) COLLATE pg_catalog."default",
    tipo character varying(255) COLLATE pg_catalog."default",
    valor integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT matriz_criticidad_masters_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.matriz_criticidad_masters
    OWNER to compaas_app;

-- Table: public.matriz_criticidads

-- DROP TABLE IF EXISTS public.matriz_criticidads;

CREATE TABLE IF NOT EXISTS public.matriz_criticidads
(
    id integer NOT NULL DEFAULT nextval('matriz_criticidads_id_seq'::regclass),
    activo character varying(255) COLLATE pg_catalog."default",
    nivel_seguridad character varying(255) COLLATE pg_catalog."default",
    criticidad character varying(255) COLLATE pg_catalog."default",
    tipo character varying(255) COLLATE pg_catalog."default",
    empresa_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    valor integer,
    CONSTRAINT matriz_criticidads_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.matriz_criticidads
    OWNER to compaas_app;
-- Index: index_matriz_criticidads_on_empresa_id

-- DROP INDEX IF EXISTS public.index_matriz_criticidads_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_matriz_criticidads_on_empresa_id
    ON public.matriz_criticidads USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.medida_seguridads

-- DROP TABLE IF EXISTS public.medida_seguridads;

CREATE TABLE IF NOT EXISTS public.medida_seguridads
(
    id integer NOT NULL DEFAULT nextval('medida_seguridads_id_seq'::regclass),
    descripcion text COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    referencia character varying(255) COLLATE pg_catalog."default",
    aplicable_centros_trat boolean,
    aplicable_sistemas_trat boolean,
    aplicable_recursos_trat boolean,
    documento_seguridad boolean,
    tipo_tratamiento_papel boolean DEFAULT false,
    tipo_tratamiento_auto boolean DEFAULT false,
    transversal boolean DEFAULT false,
    reduccion_riesgo_probabilidad integer,
    tipo integer,
    reduccion_riesgo_impacto integer,
    categoria integer,
    CONSTRAINT medida_seguridads_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.medida_seguridads
    OWNER to compaas_app;

-- Table: public.medio_recogidas

-- DROP TABLE IF EXISTS public.medio_recogidas;

CREATE TABLE IF NOT EXISTS public.medio_recogidas
(
    id integer NOT NULL DEFAULT nextval('medio_recogidas_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT medio_recogidas_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.medio_recogidas
    OWNER to compaas_app;


-- Table: public.normas

-- DROP TABLE IF EXISTS public.normas;

CREATE TABLE IF NOT EXISTS public.normas
(
    id integer NOT NULL DEFAULT nextval('normas_id_seq'::regclass),
    descripcion character varying(2048) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    titulo character varying(255) COLLATE pg_catalog."default",
    empresa_id integer,
    cliente_id integer,
    CONSTRAINT normas_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.normas
    OWNER to compaas_app;
-- Index: index_normas_on_cliente_id

-- DROP INDEX IF EXISTS public.index_normas_on_cliente_id;

CREATE INDEX IF NOT EXISTS index_normas_on_cliente_id
    ON public.normas USING btree
    (cliente_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_normas_on_empresa_id

-- DROP INDEX IF EXISTS public.index_normas_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_normas_on_empresa_id
    ON public.normas USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.observacions

-- DROP TABLE IF EXISTS public.observacions;

CREATE TABLE IF NOT EXISTS public.observacions
(
    id integer NOT NULL DEFAULT nextval('observacions_id_seq'::regclass),
    link_doc character varying(255) COLLATE pg_catalog."default",
    descripcion character varying(2048) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT observacions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.observacions
    OWNER to compaas_app;


-- Table: public.operacions

-- DROP TABLE IF EXISTS public.operacions;

CREATE TABLE IF NOT EXISTS public.operacions
(
    id integer NOT NULL DEFAULT nextval('operacions_id_seq'::regclass),
    proceso_tratamiento_id integer,
    nombre character varying COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    role integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT operacions_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_4fef5b396f FOREIGN KEY (proceso_tratamiento_id)
        REFERENCES public.proceso_tratamientos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.operacions
    OWNER to compaas_app;
-- Index: index_operacions_on_proceso_tratamiento_id

-- DROP INDEX IF EXISTS public.index_operacions_on_proceso_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_operacions_on_proceso_tratamiento_id
    ON public.operacions USING btree
    (proceso_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.origen_datos

-- DROP TABLE IF EXISTS public.origen_datos;

CREATE TABLE IF NOT EXISTS public.origen_datos
(
    id integer NOT NULL DEFAULT nextval('origen_datos_id_seq'::regclass),
    responsable_recogida character varying(255) COLLATE pg_catalog."default",
    lugar_recogida character varying(255) COLLATE pg_catalog."default",
    fichero_juridico_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    medio_recogida character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT origen_datos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.origen_datos
    OWNER to compaas_app;
-- Index: index_origen_datos_on_fichero_juridico_id

-- DROP INDEX IF EXISTS public.index_origen_datos_on_fichero_juridico_id;

CREATE INDEX IF NOT EXISTS index_origen_datos_on_fichero_juridico_id
    ON public.origen_datos USING btree
    (fichero_juridico_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.paises

-- DROP TABLE IF EXISTS public.paises;

CREATE TABLE IF NOT EXISTS public.paises
(
    id integer NOT NULL DEFAULT nextval('paises_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT pais_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.paises
    OWNER to compaas_app;


-- Table: public.pdf_adjuntos

-- DROP TABLE IF EXISTS public.pdf_adjuntos;

CREATE TABLE IF NOT EXISTS public.pdf_adjuntos
(
    id integer NOT NULL DEFAULT nextval('pdf_adjuntos_id_seq'::regclass),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    pdf_adjunto_file_name character varying(255) COLLATE pg_catalog."default",
    pdf_adjunto_content_type character varying(255) COLLATE pg_catalog."default",
    pdf_adjunto_file_size integer,
    pdf_adjunto_updated_at timestamp without time zone,
    adjunto_id integer,
    adjunto_type character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT pdf_adjuntos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pdf_adjuntos
    OWNER to compaas_app;
-- Index: index_pdf_adjuntos_on_adjunto_id_and_adjunto_type

-- DROP INDEX IF EXISTS public.index_pdf_adjuntos_on_adjunto_id_and_adjunto_type;

CREATE INDEX IF NOT EXISTS index_pdf_adjuntos_on_adjunto_id_and_adjunto_type
    ON public.pdf_adjuntos USING btree
    (adjunto_id ASC NULLS LAST, adjunto_type COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.peticions

-- DROP TABLE IF EXISTS public.peticions;

CREATE TABLE IF NOT EXISTS public.peticions
(
    id integer NOT NULL DEFAULT nextval('peticions_id_seq'::regclass),
    descripcion character varying(255) COLLATE pg_catalog."default",
    fecha timestamp without time zone,
    tipo_peticion_id integer,
    estado_peticion_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT peticions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.peticions
    OWNER to compaas_app;
-- Index: index_peticions_on_estado_peticion_id

-- DROP INDEX IF EXISTS public.index_peticions_on_estado_peticion_id;

CREATE INDEX IF NOT EXISTS index_peticions_on_estado_peticion_id
    ON public.peticions USING btree
    (estado_peticion_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_peticions_on_tipo_peticion_id

-- DROP INDEX IF EXISTS public.index_peticions_on_tipo_peticion_id;

CREATE INDEX IF NOT EXISTS index_peticions_on_tipo_peticion_id
    ON public.peticions USING btree
    (tipo_peticion_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.pias

-- DROP TABLE IF EXISTS public.pias;

CREATE TABLE IF NOT EXISTS public.pias
(
    id integer NOT NULL DEFAULT nextval('pias_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    empresa_id integer,
    prioridad integer,
    aprobacion date,
    inicio_previsto date,
    inicio_real date,
    fin_previsto date,
    fin_real date,
    horas_estimadas integer,
    horas_reales integer,
    estado character varying(255) COLLATE pg_catalog."default",
    observaciones text COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id_creador integer,
    id_supervisor integer,
    creacion timestamp without time zone,
    id_responsable_aprobacion integer,
    avance integer,
    cierre date,
    resultado character varying(255) COLLATE pg_catalog."default",
    observaciones_resultado text COLLATE pg_catalog."default",
    pdf_descripcion_completa_file_name character varying(255) COLLATE pg_catalog."default",
    pdf_descripcion_completa_content_type character varying(255) COLLATE pg_catalog."default",
    pdf_descripcion_completa_file_size integer,
    pdf_descripcion_completa_updated_at timestamp without time zone,
    CONSTRAINT pias_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pias
    OWNER to compaas_app;
-- Index: index_pias_on_empresa_id

-- DROP INDEX IF EXISTS public.index_pias_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_pias_on_empresa_id
    ON public.pias USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.pias_recurso_tratamientos

-- DROP TABLE IF EXISTS public.pias_recurso_tratamientos;

CREATE TABLE IF NOT EXISTS public.pias_recurso_tratamientos
(
    id integer NOT NULL DEFAULT nextval('pias_recurso_tratamientos_id_seq'::regclass),
    pia_id integer,
    recurso_tratamiento_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT pias_recurso_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pias_recurso_tratamientos
    OWNER to compaas_app;
-- Index: index_pias_recurso_tratamientos_on_pia_id

-- DROP INDEX IF EXISTS public.index_pias_recurso_tratamientos_on_pia_id;

CREATE INDEX IF NOT EXISTS index_pias_recurso_tratamientos_on_pia_id
    ON public.pias_recurso_tratamientos USING btree
    (pia_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_pias_recurso_tratamientos_on_recurso_tratamiento_id

-- DROP INDEX IF EXISTS public.index_pias_recurso_tratamientos_on_recurso_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_pias_recurso_tratamientos_on_recurso_tratamiento_id
    ON public.pias_recurso_tratamientos USING btree
    (recurso_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.pias_riesgos

-- DROP TABLE IF EXISTS public.pias_riesgos;

CREATE TABLE IF NOT EXISTS public.pias_riesgos
(
    id integer NOT NULL DEFAULT nextval('pias_riesgos_id_seq'::regclass),
    pia_id integer,
    riesgo_id integer,
    CONSTRAINT pias_riesgos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pias_riesgos
    OWNER to compaas_app;
-- Index: index_pias_riesgos_on_pia_id_and_riesgo_id

-- DROP INDEX IF EXISTS public.index_pias_riesgos_on_pia_id_and_riesgo_id;

CREATE INDEX IF NOT EXISTS index_pias_riesgos_on_pia_id_and_riesgo_id
    ON public.pias_riesgos USING btree
    (pia_id ASC NULLS LAST, riesgo_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_pias_riesgos_on_riesgo_id_and_pia_id

-- DROP INDEX IF EXISTS public.index_pias_riesgos_on_riesgo_id_and_pia_id;

CREATE INDEX IF NOT EXISTS index_pias_riesgos_on_riesgo_id_and_pia_id
    ON public.pias_riesgos USING btree
    (riesgo_id ASC NULLS LAST, pia_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.pias_sistema_tratamientos

-- DROP TABLE IF EXISTS public.pias_sistema_tratamientos;

CREATE TABLE IF NOT EXISTS public.pias_sistema_tratamientos
(
    id integer NOT NULL DEFAULT nextval('pias_sistema_tratamientos_id_seq'::regclass),
    pia_id integer,
    sistema_tratamiento_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT pias_sistema_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pias_sistema_tratamientos
    OWNER to compaas_app;
-- Index: index_pias_sistema_tratamientos_on_pia_id

-- DROP INDEX IF EXISTS public.index_pias_sistema_tratamientos_on_pia_id;

CREATE INDEX IF NOT EXISTS index_pias_sistema_tratamientos_on_pia_id
    ON public.pias_sistema_tratamientos USING btree
    (pia_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_pias_sistema_tratamientos_on_sistema_tratamiento_id

-- DROP INDEX IF EXISTS public.index_pias_sistema_tratamientos_on_sistema_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_pias_sistema_tratamientos_on_sistema_tratamiento_id
    ON public.pias_sistema_tratamientos USING btree
    (sistema_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: pias_sistema_tratamientos_index

-- DROP INDEX IF EXISTS public.pias_sistema_tratamientos_index;

CREATE INDEX IF NOT EXISTS pias_sistema_tratamientos_index
    ON public.pias_sistema_tratamientos USING btree
    (pia_id ASC NULLS LAST, sistema_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.poblacions

-- DROP TABLE IF EXISTS public.poblacions;

CREATE TABLE IF NOT EXISTS public.poblacions
(
    id integer NOT NULL DEFAULT nextval('poblacions_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    provincia_id integer,
    CONSTRAINT poblacions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.poblacions
    OWNER to compaas_app;
-- Index: index_poblacions_on_provincia_id

-- DROP INDEX IF EXISTS public.index_poblacions_on_provincia_id;

CREATE INDEX IF NOT EXISTS index_poblacions_on_provincia_id
    ON public.poblacions USING btree
    (provincia_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.politica_certificacions

-- DROP TABLE IF EXISTS public.politica_certificacions;

CREATE TABLE IF NOT EXISTS public.politica_certificacions
(
    id integer NOT NULL DEFAULT nextval('politica_certificacions_id_seq'::regclass),
    politica_procedimiento_id integer,
    certificacion_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT politica_certificacions_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_a20dbb6102 FOREIGN KEY (certificacion_id)
        REFERENCES public.certificacions (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_d04172135a FOREIGN KEY (politica_procedimiento_id)
        REFERENCES public.politica_procedimientos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.politica_certificacions
    OWNER to compaas_app;
-- Index: index_politica_certificacions_on_certificacion_id

-- DROP INDEX IF EXISTS public.index_politica_certificacions_on_certificacion_id;

CREATE INDEX IF NOT EXISTS index_politica_certificacions_on_certificacion_id
    ON public.politica_certificacions USING btree
    (certificacion_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_politica_certificacions_on_politica_procedimiento_id

-- DROP INDEX IF EXISTS public.index_politica_certificacions_on_politica_procedimiento_id;

CREATE INDEX IF NOT EXISTS index_politica_certificacions_on_politica_procedimiento_id
    ON public.politica_certificacions USING btree
    (politica_procedimiento_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.politica_procedimientos

-- DROP TABLE IF EXISTS public.politica_procedimientos;

CREATE TABLE IF NOT EXISTS public.politica_procedimientos
(
    id integer NOT NULL DEFAULT nextval('politica_procedimientos_id_seq'::regclass),
    empresa_id integer,
    nombre character varying(255) COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    ambito_aplicacion text COLLATE pg_catalog."default",
    tipo integer,
    version character varying(255) COLLATE pg_catalog."default",
    fecha_aprobacion date,
    fecha_revision date,
    fecha_baja date,
    estado integer,
    responsable_aprobacion character varying(255) COLLATE pg_catalog."default",
    responsable_funcional character varying(255) COLLATE pg_catalog."default",
    email_responsable_funcional character varying(255) COLLATE pg_catalog."default",
    telefono_responsable_funcional character varying(255) COLLATE pg_catalog."default",
    departamento_responsable_funcional character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    documento_file_name character varying(255) COLLATE pg_catalog."default",
    documento_content_type character varying(255) COLLATE pg_catalog."default",
    documento_file_size integer,
    documento_updated_at timestamp without time zone,
    CONSTRAINT politica_procedimientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.politica_procedimientos
    OWNER to compaas_app;
-- Index: index_politica_procedimientos_on_empresa_id

-- DROP INDEX IF EXISTS public.index_politica_procedimientos_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_politica_procedimientos_on_empresa_id
    ON public.politica_procedimientos USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.politica_tics

-- DROP TABLE IF EXISTS public.politica_tics;

CREATE TABLE IF NOT EXISTS public.politica_tics
(
    id integer NOT NULL DEFAULT nextval('politica_tics_id_seq'::regclass),
    empresa_id integer,
    con_politica boolean DEFAULT false,
    robo_perdida boolean DEFAULT false,
    instalacion_software boolean DEFAULT false,
    uso_correo boolean DEFAULT false,
    uso_internet boolean DEFAULT false,
    soporte boolean DEFAULT false,
    regimen_sancionador boolean DEFAULT false,
    aceptacion_politica boolean DEFAULT false,
    entrega_dispositivo boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT politica_tics_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_954f8f67ce FOREIGN KEY (empresa_id)
        REFERENCES public.empresas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.politica_tics
    OWNER to compaas_app;
-- Index: index_politica_tics_on_empresa_id

-- DROP INDEX IF EXISTS public.index_politica_tics_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_politica_tics_on_empresa_id
    ON public.politica_tics USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.pregunta_checklist_debida_diligencias

-- DROP TABLE IF EXISTS public.pregunta_checklist_debida_diligencias;

CREATE TABLE IF NOT EXISTS public.pregunta_checklist_debida_diligencias
(
    id integer NOT NULL DEFAULT nextval('pregunta_checklist_debida_diligencias_id_seq'::regclass),
    grupo_pregunta_checklist_debida_diligencia_id integer,
    "position" integer,
    pregunta character varying COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT pregunta_checklist_debida_diligencias_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_c8917c4d9c FOREIGN KEY (grupo_pregunta_checklist_debida_diligencia_id)
        REFERENCES public.grupo_pregunta_checklist_debida_diligencias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pregunta_checklist_debida_diligencias
    OWNER to compaas_app;
-- Index: index_preg_checklist_deb_dil_on_gr_preg_checklist_deb_dil_id

-- DROP INDEX IF EXISTS public.index_preg_checklist_deb_dil_on_gr_preg_checklist_deb_dil_id;

CREATE INDEX IF NOT EXISTS index_preg_checklist_deb_dil_on_gr_preg_checklist_deb_dil_id
    ON public.pregunta_checklist_debida_diligencias USING btree
    (grupo_pregunta_checklist_debida_diligencia_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.proceso_tratamientos

-- DROP TABLE IF EXISTS public.proceso_tratamientos;

CREATE TABLE IF NOT EXISTS public.proceso_tratamientos
(
    id integer NOT NULL DEFAULT nextval('proceso_tratamientos_id_seq'::regclass),
    nombre text COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    tiempo_auditoria integer,
    tipo character varying(255) COLLATE pg_catalog."default",
    gestion character varying(255) COLLATE pg_catalog."default",
    responsable_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    tratamiento character varying(255) COLLATE pg_catalog."default",
    finalidad text COLLATE pg_catalog."default",
    fecha_ultima_auditoria date,
    forma_recogida text COLLATE pg_catalog."default",
    plazo_conservacion text COLLATE pg_catalog."default",
    cesiones text COLLATE pg_catalog."default",
    departamento_id integer,
    consentimiento text COLLATE pg_catalog."default",
    con_categorias_especiales boolean DEFAULT false,
    con_transferencias_internacionales boolean DEFAULT false,
    role integer,
    aprobado_rgpd boolean DEFAULT false,
    licitud_a boolean DEFAULT false,
    licitud_b boolean DEFAULT false,
    licitud_c boolean DEFAULT false,
    licitud_d boolean DEFAULT false,
    licitud_e boolean DEFAULT false,
    licitud_f boolean DEFAULT false,
    informe_ponderacion_file_name character varying COLLATE pg_catalog."default",
    informe_ponderacion_content_type character varying COLLATE pg_catalog."default",
    informe_ponderacion_file_size integer,
    informe_ponderacion_updated_at timestamp without time zone,
    crit_naturaleza_dato integer,
    crit_alcance integer,
    crit_contexto integer,
    crit_tipologia_interesado integer,
    nivel_criticidad integer DEFAULT 0,
    CONSTRAINT proceso_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.proceso_tratamientos
    OWNER to compaas_app;
-- Index: index_proceso_tratamientos_on_departamento_id

-- DROP INDEX IF EXISTS public.index_proceso_tratamientos_on_departamento_id;

CREATE INDEX IF NOT EXISTS index_proceso_tratamientos_on_departamento_id
    ON public.proceso_tratamientos USING btree
    (departamento_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_proceso_tratamientos_on_responsable_id

-- DROP INDEX IF EXISTS public.index_proceso_tratamientos_on_responsable_id;

CREATE INDEX IF NOT EXISTS index_proceso_tratamientos_on_responsable_id
    ON public.proceso_tratamientos USING btree
    (responsable_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.proceso_tratamientos_sistema_tratamientos

-- DROP TABLE IF EXISTS public.proceso_tratamientos_sistema_tratamientos;

CREATE TABLE IF NOT EXISTS public.proceso_tratamientos_sistema_tratamientos
(
    id integer NOT NULL DEFAULT nextval('proceso_tratamientos_sistema_tratamientos_id_seq'::regclass),
    proceso_tratamiento_id integer,
    sistema_tratamiento_id integer,
    CONSTRAINT proceso_tratamientos_sistema_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.proceso_tratamientos_sistema_tratamientos
    OWNER to compaas_app;
-- Index: procesos_tratamiento_sistemas_tratamiento

-- DROP INDEX IF EXISTS public.procesos_tratamiento_sistemas_tratamiento;

CREATE INDEX IF NOT EXISTS procesos_tratamiento_sistemas_tratamiento
    ON public.proceso_tratamientos_sistema_tratamientos USING btree
    (sistema_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: procesos_tratamiento_sistemas_tratamiento_index

-- DROP INDEX IF EXISTS public.procesos_tratamiento_sistemas_tratamiento_index;

CREATE INDEX IF NOT EXISTS procesos_tratamiento_sistemas_tratamiento_index
    ON public.proceso_tratamientos_sistema_tratamientos USING btree
    (proceso_tratamiento_id ASC NULLS LAST, sistema_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: procesos_tratamiento_sistemas_tratamiento_proc_id

-- DROP INDEX IF EXISTS public.procesos_tratamiento_sistemas_tratamiento_proc_id;

CREATE INDEX IF NOT EXISTS procesos_tratamiento_sistemas_tratamiento_proc_id
    ON public.proceso_tratamientos_sistema_tratamientos USING btree
    (proceso_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.proveedors

-- DROP TABLE IF EXISTS public.proveedors;

CREATE TABLE IF NOT EXISTS public.proveedors
(
    id integer NOT NULL DEFAULT nextval('proveedors_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    cif character varying(255) COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    direccion_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    logo_file_name character varying(255) COLLATE pg_catalog."default",
    logo_content_type character varying(255) COLLATE pg_catalog."default",
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    web character varying(255) COLLATE pg_catalog."default",
    contacto_id integer,
    tipo integer,
    empresa_id integer,
    con_acceso_a_datos boolean,
    CONSTRAINT proveedors_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.proveedors
    OWNER to compaas_app;
-- Index: index_proveedors_on_contacto_id

-- DROP INDEX IF EXISTS public.index_proveedors_on_contacto_id;

CREATE INDEX IF NOT EXISTS index_proveedors_on_contacto_id
    ON public.proveedors USING btree
    (contacto_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_proveedors_on_direccion_id

-- DROP INDEX IF EXISTS public.index_proveedors_on_direccion_id;

CREATE INDEX IF NOT EXISTS index_proveedors_on_direccion_id
    ON public.proveedors USING btree
    (direccion_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.provincia

-- DROP TABLE IF EXISTS public.provincia;

CREATE TABLE IF NOT EXISTS public.provincia
(
    id integer NOT NULL DEFAULT nextval('provincia_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    pais_id integer,
    CONSTRAINT provincia_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.provincia
    OWNER to compaas_app;
-- Index: index_provincia_on_pais_id

-- DROP INDEX IF EXISTS public.index_provincia_on_pais_id;

CREATE INDEX IF NOT EXISTS index_provincia_on_pais_id
    ON public.provincia USING btree
    (pais_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.receptor_cesions

-- DROP TABLE IF EXISTS public.receptor_cesions;

CREATE TABLE IF NOT EXISTS public.receptor_cesions
(
    id integer NOT NULL DEFAULT nextval('receptor_cesions_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    cif character varying(255) COLLATE pg_catalog."default",
    direccion_id integer,
    contacto_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT receptor_cesions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.receptor_cesions
    OWNER to compaas_app;
-- Index: index_receptor_cesions_on_contacto_id

-- DROP INDEX IF EXISTS public.index_receptor_cesions_on_contacto_id;

CREATE INDEX IF NOT EXISTS index_receptor_cesions_on_contacto_id
    ON public.receptor_cesions USING btree
    (contacto_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_receptor_cesions_on_direccion_id

-- DROP INDEX IF EXISTS public.index_receptor_cesions_on_direccion_id;

CREATE INDEX IF NOT EXISTS index_receptor_cesions_on_direccion_id
    ON public.receptor_cesions USING btree
    (direccion_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.receptor_transferencia_internacionals

-- DROP TABLE IF EXISTS public.receptor_transferencia_internacionals;

CREATE TABLE IF NOT EXISTS public.receptor_transferencia_internacionals
(
    id integer NOT NULL DEFAULT nextval('receptor_transferencia_internacionals_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    cif character varying(255) COLLATE pg_catalog."default",
    direccion_id integer,
    contacto_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT receptor_transferencia_internacionals_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.receptor_transferencia_internacionals
    OWNER to compaas_app;
-- Index: index_receptor_transferencia_internacionals_on_contacto_id

-- DROP INDEX IF EXISTS public.index_receptor_transferencia_internacionals_on_contacto_id;

CREATE INDEX IF NOT EXISTS index_receptor_transferencia_internacionals_on_contacto_id
    ON public.receptor_transferencia_internacionals USING btree
    (contacto_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_receptor_transferencia_internacionals_on_direccion_id

-- DROP INDEX IF EXISTS public.index_receptor_transferencia_internacionals_on_direccion_id;

CREATE INDEX IF NOT EXISTS index_receptor_transferencia_internacionals_on_direccion_id
    ON public.receptor_transferencia_internacionals USING btree
    (direccion_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.recurso_tratamiento_externos

-- DROP TABLE IF EXISTS public.recurso_tratamiento_externos;

CREATE TABLE IF NOT EXISTS public.recurso_tratamiento_externos
(
    id integer NOT NULL DEFAULT nextval('recurso_tratamiento_externos_id_seq'::regclass),
    inicio_contrato date,
    fin_contrato date,
    contrato character varying(255) COLLATE pg_catalog."default",
    objeto_servicio character varying(255) COLLATE pg_catalog."default",
    subcontratista character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT recurso_tratamiento_externos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.recurso_tratamiento_externos
    OWNER to compaas_app;


-- Table: public.recurso_tratamiento_internos

-- DROP TABLE IF EXISTS public.recurso_tratamiento_internos;

CREATE TABLE IF NOT EXISTS public.recurso_tratamiento_internos
(
    id integer NOT NULL DEFAULT nextval('recurso_tratamiento_internos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    descripcion character varying(255) COLLATE pg_catalog."default",
    centro_tratamiento_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT recurso_tratamiento_internos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.recurso_tratamiento_internos
    OWNER to compaas_app;
-- Index: index_recurso_tratamiento_internos_on_centro_tratamiento_id

-- DROP INDEX IF EXISTS public.index_recurso_tratamiento_internos_on_centro_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_recurso_tratamiento_internos_on_centro_tratamiento_id
    ON public.recurso_tratamiento_internos USING btree
    (centro_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.recurso_tratamientos

-- DROP TABLE IF EXISTS public.recurso_tratamientos;

CREATE TABLE IF NOT EXISTS public.recurso_tratamientos
(
    id integer NOT NULL DEFAULT nextval('recurso_tratamientos_id_seq'::regclass),
    centro_tratamiento_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    tipo character varying(255) COLLATE pg_catalog."default",
    responsable_id integer,
    nombre character varying(255) COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    fecha_ultima_auditoria date,
    sistema_operativo character varying(255) COLLATE pg_catalog."default",
    nivel_criticidad integer DEFAULT 0,
    CONSTRAINT recurso_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.recurso_tratamientos
    OWNER to compaas_app;
-- Index: index_recurso_tratamientos_on_centro_tratamiento_id

-- DROP INDEX IF EXISTS public.index_recurso_tratamientos_on_centro_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_recurso_tratamientos_on_centro_tratamiento_id
    ON public.recurso_tratamientos USING btree
    (centro_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_recurso_tratamientos_on_responsable_id

-- DROP INDEX IF EXISTS public.index_recurso_tratamientos_on_responsable_id;

CREATE INDEX IF NOT EXISTS index_recurso_tratamientos_on_responsable_id
    ON public.recurso_tratamientos USING btree
    (responsable_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.recurso_tratamientos_encargado_tratamientos

-- DROP TABLE IF EXISTS public.recurso_tratamientos_encargado_tratamientos;

CREATE TABLE IF NOT EXISTS public.recurso_tratamientos_encargado_tratamientos
(
    encargado_tratamiento_id integer,
    recurso_tratamiento_id integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.recurso_tratamientos_encargado_tratamientos
    OWNER to compaas_app;
-- Index: recurso_tratamientos_encargado_tratamientos_index

-- DROP INDEX IF EXISTS public.recurso_tratamientos_encargado_tratamientos_index;

CREATE INDEX IF NOT EXISTS recurso_tratamientos_encargado_tratamientos_index
    ON public.recurso_tratamientos_encargado_tratamientos USING btree
    (recurso_tratamiento_id ASC NULLS LAST, encargado_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.recurso_tratamientos_incidencias

-- DROP TABLE IF EXISTS public.recurso_tratamientos_incidencias;

CREATE TABLE IF NOT EXISTS public.recurso_tratamientos_incidencias
(
    incidencia_id integer,
    recurso_tratamiento_id integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.recurso_tratamientos_incidencias
    OWNER to compaas_app;
-- Index: recurso_tratamientos_incidencias_index

-- DROP INDEX IF EXISTS public.recurso_tratamientos_incidencias_index;

CREATE INDEX IF NOT EXISTS recurso_tratamientos_incidencias_index
    ON public.recurso_tratamientos_incidencias USING btree
    (recurso_tratamiento_id ASC NULLS LAST, incidencia_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.recurso_tratamientos_sistema_tratamientos

-- DROP TABLE IF EXISTS public.recurso_tratamientos_sistema_tratamientos;

CREATE TABLE IF NOT EXISTS public.recurso_tratamientos_sistema_tratamientos
(
    id integer NOT NULL DEFAULT nextval('recurso_tratamientos_sistema_tratamientos_id_seq'::regclass),
    recurso_tratamiento_id integer,
    sistema_tratamiento_id integer,
    CONSTRAINT recurso_tratamientos_sistema_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.recurso_tratamientos_sistema_tratamientos
    OWNER to compaas_app;
-- Index: recurso_tratamientos_sistema_tratamientos_index

-- DROP INDEX IF EXISTS public.recurso_tratamientos_sistema_tratamientos_index;

CREATE INDEX IF NOT EXISTS recurso_tratamientos_sistema_tratamientos_index
    ON public.recurso_tratamientos_sistema_tratamientos USING btree
    (recurso_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: recurso_tratamientos_sistema_tratamientos_sist_index

-- DROP INDEX IF EXISTS public.recurso_tratamientos_sistema_tratamientos_sist_index;

CREATE INDEX IF NOT EXISTS recurso_tratamientos_sistema_tratamientos_sist_index
    ON public.recurso_tratamientos_sistema_tratamientos USING btree
    (sistema_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.remesa_in_out_soportes

-- DROP TABLE IF EXISTS public.remesa_in_out_soportes;

CREATE TABLE IF NOT EXISTS public.remesa_in_out_soportes
(
    id integer NOT NULL DEFAULT nextval('remesa_in_out_soportes_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT remesa_in_out_soportes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.remesa_in_out_soportes
    OWNER to compaas_app;


-- Table: public.responsables

-- DROP TABLE IF EXISTS public.responsables;

CREATE TABLE IF NOT EXISTS public.responsibles
(
    responsible_id integer NOT NULL AUTO_INCREMENT,
    responsible_name VARCHAR(255),
    responsible_email VARCHAR(255),
    responsible_phone VARCHAR(255),
    responsible_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    responsible_updated_at TIMESTAMP,
    CONSTRAINT PRIMARY KEY (responsible_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.responsables
    OWNER to compaas_app;

-- Table: public.respuesta_checklist_debida_diligencias

-- DROP TABLE IF EXISTS public.respuesta_checklist_debida_diligencias;

CREATE TABLE IF NOT EXISTS public.respuesta_checklist_debida_diligencias
(
    id integer NOT NULL DEFAULT nextval('respuesta_checklist_debida_diligencias_id_seq'::regclass),
    checklist_debida_diligencia_id integer,
    pregunta_checklist_debida_diligencia_id integer,
    respuesta integer,
    observaciones text COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT respuesta_checklist_debida_diligencias_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_aa731388ec FOREIGN KEY (checklist_debida_diligencia_id)
        REFERENCES public.checklist_debida_diligencias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_e304f9e3c0 FOREIGN KEY (pregunta_checklist_debida_diligencia_id)
        REFERENCES public.pregunta_checklist_debida_diligencias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.respuesta_checklist_debida_diligencias
    OWNER to compaas_app;
-- Index: index_resp_checklist_deb_dil_on_preg_checklist_deb_dil_id

-- DROP INDEX IF EXISTS public.index_resp_checklist_deb_dil_on_preg_checklist_deb_dil_id;

CREATE INDEX IF NOT EXISTS index_resp_checklist_deb_dil_on_preg_checklist_deb_dil_id
    ON public.respuesta_checklist_debida_diligencias USING btree
    (pregunta_checklist_debida_diligencia_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_respuesta_checklist_deb_dil_on_checklist_deb_dil_id

-- DROP INDEX IF EXISTS public.index_respuesta_checklist_deb_dil_on_checklist_deb_dil_id;

CREATE INDEX IF NOT EXISTS index_respuesta_checklist_deb_dil_on_checklist_deb_dil_id
    ON public.respuesta_checklist_debida_diligencias USING btree
    (checklist_debida_diligencia_id ASC NULLS LAST)
    TABLESPACE pg_default;



-- Table: public.respuesta_cuestionario_riesgo_legals

-- DROP TABLE IF EXISTS public.respuesta_cuestionario_riesgo_legals;

CREATE TABLE IF NOT EXISTS public.respuesta_cuestionario_riesgo_legals
(
    id integer NOT NULL DEFAULT nextval('respuesta_cuestionario_riesgo_legals_id_seq'::regclass),
    cuestionable_id integer,
    cuestionable_type character varying COLLATE pg_catalog."default",
    cuestionario_riesgo_legal_id integer,
    key_respuesta integer,
    con_riesgo_legal boolean DEFAULT false,
    ultimo_cambio_por_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    computable_mostrada boolean,
    CONSTRAINT respuesta_cuestionario_riesgo_legals_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_0c1590c204 FOREIGN KEY (cuestionario_riesgo_legal_id)
        REFERENCES public.cuestionario_riesgo_legals (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_325355e134 FOREIGN KEY (ultimo_cambio_por_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.respuesta_cuestionario_riesgo_legals
    OWNER to compaas_app;
-- Index: index_respuesta_cuestionario_riesgo_legals_on_cuestionario

-- DROP INDEX IF EXISTS public.index_respuesta_cuestionario_riesgo_legals_on_cuestionario;

CREATE INDEX IF NOT EXISTS index_respuesta_cuestionario_riesgo_legals_on_cuestionario
    ON public.respuesta_cuestionario_riesgo_legals USING btree
    (cuestionario_riesgo_legal_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_respuesta_cuestionario_riesgo_legals_on_custionable

-- DROP INDEX IF EXISTS public.index_respuesta_cuestionario_riesgo_legals_on_custionable;

CREATE INDEX IF NOT EXISTS index_respuesta_cuestionario_riesgo_legals_on_custionable
    ON public.respuesta_cuestionario_riesgo_legals USING btree
    (cuestionable_type COLLATE pg_catalog."default" ASC NULLS LAST, cuestionable_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_respuesta_cuestionario_riesgo_legals_on_ultimo_cambio_por

-- DROP INDEX IF EXISTS public.index_respuesta_cuestionario_riesgo_legals_on_ultimo_cambio_por;

CREATE INDEX IF NOT EXISTS index_respuesta_cuestionario_riesgo_legals_on_ultimo_cambio_por
    ON public.respuesta_cuestionario_riesgo_legals USING btree
    (ultimo_cambio_por_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.riesgo_activos

-- DROP TABLE IF EXISTS public.riesgo_activos;

CREATE TABLE IF NOT EXISTS public.riesgo_activos
(
    id integer NOT NULL DEFAULT nextval('riesgo_activos_id_seq'::regclass),
    riesgo_id integer,
    activo_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying COLLATE pg_catalog."default",
    CONSTRAINT riesgo_activos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_f150b3e199 FOREIGN KEY (riesgo_id)
        REFERENCES public.riesgos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.riesgo_activos
    OWNER to compaas_app;
-- Index: index_riesgo_activos_on_activo_id

-- DROP INDEX IF EXISTS public.index_riesgo_activos_on_activo_id;

CREATE INDEX IF NOT EXISTS index_riesgo_activos_on_activo_id
    ON public.riesgo_activos USING btree
    (activo_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_riesgo_activos_on_riesgo_id

-- DROP INDEX IF EXISTS public.index_riesgo_activos_on_riesgo_id;

CREATE INDEX IF NOT EXISTS index_riesgo_activos_on_riesgo_id
    ON public.riesgo_activos USING btree
    (riesgo_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.riesgo_articulos

-- DROP TABLE IF EXISTS public.riesgo_articulos;

CREATE TABLE IF NOT EXISTS public.riesgo_articulos
(
    id integer NOT NULL DEFAULT nextval('riesgo_articulos_id_seq'::regclass),
    riesgo_id integer,
    articulo_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT riesgo_articulos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_22d69d01a9 FOREIGN KEY (riesgo_id)
        REFERENCES public.riesgos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_3ba3f31f81 FOREIGN KEY (articulo_id)
        REFERENCES public.articulos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.riesgo_articulos
    OWNER to compaas_app;
-- Index: index_riesgo_articulos_on_articulo_id

-- DROP INDEX IF EXISTS public.index_riesgo_articulos_on_articulo_id;

CREATE INDEX IF NOT EXISTS index_riesgo_articulos_on_articulo_id
    ON public.riesgo_articulos USING btree
    (articulo_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_riesgo_articulos_on_riesgo_id

-- DROP INDEX IF EXISTS public.index_riesgo_articulos_on_riesgo_id;

CREATE INDEX IF NOT EXISTS index_riesgo_articulos_on_riesgo_id
    ON public.riesgo_articulos USING btree
    (riesgo_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.riesgo_legals

-- DROP TABLE IF EXISTS public.riesgo_legals;

CREATE TABLE IF NOT EXISTS legal_risks
(
    legal_risk_id integer NOT NULL AUTO_INCREMENT,
    nombre character varying COLLATE pg_catalog."default",
    criticidad integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT riesgo_legals_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.riesgo_legals
    OWNER to compaas_app;

-- Table: public.riesgo_medidas

-- DROP TABLE IF EXISTS public.riesgo_medidas;

CREATE TABLE IF NOT EXISTS public.riesgo_medidas
(
    id integer NOT NULL DEFAULT nextval('riesgo_medidas_id_seq'::regclass),
    riesgo_id integer,
    medida_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT riesgo_medidas_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_a92da60a2e FOREIGN KEY (riesgo_id)
        REFERENCES public.riesgos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_c9dcf6a4de FOREIGN KEY (medida_id)
        REFERENCES public.medida_seguridads (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.riesgo_medidas
    OWNER to compaas_app;
-- Index: index_riesgo_medidas_on_medida_id

-- DROP INDEX IF EXISTS public.index_riesgo_medidas_on_medida_id;

CREATE INDEX IF NOT EXISTS index_riesgo_medidas_on_medida_id
    ON public.riesgo_medidas USING btree
    (medida_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_riesgo_medidas_on_riesgo_id

-- DROP INDEX IF EXISTS public.index_riesgo_medidas_on_riesgo_id;

CREATE INDEX IF NOT EXISTS index_riesgo_medidas_on_riesgo_id
    ON public.riesgo_medidas USING btree
    (riesgo_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.riesgos

-- DROP TABLE IF EXISTS public.riesgos;

CREATE TABLE IF NOT EXISTS public.riesgos
(
    id integer NOT NULL DEFAULT nextval('riesgos_id_seq'::regclass),
    ref character varying(255) COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    tratamiento character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    probabilidad_por_defecto integer,
    centros_por_defecto boolean,
    recursos_por_defecto boolean,
    sistemas_por_defecto boolean,
    disponibilidad boolean DEFAULT false,
    confidencialidad boolean DEFAULT false,
    integridad boolean DEFAULT false,
    trazabilidad boolean DEFAULT false,
    autenticidad boolean DEFAULT false,
    CONSTRAINT riesgos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.riesgos
    OWNER to compaas_app;


-- Table: public.roles

-- DROP TABLE IF EXISTS public.roles;

CREATE TABLE IF NOT EXISTS public.roles
(
    id integer NOT NULL DEFAULT nextval('roles_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default",
    resource_id integer,
    resource_type character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT roles_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.roles
    OWNER to compaas_app;
-- Index: index_roles_on_name

-- DROP INDEX IF EXISTS public.index_roles_on_name;

CREATE INDEX IF NOT EXISTS index_roles_on_name
    ON public.roles USING btree
    (name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_roles_on_name_and_resource_type_and_resource_id

-- DROP INDEX IF EXISTS public.index_roles_on_name_and_resource_type_and_resource_id;

CREATE INDEX IF NOT EXISTS index_roles_on_name_and_resource_type_and_resource_id
    ON public.roles USING btree
    (name COLLATE pg_catalog."default" ASC NULLS LAST, resource_type COLLATE pg_catalog."default" ASC NULLS LAST, resource_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.schema_migrations

-- DROP TABLE IF EXISTS public.schema_migrations;

CREATE TABLE IF NOT EXISTS public.schema_migrations
(
    version character varying(255) COLLATE pg_catalog."default" NOT NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.schema_migrations
    OWNER to compaas_app;
-- Index: unique_schema_migrations

-- DROP INDEX IF EXISTS public.unique_schema_migrations;

CREATE UNIQUE INDEX IF NOT EXISTS unique_schema_migrations
    ON public.schema_migrations USING btree
    (version COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.sectors

-- DROP TABLE IF EXISTS public.sectors;

CREATE TABLE IF NOT EXISTS public.sectors
(
    id integer NOT NULL DEFAULT nextval('sectors_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT sectors_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sectors
    OWNER to compaas_app;

-- Table: public.sistema_tratamiento_externos

-- DROP TABLE IF EXISTS public.sistema_tratamiento_externos;

CREATE TABLE IF NOT EXISTS public.sistema_tratamiento_externos
(
    id integer NOT NULL DEFAULT nextval('sistema_tratamiento_externos_id_seq'::regclass),
    inicio_contrato date,
    fin_contrato date,
    objeto_servicio character varying(255) COLLATE pg_catalog."default",
    subcontratista character varying(255) COLLATE pg_catalog."default",
    contrato character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT sistema_tratamiento_externos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sistema_tratamiento_externos
    OWNER to compaas_app;

-- Table: public.sistema_tratamiento_internos

-- DROP TABLE IF EXISTS public.sistema_tratamiento_internos;

CREATE TABLE IF NOT EXISTS public.sistema_tratamiento_internos
(
    id integer NOT NULL DEFAULT nextval('sistema_tratamiento_internos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    descripcion character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT sistema_tratamiento_internos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sistema_tratamiento_internos
    OWNER to compaas_app;


-- Table: public.sistema_tratamientos

-- DROP TABLE IF EXISTS public.sistema_tratamientos;

CREATE TABLE IF NOT EXISTS public.sistema_tratamientos
(
    id integer NOT NULL DEFAULT nextval('sistema_tratamientos_id_seq'::regclass),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    nombre text COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    tipo character varying(255) COLLATE pg_catalog."default",
    responsable_id integer,
    clase character varying(255) COLLATE pg_catalog."default",
    fecha_ultima_auditoria date,
    nivel_criticidad integer DEFAULT 0,
    CONSTRAINT sistema_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sistema_tratamientos
    OWNER to compaas_app;
-- Index: index_sistema_tratamientos_on_responsable_id

-- DROP INDEX IF EXISTS public.index_sistema_tratamientos_on_responsable_id;

CREATE INDEX IF NOT EXISTS index_sistema_tratamientos_on_responsable_id
    ON public.sistema_tratamientos USING btree
    (responsable_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.sistema_tratamientos_incidencias

-- DROP TABLE IF EXISTS public.sistema_tratamientos_incidencias;

CREATE TABLE IF NOT EXISTS public.sistema_tratamientos_incidencias
(
    incidencia_id integer,
    sistema_tratamiento_id integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sistema_tratamientos_incidencias
    OWNER to compaas_app;
-- Index: sistema_tratamientos_incidencias_index

-- DROP INDEX IF EXISTS public.sistema_tratamientos_incidencias_index;

CREATE INDEX IF NOT EXISTS sistema_tratamientos_incidencias_index
    ON public.sistema_tratamientos_incidencias USING btree
    (sistema_tratamiento_id ASC NULLS LAST, incidencia_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.tarea_recurrentes

-- DROP TABLE IF EXISTS public.tarea_recurrentes;

CREATE TABLE IF NOT EXISTS public.tarea_recurrentes
(
    id integer NOT NULL DEFAULT nextval('tarea_recurrentes_id_seq'::regclass),
    descripcion character varying(255) COLLATE pg_catalog."default",
    inicio date,
    baja date,
    causa_baja character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tarea_recurrentes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tarea_recurrentes
    OWNER to compaas_app;

-- Table: public.tareas

-- DROP TABLE IF EXISTS public.tareas;

CREATE TABLE IF NOT EXISTS public.tareas
(
    id integer NOT NULL DEFAULT nextval('tareas_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    id_tipo integer,
    pia_id integer,
    creacion date,
    id_creador integer,
    aprobacion date,
    id_responsable_aprobacion integer,
    id_supervisor integer,
    inicio_previsto date,
    fin_previsto date,
    estado integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    observaciones text COLLATE pg_catalog."default",
    avance integer,
    horas_dedicadas numeric(5,2),
    id_referencia integer,
    fin_real date,
    cierre date,
    horas_estimadas integer,
    user_informado integer,
    asignacion date,
    id_responsable_asignacion integer,
    consultant_id integer,
    inicio_real date,
    recurrente boolean,
    periodo integer,
    empresa_id integer,
    fecha_limite date,
    nombre_solicitante character varying COLLATE pg_catalog."default",
    email_solicitante character varying COLLATE pg_catalog."default",
    telefono_solicitante character varying COLLATE pg_catalog."default",
    CONSTRAINT tareas_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tareas
    OWNER to compaas_app;
-- Index: index_tareas_on_empresa_id

-- DROP INDEX IF EXISTS public.index_tareas_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_tareas_on_empresa_id
    ON public.tareas USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_tareas_on_pia_id

-- DROP INDEX IF EXISTS public.index_tareas_on_pia_id;

CREATE INDEX IF NOT EXISTS index_tareas_on_pia_id
    ON public.tareas USING btree
    (pia_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.tickets

-- DROP TABLE IF EXISTS public.tickets;

CREATE TABLE IF NOT EXISTS public.tickets
(
    id integer NOT NULL DEFAULT nextval('tickets_id_seq'::regclass),
    descripcion character varying(255) COLLATE pg_catalog."default",
    horas_estimadas integer,
    inicio timestamp without time zone,
    fin timestamp without time zone,
    porcentaje integer,
    horas_realizadas integer,
    cierre timestamp without time zone,
    ficha_servicio_id integer,
    tipo_ticket_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tickets_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tickets
    OWNER to compaas_app;
-- Index: index_tickets_on_ficha_servicio_id

-- DROP INDEX IF EXISTS public.index_tickets_on_ficha_servicio_id;

CREATE INDEX IF NOT EXISTS index_tickets_on_ficha_servicio_id
    ON public.tickets USING btree
    (ficha_servicio_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_tickets_on_tipo_ticket_id

-- DROP INDEX IF EXISTS public.index_tickets_on_tipo_ticket_id;

CREATE INDEX IF NOT EXISTS index_tickets_on_tipo_ticket_id
    ON public.tickets USING btree
    (tipo_ticket_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.tipo_campo_fichero_juridico

-- DROP TABLE IF EXISTS public.tipo_campo_fichero_juridico;

CREATE TABLE IF NOT EXISTS public.tipo_campo_fichero_juridico
(
    tipo_campo_id integer,
    fichero_juridico_id integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_campo_fichero_juridico
    OWNER to compaas_app;

-- Table: public.tipo_campos

-- DROP TABLE IF EXISTS public.tipo_campos;

CREATE TABLE IF NOT EXISTS public.tipo_campos
(
    id integer NOT NULL DEFAULT nextval('tipo_campos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    descripcion character varying(2048) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_campos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_campos
    OWNER to compaas_app;

-- Table: public.tipo_consulta

-- DROP TABLE IF EXISTS public.tipo_consulta;

CREATE TABLE IF NOT EXISTS public.tipo_consulta
(
    id integer NOT NULL DEFAULT nextval('tipo_consulta_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_consulta_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_consulta
    OWNER to compaas_app;

-- Table: public.tipo_ficha_servicios

-- DROP TABLE IF EXISTS public.tipo_ficha_servicios;

CREATE TABLE IF NOT EXISTS public.tipo_ficha_servicios
(
    id integer NOT NULL DEFAULT nextval('tipo_ficha_servicios_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_ficha_servicios_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_ficha_servicios
    OWNER to compaas_app;


-- Table: public.tipo_frecuencia_tarea_recurrentes

-- DROP TABLE IF EXISTS public.tipo_frecuencia_tarea_recurrentes;

CREATE TABLE IF NOT EXISTS public.tipo_frecuencia_tarea_recurrentes
(
    id integer NOT NULL DEFAULT nextval('tipo_frecuencia_tarea_recurrentes_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_frecuencia_tarea_recurrentes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_frecuencia_tarea_recurrentes
    OWNER to compaas_app;

-- Table: public.tipo_gestion_recurso_tratamientos

-- DROP TABLE IF EXISTS public.tipo_gestion_recurso_tratamientos;

CREATE TABLE IF NOT EXISTS public.tipo_gestion_recurso_tratamientos
(
    id integer NOT NULL DEFAULT nextval('tipo_gestion_recurso_tratamientos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_gestion_recurso_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_gestion_recurso_tratamientos
    OWNER to compaas_app;

-- Table: public.tipo_incidencia

-- DROP TABLE IF EXISTS public.tipo_incidencia;

CREATE TABLE IF NOT EXISTS public.tipo_incidencia
(
    id integer NOT NULL DEFAULT nextval('tipo_incidencia_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_incidencia_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_incidencia
    OWNER to compaas_app;


-- Table: public.tipo_medida_seguridads

-- DROP TABLE IF EXISTS public.tipo_medida_seguridads;

CREATE TABLE IF NOT EXISTS public.tipo_medida_seguridads
(
    id integer NOT NULL DEFAULT nextval('tipo_medida_seguridads_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_medida_seguridads_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_medida_seguridads
    OWNER to compaas_app;

-- Table: public.tipo_op_in_out_soportes

-- DROP TABLE IF EXISTS public.tipo_op_in_out_soportes;

CREATE TABLE IF NOT EXISTS public.tipo_op_in_out_soportes
(
    id integer NOT NULL DEFAULT nextval('tipo_op_in_out_soportes_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_op_in_out_soportes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_op_in_out_soportes
    OWNER to compaas_app;

-- Table: public.tipo_peticions

-- DROP TABLE IF EXISTS public.tipo_peticions;

CREATE TABLE IF NOT EXISTS public.tipo_peticions
(
    id integer NOT NULL DEFAULT nextval('tipo_peticions_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_peticions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_peticions
    OWNER to compaas_app;

-- Table: public.tipo_recurso_tratamientos

-- DROP TABLE IF EXISTS public.tipo_recurso_tratamientos;

CREATE TABLE IF NOT EXISTS public.tipo_recurso_tratamientos
(
    id integer NOT NULL DEFAULT nextval('tipo_recurso_tratamientos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_recurso_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_recurso_tratamientos
    OWNER to compaas_app;

-- Table: public.tipo_sistema_tratamientos

-- DROP TABLE IF EXISTS public.tipo_sistema_tratamientos;

CREATE TABLE IF NOT EXISTS public.tipo_sistema_tratamientos
(
    id integer NOT NULL DEFAULT nextval('tipo_sistema_tratamientos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_sistema_tratamientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_sistema_tratamientos
    OWNER to compaas_app;


-- Table: public.tipo_soportes

-- DROP TABLE IF EXISTS public.tipo_soportes;

CREATE TABLE IF NOT EXISTS public.tipo_soportes
(
    id integer NOT NULL DEFAULT nextval('tipo_soportes_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_soportes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_soportes
    OWNER to compaas_app;

-- Table: public.tipo_tarea_recurrentes

-- DROP TABLE IF EXISTS public.tipo_tarea_recurrentes;

CREATE TABLE IF NOT EXISTS public.tipo_tarea_recurrentes
(
    id integer NOT NULL DEFAULT nextval('tipo_tarea_recurrentes_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_tarea_recurrentes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_tarea_recurrentes
    OWNER to compaas_app;

-- Table: public.tipo_tickets

-- DROP TABLE IF EXISTS public.tipo_tickets;

CREATE TABLE IF NOT EXISTS public.tipo_tickets
(
    id integer NOT NULL DEFAULT nextval('tipo_tickets_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tipo_tickets_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_tickets
    OWNER to compaas_app;

-- Table: public.tmp_cumplimientos

-- DROP TABLE IF EXISTS public.tmp_cumplimientos;

CREATE TABLE IF NOT EXISTS public.tmp_cumplimientos
(
    id integer NOT NULL DEFAULT nextval('tmp_cumplimientos_id_seq'::regclass),
    empresa_id integer,
    control_id integer,
    cumplimiento integer DEFAULT 0,
    fecha date,
    evidencia_descripcion text COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    evidencia_file_name character varying(255) COLLATE pg_catalog."default",
    evidencia_content_type character varying(255) COLLATE pg_catalog."default",
    evidencia_file_size integer,
    evidencia_updated_at timestamp without time zone,
    implantado boolean DEFAULT false,
    ejecutado boolean DEFAULT false,
    definido boolean DEFAULT false,
    manipulable_medible boolean DEFAULT false,
    optimizado boolean DEFAULT false,
    cumplimiento_updated_at timestamp without time zone,
    necesita_recalcular_valoraciones boolean DEFAULT false,
    CONSTRAINT tmp_cumplimientos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tmp_cumplimientos
    OWNER to compaas_app;

-- Table: public.transferencia_internacionals

-- DROP TABLE IF EXISTS public.transferencia_internacionals;

CREATE TABLE IF NOT EXISTS public.transferencia_internacionals
(
    id integer NOT NULL DEFAULT nextval('transferencia_internacionals_id_seq'::regclass),
    fichero_juridico_id integer,
    pais_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    fecha_autorizacion date,
    codigo_autorizacion character varying(255) COLLATE pg_catalog."default",
    receptor character varying(255) COLLATE pg_catalog."default",
    fecha_inicio date,
    fecha_fin date,
    estado character varying(255) COLLATE pg_catalog."default",
    id_alta integer,
    id_baja integer,
    id_user integer,
    proceso_tratamiento_id integer,
    proveedor_id integer,
    legitimacion text COLLATE pg_catalog."default",
    observaciones character varying COLLATE pg_catalog."default",
    CONSTRAINT transferencia_internacionals_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.transferencia_internacionals
    OWNER to compaas_app;
-- Index: index_transferencia_internacionals_on_fichero_juridico_id

-- DROP INDEX IF EXISTS public.index_transferencia_internacionals_on_fichero_juridico_id;

CREATE INDEX IF NOT EXISTS index_transferencia_internacionals_on_fichero_juridico_id
    ON public.transferencia_internacionals USING btree
    (fichero_juridico_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_transferencia_internacionals_on_proceso_tratamiento_id

-- DROP INDEX IF EXISTS public.index_transferencia_internacionals_on_proceso_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_transferencia_internacionals_on_proceso_tratamiento_id
    ON public.transferencia_internacionals USING btree
    (proceso_tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_transferencia_internacionals_on_proveedor_id

-- DROP INDEX IF EXISTS public.index_transferencia_internacionals_on_proveedor_id;

CREATE INDEX IF NOT EXISTS index_transferencia_internacionals_on_proveedor_id
    ON public.transferencia_internacionals USING btree
    (proveedor_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.tratamiento_genericos

-- DROP TABLE IF EXISTS public.tratamiento_genericos;

CREATE TABLE IF NOT EXISTS public.tratamiento_genericos
(
    id integer NOT NULL DEFAULT nextval('tratamiento_genericos_id_seq'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    finalidad text COLLATE pg_catalog."default",
    forma_recogida text COLLATE pg_catalog."default",
    plazo_conservacion character varying(255) COLLATE pg_catalog."default",
    cesiones text COLLATE pg_catalog."default",
    tipo integer,
    tiempo_auditoria integer,
    departamento_id integer,
    sector_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT tratamiento_genericos_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tratamiento_genericos
    OWNER to compaas_app;
-- Index: index_tratamiento_genericos_on_creador_id

-- DROP INDEX IF EXISTS public.index_tratamiento_genericos_on_creador_id;

CREATE INDEX IF NOT EXISTS index_tratamiento_genericos_on_creador_id
    ON public.tratamiento_genericos USING btree
    (user_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_tratamiento_genericos_on_departamento_id

-- DROP INDEX IF EXISTS public.index_tratamiento_genericos_on_departamento_id;

CREATE INDEX IF NOT EXISTS index_tratamiento_genericos_on_departamento_id
    ON public.tratamiento_genericos USING btree
    (departamento_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_tratamiento_genericos_on_sector_id

-- DROP INDEX IF EXISTS public.index_tratamiento_genericos_on_sector_id;

CREATE INDEX IF NOT EXISTS index_tratamiento_genericos_on_sector_id
    ON public.tratamiento_genericos USING btree
    (sector_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    email character varying(255) COLLATE pg_catalog."default" NOT NULL DEFAULT ''::character varying,
    encrypted_password character varying(255) COLLATE pg_catalog."default" NOT NULL DEFAULT ''::character varying,
    reset_password_token character varying(255) COLLATE pg_catalog."default",
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer NOT NULL DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255) COLLATE pg_catalog."default",
    last_sign_in_ip character varying(255) COLLATE pg_catalog."default",
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255) COLLATE pg_catalog."default",
    foto_file_name character varying(255) COLLATE pg_catalog."default",
    foto_content_type character varying(255) COLLATE pg_catalog."default",
    foto_file_size integer,
    foto_updated_at timestamp without time zone,
    surname character varying(255) COLLATE pg_catalog."default",
    email_secundario character varying(255) COLLATE pg_catalog."default",
    telefono character varying(255) COLLATE pg_catalog."default",
    telefono_secundario character varying(255) COLLATE pg_catalog."default",
    fax character varying(255) COLLATE pg_catalog."default",
    fecha_designacion date,
    observaciones text COLLATE pg_catalog."default",
    pdf_designacion_file_name character varying(255) COLLATE pg_catalog."default",
    pdf_designacion_content_type character varying(255) COLLATE pg_catalog."default",
    pdf_designacion_file_size integer,
    pdf_designacion_updated_at timestamp without time zone,
    empresa_id integer,
    departamento character varying(255) COLLATE pg_catalog."default",
    nda_accepted_at timestamp without time zone,
    nda_accepted_ip character varying COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to compaas_app;
-- Index: index_users_on_email

-- DROP INDEX IF EXISTS public.index_users_on_email;

CREATE UNIQUE INDEX IF NOT EXISTS index_users_on_email
    ON public.users USING btree
    (email COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_users_on_reset_password_token

-- DROP INDEX IF EXISTS public.index_users_on_reset_password_token;

CREATE UNIQUE INDEX IF NOT EXISTS index_users_on_reset_password_token
    ON public.users USING btree
    (reset_password_token COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: public.users_roles

-- DROP TABLE IF EXISTS public.users_roles;

CREATE TABLE IF NOT EXISTS public.users_roles
(
    user_id integer,
    role_id integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users_roles
    OWNER to compaas_app;
-- Index: index_users_roles_on_user_id_and_role_id

-- DROP INDEX IF EXISTS public.index_users_roles_on_user_id_and_role_id;

CREATE INDEX IF NOT EXISTS index_users_roles_on_user_id_and_role_id
    ON public.users_roles USING btree
    (user_id ASC NULLS LAST, role_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.valoracion_activo_riesgos

-- DROP TABLE IF EXISTS public.valoracion_activo_riesgos;

CREATE TABLE IF NOT EXISTS public.valoracion_activo_riesgos
(
    id integer NOT NULL DEFAULT nextval('valoracion_activo_riesgos_id_seq'::regclass),
    empresa_id integer,
    activo_id integer,
    activo_type character varying COLLATE pg_catalog."default",
    riesgo_id integer,
    probabilidad integer,
    impacto integer,
    nivel_riesgo_teorico numeric(8,5),
    nivel_riesgo_actual numeric(8,5),
    probabilidad_actual_value numeric(8,5),
    impacto_actual_value numeric(8,5),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT valoracion_activo_riesgos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_93ac739e44 FOREIGN KEY (empresa_id)
        REFERENCES public.empresas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_dc1073bd4f FOREIGN KEY (riesgo_id)
        REFERENCES public.riesgos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.valoracion_activo_riesgos
    OWNER to compaas_app;
-- Index: index_valoracion_activo_riesgos_on_activo_type_and_activo_id

-- DROP INDEX IF EXISTS public.index_valoracion_activo_riesgos_on_activo_type_and_activo_id;

CREATE INDEX IF NOT EXISTS index_valoracion_activo_riesgos_on_activo_type_and_activo_id
    ON public.valoracion_activo_riesgos USING btree
    (activo_type COLLATE pg_catalog."default" ASC NULLS LAST, activo_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_valoracion_activo_riesgos_on_empresa_id

-- DROP INDEX IF EXISTS public.index_valoracion_activo_riesgos_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_valoracion_activo_riesgos_on_empresa_id
    ON public.valoracion_activo_riesgos USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_valoracion_activo_riesgos_on_riesgo_id

-- DROP INDEX IF EXISTS public.index_valoracion_activo_riesgos_on_riesgo_id;

CREATE INDEX IF NOT EXISTS index_valoracion_activo_riesgos_on_riesgo_id
    ON public.valoracion_activo_riesgos USING btree
    (riesgo_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.valoracion_tratamientos

-- DROP TABLE IF EXISTS public.valoracion_tratamientos;

CREATE TABLE IF NOT EXISTS public.valoracion_tratamientos
(
    id integer NOT NULL DEFAULT nextval('valoracion_tratamientos_id_seq'::regclass),
    empresa_id integer,
    tratamiento_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    nivel_riesgo_teorico numeric(5,2) DEFAULT 0,
    nivel_riesgo_actual numeric(5,2) DEFAULT 0,
    CONSTRAINT valoracion_tratamientos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_rails_cab398d6fc FOREIGN KEY (tratamiento_id)
        REFERENCES public.proceso_tratamientos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_rails_d289eade07 FOREIGN KEY (empresa_id)
        REFERENCES public.empresas (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.valoracion_tratamientos
    OWNER to compaas_app;
-- Index: index_valoracion_tratamientos_on_empresa_id

-- DROP INDEX IF EXISTS public.index_valoracion_tratamientos_on_empresa_id;

CREATE INDEX IF NOT EXISTS index_valoracion_tratamientos_on_empresa_id
    ON public.valoracion_tratamientos USING btree
    (empresa_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: index_valoracion_tratamientos_on_tratamiento_id

-- DROP INDEX IF EXISTS public.index_valoracion_tratamientos_on_tratamiento_id;

CREATE INDEX IF NOT EXISTS index_valoracion_tratamientos_on_tratamiento_id
    ON public.valoracion_tratamientos USING btree
    (tratamiento_id ASC NULLS LAST)
    TABLESPACE pg_default;