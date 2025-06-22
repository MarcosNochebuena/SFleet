# SFleet
Technical challenge. Vehicle monitoring and maintenance system

[![Ruby Version](https://img.shields.io/badge/ruby-3.4.1-blue)](https://www.ruby-lang.org/en/downloads/)
[![Rails Version](https://img.shields.io/badge/rails-8.0.2-blue)](https://rubyonrails.org/)

Este proyecto simula un sistema de monitoreo y mantenimiento de vehículos, con las siguientes funcionalidades:

- Listado de vehículos
- Creación de vehículos
- Listado de reportes de mantenimiento
- Creación de reportes de mantenimiento
- Listado de ordenes de servicio
- Creación de ordenes de servicio

## Requisitos

- Ruby 3.4.1
- Rails 8.0.2
- PostgreSQL 16

## Instalación

```bash
git clone https://github.com/marcosn/SFleet.git
cd SFleet
bundle install
```
## Variables de entorno
Crear un archivo application.yml en la carpeta config con las siguientes variables:
```markdown
database_adapter: postgresql
database_username: your_postgres_user
database_password: your_postgres_password
database_host: your_postgres_host
database_port: your_postgres_port || 5432
```

# Crear base de datos
```bash
rails db:create
rails db:migrate
rails db:seed
```
o
```bash
rails db:setup
```

## Iniciar el servidor
Para el entorno de desarrollo, iniciar el servidor con el siguiente comando:
```bash
rails server
```
## Ejecutar las pruebas
```bash
rspec
```
## Consultar la cobertura de pruebas
La cobertura se genera automáticamente al correr los tests con RSpec.
Abre el archivo `coverage/index.html` en tu navegador para ver el reporte:

```bash
open coverage/index.html
```
## Ejemplos de endpoints
Vehículos
```markdown
GET /vehicles
GET /vehicles/:id
POST /vehicles
PUT /vehicles/:id
PATCH /vehicles/:id/status?status=
DELETE /vehicles/:id
```

Reportes de mantenimiento
```markdown
GET /maintenance_reports
GET /maintenance_reports/:id
POST /maintenance_reports
PUT /maintenance_reports/:id
DELETE /maintenance_reports/:id
```
Ordenes de servicio
```markdown
GET /service_orders
GET /service_orders/:id
POST /service_orders
PUT /service_orders/:id
PATCH /service_orders/:id/status?status=
DELETE /service_orders/:id
```

## Ejemplo de solicitud GET /vehicles
```bash
GET /vehicles
```

## Ejemplo de respuesta GET /vehicles
```json
[
    {
    "id": 1,
    "brand": "Toyota",
    "model": "Corolla",
    "year": 2022,
    "license_plate": "ABC123",
    "created_at": "2025-06-22T00:52:09.718Z",
    "updated_at": "2025-06-22T00:52:09.718Z"
    }
]
```

## Ejemplo de solicitud POST /vehicles
```bash
POST /vehicles
```
body:
```json
{
    "license_plate": "ABC123",
    "make": "Toyota",
    "model": "Corolla",
    "year": 2022,
    "status": "available"
}
```

## Ejemplo de respuesta POST /vehicles
```json
{
    "id": 1,
    "license_plate": "ABC123",
    "make": "Toyota",
    "model": "Corolla",
    "year": 2022,
    "status": "available",
    "created_at": "2025-06-22T00:52:09.718Z",
    "updated_at": "2025-06-22T00:52:09.718Z"
}
```

## Licencia
MIT

## Autores
- Marcos Jose Nochebuena
