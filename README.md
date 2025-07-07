# 📹: Video Compactor
![VideoManagerCompactor](video.png?raw=true "VideoManagerCompactor")

## ✏️ Descrição do Projeto
<p align="left">Este projeto tem como objetivo concluir a entrega do Hackaton do curso de Software Architecture da Pós Graduação da FIAP 2024/2025.
Este repositório constrói um serviço que faz parte de uma arquitetura de microsserviços.</p>

## 📊 Code Coverage
[![Coverage Status](https://coveralls.io/repos/github/diegogl12/video-compactor/badge.svg?branch=workflows)](https://coveralls.io/github/diegogl12/video-compactor?branch=workflows)

## 🏗️ Arquitetura de Microsserviços
![Arquitetura](arquitetura.png?raw=true "Arquitetura")

### 💻 Tecnologias Utilizadas
- Linguagem escolhida: Elixir
- Banco de Dados: MongoDB
- Mensageria: SQS

### 🔨 Detalhes desse serviço
Este serviço faz: 
 - O consumo via mensageria SQS da informação (id, caminho do S3) do video à ser compactado;
 - Compacta e mantém em memória o video;
 - Notifica o [Fiap Video Manager](https://github.com/RafaelKamada/fiap-video-manager) sobre o status (compactado com sucesso ou com erro);
 - Mantém no seu banco de dados o arquivo

### 🛠️ Execução do projeto
1. Faça o clone do projeto: ```git clone git@github.com:diegogl12/food-order-producao.git```
2. Rode o comando do docker-compose na raiz do projeto: ```make up```
4. Acessar o arquivo de endpoints.exs para descobrir os endpoints: ```https://github.com/diegogl12/food-order-producao/blob/main/lib/infra/web/endpoints.ex```
5. Popular mensagem no SQS local: ```make create_message```


### Endpoints Disponíveis

| Método | Endpoint                                | Descrição                                             |
| ------ | --------------------------------------- | ----------------------------------------------------- |
| GET    | /api/video/id            | Consulta o video através do ID. |
=======
 - Notifica o Fiap-Video-Manager sobre o status (compactado com sucesso ou com erro);
 - Mantém no seu banco de dados o arquivo

### 🗄️ Outros repos do microserviço dessa arquitetura
- [Fiap Video Manager](https://github.com/RafaelKamada/fiap-video-manager)

### 📈 Documentações
- [Miro (todo planejamento do projeto)](https://miro.com/app/board/uXjVKhyEAME=/)


### 👥 Autores
| [<img loading="lazy" src="https://avatars.githubusercontent.com/u/96452759?v=4" width=115><br><sub>Robson Vilaça - RM358345</sub>](https://github.com/vilacalima) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/16946021?v=4" width=115><br><sub>Diego Gomes - RM358549</sub>](https://github.com/diegogl12) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/8690168?v=4" width=115><br><sub>Nathalia Freire - RM359533</sub>](https://github.com/nathaliaifurita) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/43392619?v=4" width=115><br><sub>Rafael Kamada - RM359345</sub>](https://github.com/RafaelKamada) |
| :---: | :---: | :---: | :---: |
