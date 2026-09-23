# OmniOpsys — Sistema Modular Multiempresa (Cuotero)

Sistema modular de gestión empresarial construido sobre **Oracle APEX 21c**, con arquitectura multiempresa y multi-módulo. El primer módulo implementado es **Finanzas**, que incluye un sistema completo de cuotero (proformas, aprobaciones, cobros, mora y cierre de plan).

---

## Objetivo del proyecto

Demostrar habilidades en:

- Diseño de base de datos relacional en Oracle 21c
- Arquitectura modular multiempresa
- Desarrollo de aplicaciones con Oracle APEX
- Modelado de procesos de negocio (BPMN)
- Control de acceso basado en roles (RBAC)

---

## Arquitectura

## Módulos planificados

| Módulo     | Prefijo | Estado |
|------------|---------|--------|
| Finanzas   | 'F'     | 🔄 En desarrollo |
| RRHH       | 'R'     | ⏳ Pendiente |
| Ventas     | 'V'     | ⏳ Pendiente |
| Stock      | 'S'     | ⏳ Pendiente |
| Compras    | 'C'     | ⏳ Pendiente |
| Facturacion| 'FAC'   | ⏳ Pendiente |

## Estructura de la base de datos

- **Tablas globales:** `OMNI_<ENTIDAD>` (ej: `OMNI_EMPRESAS`)
- **Tablas por módulo:** `OMNI_<PREFIJO>_<ENTIDAD>` (ej: `OMNI_F_CLIENTES`)
- Todas las tablas de negocio llevan `ID_EMPRESA` como FK

### Modelo de seguridad

El sistema valida en cascada al loguearse:

1. El usuario está activo ¿? → 'OMNI_USUARIOS'
2. Pertenece a la empresa ¿? → 'OMNI_USUARIO_EMPRESA'
3. La empresa tiene el programa habilitado ¿? → 'OMNI_EMPRESA_PROGRAMA'
4. Tiene rol en ese programa ¿? → 'OMNI_USUARIO_ROL' + 'OMNI_ROLES'
5.  Acceso concedido

---

## Estructura del repositorio

```
omniopsys-portafolio/
├── docs/               Documentación técnica
│   ├── 01-arquitectura-global.md
│   └── imagenes/
│       └── diagrama-bpmn.png
├── database/           Scripts SQL organizados por bloque
│   └── 01-global/
├── apex/               Exportaciones de la aplicación APEX
├── screenshots/        Capturas para portafolio
├── CHANGELOG.md
├── README.md
└── LICENSE
```

---

## Estado del proyecto

| Bloque | Descripción                     | Estado        |
|--------|---------------------------------|---------------|
| 1      | Arquitectura global (7 tablas)  | ✅ Completado |
| 2      | Módulo Finanzas (13 tablas)     | 🔄 En curso   |
| 3      | Workspace APEX + seguridad      | ⏳ Pendiente  |
| 4      | Páginas APEX                    | ⏳ Pendiente  |
| 5      | Documentación final             | ⏳ Pendiente  |

---

## Tecnologías

- **Oracle Database 21c**
- **Oracle APEX**
- **Oracle REST Data Services (ORDS)**
- **SQL / PL/SQL**
- **Git / GitHub**

---

## Documentación

- [Arquitectura Global (BLOQUE 1)](docs/01-arquitectura-global.md)
- [Diagrama BPMN del proceso](docs/imagenes/diagrama_bpmn.png)
- [Changelog](CHANGELOG.md)

---

## Autor

**Juan Carlos Fernández Bobadilla**
- GitHub: [@JuanCarlos3107](https://github.com/JuanCarlos3107)

---

## Licencia

Este proyecto está bajo la Licencia MIT. Ver [LICENSE](LICENSE) para más detalles.
