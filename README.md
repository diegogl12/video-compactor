# :hamburger: Food Order Produção
![FoodOrder](foodorder.png?raw=true "FoodOrder")

## :pencil: Descrição do Projeto
<p align="left">Este projeto tem como objetivo concluir as  entregas do Tech Challenge do curso de Software Architecture da Pós Graduação da FIAP 2024/2025.
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
Este serviço cuida do domínio de produção, recebendo por mensageria, o evento que inicia a requisição de produção. Este evento vem do início de produção de um pedido do serviço Pedidos.
Além disso, expõe um endpoint para atualizar o status de produção, que, consequentemente, atualiza o status do pedido no serviço Pedidos. 

### :hammer_and_wrench: Execução do projeto
1. Faça o clone do projeto: ```git clone git@github.com:diegogl12/food-order-producao.git```
2. Rode o comando do docker-compose na raiz do projeto: ```make up```
4. Acessar o arquivo de endpoints.exs para descobrir os endpoints: ```https://github.com/diegogl12/food-order-producao/blob/main/lib/infra/web/endpoints.ex```
5. Popular mensagem no SQS local: ```make create_message```

### 🗄️ Outros repos do microserviço dessa arquitetura
- [Food Order Produção](https://github.com/diegogl12/food-order-producao)
- [Food Order Pagamento](https://github.com/diegogl12/food-order-pagamento)
- [Food Order Cardápio](https://github.com/RafaelKamada/foodorder-cardapio)
- [Food Order Pedidos](https://github.com/vilacalima/food-order-pedidos)
- [Food Order Usuários](https://github.com/RafaelKamada/FoodOrder)

### :page_with_curl: Documentações
- [Miro (todo planejamento do projeto)](https://miro.com/app/board/uXjVKhyEAME=/)


### :busts_in_silhouette: Autores
| [<img loading="lazy" src="https://avatars.githubusercontent.com/u/96452759?v=4" width=115><br><sub>Robson Vilaça - RM358345</sub>](https://github.com/vilacalima) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/16946021?v=4" width=115><br><sub>Diego Gomes - RM358549</sub>](https://github.com/diegogl12) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/8690168?v=4" width=115><br><sub>Nathalia Freire - RM359533</sub>](https://github.com/nathaliaifurita) |  [<img loading="lazy" src="https://avatars.githubusercontent.com/u/43392619?v=4" width=115><br><sub>Rafael Kamada - RM359345</sub>](https://github.com/RafaelKamada) |
| :---: | :---: | :---: | :---: |
