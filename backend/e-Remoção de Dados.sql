-- Remove os telefones associados a pessoa de nome "Rafael Lima"
DELETE FROM pessoafone
WHERE Pessoa_idPessoa IN (
    SELECT pf.Pessoa_idPessoa
    FROM pessoafisica pf JOIN
         pessoa p ON
		 pf.Pessoa_idPessoa = p.idPessoa
    WHERE pf.nome = 'Rafael Lima'
);


-- Remove orçamentos de compra que já venceram a mais de 6 meses e não geraram pedido de compra
DELETE FROM orccompra
WHERE PedidoCompra_Pedido_id IS NULL
AND dataValidade < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- Remove os leads que não viraram clientes
DELETE FROM `Lead`
WHERE PessoaFisica_Pessoa_idPessoa IN (
    SELECT l.PessoaFisica_Pessoa_idPessoa
    FROM `Lead` l
    JOIN pessoafisica pf ON l.PessoaFisica_Pessoa_idPessoa = pf.Pessoa_idPessoa
    JOIN pessoa p ON pf.Pessoa_idPessoa = p.idPessoa
    WHERE p.ehCliente = false
);

-- Remove os enderços empresa de CNPJ "45678901000102"
DELETE FROM pessoaendereco
WHERE Pessoa_idPessoa IN (
    SELECT p.idPessoa
    FROM pessoa p JOIN pessoajuridica pj
		 ON p.idPessoa = pj.Pessoa_idPessoa
    WHERE pj.cnpj = '45678901000102'
);


-- Remove os orçamentos de venda que venceram a mais de 2 meses e não geraram pedido de venda
DELETE FROM orcvenda
WHERE (Pessoa_idPessoa, dataCotacao) IN (
    SELECT ov.Pessoa_idPessoa, ov.dataCotacao
    FROM orcvenda ov
    LEFT JOIN PedidoVendaOrc pvo
        ON ov.Pessoa_idPessoa = pvo.OrcVenda_Pessoa_idPessoa
        AND ov.dataCotacao = pvo.OrcVenda_dataCotacao
    WHERE pvo.PedidoVenda_Pedido_id IS NULL
    AND ov.dataValidade < DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
);