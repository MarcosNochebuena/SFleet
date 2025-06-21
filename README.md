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
rails db:create
rails db:migrate
```

## Variables de entorno
```markdown
## Configuración de entorno
Crear un archivo application.yml en la carpeta config con las siguientes variables:
```yaml
  database_adapter: postgresql
  database_username: your_postgres_user
  database_password: your_postgres_password
  database_host: your_postgres_host
  database_port: your_postgres_port || 5432
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
## Ejecutar el linter
```bash
rubocop
```

## Licencia
MIT

