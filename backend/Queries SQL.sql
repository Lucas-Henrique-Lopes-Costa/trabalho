use bd_trabalho;

SHOW DATABASES;

SELECT user, host FROM mysql.user WHERE user = 'lucas';

CREATE USER 'lucas'@'localhost' IDENTIFIED BY '2022#estudante';
GRANT ALL PRIVILEGES ON BD_Trabalho.* TO 'lucas'@'localhost';
FLUSH PRIVILEGES;

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