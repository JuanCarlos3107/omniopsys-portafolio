
# OmniOpsys — Sistema Modular Multiempresa
## Documentación BLOQUE 1: Arquitectura Global
**Autor:** Juan Carlos
**Fecha:** 2026-09-21
**Base de datos:** Oracle 21c
**Esquema:** OMNIOPS
**Plataforma:** Oracle APEX
---
## 1. Visión general
OmniOpsys es un sistema modular multiempresa diseñado para alojar distintos
módulos de negocio (Finanzas, RRHH, Ventas, Stock, Compras...) sobre una
arquitectura global común de empresas, usuarios, roles y programas.

El primer módulo a implementar es **Finanzas** (sistema cuotero), que se
desarrollará en el BLOQUE 2.
---
## 2. Estándares definidos
### 2.1 Nomenclatura de tablas
- Tablas globales: `OMNI_<ENTIDAD>` (ej: `OMNI_EMPRESAS`)
- Tablas de módulo: `OMNI_<PREFIJO>_<ENTIDAD>` (ej: `OMNI_F_CLIENTES` para Finanzas)
- Entidades en **plural** y **mayúsculas**

### 2.2 Prefijos de módulo

| Módulo      | Prefijo |
|-----------  |---------|
| Finanzas    | F       |
| RRHH        | R       |
| Ventas      | V       |
| Stock       | S       |
| Compras     | C       |
| Facturacion | FAC     | 

### 2.3 Columnas

- PK: `ID_<ENTIDAD>` (NUMBER, IDENTITY)
- FK: `ID_<ENTIDAD_REFERENCIADA>`
- Código numérico de lógica: `CODIGO_<ENTIDAD>` (NUMBER)
- Auditoría corta:
  - `FECHA_ALTA_<ENTIDAD>` (DATE)
  - `USR_CREA_<ENTIDAD>` (VARCHAR2 50)
  - `FECHA_MOD_<ENTIDAD>` (DATE)
  - `USR_MOD_<ENTIDAD>` (VARCHAR2 50)

### 2.4 Tipos de datos estandarizados

| Uso                          | Tipo           |
|------------------------------|----------------|
| Montos generales             | NUMBER(14,2)   |
| Montos acumulados / totales  | NUMBER(16,2)   |
| Tasas de interés / mora      | NUMBER(8,4)    |
| Cantidades / contadores      | NUMBER(10)     |
| Textos cortos                | VARCHAR2(50)   |
| Nombres / razones sociales   | VARCHAR2(150)  |
| Descripciones / observaciones| VARCHAR2(300)  |
| Textos largos                | CLOB           |
| Fechas                       | DATE           |
| Flags S/N                    | VARCHAR2(1) CHECK IN ('S','N') |
| Estados                      | VARCHAR2(10-15) CHECK |

### 2.5 Reglas de negocio para datos

- Códigos usados en lógica o integridad → **NUMBER**
- Identificadores externos alfabéticos (username, email, RUC) → VARCHAR2
- Montos: siempre `NUMBER(x,2)` con redondeo `ROUND(...,2)`
- Tasas: siempre `NUMBER(x,4)`
- Nunca usar FLOAT ni BINARY_DOUBLE para dinero

---

## 3. Tablas globales creadas (BLOQUE 1)

### 3.1 OMNI_EMPRESAS

Tabla maestra global. Todas las tablas de negocio referencian mediante ID_EMPRESA.

Campos principales:
- ID_EMPRESA (PK)
- CODIGO_EMPRESA (UNIQUE)
- NOMBRE_EMPRESA, NOMBRE_COMERCIAL_EMPRESA
- RUC_EMPRESA (UNIQUE)
- DIRECCION, TELEFONO, EMAIL, LOGO_URL
- ESTADO_EMPRESA (ACTIVA/INACTIVA)
- Auditoría

### 3.2 OMNI_PROGRAMAS

Catálogo de módulos del sistema.

Campos principales:
- ID_PROGRAMA (PK)
- CODIGO_PROGRAMA (NUMBER, UNIQUE)
- NOMBRE_PROGRAMA, DESCRIPCION_PROGRAMA
- PREFIJO_PROGRAMA (UNIQUE) — ej: F, R, V
- ICONO_PROGRAMA, ORDEN_MENU_PROGRAMA
- ESTADO_PROGRAMA (ACTIVO/INACTIVO)
- Auditoría

### 3.3 OMNI_ROLES

Catálogo de roles globales y por programa.

Campos principales:
- ID_ROL (PK)
- ID_PROGRAMA (FK, NULL si es global)
- CODIGO_ROL (NUMBER)
- NOMBRE_ROL, DESCRIPCION_ROL
- ES_ROL_GLOBAL (S/N)
- ESTADO_ROL (ACTIVO/INACTIVO)
- Auditoría

Restricciones:
- UNIQUE (CODIGO_ROL, ID_PROGRAMA)
- FK a OMNI_PROGRAMAS

