-- ============================================================
-- Tabla   : OMNI_ARCHIVOS
-- Módulo  : GLOBAL (transversal a todos los módulos)
-- Autor   : Juan Carlos
-- Fecha   : 2026-09-23
-- Desc    : Metadatos de archivos almacenados externamente
--           (logos, documentos, comprobantes, etc.)
-- ============================================================

CREATE TABLE OMNIOPS.OMNI_ARCHIVOS (
    ID_ARCHIVO              NUMBER(10)      GENERATED ALWAYS AS IDENTITY,
    CODIGO_ARCHIVO          NUMBER(10)      NOT NULL,
    ID_EMPRESA              NUMBER(10)      NOT NULL,
    TABLA_REFERENCIA        VARCHAR2(50)    NOT NULL,
    ID_REFERENCIA           NUMBER(10)      NOT NULL,
    TIPO_ARCHIVO            VARCHAR2(30)    NOT NULL,
    NOMBRE_ARCHIVO          VARCHAR2(200)   NOT NULL,
    RUTA_URL_ARCHIVO        VARCHAR2(500)   NOT NULL,
    MIME_TYPE_ARCHIVO       VARCHAR2(100),
    PESO_ARCHIVO_KB         NUMBER(10),
    DESCRIPCION_ARCHIVO     VARCHAR2(300),
    ESTADO_ARCHIVO          VARCHAR2(10)    DEFAULT 'ACTIVO' NOT NULL,
    FECHA_ALTA_ARCHIVO      DATE            DEFAULT SYSDATE NOT NULL,
    USR_CREA_ARCHIVO        VARCHAR2(50),
    FECHA_MOD_ARCHIVO       DATE,
    USR_MOD_ARCHIVO         VARCHAR2(50),
    --
    CONSTRAINT PK_OMNI_ARCHIVOS
        PRIMARY KEY (ID_ARCHIVO),
    CONSTRAINT UQ_OMNI_ARCHIVOS_CODIGO
        UNIQUE (CODIGO_ARCHIVO),
    CONSTRAINT FK_OMNI_ARCHIVOS_EMPRESA
        FOREIGN KEY (ID_EMPRESA) REFERENCES OMNIOPS.OMNI_EMPRESAS (ID_EMPRESA),
    CONSTRAINT CK_OMNI_ARCHIVOS_ESTADO
        CHECK (ESTADO_ARCHIVO IN ('ACTIVO','ELIMINADO'))
);

COMMENT ON TABLE OMNIOPS.OMNI_ARCHIVOS IS
    'Metadatos de archivos (logos, documentos, comprobantes) almacenados en carpeta externa. No guarda el archivo en sí, solo su ubicación y datos descriptivos.';

COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.ID_ARCHIVO          IS 'Identificador único del archivo (PK)';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.CODIGO_ARCHIVO      IS 'Código numérico del archivo (usado en lógica)';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.ID_EMPRESA          IS 'Empresa propietaria del archivo (FK)';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.TABLA_REFERENCIA    IS 'Nombre de la tabla a la que pertenece el archivo (ej: OMNI_F_CLIENTES)';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.ID_REFERENCIA       IS 'ID del registro específico al que se asocia el archivo';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.TIPO_ARCHIVO        IS 'Tipo funcional del archivo (LOGO, DNI, CONTRATO, COMPROBANTE, etc.)';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.NOMBRE_ARCHIVO      IS 'Nombre original del archivo';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.RUTA_URL_ARCHIVO    IS 'Ruta o URL donde está almacenado el archivo';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.MIME_TYPE_ARCHIVO   IS 'Tipo MIME del archivo (image/png, application/pdf, etc.)';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.PESO_ARCHIVO_KB     IS 'Peso del archivo en KB';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.DESCRIPCION_ARCHIVO IS 'Descripción o comentario sobre el archivo';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.ESTADO_ARCHIVO      IS 'Estado del archivo: ACTIVO / ELIMINADO';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.FECHA_ALTA_ARCHIVO  IS 'Fecha de alta del registro (auditoría)';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.USR_CREA_ARCHIVO    IS 'Usuario que creó el registro (auditoría)';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.FECHA_MOD_ARCHIVO   IS 'Fecha de última modificación (auditoría)';
COMMENT ON COLUMN OMNIOPS.OMNI_ARCHIVOS.USR_MOD_ARCHIVO     IS 'Usuario que modificó el registro (auditoría)';