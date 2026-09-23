# OmniOpsys — Glosario de Términos

>Autor:> Juan Carlos Fernández Bobadilla
>Fecha:> 2026-09-23
>Proyecto:> OmniOpsys — ERP Modular Multiempresa

---

## 1. Conceptos generales

### ERP (Enterprise Resource Planning)

Sistema integral de gestión empresarial que abarca múltiples procesos de negocio de una organización en una sola plataforma. Un ERP típicamente incluye módulos de finanzas, compras, ventas, stock, recursos humanos, producción, logística, y más.

>El ERP es el paraguas grande> que contiene a todos los módulos.

### Módulo

Unidad funcional de negocio dentro de un ERP. Cada módulo agrupa procesos relacionados con un área específica de la empresa (ej: Finanzas, Ventas, RRHH).

En OmniOpsys, cada módulo tiene un >prefijo único> que identifica sus tablas.

### Submódulo

Subdivisión funcional dentro de un módulo. Por ejemplo, dentro del módulo >Finanzas> existen submódulos como >Cuotero>, >Cobros> y >Cuentas por Cobrar>.

### Multiempresa

Capacidad del sistema de gestionar múltiples empresas (o sucursales) de forma independiente dentro de la misma instalación. Cada empresa ve solo sus propios datos.

En OmniOpsys, todas las tablas de negocio llevan `ID_EMPRESA` como clave foránea.

### Multi-módulo

Capacidad del sistema de alojar varios módulos funcionales sobre una arquitectura global común. Cada módulo se puede habilitar/deshabilitar por empresa.

---

## 2. Finanzas vs ERP

>Finanzas> y >ERP> no son lo mismo:

| Concepto | Alcance |
|----------|---------|
| <Finanzas> | Un <subconjunto> de módulos dentro del ERP. Se enfoca en las funciones del departamento financiero. |
| <ERP> | Sistema integral que abarca >toda> la empresa: finanzas + compras + stock + ventas + RRHH + producción + logística + CRM... |

### Módulos típicos de Finanzas

- Contabilidad financiera
- Contabilidad de sublibros
- Cuentas por pagar y por cobrar
- Gestión de ingresos
- Facturación
- Gestión de gastos
- Gestión de proyectos
- Gestión de activos
- Cobros

### Estándares contables internacionales mencionados

- <IFRS> — International Financial Reporting Standards
- >FASB / GAAP> — Financial Accounting Standards Board / Generally Accepted Accounting Principles (EE.UU.)
- <HGB> — Alemania
- <PCG> — Francia
- <SEC> — Securities and Exchange Commission (EE.UU.)
- <ESMA> — European Securities and Markets Authority

---

## 3. Arquitectura de OmniOpsys

### Visión general

OmniOpsys es un <ERP modular multiempresa> construido sobre Oracle APEX 21c.

```
OmniOpsys (ERP modular)
├── Global (empresas, usuarios, roles, programas, archivos)
├── Módulo Finanzas (OMNI_F_*)
│   ├── Submódulo: Cuotero (proformas, cuotas, mora, cierre)
│   ├── Submódulo: Cobros (pagos, débito automático)
│   └── Submódulo: Cuentas por cobrar (futuro)
├── Módulo Ventas (OMNI_V_*)
│   ├── Pedidos
│   ├── Facturación
│   └── Clientes comerciales
├── Módulo Compras (OMNI_C_*)
├── Módulo Stock (OMNI_S_*)
├── Módulo RRHH (OMNI_R_*)
└── Módulo Contabilidad (OMNI_CT_*) — la esencia del sistema
```

### Módulos planificados

| Módulo       | Prefijo | Alcance |
|--------------|---------|---------|
| Finanzas     | `F`     | Cuotero, cobros, mora, cierre de plan |
| RRHH         | `R`     | Legajos, liquidación de sueldos, asistencia |
| Ventas       | `V`     | Pedidos, facturación, listas de precios, clientes comerciales |
| Stock        | `S`     | Productos, depósitos, movimientos de inventario |
| Compras      | `C`     | Proveedores, órdenes de compra, recepciones |
| Contabilidad | `CT`    | Plan de cuentas, asientos, libros IVA, mayor, balances |

