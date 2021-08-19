# README

### Teste para Neoway

##### requisitos

* Ruby version
2.7.2

* Rails version
6.1.4

* Docker Version
Docker version 20.10.7, build 20.10.7-0ubuntu1~20.04.1

* Docker-Compose Version
docker-compose version 1.25.0

## Run Tests para Neoway

* Entrar na pasta do projeto e buildar as imagens
```sh
docker-compose up --build
```
* Ao buildar a imagem, será criado o banco de dados postgres para conexão.

* Quando os containers estiverem ativos, entrar em local para verificar o retorno da API

http://localhost:3000/purchases_data/index

* Ao acessar a página index, é chamado o método purchases_data que carrega os dados do arquivo "base_teste.txt" enviado para análise.

* Foi efetuado uma paginação simples utilizando a gem Kaminari para facilitar a visualização dos dados.

### Testes no console do rails
* Abrir um terminal e executar
```sh
docker exec -it neoway /bin/bash
```
* Entrar no console do rails
```sh
rails c
```
* Para integrar os 49998 dados do arquivo "base_teste.txt" ao banco de dados.
Rodar no console do rails
```ruby
PurchaseData.new.process_data
```
#### Teste rápido
* Caso deseje efetuar um teste de carga rápida, Na linha 12 do arquivo_purchase_data.rb, modificar para:

```ruby
rows.last(10).map do |row|
```
com isto apenas as 10 últimas lihas do arquivos serão lidas e persistidas

#### Tratamentos
Foi efetuado um tratamento para não duplicar o registro cada vez que a página index for carregada chamdo o método de tratamento e persistência de dados.

```link
https://www.linkedin.com/in/claudinei-ap-perboni-30a85317/
```

