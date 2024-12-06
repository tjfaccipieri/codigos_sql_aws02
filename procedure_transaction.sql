-- criar uma procedure(função) para transferir alunos de uma turma para outra --
CREATE PROCEDURE transferir_alunos()
-- Início da procedure --
BEGIN
    -- Declaração de variáveis --
    DECLARE qtd_alunos INT;
    
    -- Início da transação --
    START TRANSACTION;
        -- Cria nova turma
        INSERT INTO turmas (codigo) VALUES ('T2024-4A');
        
        -- Pega o ID da nova turma
        SET @nova_turma = LAST_INSERT_ID();
        
        -- Move alunos específicos para nova turma
        UPDATE alunos SET turma = @nova_turma 
        WHERE id IN (1, 2, 3);
        
        -- Verifica quantidade de alunos
        SELECT COUNT(*) INTO qtd_alunos 
        FROM alunos 
        WHERE turma = @nova_turma;
        
        -- Verifica se a quantidade de alunos é menor que 3 --
        IF qtd_alunos < 3 THEN
        -- Se a quantidade for menor que 3, desfaz as alterações --
            ROLLBACK;
        ELSE
        -- Se a quantidade for maior ou igual a 3, confirma as alterações --
            COMMIT;
        END IF;
END //
-- Fim da procedure --
DELIMITER ;

-- Para executar:
CALL transferir_alunos();