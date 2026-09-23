# Changelog

Todos los cambios notables de este proyecto se documentan en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es/1.0.0/)
y este proyecto sigue [Versionado Semántico](https://semver.org/lang/es/).

---

## [0.1.0] - 2026-09-21

### Agregado

- Arquitectura global multiempresa (BLOQUE 1)
  - 7 tablas globales creadas en el esquema `OMNIOPS`:
    - `OMNI_EMPRESAS` — empresas del sistema
    - `OMNI_PROGRAMAS` — catálogo de módulos
    - `OMNI_ROLES` — roles globales y por programa
    - `OMNI_USUARIOS` — usuarios globales
    - `OMNI_EMPRESA_PROGRAMA` — habilitación de módulos por empresa
    - `OMNI_USUARIO_EMPRESA` — relación N:M usuario↔empresa
    - `OMNI_USUARIO_ROL` — asignación de roles con contexto de empresa
- Documentación de arquitectura global (`docs/01-arquitectura-global.md`)
- Diagrama BPMN del proceso (`docs/imagenes/diagrama-bpmn.png`)
- Scripts SQL organizados en `database/01-global/`
- Estándares del proyecto:
  - Nomenclatura `OMNI_<Módulo>_<Entidad>`
  - Códigos numéricos para lógica
  - Auditoría corta ('USR_CREA_X', 'FECHA_MOD_X', 'USR_MOD_X')
  - Tipos de datos estandarizados para montos y tasas

  ## [0.2.0] - 2026-09-23

### Agregado

- **Módulo Finanzas (BLOQUE 2)** — Sistema Cuotero
  - 16 tablas creadas:
    - Globales: `OMNI_PERSONAS`, `OMNI_ARCHIVOS`
    - Finanzas: `OMNI_F_CLIENTES`, `OMNI_F_PLANES`, `OMNI_F_PROFORMAS`,
      `OMNI_F_EVALUACIONES`, `OMNI_F_HIST_APROBACIONES`,
      `OMNI_F_TERMINOS_ACEPTADOS`, `OMNI_F_ENTIDADES_PAGO`,
      `OMNI_F_CUENTAS_BANCARIAS`, `OMNI_F_TARJETAS_CLIENTE`,
      `OMNI_F_CUOTAS`, `OMNI_F_PAGOS`, `OMNI_F_INTENTOS_DEBITO`,
      `OMNI_F_MORAS`, `OMNI_F_NOTIFICACIONES`, `OMNI_F_CIERRES_PLAN`
- Indicadores de rol en `OMNI_PERSONAS` (`ES_CLIENTE_PERSONA`, `ES_USUARIO_PERSONA`)
- Documentación del modelo de datos Finanzas (`docs/03-modelo-datos-finanzas.md`)
- Diagrama BPMN del proceso

## Notas

- Este es el primer bloque del proyecto. El siguiente es el * BLOQUE 2: Módulo Finanzas *,
  que incluirá las 14 tablas del sistema cuotero.

---

## [Unreleased]

## Por venir

- BLOQUE 2: Módulo Finanzas (14 tablas)
- BLOQUE 3: Workspace APEX + seguridad
- BLOQUE 4: Páginas APEX
- BLOQUE 5: Documentación final