INSERT INTO pessoa (cpf, rg, telefone) VALUES('45677736325', '479156116', '45991035957');

ALTER TABLE pessoa ADD nome varchar(255) NOT NULL;

UPDATE pessoa 
SET 
    nome = 'Pedro Arthur'
WHERE
    id = 1;

INSERT INTO pessoa (cpf, rg, telefone, nome) VALUES ('50849835011', '337524002', '41637066816', 'Xedyu'), ('77338151261', '442233085', '41632816896', 'Ersail'); 


SELECT * FROM pessoa;

INSERT INTO Funcionario (cargo, codigo, fk_Pessoa_id) VALUES ('lavador', '12345', 1), ('lavador', '54321', 2);

INSERT INTO dono_do_veiculo (fk_Pessoa_id) VALUES (3);

INSERT INTO Veiculo (placa, chassi, fk_Dono_do_veiculo_fk_Pessoa_id) VALUES ('PIA2A19', '9bwhe21j024060831', 3);

SELECT * FROM Funcionario;

ALTER TABLE lavagem CHANGE data data timestamp;

INSERT INTO lavagem (fk_Funcionario_codigo, fk_Funcionario_fk_Pessoa_id, fk_Veiculo_chassi, data) VALUES (12345, 1, '9bwhe21j024060831', current_timestamp());

RENAME TABLE lavagem TO lavagens;

SELECT * FROM lavagens;

CREATE UNIQUE INDEX telefone ON Pessoa (telefone);

ALTER TABLE Pessoa
ADD UNIQUE (cpf);

ALTER TABLE Pessoa
DROP INDEX telefone;

ALTER TABLE lavagens ADD PRIMARY KEY (fk_Funcionario_codigo, fk_Funcionario_fk_Pessoa_id, fk_Veiculo_chassi, data);