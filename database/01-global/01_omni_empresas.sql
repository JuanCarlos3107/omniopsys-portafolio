-- ============================================================
-- Tabla   : OMNI_EMPRESAS
-- Módulo  : GLOBAL (transversal a todos los módulos)
-- Autor   : [JCFB]
-- Fecha   : 2026-09-19
-- Desc    : Tabla maestra de empresas del sistema OmniOpsys
-- ============================================================

CREATE TABLE OMNIOPS.OMNI_EMPRESAS (
    ID_EMPRESA                    NUMBER(10)      GENERATED ALWAYS AS IDENTITY,
    CODIGO_EMPRESA                VARCHAR2(10)    NOT NULL,
    NOMBRE_EMPRESA                VARCHAR2(150)   NOT NULL,
    NOMBRE_COMERCIAL_EMPRESA      VARCHAR2(150),
    RUC_EMPRESA                   VARCHAR2(20),
    DIRECCION_EMPRESA             VARCHAR2(200),
    TELEFONO_EMPRESA              VARCHAR2(30),
    EMAIL_EMPRESA                 VARCHAR2(100),
    LOGO_URL_EMPRESA              VARCHAR2(300),
    ESTADO_EMPRESA                VARCHAR2(10)    DEFAULT 'ACTIVA' NOT NULL,
    FECHA_ALTA_EMPRESA            DATE            DEFAULT SYSDATE NOT NULL,
    USUARIO_CREACION_EMPRESA      VARCHAR2(50),
    FECHA_MODIFICACION_EMPRESA    DATE,
    USUARIO_MODIFICACION_EMPRESA  VARCHAR2(50),
    --
    CONSTRAINT PK_OMNI_EMPRESAS
        PRIMARY KEY (ID_EMPRESA),
    CONSTRAINT UQ_OMNI_EMPRESAS_CODIGO
        UNIQUE (CODIGO_EMPRESA),
    CONSTRAINT UQ_OMNI_EMPRESAS_RUC
        UNIQUE (RUC_EMPRESA),
    CONSTRAINT CK_OMNI_EMPRESAS_ESTADO
        CHECK (ESTADO_EMPRESA IN ('ACTIVA','INACTIVA'))
);

COMMENT ON TABLE OMNIOPS.OMNI_EMPRESAS IS
    'Tabla maestra global de empresas del sistema OmniOpsys. Todas las tablas de negocio referencian a esta mediante ID_EMPRESA.';

COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.ID_EMPRESA                   IS 'Identificador único de la empresa (PK)';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.CODIGO_EMPRESA               IS 'Código corto de la empresa (ej: OMNI01, SUC01)';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.NOMBRE_EMPRESA               IS 'Razón social de la empresa';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.NOMBRE_COMERCIAL_EMPRESA     IS 'Nombre de fantasía o comercial';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.RUC_EMPRESA                  IS 'Identificación fiscal (RUC) de la empresa';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.DIRECCION_EMPRESA            IS 'Dirección legal o comercial';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.TELEFONO_EMPRESA             IS 'Teléfono principal de contacto';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.EMAIL_EMPRESA                IS 'Email principal de contacto';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.LOGO_URL_EMPRESA             IS 'URL del logo para usar en reportes y pantallas';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.ESTADO_EMPRESA               IS 'Estado de la empresa: ACTIVA / INACTIVA';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.FECHA_ALTA_EMPRESA           IS 'Fecha en que se dio de alta la empresa';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.USUARIO_CREACION_EMPRESA     IS 'Usuario que creó el registro (auditoría)';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.FECHA_MODIFICACION_EMPRESA   IS 'Fecha de última modificación (auditoría)';
COMMENT ON COLUMN OMNIOPS.OMNI_EMPRESAS.USUARIO_MODIFICACION_EMPRESA IS 'Usuario que modificó el registro (auditoría)';