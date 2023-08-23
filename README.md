<div align="center">
<img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Imagens/blob/main/Atividade_AWS_Docker/compass-uol-logo.png" width="180px">
</div>

# Atividade AWS - Docker - IF Fluminense

<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Imagens/blob/main/Atividade_AWS_Docker/l-docker.png" width="120px">
</div>

# Sobre a atividade

<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/arq.jpg" width="500px">
</div>

1. Instalação e configuração do DOCKER ou CONTAINERD no host EC2.
  * Ponto adicional para o trabalho que utilizar a instalação via script de Start Instance (user_data.sh)

2. Efetuar Deploy de uma aplicação Wordpress com: 
  * Container de aplicação
  * RDS database MySQL

3. Configuração da utilização do serviço EFS AWS para estáticos do container de aplicação WordPress

4. Configuração do serviço de Load Balancer AWS para a aplicação Wordpress

##

# Passo a Passo
## Passo 1: Criando a VPC:
* Na AWS busque por `VPC`.
  
<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/VPC1.png" width="600px">
</div>
  
* No menu de VPC clique em `Criar VPC`.
  
<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/VPC2.png" width="650px">
</div>
  
* Slecione a opção `and more` e clique em Criar VPC`.
* Após criar a VPC ainda no menu vá até `Gateways NAT`.
* Clique em `Criar gateway NAT`.
 
 <div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/VPC3.png" width="1100px">
</div> 

* Nomeie o Nat Gateway e em `Sub-rede` selecione uma das sub-redes públicas.
  
 <div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/VPC4.png" width="600px">
</div> 
  
* Mantenha `Tipo de conectividade` como público.
* Em seguida clique em `Criar gateway NAT`.
* Após criar o NAT gateway, acesse `Tabelas de rotas`.
* Na `Tabela de rotas` selecione as rotas privadas, clique em `Ações` e selecione `Editar rotas`, será necessário realizar isso para as duas rotas.
* Em `Editar rotas` em `destino` selecione `0.0.0/0`
* Em Alvo selecione `Gateway NAT` e selecione o NAT gateway criado anteriormente.
* Clique em `Salvar alterações`.
* Para verificar se sua VPC está correta acesse `Suas VPCs` em seguida selecione a VPC criada anteriormente e a opção `Resource map`
  
  <div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/VPC5.png" width="700px">
</div>

## Passo 2: Criando os Security Groups:
* No menu EC2 procure por `Security groups` na barra de navegação à esquerda.
* Acesse e clique em `Criar novo grupo de segurança`, e crie os grupos de segurança a seguir.

#### SG-ALB
  | Type         | Protocol | Port Range | Source Type | Source      |
  |--------------|----------|------------|-------------|-------------|
  | HTTP         | TCP      | 80         | Anywhere    | 0.0.0.0/0   |

#### SG-EC2
  | Type         | Protocol | Port Range | Source Type | Source      |
  |--------------|----------|------------|-------------|-------------|
  | SSH          | TCP      | 22         | Anywhere    | 0.0.0.0/0   |
  | HTTP         | TCP      | 80         | Custom      | SG-ALB      |

#### SG-EFS
  | Type         | Protocol | Port Range | Source Type | Source      |
  |--------------|----------|------------|-------------|-------------|
  | NFS          | TCP      | 2049       | Anywhere    | 0.0.0.0/0   |

#### SG-RDS
  | Type         | Protocol | Port Range | Source Type | Source      |
  |--------------|----------|------------|-------------|-------------|
  | MYSQL/Aurora | TCP      | 3306       | Anywhere    | 0.0.0.0/0   |

## Passo 3: Criando o EFS:

* Busque por `EFS` na Amazon AWS o serviço de arquivos de NFS escalável da AWS.
* Na Página de EFS clique em `Criar sistema de arquivos`.

<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/EFS1.png" width="220px">
</div>

* Clique em `Costumize`.

<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/EFS2.png" width=400px">
</div>

* Selecione o **SG** criado para o EFS e finalize a crição.

<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/EFS3.png" width="1200px">
</div>

## Passo 4: Criando o RDS:
* Busque por RDS na Amazon AWS.
* Na página de RDS clique em `Create database`.

<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/RDS1.png" width="500px">
</div>

* Em `Engine options` selecione **MySQL**
* Em `Templates` selecione **Free tier**

<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/RDS2.png" width="500px">
</div>


<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/RDS3.png" width="500px">
</div>


<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/RDS4.png" width="500px">
</div>


<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/RDS5.png" width="500px">
</div>


<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/RDS6.png" width="500px">
</div>

<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/RDS7.png" width="500px">
</div>


<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/RDS8.png" width="500px">
</div>


<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/RDS9.png" width="500px">
</div>


## Passo 5: Criando o Template:
* Na AWS busque por `EC2`
* No menu de EC2 clique em `Launch Template`.
* Configure o template da seguinte forma:
  
<div align="center">
  <img src="" width="180px">
</div>

* No quadro do User data copie e cole o [StartScript.sh](https://github.com/RaphaelAntunesMarinhoDeSouza/Atividade_AWS-Docker-IF_Fluminense/blob/main/StartScript.sh).

## Passo 5: Criando o Target group:
* No menu EC2 procure por `Grupos de destino` na barra de navegação à esquerda.
* Acesse e clique em `Criar grupo de destino`.
* Em `Escolha um tipo de destino` clique em `Instâncias`.
* Nomeie o grupo de destino.
*  Em `Protocolo` mantenha `HTTP` e em `Porta` mantenha a porta `80`.
*  Como `VPC` selecione a VPC criada anteriormente.
*  Mantenha a `Versão do protocolo` como `HTTP1`.
*  A seguir clique em `Próximo`.
*  Na página de `Registrar destinos` não selecione nenhuma instância.
*  Selecione `Criar grupo de destino`.

## Passo 6: Criando o Load balancer:

## Passo 7: Criando o  Auto Scaling:

# Testando o funcionamento
Para isso basta copiar o endereço DNS do load balancer e cola-lo no browser, após fazer isso deverá aparecer a página do wordpress exibida a baixo:
<div align="center">
  <img src="" width="180px">
</div>

Volte a console AWS e no menu EC2 busque por `target group` Aqui ambas as instâncias precisam estar healthy. Neste ponto cabe ressaltar que pode ser que levem alguns minutos para que fiquem healthy.
<div align="center">
  <img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/Atividade_AWS_Docker/Healthy.png" width="1200px">
</div>

Acesse a instância via PuTTy e dê os seguintes comandos:
* `` docker exec -it <ID_DO_CONTAINER_WORDPRESS> /bin/bash `` 
* Dentro do container WordPress execute: ``apt-get update`` e depois `` apt-get install default-mysql-client -y ``.
*  Agora use o comando: `` mysql -h <ENDPOINT_DO_SEU_RDS> -P 3306 -u admin -p `` para entrar no banco de dados MySQL com as mesmas credenciais do seu RDS.




