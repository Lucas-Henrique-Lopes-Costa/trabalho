/* 1- Gatilho que impede que um determinado produto seja deletado se houver pelo menos 1 produto em estoque remanescete. - DELETE*/
DROP TRIGGER before_produto_delete;

DELIMITER $$
CREATE TRIGGER  before_produto_delete
    BEFORE DELETE ON Produto
    FOR EACH ROW
BEGIN
    IF OLD.quantidade > 0 THEN
    SIGNAL SQLESTATE '45000'
    SET MESSAGE_TEXT = 'Não é possível deletar o produto porque ainda há itens em estoque.';
    END IF;
END $$
DELIMITER ;

--INSERT INTO Produto (codProd, descricao, precoVenda, qtdeEstoque, marca, nome, material, cor) VALUES
--(33, 'Jaqueta-UFLA', 270.80, 1, 'Marca X', 'Jaqueta', 'Titânio', 'Azul'); /* Insere um exemplo */

--Exemplo 1:

--SELECT * FROM Produto; /*Exemplifica quais produtos estão no estoque */

--DELETE FROM Produto WHERE codProd = 33; /* Tenta deletar um produto com um item ainda remanescente */

--UPDATE Produto SET qtdeEstoque = 0 WHERE codProd = 33; /* Atualiza a quantidade do produto para 0, como se tivesse ocorrido a ultima venda*/

--DELETE FROM Produto WHERE codProd = 33; /* Deleta o produto caso a loja não queira mais trabalhar com ele */

--SELECT * FROM Produto; /*Exemplifica quais produtos estão no estoque */


/* 2- Gatilho que impede que um determinado preço de produto seja definido com valor nulo ou negativo - INSERT */
DROP TRIGGER IF EXISTS before_precoProduto_insert;

DELIMITER $$
CREATE TRIGGER before_precoProduto_insert
    BEFORE INSERT ON Produto
    FOR EACH ROW
BEGIN
    IF NEW.preco <= 0 THEN
    SIGNAL SQLESTATE '45000'
    SET MESSAGE_TEXT = 'O preço definido para esse produto não é válido! Por favor, digite um preço para esse produto e insira novamente.';
    END IF;
END $$
DELIMITER ;

--Exemplo 2:

--SELECT * FROM Produto;

--INSERT INTO Produto (codProd, descricao, precoVenda, qtdeEstoque, marca, nome, material, cor) VALUES
--(33, 'Jaqueta-UFLA', 0.00 , 1, 'Marca X', 'Jaqueta', 'Titânio', 'Azul'); /* Insere um exemplo com erro */

--SELECT * FROM Produto;

--INSERT INTO Produto (codProd, descricao, precoVenda, qtdeEstoque, marca, nome, material, cor) VALUES
--(33, 'Jaqueta-UFLA', 217.90 , 1, 'Marca X', 'Jaqueta', 'Titânio', 'Azul'); /* Insere um exemplo corretamente*/

--SELECT * FROM Produto WHERE codProd = 33;

/* 3- Gatilho que controla automaticamente o estoque baixo de um determinado produto. Além disso, salva cada alteração feita
na quantidade de produtos, como o vendedor e o horário da venda - UPDATE*/
-- Criação da tabela de histórico, se ainda não existir

CREATE TABLE IF NOT EXISTS HISTORICO_ESTOQUE (
    idHist INT AUTO_INCREMENT PRIMARY KEY,
    idProduto INT,
    qtdeAntiga INT,
    qtdeNova INT,
    dataAlteracao DATETIME,
    usuarioAlteracao VARCHAR(60),
    observacao VARCHAR(30),
    FOREIGN KEY (idProduto) REFERENCES Produto(codProd)
);

DELIMITER $$

CREATE TRIGGER before_produto_update
BEFORE UPDATE ON Produto
FOR EACH ROW
BEGIN
    DECLARE observacao_texto VARCHAR(255);
    
    -- Verifica se o estoque está baixo
    IF NEW.qtdeEstoque < 10 THEN
        SET observacao_texto = 'Estoque baixo';
    ELSE
        SET observacao_texto = NULL;
    END IF;
    
    -- Insere o histórico da alteração do estoque na tabela de histórico
    INSERT INTO HISTORICO_ESTOQUE (idProduto, qtdeAntiga, qtdeNova, dataAlteracao, usuarioAlteracao, observacao)
    VALUES (OLD.codProd, OLD.qtdeEstoque, NEW.qtdeEstoque, NOW(), USER(), observacao_texto);
END $$

DELIMITER ;

--Exemplo 3:

-- SELECT * FROM PRODUTO;

-- UPDATE Produto SET qtdeEstoque = 5 WHERE codProd = 1;

-- SELECT * FROM HISTORICO_ESTOQUE;
