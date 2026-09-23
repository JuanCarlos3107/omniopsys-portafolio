-- ============================================================
-- Tabla   : OMNI_ROLES
-- Módulo  : GLOBAL (catálogo de roles del sistema)
-- Autor   : [JCFB]
-- Fecha   : 2026-09-19
-- Desc    : Roles globales y por programa del sistema OmniOpsys
-- ============================================================

CREATE TABLE OMNIOPS.OMNI_ROLES (
    ID_ROL              NUMBER(5)       GENERATED ALWAYS AS IDENTITY,
    ID_PROGRAMA         NUMBER(8),
    CODIGO_ROL          NUMBER(5)       NOT NULL,
    NOMBRE_ROL          VARCHAR2(50)    NOT NULL,
    DESCRIPCION_ROL     VARCHAR2(200),
    ES_ROL_GLOBAL       VARCHAR2(1)     DEFAULT 'N' NOT NULL,
    ESTADO_ROL          VARCHAR2(10)    DEFAULT 'ACTIVO' NOT NULL,
    FECHA_ALTA_ROL      DATE            DEFAULT SYSDATE NOT NULL,
    USR_CREA_ROL        VARCHAR2(50),
    FECHA_MOD_ROL       DATE,
    USR_MOD_ROL         VARCHAR2(50),
    --
    CONSTRAINT PK_OMNI_ROLES
        PRIMARY KEY (ID_ROL),
    CONSTRAINT FK_OMNI_ROLES_PROGRAMA
        FOREIGN KEY (ID_PROGRAMA) REFERENCES OMNIOPS.OMNI_PROGRAMAS (ID_PROGRAMA),
    CONSTRAINT UQ_OMNI_ROLES_CODIGO_PROG
        UNIQUE (CODIGO_ROL, ID_PROGRAMA),
    CONSTRAINT CK_OMNI_ROLES_GLOBAL
        CHECK (ES_ROL_GLOBAL IN ('S','N')),
    CONSTRAINT CK_OMNI_ROLES_ESTADO
        CHECK (ESTADO_ROL IN ('ACTIVO','INACTIVO'))
);

COMMENT ON TABLE OMNIOPS.OMNI_ROLES IS
    'Catálogo de roles del sistema. Los roles globales tienen ID_PROGRAMA NULL y ES_ROL_GLOBAL = S. Los roles por programa referencian OMNI_PROGRAMAS.';

COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.ID_ROL          IS 'Identificador único del rol (PK)';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.ID_PROGRAMA     IS 'Programa al que pertenece el rol (NULL si es global)';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.CODIGO_ROL      IS 'Código numérico del rol (usado en lógica del sistema)';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.NOMBRE_ROL      IS 'Nombre legible del rol';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.DESCRIPCION_ROL IS 'Descripción del rol y sus permisos';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.ES_ROL_GLOBAL   IS 'Indica si el rol es global (S) o específico de un programa (N)';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.ESTADO_ROL      IS 'Estado del rol: ACTIVO / INACTIVO';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.FECHA_ALTA_ROL  IS 'Fecha en que se dio de alta el rol';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.USR_CREA_ROL    IS 'Usuario que creó el registro (auditoría)';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.FECHA_MOD_ROL   IS 'Fecha de última modificación (auditoría)';
COMMENT ON COLUMN OMNIOPS.OMNI_ROLES.USR_MOD_ROL     IS 'Usuario que modificó el registro (auditoría)';