-- Atualiza o endereço do vendedor com o número de registro "1001" para
-- Av. Dr. Silvio Menicuci, 2440 (Apto 403) - Vila Ester, Lavras - MG, 37200-000
UPDATE pessoaendereco pe
SET pe.numero = '2440',
    pe.logadouro = 'Av. Dr. Silvio Menicuci',
    pe.complemento = 'Apto 403',
    pe.bairro = 'Vila Ester',
    pe.cidade = 'Lavras',
    pe.cep = '37200000',
    pe.estado = 'MG'
WHERE pe.Pessoa_idPessoa = (
    SELECT p.idPessoa
    FROM pessoa p JOIN
		 pessoafisica pf ON
         pf.Pessoa_idPessoa = p.idPessoa 
         JOIN vendedor v ON
         v.PessoaFisica_Pessoa_idPessoa = pf.Pessoa_idPessoa
    WHERE v.numRegistro = 1001
);


-- Atualiza o preço cotado para 4000 no orçamento de compra com a data de cotação
-- de 2024-01-05 e idPessoa igual a 11 e aumenta sua data de validade em 10 dias.
UPDATE orcCompra
SET precoCotado = 4000,
    dataValidade = DATE_ADD(dataValidade, INTERVAL 10 DAY)
WHERE dataCotacao = '2024-01-05' AND PessoaJuridica_Pessoa_idPessoa = 11;


-- Atualiza o valor booleano `transportadora` para 1, indicando que a
-- empresa de nome "Empresa G" faz serviços de transportadora.
UPDATE pessoajuridica
SET transportadora = 1
WHERE razaoSocial = 'Empresa G';


-- Aumenta em 10% o valor de venda de todos os produtos da Marca B.
UPDATE produto
SET precoVenda = precoVenda * 1.10
WHERE marca = 'Marca B';


-- Aumenta a quantidade do produto com a descrição "Shorts jeans" em 4
-- unidades e reduz seu preco em 5% para o pedido de venda com o código
-- 31 na tabela compoevendasemorc.
UPDATE compoevendasemorc cv
SET cv.quantidade = cv.quantidade + 4,
    cv.preco = cv.preco * 0.95
WHERE cv.PedidoVenda_Pedido_id = 31
  AND cv.Produto_codProd = (
      SELECT p.codProd
      FROM produto p
      WHERE p.descricao = 'Shorts jeans'
  );
