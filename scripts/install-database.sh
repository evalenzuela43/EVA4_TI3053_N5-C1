#!/bin/bash
set -e

echo "=== Instalando Base de datos SIMI ERP ==="

# Actualizar sistema
sudo dnf update -y

# Instalar Docker
sudo dnf install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
newgrp docker

# Instalar Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Clonar repositorio
sudo mkdir -p /srv/simi-erp
sudo chown ec2-user:ec2-user /srv/simi-erp
cd /srv/simi-erp
git clone https://github.com/TU_USUARIO/simi-erp.git .

# Crear .env para docker-compose
cat > database/.env << 'EOF'
DB_USER=simiuser
DB_PASSWORD=SimiPass2024!
DB_NAME=simi_erp
EOF

# Levantar PostgreSQL
cd database
docker-compose up -d

echo "=== Base de datos instalada correctamente ==="