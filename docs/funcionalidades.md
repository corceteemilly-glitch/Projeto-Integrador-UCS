**PRINCIPAIS FUNCIONALIDADES:**

**1. Autenticação e acesso:**
- Login de usuários por meio de usuário e senha;
- Validação dos dados de acesso;
- Opção para visualizar ou ocultar a senha digitada;
- Opção de memorizar o nome do usuário (Lembrar-me);
- Orientação para recuperação de senha;
- Tela de identificação dos integrantes responsáveis pelo projeto.

**2. Painel inicial (Dashboard):**
- Exibição do faturamento total do mês;
- Visualização da quantidade de itens vendidos no mês;
- Exibição do número total de vendas realizadas no mês;
- Gráfico de faturamento dos últimos seis meses;
- Gráfico dos cinco produtos mais vendidos no mês;
- Acesso rápido à funcionalidade de registrar uma nova venda.

**3. Gerenciamento de vendas:**
- Cadastro de novas vendas;
- Seleção de clientes previamente cadastrados;
- Seleção de produtos disponíveis no sistema;
- Registro da quantidade vendida;
- Preenchimento automático do valor unitário do produto, permitindo alteração;
- Cálculo automático do valor total da venda;
- Registro da data da venda;
- Salvamento das informações no banco de dados local;
- Edição de vendas já cadastradas;
- Exclusão de vendas;
- Visualização dos detalhes de cada venda.

Para registrar uma venda, é necessário possuir pelo menos um cliente e um produto cadastrados.

**4. Histórico de vendas:**
- Listagem de todas as vendas realizadas;
- Identificação do cliente e do produto vendido;
- Exibição da quantidade, valor e data de cada venda;
- Pesquisa de vendas por nome do cliente ou produto;
- Filtros por período:
  - Todas as vendas;
  - Últimos 30 dias;
  - Últimos 90 dias;
  - Últimos 12 meses.
- Acesso aos detalhes individuais de cada venda.

**5. Gerenciamento de clientes:**
- Cadastro de novos clientes;
- Registro do nome completo do cliente;
- Cadastro de telefone para contato;
- Cadastro de e-mail (opcional);
- Cadastro de endereço (opcional);
- Listagem de clientes cadastrados;
- Pesquisa de clientes pelo nome;
- Edição dos dados de clientes existentes;
- Exclusão de clientes que não possuem vendas vinculadas.

**6. Gerenciamento de produtos:**
- Cadastro de novos produtos rurais;
- Registro do nome do produto;
- Campo para descrição e detalhes do produto (opcional);
- Definição do valor unitário;
- Registro da unidade de medida (kg, unidade, dúzia etc.);
- Listagem de produtos cadastrados;
- Pesquisa de produtos pelo nome;
- Edição das informações dos produtos;
- Exclusão de produtos que não possuem vendas vinculadas.

**7. Navegação do aplicativo:**
- Menu inferior para facilitar o acesso às principais áreas;
- Navegação entre as telas:
  - Início;
  - Vendas;
  - Clientes;
  - Produtos.
- Opção de sair do sistema;
- Interface padronizada para facilitar a utilização.

**8. Armazenamento de dados:**
- Armazenamento local utilizando SQLite;
- Relacionamento entre usuários, clientes, produtos e vendas;
- Utilização do aplicativo sem conexão com a internet;
- Persistência dos dados cadastrados.