### Nomenclatura de tablas

- <Tablas globales:> `OMNI_<ENTIDAD>` (ej: `OMNI_EMPRESAS`)
- <Tablas de módulo:> `OMNI_<PREFIJO>_<ENTIDAD>` (ej: `OMNI_F_CLIENTES`)
- Entidades en <plural> y <mayúsculas>

---

## 4. Seguridad y control de acceso

### Roles del sistema

Los roles en OmniOpsys se dividen en:

- <Roles globales:> `SUPER_ADMIN` (acceso total al sistema)
- <Roles por programa:> específicos de cada módulo (ej: `ASESOR`, `FINANZAS`, `APROBADOR`, `CAJA` para el módulo Finanzas)

### Modelo de seguridad en cascada

Al loguearse un usuario y seleccionar empresa, el sistema valida:

1. ¿El usuario está ACTIVO? → `OMNI_USUARIOS`
2. ¿Pertenece a la empresa? → `OMNI_USUARIO_EMPRESA`
3. ¿La empresa tiene el programa habilitado? → `OMNI_EMPRESA_PROGRAMA`
4. ¿Tiene rol en ese programa? → `OMNI_USUARIO_ROL` + `OMNI_ROLES`
5. ✅ Acceso concedido

### RBAC (Role-Based Access Control)

Control de acceso basado en roles. Los permisos se asignan a roles, y los roles a usuarios. En OmniOpsys, además, los roles se contextualizan por empresa.

### Licenciamiento de módulos

Los módulos que una empresa puede usar se controlan mediante la tabla `OMNI_EMPRESA_PROGRAMA`. Aunque un usuario tenga un rol del módulo Finanzas, si la empresa no tiene habilitado ese módulo, no puede acceder.

---

## 5. Procesos del módulo Finanzas (Cuotero)

### Proforma

Documento preliminar que detalla la propuesta de financiamiento al cliente (monto, cuotas, tasa de interés). >No es un documento legal>, es una oferta previa a la aprobación.

### Evaluación crediticia

Análisis de la capacidad de pago del cliente. Puede ser:

- <Automática:> si cumple reglas predefinidas
- <Manual:> requiere revisión de un aprobador

### Términos aceptados

Documento donde el cliente acepta formalmente las condiciones del financiamiento, incluyendo:

- Aceptación de débito automático (si aplica)
- Aceptación de notificaciones
- Condiciones generales

### Cuota

Cada uno de los pagos parciales en que se divide el monto financiado. Cada cuota tiene:

- Número de cuota
- Monto (capital + interés)
- Fecha de vencimiento
- Estado (PENDIENTE, PAGADA, EN_MORA)

### Origen de la cuota

Las cuotas pueden originarse desde distintos módulos:

- <`FINANZAS`> — generadas por una proforma del propio módulo Finanzas
- <`VENTAS`> — generadas por una factura a crédito del módulo Ventas
- <`MANUAL`> — cargadas manualmente

Esto permite integrar módulos a futuro.

### Mora

Recargo aplicado a las cuotas vencidas e impagas. Se calcula por:

- Días de atraso
- Tasa de mora (diaria o mensual)

### Débito automático

Cobro automático de cuotas mediante la cuenta bancaria vinculada del cliente. Requiere autorización previa y puede fallar (registrándose como intento fallido).

### Pago manual

Cobro donde el cliente paga por sus propios medios (efectivo, transferencia, tarjeta, cheque) y el área de Caja/Cobranzas lo registra.

### Conciliación bancaria

Proceso de verificar que los pagos registrados coinciden con los movimientos reales en el banco. Estados: PENDIENTE, CONCILIADO, RECHAZADO.

