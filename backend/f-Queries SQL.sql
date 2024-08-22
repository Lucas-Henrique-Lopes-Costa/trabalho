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
FROM pedidovenda pv JOIN -- INNER JOIN PORQUE NÃO FAZ SENTIDO PEGAR VALORES QUE NÃO TENHAM CORRESPONDENCIAS NAS OUTRAS TABELAS
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

-- usamos para conseguir verificar se exite para fazer a conexão com o php
SELECT user, host FROM mysql.user;

-- Esta consulta recupera os nomes dos vendedores e seus números de telefone, combinando as 
-- tabelas Vendedor, PessoaFisica, e PessoaFone, e ordena os resultados alfabeticamente pelo 
-- nome do vendedor.
SELECT PessoaFisica.nome, PessoaFone.fone
FROM Vendedor
JOIN PessoaFisica ON Vendedor.PessoaFisica_Pessoa_idPessoa = PessoaFisica.Pessoa_idPessoa
JOIN PessoaFone ON PessoaFisica.Pessoa_idPessoa = PessoaFone.Pessoa_idPessoa
ORDER BY PessoaFisica.nome ASC;

-- Esta consulta agrupa os produtos pelo tipo de material, calcula a quantidade total em estoque 
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

-- seleciona a quantidade de clientes que vieram por cada anuncio - GROUP BY + count
SELECT idAnuncio, COUNT(PessoaFisica_Pessoa_idPessoa) AS quantidadeClientes
FROM `Lead` -- USA A CRASE PORQUE ELA É PALAVRA RESERVADO
GROUP BY idAnuncio;

-- selecionar todos os clientes que se cadastraram entre duas datas específicas - BETWEEN
SELECT PessoaFisica_Pessoa_idPessoa, idAnuncio, dataCadastro
FROM `Lead`
WHERE dataCadastro BETWEEN '2024-01-01' AND '2024-06-30';

-- agrupa por preço médio das marcas
SELECT marca, ROUND(AVG(precoVenda), 2) AS precoMedio
FROM Produto
WHERE marca LIKE '%A' OR marca LIKE '%B' OR marca LIKE '%C' -- TERMINA COM %
GROUP BY marca;

-- seleciona todos os orcamentos de compra que estão com a situação atrasada, e mostra quantos dias de atraso
SELECT o.PedidoCompra_Pedido_id, o.dataCotacao, o.dataValidade, DATEDIFF(CURDATE(), o.dataValidade) AS diasVencimento
FROM orccompra o
WHERE o.dataValidade < CURDATE()
ORDER BY diasVencimento ASC;

-- seleciona todos os clientes com numeros de telefone pertencentes a cidade de São Paulo
SELECT PFIS.nome AS NomeCliente, PF.fone AS TelefoneCliente
FROM pessoa P 
JOIN pessoaFisica PFIS ON P.idPessoa = PFIS.Pessoa_idPessoa
JOIN PessoaFone PF ON PFIS.Pessoa_idPessoa = PF.Pessoa_idPessoa
WHERE P.ehCliente = 1
AND PF.fone LIKE '%+5511%';

-- seleciona o nome, código e descrição dos produtos com descrição menor que 15 caracteres
SELECT codProd, nome, descricao
FROM produto
WHERE LENGTH(descricao) < 15;

-- Seleciona os vendedores que fizeram pelo menos uma venda.
SELECT nome 
FROM
	vendedor v JOIN
    pessoafisica p ON
    v.PessoaFisica_Pessoa_idPessoa = p.Pessoa_idPessoa
WHERE PessoaFisica_Pessoa_idPessoa IN (
    SELECT Vendedor_PessoaFisica_Pessoa_idPessoa 
    FROM pedidovenda
); -- DARIA PARA FAZER DE UMA FORMMA MAIS SIMPLES, MAS O USO DO IN É PARA COMPRIR REQUISITO, poderiamos fazer um JOIN com pedido venda com idPessoa

-- Seleciona os orçamentos de venda que venceram a mais de 2 meses e não geraram pedido de venda
SELECT dataCotacao, Pessoa_idPessoa, dataValidade, prazoEntrega, precoCotado
FROM orcvenda ov LEFT OUTER JOIN PedidoVendaOrc pvo -- OUTER JOIN PARA PEGAR OS NULOS
	 ON ov.Pessoa_idPessoa = pvo.OrcVenda_Pessoa_idPessoa
	 AND ov.dataCotacao = pvo.OrcVenda_dataCotacao
WHERE pvo.PedidoVenda_Pedido_id IS NULL -- SELECIONA OS NULOS
AND ov.dataValidade < DATE_SUB(CURDATE(), INTERVAL 2 MONTH);

-- Seleciona o nome de todas as pessoas físicas e jurídicas cadastradas
SELECT nome FROM PessoaFisica
UNION
SELECT nomeFantasia AS nome FROM PessoaJuridica;

-- Seleciona os orçamentos de compra que geraram pedido de compra 
SELECT *
FROM OrcCompra
WHERE PedidoCompra_Pedido_id IS NOT NULL;

-- Recupera os IDs dos pedidos de venda sem orçamento onde todos os itens vendidos têm preço superior a R$100
SELECT DISTINCT PedidoVenda_Pedido_id -- DISTINCT PORQUE ELE NÃO PEGA REPETIDO
FROM CompoeVendaSemOrc cv1
WHERE 100 < ALL (
                  SELECT cv2.preco 
                  FROM CompoeVendaSemOrc cv2 
                  WHERE cv1.PedidoVenda_Pedido_id = cv2.PedidoVenda_Pedido_id
                ) -- PARA CADA TUPLA VAI GERAR UMA TABELA E TODOS TEM QUE SER MAIOR, INEFICIENTE PORQUE PARA CADA LINHA FAZ UM SELECT DIFERENTE
ORDER BY PedidoVenda_Pedido_id;

-- Recupera os IDs dos pedidos de venda sem orçamento onde pelo menos um item possui o valor superior a R$200
SELECT DISTINCT PedidoVenda_Pedido_id 
FROM CompoeVendaSemOrc cv1
WHERE 200 < ANY (
                  SELECT cv2.preco 
                  FROM CompoeVendaSemOrc cv2 
                  WHERE cv1.PedidoVenda_Pedido_id = cv2.PedidoVenda_Pedido_id
                ) -- ANY PEGA SE UMA CONDIÇÃO JÁ FOR SUPRIDA
ORDER BY PedidoVenda_Pedido_id;
                  
-- Recupera o nome das pessoas físicas que têm pelo menos um orçamento registrado.
-- O SELECT 1 é usado com EXISTS para verificar se a subconsulta retorna alguma linha, sem se preocupar com os dados específicos.
SELECT nome FROM PessoaFisica pf
WHERE EXISTS (SELECT 1 FROM OrcVenda o WHERE o.Pessoa_idPessoa = pf.Pessoa_idPessoa); -- O SELECT 1 É PEGAR A PRIMEIRA LINHA DA CONSULTA E O EXISTS SELECIONA O VERDADEIRO
