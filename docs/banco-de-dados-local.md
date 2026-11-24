## Banco de Dados Local

O aplicativo AgroVende utiliza o SQLite como banco de dados local. Dessa forma, as informações ficam armazenadas diretamente no celular, permitindo o uso do aplicativo mesmo sem conexão com a internet.

Para implementar o banco de dados, foi utilizada a biblioteca sqflite, que permite conectar o SQLite ao aplicativo desenvolvido em Flutter.

O banco de dados é criado automaticamente ao iniciar a aplicação e possui quatro tabelas, conforme a modelagem definida no projeto.

**TABELAS E COLUNAS:**

| Tabela | Colunas |
|---|---|
| Usuário | id_usuario, nome, login, senha |
| Cliente | id_cliente, nome, telefone, email, endereco |
| Produto | id_produto, nome, descricao, valor_unitario, unidade_medida |
| Venda | id_venda, id_cliente, id_produto, id_usuario, quantidade, valor_unitario, valor_total, data_venda |

**RELACIONAMENTOS:**

- Usuário e venda (1:N);
- Cliente e venda (1:N);
- Produto e venda (1:N).

A tabela de vendas utiliza chaves estrangeiras para relacionar os registros com os usuários, clientes e produtos cadastrados.

O aplicativo permite cadastrar, consultar, editar e excluir clientes, produtos e vendas, respeitando os relacionamentos do banco de dados.

Os dados das vendas também são utilizados para mostrar o faturamento, a quantidade vendida, o número de vendas realizadas e os produtos mais vendidos, facilitando o acompanhamento dos resultados.

A implementação do banco de dados está disponível no arquivo [banco.dart](../meu_agro_venda/lib/banco.dart).

[Modelagem do banco de dados](modelagem-banco-de-dados.md)
