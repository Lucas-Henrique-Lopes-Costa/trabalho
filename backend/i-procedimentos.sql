-- Procedimento Para Verificar Estoque
DELIMITER //
CREATE PROCEDURE VerificarEstoque(
    IN p_codProd INT,
    IN p_quantidade INT,
    OUT p_disponivel BOOLEAN
)
BEGIN
    DECLARE v_qtdeEstoque INT;

    SELECT qtdeEstoque INTO v_qtdeEstoque
    FROM Produto
    WHERE codProd = p_codProd;

    IF v_qtdeEstoque >= p_quantidade THEN
        SET p_disponivel = TRUE;
    ELSE
        SET p_disponivel = FALSE;
    END IF;
END //
DELIMITER ;

-- Função Para Calcular Valor Total do Pedido
DELIMITER //
CREATE FUNCTION CalcularValorTotalPedido(p_Pedido_id INT) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE v_valorTotal FLOAT;

    SELECT SUM(preco * quantidade) INTO v_valorTotal
    FROM CompoeVendaSemOrc
    WHERE PedidoVenda_Pedido_id = p_Pedido_id;

    RETURN IFNULL(v_valorTotal, 0);
END //
DELIMITER ;

-- Procedimento Para Atualizar a Situação do Pedido
DELIMITER //
CREATE PROCEDURE AtualizarSituacaoPedido()
BEGIN
    DECLARE v_idPedido INT;
    DECLARE v_dataAtual DATE;
    DECLARE v_situacao CHAR(12);

    SET v_dataAtual = CURDATE();

    DECLARE cursorPedidos CURSOR FOR 
    SELECT id, situacao
    FROM Pedido
    WHERE situacao = 'Em Processamento';

    OPEN cursorPedidos;
    read_loop: LOOP
        FETCH cursorPedidos INTO v_idPedido, v_situacao;

        IF v_situacao = 'Em Processamento' THEN
            UPDATE Pedido
            SET situacao = CASE 
                WHEN v_dataAtual > dataPedido + INTERVAL 7 DAY THEN 'Atrasado'
                ELSE 'Em Processamento'
            END
            WHERE id = v_idPedido;
        END IF;

        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cursorPedidos;
END //
DELIMITER ;