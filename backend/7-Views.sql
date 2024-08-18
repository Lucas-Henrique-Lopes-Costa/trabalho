-- g)

-- Tirar a restrição de sempre ter que utilizar um GROUP BY na sessão
SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

-- 1. View que relaciona os dados do Número de registro do vendedor, e a quantidade de pedidos de venda feitas por ele
CREATE VIEW FuncENumeroDeVendas AS
SELECT V.numRegistro AS NumeroRegistro, COUNT(PV.Vendedor_PessoaFisica_Pessoa_idPessoa) AS NPedidos
FROM Vendedor V JOIN PedidoVenda PV ON PV.Vendedor_PessoaFisica_Pessoa_idPessoa = V.PessoaFisica_Pessoa_idPessoa
GROUP BY V.numRegistro;

-- Exemplos:

-- 1.1 Como as views funcionam como uma maneira de simplificar queries, podemos utilizar essa view para ter
-- imediatamente o número de pedidos de venda feitos por cada funcionário.
SELECT * FROM FuncENumeroDeVendas;

-- 1.2 Ou então, podemos associar a view feita com outra query. Por exemplo, podemos ver quais ou qual funcionario
-- fez mais pedidos de venda
SELECT NumeroRegistro, MAX(NPedidos) AS MaiorNumeroDePedidos
FROM FuncENumeroDeVendas;

-- 2. View que seleciona a pessoa que é cliente com seu pedido e a situação e data do pedido.
CREATE VIEW SituacaoPedido AS
SELECT PS.idPessoa AS IdentificacaoPessoa, PD.id AS IdentificacaoPedido,PD.situacao AS SituacaoPedido, PD.dataPedido AS DataDoPedido
FROM Pessoa PS JOIN Pedido PD
ON PS.idPessoa = PD.Pessoa_idPessoa
WHERE PS.ehCliente = 1
GROUP BY PS.idPessoa;

-- 2.1 Um exemplo de organizar mais essa view seria utilizar o CPF do cliente para relacionar com seu pedido
SELECT P.cpf AS CPF, IdentificacaoPedido, SituacaoPedido, DataDoPedido
FROM SituacaoPedido SP JOIN PessoaFisica P
ON SP.IdentificacaoPessoa = P.Pessoa_idPessoa;

-- 3. Um outro exemplo útil seria filtrar quais Leads (Pessoas captadas pelas estratégias de marketing digital)
-- se tornaram clientes da empresa e por quais plataformas (Instagram, Facebook...)
CREATE VIEW LeadsClientes AS
SELECT P.idPessoa AS idLeadCliente, L.plataformaOrigem AS PlataformaDigital
FROM Pessoa P JOIN `Lead` L 
ON P.idPessoa = L.PessoaFisica_Pessoa_idPessoa
WHERE P.ehCliente = 1;

-- 3.1 Como as plataformas estão registradas por codigos, podemos fazer uma troca pelo nome das plataformas
SELECT idLeadCliente, 
		CASE PlataformaDigital
			WHEN 11 THEN 'Instagram'
            WHEN 22 THEN 'Facebook'
            WHEN 33 THEN 'Twitter'
            ELSE 'Outra'
		END AS NomePlataforma
FROM LeadsClientes;


