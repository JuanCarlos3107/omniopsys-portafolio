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

## Notas

- Este es el primer bloque del proyecto. El siguiente es el * BLOQUE 2: Módulo Finanzas *,
  que incluirá las 13 tablas del sistema cuotero.

---

## [Unreleased]

## Por venir

- BLOQUE 2: Módulo Finanzas (13 tablas)
- BLOQUE 3: Workspace APEX + seguridad
- BLOQUE 4: Páginas APEX
- BLOQUE 5: Documentación final