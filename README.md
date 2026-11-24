# Projeto-Integrador-VI-B

**Criação de aplicativo mobile para a venda de produtos rurais.**

O objetivo do aplicativo AgroVende é facilitar o registro e o acompanhamento de vendas de produtos rurais. A proposta é oferecer uma ferramenta simples e prática para vendedores e empresas do setor agrícola, permitindo organizar informações comerciais e acompanhar o desempenho das vendas.

O sistema permite registrar vendas informando o cliente, o produto, a quantidade comercializada e o valor da venda. Além disso, conta com um painel de indicadores gráficos para acompanhar o faturamento e analisar o desempenho comercial.

[docs/problema-e-publico-alvo.md](docs/problema-e-publico-alvo.md)


**FUNCIONALIDADES:**

- Tela de acesso e integrantes do projeto;
- Cadastro e visualização de produtos;
- Cadastro e visualização de clientes;
- Registro e histórico de vendas;
- Detalhamento das vendas;
- Exibição de indicadores de faturamento.

[docs/funcionalidades.md](docs/funcionalidades.md)


**TECNOLOGIAS:**

- Flutter
- Linguagem Dart
- SQL (SQLite)
- Biblioteca sqflite
- Visual Studio Code
- Android Studio

[docs/tecnologias.md](docs/tecnologias.md)


**WIREFRAME DO APP:**

O aplicativo possui telas de login, integrantes, dados de faturamento, registro e histórico de vendas, além de telas para visualização e cadastro de clientes e produtos.

Telas em alta definição: [docs/wireframe.md](docs/wireframe.md)


**BANCO DE DADOS:**

O aplicativo AgroVende utiliza o SQLite como banco de dados local. Dessa forma, as informações ficam armazenadas diretamente no celular, permitindo a utilização do aplicativo sem conexão com a internet.

O banco de dados é composto por quatro tabelas: usuário, cliente, produto e venda. Todas possuem no mínimo três colunas, sendo que a tabela de venda possui relacionamento com as demais tabelas.

- [docs/modelagem-banco-de-dados.md](docs/modelagem-banco-de-dados.md)
- [docs/banco-de-dados-local.md](docs/banco-de-dados-local.md)


**CÓDIGO-FONTE:**

O código-fonte está disponível na pasta [meu_agro_venda](meu_agro_venda).

- `lib/main.dart`: inicialização, tela de acesso e integrantes;
- `lib/banco.dart`: criação e gerenciamento do banco de dados;
- `lib/telas.dart`: implementação das demais telas;
- `pubspec.yaml`: dependências do aplicativo.

Para executar o projeto, é necessário ter o Flutter SDK e o ambiente Android configurados.

Na pasta `meu_agro_venda`, executar os comandos:

    flutter pub get
    flutter run


**APK:**

O aplicativo foi compilado e testado no emulador Android, incluindo testes de cadastro.

O arquivo APK está disponível para download:

- [Download do AgroVende.apk](https://github.com/corceteemilly-glitch/Projeto-Integrador-UCS/releases)
- [docs/apk.md](docs/apk.md)

**Dados de acesso para teste:**

- Usuário: admin
- Senha: 123456


**VÍDEO DEMONSTRATIVO:**

Link do vídeo no YouTube: https://youtu.be/9HatKOYIe2o

**INSTRUÇÕES DE EXECUÇÃO:**

O passo a passo para configurar e executar o aplicativo em outro computador está disponível em [Instruções de execução](EXECUTAR.md).


**INTEGRANTES:**

- ANDERSON VANZETTO
- EMILLY CORCETE DOS SANTOS
- FRANCIELE TERNES KUSSLER
- MONIQUE CRISTINA LEÃO ALVES
- LUCCAS FAGUNDES DE SOUZA
