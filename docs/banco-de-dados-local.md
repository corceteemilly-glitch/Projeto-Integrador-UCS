## Banco de Dados Local

O aplicativo AgroVende utilizará o SQLite como banco de dados local. Dessa forma, as informações ficarão armazenadas diretamente no celular, permitindo o uso do aplicativo mesmo sem conexão com a internet.

Para implementar o banco de dados, será utilizada a biblioteca sqflite, que permite conectar o SQLite ao aplicativo desenvolvido em Flutter. O banco terá quatro tabelas: usuários, clientes, produtos e vendas, conforme a modelagem definida no projeto.

Com isso, será possível cadastrar, consultar, editar e excluir informações. Os dados das vendas também serão utilizados para mostrar o faturamento, a quantidade de vendas e os produtos mais vendidos, facilitando o acompanhamento dos resultados.
