-- (b)
-- Adiciona campo CNPJ na tabela de Leads. Faz sentido, pois um Lead pode ser uma empresa
-- Se inicia com valor nulo, já que há leads que não tem CNPJ
ALTER TABLE `Lead` ADD COLUMN cnpj CHAR(14) NULL;

-- Remove a coluna de data de validade da tabela OrcVenda se não houverem restrições.
ALTER TABLE OrcVenda DROP COLUMN dataValidade RESTRICT;

-- Adiciona um valor default de '11111111111' nos cpfs da tabela PessoaFisica
ALTER TABLE PessoaFisica ALTER COLUMN cpf SET DEFAULT '11111111111';

-- Exemplo de exclusão de tabela
-- Cria tabela de Leads com CNPJ
CREATE TABLE LeadCNPJ (
    PessoaJuridica_Pessoa_idPessoa INT NOT NULL,
    plataformaOrigem INT NOT NULL,
    idAnuncio INT NOT NULL UNIQUE,
    dataCadastro DATE NOT NULL,
    PRIMARY KEY (PessoaJuridica_Pessoa_idPessoa),
    CONSTRAINT fk_Pessoa_PessoaJuridica10
		FOREIGN KEY (PessoaJuridica_Pessoa_idPessoa)
        REFERENCES PessoaJuridica (Pessoa_idPessoa)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Deleta a tabela e tudo que a referencia
DROP TABLE LeadCNPJ CASCADE;