use bd_trabalho;

-- Calcula a porcentagem de orçamentos feitos que geraram pelo menos um pedido de venda
SELECT 
    CONCAT(
        ROUND(
            (COUNT(DISTINCT o.dataCotacao, o.Pessoa_idPessoa) * 100) / 
            (SELECT COUNT(*) FROM orcvenda), 
        2), 
        '%'
    ) AS PercentualDeOrcamentosQueGeraramPedido
FROM orcvenda o JOIN 
     pedidovendaorc p ON 
     o.dataCotacao = p.OrcVenda_dataCotacao AND o.Pessoa_idPessoa = p.OrcVenda_Pessoa_idPessoa;
     

-- Seleciona o nome, o número de registro e a quantidade de pedidos vendidos dos vendedores
-- que realizaram pelo menos 10 vendas. Os resultados são ordenados de forma decrescente 
-- pela quantidade de pedidos vendidos. Em caso de empate na quantidade de pedidos, 
-- a ordenação secundária é feita em ordem alfabética crescente pelo nome do vendedor.
SELECT nome AS nomeVendedor, numRegistro, COUNT(*) AS qtdPedidosVendidos
FROM pedidovenda pv JOIN
	 vendedor v ON
     pv.Vendedor_PessoaFisica_Pessoa_idPessoa = v.PessoaFisica_Pessoa_idPessoa JOIN
     pessoafisica pf ON
     v.PessoaFisica_Pessoa_idPessoa = pf.Pessoa_idPessoa
GROUP BY nome, numRegistro
HAVING qtdPedidosVendidos >= 10
ORDER BY qtdPedidosVendidos DESC, nomeVendedor;


-- Calcula o valor do ticket médio dos pedidos de venda
SELECT CONCAT('R$ ', ROUND(
    (
        (SELECT SUM(quantidade * preco) FROM compoevendasemorc) + 
        (SELECT SUM(precoCotado) FROM pedidovendaorc p JOIN orcvenda o ON p.OrcVenda_dataCotacao = o.dataCotacao AND p.OrcVenda_Pessoa_idPessoa = o.Pessoa_idPessoa)
    ) / COUNT(*), 2)) AS ValorTicketMedio
FROM pedidovenda;

-- Seleciona o nome, o número de registro e a quantidade de pedidos vendidos dos vendedores
-- usamos para conseguir verificar se exite para fazer a conexão com o php
SELECT user, host FROM mysql.user WHERE user = 'estudante';

-- Esta consulta recupera os nomes dos vendedores e seus números de telefone, combinando as 
-- tabelas Vendedor, PessoaFisica, e PessoaFone, e ordena os resultados alfabeticamente pelo 
-- nome do vendedor.
SELECT PessoaFisica.nome, PessoaFone.fone
FROM Vendedor
JOIN PessoaFisica ON Vendedor.PessoaFisica_Pessoa_idPessoa = PessoaFisica.Pessoa_idPessoa
JOIN PessoaFone ON PessoaFisica.Pessoa_idPessoa = PessoaFone.Pessoa_idPessoa
ORDER BY PessoaFisica.nome ASC;

--Esta consulta agrupa os produtos pelo tipo de material, calcula a quantidade total em estoque 
-- para cada material, e exibe apenas os materiais que têm mais de 5 unidades em estoque.
SELECT 
    Produto.material, 
    SUM(Produto.qtdeEstoque) AS total_estoque
FROM Produto
GROUP BY Produto.material
HAVING SUM(Produto.qtdeEstoque) > 5
ORDER BY total_estoque DESC;
-- Seleciona o número de telefone de cada Pessoa que é cliente e seu nome
SELECT PFIS.nome AS NomeCliente, PF.fone AS TelefoneCliente
FROM PessoaFisica PFIS JOIN PessoaFone PF
ON PFIS.Pessoa_idPessoa = PF.Pessoa_idPessoa; 

-- Seleciona e ordena os clientes que fizeram um Orçamento de venda e do que mais fez para o que menos fez
SELECT PF.nome AS NomeCliente, COUNT(OV.Pessoa_idPessoa) AS QuantidadeDeOrcamentos
FROM PessoaFisica PF JOIN OrcVenda OV
ON PF.Pessoa_idPessoa = OV.Pessoa_idPessoa
GROUP BY NomeCliente
ORDER BY QuantidadeDeOrcamentos DESC;

-- Seleciona os dados do Número de registro do vendedor, e a quantidade de pedidos de venda feitas por ele
SELECT V.numRegistro AS NumeroRegistro, COUNT(PV.Vendedor_PessoaFisica_Pessoa_idPessoa) AS NumeroPedidos
FROM Vendedor V JOIN PedidoVenda PV 
ON PV.Vendedor_PessoaFisica_Pessoa_idPessoa = V.PessoaFisica_Pessoa_idPessoa
GROUP BY V.numRegistro;
