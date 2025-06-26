# 📹: Video Compactor
![VideoManagerCompactor](video.png?raw=true "VideoManagerCompactor")

## :pencil: Descrição do Projeto
<p align="left">Este projeto tem como objetivo concluir a entrega do Hackaton do curso de Software Architecture da Pós Graduação da FIAP 2024/2025.
Este repositório constrói um serviço que faz parte de uma arquitetura de microsserviços.</p>

## 📊 Code Coverage
[![Coverage Status](https://coveralls.io/repos/github/diegogl12/food-order-producao/badge.svg?branch=feat/tests)](https://coveralls.io/github/diegogl12/food-order-producao?branch=feat/tests)

## 🏗️ Arquitetura de Microsserviços
![Arquitetura](arquitetura.png?raw=true "Arquitetura")

### :computer: Tecnologias Utilizadas
- Linguagem escolhida: Elixir
- Banco de Dados: MongoDB
- Mensageria: SQS

### :hammer: Detalhes desse serviço
Este serviço faz: 
 - O consumo via mensageria SQS da informação (id, caminho do S3) do video à ser compactado;
 - Compacta e mantém em memória o video;
 - Notifica o [Fiap Video Manager](https://github.com/RafaelKamada/fiap-video-manager) sobre o status (compactado com sucesso ou com erro);
 - Mantém no seu banco de dados o arquivo

### :hammer_and_wrench: Execução do projeto
1. Faça o clone do projeto: ```git@github.com:diegogl12/video-compactor.git```
2. Rode o comando do docker-compose na raiz do projeto: ```docker-compose up --build -d```


### Endpoints Disponíveis

| Método | Endpoint                                | Descrição                                             |
| ------ | --------------------------------------- | ----------------------------------------------------- |
| GET    | /api/video/id            | Consulta o video através do ID. |
=======
 - Notifica o Fiap-Video-Manager sobre o status (compactado com sucesso ou com erro);
 - Mantém no seu banco de dados o arquivo

### :hammer_and_wrench: Execução do projeto
1. Faça o clone do projeto: ```git@github.com:diegogl12/video-compactor.git```
2. Rode o comando do docker-compose na raiz do projeto: ```docker-compose up --build -d```
 - Notifica o Fiap-Video-Manager sobre o status (compactado com sucesso ou com erro);
 - Mantém no seu banco de dados o arquivo

### :hammer_and_wrench: Execução do projeto
1. Faça o clone do projeto: ``` ```
2. Rode o comando do docker-compose na raiz do projeto: ```make up```


### 🗄️ Outros repos do microserviço dessa arquitetura
- [Fiap Video Manager](https://github.com/RafaelKamada/fiap-video-manager)


### :page_with_curl: Documentações
- [Miro (todo planejamento do projeto)](https://miro.com/app/board/uXjVKhyEAME=/)


### :busts_in_silhouette: Autores
| [<img loading="lazy" src="https://avatars.githubusercontent.com/u/96452759?v=4" width=115><br><sub>Robson Vilaça - RM358345</sub>](https://github.com/vilacalima) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/16946021?v=4" width=115><br><sub>Diego Gomes - RM358549</sub>](https://github.com/diegogl12) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/8690168?v=4" width=115><br><sub>Nathalia Freire - RM359533</sub>](https://github.com/nathaliaifurita) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/43392619?v=4" width=115><br><sub>Rafael Kamada - RM359345</sub>](https://github.com/RafaelKamada) |
| :---: | :---: | :---: | :---: |
