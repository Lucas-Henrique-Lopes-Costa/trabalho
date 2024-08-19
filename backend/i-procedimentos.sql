-- PROCEDIMENTO 1
-- Procedimento Para Verificar se o estoque de um produto específico é suficiente para atender a um pedido (quantidade)
DELIMITER //
CREATE PROCEDURE VerificarEstoque(
    IN p_codProd INT,
    IN p_quantidade INT,
    OUT p_disponivel CHAR(1)
)
BEGIN
    DECLARE v_qtdeEstoque INT;

    SELECT qtdeEstoque INTO v_qtdeEstoque
    FROM Produto
    WHERE codProd = p_codProd;

    IF v_qtdeEstoque >= p_quantidade THEN
        SET p_disponivel = 'S';
    ELSE
        SET p_disponivel = 'N';
    END IF;
END //

DELIMITER ;

-- Para teste do procedimento
-- SELECT * 
-- FROM produto;

CALL VerificarEstoque(1, 51, @disponivel);
SELECT @disponivel;






-- PROCEDIMENTO 2
-- Este procedimento aplica um desconto a um produto com base na quantidade disponível em estoque. 
-- Se a quantidade for baixa, um desconto menor é aplicado; caso contrário, o desconto é maior.
DELIMITER //

CREATE PROCEDURE AtualizarPrecoComDesconto(
    IN p_codProd INT,
    IN p_descontoBaixoEstoque FLOAT,
    IN p_descontoAltoEstoque FLOAT
)
BEGIN
    DECLARE v_qtdeEstoque INT;

    SELECT qtdeEstoque INTO v_qtdeEstoque
    FROM Produto
    WHERE codProd = p_codProd;

    UPDATE Produto
    SET precoVenda = precoVenda * (1 - CASE 
                                        WHEN v_qtdeEstoque < 20 THEN p_descontoBaixoEstoque
                                        ELSE p_descontoAltoEstoque
                                      END)
    WHERE codProd = p_codProd;
END //

DELIMITER ;


CALL AtualizarPrecoComDesconto(
    5,       -- Código do produto
    0.10,    -- Desconto de 10% para baixo estoque
    0.20     -- Desconto de 20% para alto estoque
);

select *
FROM produto;








-- PROCEDIMENTO 3
-- Este procedimento percorre todos os pedidos que estão "processando" e atualiza o status para "Atrasado" se o prazo de entrega tiver expirado.
DELIMITER //

CREATE PROCEDURE VerificarPedidosAtrasados()
BEGIN
    DECLARE v_idPedido INT;
    DECLARE v_dataPedido DATE;
    DECLARE done INT DEFAULT 0;

    DECLARE cursorPedidos CURSOR FOR
    SELECT id, dataPedido
    FROM Pedido
    WHERE situacao = 'processando';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cursorPedidos;

    read_loop: LOOP
        FETCH cursorPedidos INTO v_idPedido, v_dataPedido;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF CURDATE() > DATE_ADD(v_dataPedido, INTERVAL 7 DAY) THEN
            UPDATE Pedido
            SET situacao = 'atrasado'
            WHERE id = v_idPedido;
        END IF;
    END LOOP;

    CLOSE cursorPedidos;
END //

DELIMITER ;

-- Para teste do Procedimento
-- SELECT * 
-- FROM pedido;

CALL VerificarPedidosAtrasados();
