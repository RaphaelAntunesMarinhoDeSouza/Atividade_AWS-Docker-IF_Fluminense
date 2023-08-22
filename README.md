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
* Na AWS busque por `VPC`
* No menu de VPC clique em `Criar VPC`.
* Slecione a opção `and more`.
* Após criar a VPC ainda no menu vá até `Gateways NAT`.
* Clique em `Criar gateway NAT`.
* Nomeie o Nat Gateway e em `Sub-rede` selecione uma das sub-redes públicas.
* Mantenha `Tipo de conectividade` como público.
* Em seguida clique em `Criar gateway NAT`.
* Após criar o NAT gateway, acesse `Tabelas de rotas`.
* Na `Tabela de rotas` selecione as rotas privadas, clique em `Ações` e selecione `Editar rotas`, será necessário realizar isso para as duas rotas.
* Em `Editar rotas` em `destino` selecione `0.0.0/0`
* Em Alvo selecione `Gateway NAT` e selecione o NAT gateway criado anteriormente.
* Clique em `Salvar alterações`.
* Para verificar se sua VPC está correta acesse `Suas VPCs` em seguida selecione a VPC criada anteriormente e a opção `Resource map`

## Passo 2: Criando os Security Groups:
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

## Passo 4: Criando o RDS:

## Passo 4: Criando o Template:
* Na AWS busque por `EC2`
* No menu de EC2 clique em `Launch Template`.
* Configure o template da seguinte forma:
* No quadro do User data copie e cole o [StartScript.sh](https://github.com/RaphaelAntunesMarinhoDeSouza/Atividade_AWS-Docker-IF_Fluminense/blob/main/StartScript.sh).

## Passo 5: Criando o Target group:

## Passo 6: Criando o Load balancer:

## Passo 7: Criando o  Auto Scaling:






<div align="center">
  <img src="" width="180px">
</div>
