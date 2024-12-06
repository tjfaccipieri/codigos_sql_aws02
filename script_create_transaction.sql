-- COMANDOS PARA EXIBIR OS DATABASES EXISTENTES --
SHOW DATABASES;
SHOW SCHEMAS;

-- CRIAR O SCHEMA/DATABASE --
CREATE SCHEMA aula_sql;

-- INFORMAR QUAL DATABASE SERÁ USADO --
USE aula_sql;

-- criar a tabela --
CREATE TABLE tb_turmas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(10) UNIQUE NOT NULL
);

-- mostrar todas as tabelas do banco em uso --
SHOW TABLES;

-- mostrar as colunas de uma tabela em especifico --
DESCRIBE tb_turmas;
SHOW COLUMNS FROM aula_sql.tb_turmas;

-- criar a tabela de alunos --
CREATE TABLE IF NOT EXISTS tb_alunos(
	id INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    sobrenome VARCHAR(20) NOT NULL,
    idade INT,
    notaFinal DECIMAL(3,1),
    cidade VARCHAR(30) DEFAULT 'São Paulo',
    inicio DATE,
    turma INT,
    FOREIGN KEY(turma) REFERENCES tb_turmas(id)
);

-- exibir as colunas da tabela --
DESCRIBE tb_alunos;

-- mostrar todos os dados da tabela, o que tbm mostra as colunas, mas sem as especificações --
select * from tb_alunos;

-- trabalhar com TRANSACTIONS, para acso precise, possa dar um rollback nas operações, e não danificar ou alterar os dados --
-- essa primeira transaction deu certo, então finalizamos ela com COMMIT --
START TRANSACTION;
UPDATE tb_alunos SET turma = 2 WHERE id = 11;
SELECT * FROM tb_alunos;
COMMIT;

-- essa segunda transaction deu erro, então finalizamos com ROLLBACK, desfazendo os dados --
START TRANSACTION;
UPDATE tb_alunos SET turma = 2 WHERE id > 11;
SELECT * FROM tb_alunos;
ROLLBACK;