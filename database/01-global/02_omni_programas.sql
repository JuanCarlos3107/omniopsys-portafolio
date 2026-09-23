-- ============================================================
-- Tabla   : OMNI_PROGRAMAS
-- Módulo  : GLOBAL (catálogo de módulos del sistema)
-- Autor   : [tu nombre]
-- Fecha   : 2026-09-19
-- Desc    : Catálogo de programas/módulos del sistema OmniOpsys
-- ============================================================

CREATE TABLE OMNIOPS.OMNI_PROGRAMAS (
    ID_PROGRAMA                   NUMBER(5)       GENERATED ALWAYS AS IDENTITY,
    CODIGO_PROGRAMA               NUMBER(20)    NOT NULL,
    NOMBRE_PROGRAMA               VARCHAR2(100)   NOT NULL,
    DESCRIPCION_PROGRAMA          VARCHAR2(300),
    PREFIJO_PROGRAMA              VARCHAR2(10)    NOT NULL,
    ICONO_PROGRAMA                VARCHAR2(100),
    ORDEN_MENU_PROGRAMA           NUMBER(3)       DEFAULT 1 NOT NULL,
    ESTADO_PROGRAMA               VARCHAR2(10)    DEFAULT 'ACTIVO' NOT NULL,
    FECHA_ALTA_PROGRAMA           DATE            DEFAULT SYSDATE NOT NULL,
    USUARIO_CREACION_PROGRAMA     VARCHAR2(50),
    FECHA_MOD_PROGRAMA   DATE,
    USUARIO_MOD_PROGRAMA VARCHAR2(50),
    --
    CONSTRAINT PK_OMNI_PROGRAMAS
        PRIMARY KEY (ID_PROGRAMA),
    CONSTRAINT UQ_OMNI_PROGRAMAS_CODIGO
        UNIQUE (CODIGO_PROGRAMA),
    CONSTRAINT UQ_OMNI_PROGRAMAS_PREFIJO
        UNIQUE (PREFIJO_PROGRAMA),
    CONSTRAINT CK_OMNI_PROGRAMAS_ESTADO
        CHECK (ESTADO_PROGRAMA IN ('ACTIVO','INACTIVO'))
);

COMMENT ON TABLE OMNIOPS.OMNI_PROGRAMAS IS
    'Catálogo global de programas/módulos del sistema OmniOpsys. Cada programa define un prefijo que usan sus tablas.';

COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.ID_PROGRAMA                   IS 'Identificador único del programa (PK)';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.CODIGO_PROGRAMA               IS 'Código corto del programa (ej: FINANZAS, RRHH)';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.NOMBRE_PROGRAMA               IS 'Nombre legible del programa';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.DESCRIPCION_PROGRAMA          IS 'Descripción del alcance del programa';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.PREFIJO_PROGRAMA              IS 'Prefijo que usan las tablas del módulo (ej: F, R, V)';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.ICONO_PROGRAMA                IS 'Ícono representativo para el menú de la aplicación';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.ORDEN_MENU_PROGRAMA           IS 'Orden de aparición en el menú principal';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.ESTADO_PROGRAMA               IS 'Estado del programa: ACTIVO / INACTIVO';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.FECHA_ALTA_PROGRAMA           IS 'Fecha en que se dio de alta el programa';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.USUARIO_CREACION_PROGRAMA     IS 'Usuario que creó el registro (auditoría)';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.FECHA_MOD_PROGRAMA   IS 'Fecha de última modificación (auditoría)';
COMMENT ON COLUMN OMNIOPS.OMNI_PROGRAMAS.USUARIO_MOD_PROGRAMA IS 'Usuario que modificó el registro (auditoría)';