### 3.4 OMNI_USUARIOS

Usuarios globales del sistema.

Campos principales:
- ID_USUARIO (PK)
- CODIGO_USUARIO (NUMBER, UNIQUE)
- USERNAME_USUARIO (UNIQUE)
- EMAIL_USUARIO (UNIQUE)
- NOMBRE_USUARIO
- PASSWORD_HASH_USUARIO
- TELEFONO_USUARIO
- ES_SUPER_ADMIN_USUARIO (S/N)
- ESTADO_USUARIO (ACTIVO/INACTIVO/BLOQUEADO)
- ULTIMO_ACCESO_USUARIO
- Auditoría

### 3.5 OMNI_EMPRESA_PROGRAMA

Habilitación/licenciamiento de programas por empresa. Capa de seguridad
que impide que una empresa acceda a un módulo no habilitado.

Campos principales:
- ID_EMPRESA_PROGRAMA (PK)
- CODIGO_EMPRESA_PROGRAMA (NUMBER, UNIQUE)
- ID_EMPRESA (FK)
- ID_PROGRAMA (FK)
- ESTADO_EMPRESA_PROGRAMA (ACTIVO/SUSPENDIDO/INACTIVO)
- FECHA_ACTIVACION, FECHA_VENCIMIENTO
- OBSERVACION_EMPRESA_PROG
- Auditoría

Restricciones:
- UNIQUE (ID_EMPRESA, ID_PROGRAMA)

### 3.6 OMNI_USUARIO_EMPRESA

Relación N:M entre usuarios y empresas.

Campos principales:
- ID_USUARIO_EMPRESA (PK)
- CODIGO_USUARIO_EMPRESA (NUMBER, UNIQUE)
- ID_USUARIO (FK)
- ID_EMPRESA (FK)
- ES_EMPRESA_PRINCIPAL (S/N)
- ESTADO_USUARIO_EMPRESA (ACTIVO/SUSPENDIDO/INACTIVO)
- FECHA_ASIGNACION
- OBSERVACION_USUARIO_EMP
- Auditoría

Restricciones:
- UNIQUE (ID_USUARIO, ID_EMPRESA)

### 3.7 OMNI_USUARIO_ROL

Asignación de roles a usuarios en contexto de empresa.
Un usuario puede tener distintos roles en distintas empresas.

Campos principales:
- ID_USUARIO_ROL (PK)
- CODIGO_USUARIO_ROL (NUMBER, UNIQUE)
- ID_USUARIO (FK)
- ID_ROL (FK)
- ID_EMPRESA (FK)
- ESTADO_USUARIO_ROL (ACTIVO/SUSPENDIDO/INACTIVO)
- FECHA_ASIGNACION
- OBSERVACION_USUARIO_ROL
- Auditoría

Restricciones:
- UNIQUE (ID_USUARIO, ID_ROL, ID_EMPRESA)

---

## 4. Diagrama de relaciones globales

```
OMNI_EMPRESAS ──1:N── OMNI_EMPRESA_PROGRAMA ──N:1── OMNI_PROGRAMAS
OMNI_EMPRESAS ──1:N── OMNI_USUARIO_EMPRESA ──N:1── OMNI_USUARIOS
OMNI_EMPRESAS ──1:N── OMNI_USUARIO_ROL ──N:1── OMNI_ROLES
OMNI_PROGRAMAS ──1:N── OMNI_ROLES
OMNI_USUARIOS ──1:N── OMNI_USUARIO_ROL ──N:1── OMNI_ROLES
```

---

## 5. Modelo de seguridad (cascada de validación)

Al loguearse un usuario y seleccionar empresa, el sistema valida:

1. ¿El usuario está ACTIVO?                  → OMNI_USUARIOS
2. ¿El usuario pertenece a esa empresa?      → OMNI_USUARIO_EMPRESA
3. ¿La empresa tiene el programa habilitado? → OMNI_EMPRESA_PROGRAMA
4. ¿El usuario tiene un rol en ese programa? → OMNI_USUARIO_ROL + OMNI_ROLES
5.  Acceso concedido

---

## 6. Estado del proyecto

| Bloque | Descripción                     | Estado        |
|--------|---------------------------------|---------------|
| 1      | Arquitectura global (7 tablas)  | ✅ COMPLETADO |
| 2      | Módulo Finanzas (tablas)        | ⏳ Pendiente  |
| 3      | Workspace APEX + seguridad      | ⏳ Pendiente  |
| 4      | Páginas APEX                    | ⏳ Pendiente  |
| 5      | Documentación final             | ⏳ Pendiente  |

---

## 7. Próximos pasos

- BLOQUE 2: Diseñar y crear las tablas del módulo Finanzas
  (OMNI_F_CLIENTES, OMNI_F_PLANES, OMNI_F_PROFORMAS, OMNI_F_CUOTAS, etc.)
- Cada tabla del módulo llevará ID_EMPRESA como FK a OMNI_EMPRESAS.