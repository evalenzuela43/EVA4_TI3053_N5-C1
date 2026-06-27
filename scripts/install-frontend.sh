#!/bin/bash
set -e

echo "=== Instalando Frontend SIMI ERP ==="

# Actualizar sistema
sudo dnf update -y

# Instalar Node.js 20
sudo dnf install -y nodejs npm git

# Clonar repositorio
sudo mkdir -p /srv/simi-erp
sudo chown ec2-user:ec2-user /srv/simi-erp
cd /srv/simi-erp
git clone https://github.com/TU_USUARIO/simi-erp.git .

# Instalar dependencias
cd frontend
npm install

# Copiar variables de entorno
cp .env.example .env
echo "⚠️  Edita /srv/simi-erp/frontend/.env con tus valores reales"

# Instalar PM2 para mantener el proceso activo
sudo npm install -g pm2
pm2 start server.js --name simi-erp
pm2 startup
pm2 save

echo "=== Frontend instalado correctamente ==="