### Cierre de plan

Proceso final cuando todas las cuotas fueron canceladas. Se genera:

- Comprobante final
- Registro de cierre
- Liberación de la obligación

---

## 6. Formas y medios de pago

### Forma de pago de la venta

Cómo el cliente decide comprar (se define en la proforma o factura):

- `CONTADO` — paga todo al momento
- `CREDITO` — a plazo (30, 60, 90 días)
- `CUOTAS` — financiado en cuotas
- `TARJETA` — pago con tarjeta (crédito/débito)

### Medio de pago del cobro

Cómo el cliente paga efectivamente cada cuota (se registra en cada pago):

- `EFECTIVO`
- `TRANSFERENCIA`
- `DEBITO_AUTO`
- `TARJETA`
- `CHEQUE`

>Son dos cosas distintas> y se modelan en tablas distintas.

---

## 7. Estándares internos de OmniOpsys

### Códigos

- Todos los `CODIGO_*` que se usan en lógica o integridad son >numéricos> (NUMBER)
- Los identificadores externos alfabéticos (username, email, RUC) siguen siendo VARCHAR2

### Auditoría corta

Todas las tablas llevan:

- `FECHA_ALTA_<ENTIDAD>` — fecha de creación
- `USR_CREA_<ENTIDAD>` — usuario que creó
- `FECHA_MOD_<ENTIDAD>` — fecha de última modificación
- `USR_MOD_<ENTIDAD>` — usuario que modificó

### Tipos de datos estandarizados

| Uso                          | Tipo           |
|------------------------------|----------------|
| Montos generales             | NUMBER(14,2)   |
| Montos acumulados / totales  | NUMBER(16,2)   |
| Tasas de interés / mora      | NUMBER(8,4)    |
| Cantidades / contadores      | NUMBER(10)     |
| Textos cortos                | VARCHAR2(50)   |
| Nombres / razones sociales   | VARCHAR2(150)  |
| Descripciones / observaciones| VARCHAR2(300)  |
| URLs                         | VARCHAR2(500)  |
| Fechas                       | DATE           |
| Flags S/N                    | VARCHAR2(1) CHECK IN ('S','N') |

### Almacenamiento de archivos

- Los archivos (imágenes, PDFs, documentos) >NO se guardan en la BD>
- Se almacenan en >carpeta del servidor APEX> o servicio externo
- En la BD se guarda solo la >URL/ruta> y metadatos en `OMNI_ARCHIVOS`

---

## 8. Glosario rápido (A-Z)

| Término | Definición |
|---------|------------|
| <APEX> | Oracle Application Express — plataforma low-code de Oracle |
| <Cuota> | Cada pago parcial de un financiamiento |
| <Cuotero> | Sistema que gestiona financiamientos en cuotas |
| <ERP> | Enterprise Resource Planning — sistema integral de gestión |
| <IFRS> | Estándares internacionales de información financiera |
| <Mora> | Recargo por pago fuera de término |
| <Multiempresa> | Soporte para múltiples empresas en una misma instalación |
| <ORDS> | Oracle REST Data Services — sirve APEX vía HTTP |
| <Proforma> | Documento preliminar de oferta de financiamiento |
| <RBAC> | Role-Based Access Control — control de acceso por roles |
| <RUC> | Registro Único de Contribuyentes (identificación fiscal) |
| >Schema> | Esquema de base de datos (en OmniOpsys: `OMNIOPS`) |
| <Swimlane> | Carril en un diagrama BPMN que representa un rol |
| >Términos aceptados> | Documento donde el cliente acepta las condiciones |
| <WorkSpace APEX> | Entorno de desarrollo en APEX vinculado a un schema |

---

## 9. Referencias

- [Oracle APEX Documentation](https://docs.oracle.com/en/database/oracle/apex/)
- [Oracle Database 21c Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/21/)
- [BPMN 2.0 Specification](https://www.bpmn.org/)