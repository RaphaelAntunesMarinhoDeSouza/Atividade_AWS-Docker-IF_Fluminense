#!/bin/bash

# Atualiza o sistema operacional
sudo yum update -y

# Instala o Docker
sudo yum install docker -y

# Inicia o Docker
sudo systemctl start docker

# Habilita o serviço do Docker
sudo systemctl enable docker

# Adiciona o usuário atual ao grupo 'docker'
sudo usermod -aG docker ec2-user

# Configura o Docker para iniciar durante a inicialização do sistema
sudo chkconfig docker on

# Instala a utilidade nfs-utils
sudo yum install nfs-utils -y

# Cria o diretório 'efs' dentro do diretório 'mnt'
sudo mkdir /mnt/efs/

# Concede permissões de leitura, escrita e execução para todos os usuários no diretório 'efs'
sudo chmod +rwx /mnt/efs/

# Monta o sistema de arquivos do Amazon EFS
sudo mount -t efs <DNS_NAME_DO_EFS>:/ /mnt/efs

# Adiciona uma entrada ao /etc/fstab para montagem persistente
echo "<DNS_NAME_DO_EFS>:/ /mnt/efs nfs4 defaults 0 0" >> /etc/fstab

# Instala o Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Torna o binário do Docker Compose executável
sudo chmod +x /usr/local/bin/docker-compose

# Move o binário do Docker Compose para um diretório no PATH do sistema
sudo mv /usr/local/bin/docker-compose /bin/docker-compose
