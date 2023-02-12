CREATE TABLE Pessoa (
    cpf VARCHAR (11),
    rg VARCHAR(9),
    telefone varchar(11),
    id INT NOT NULL auto_increment,
    PRIMARY KEY (id)
);

CREATE TABLE Funcionario (
    cargo VARCHAR(255),
    codigo VARCHAR(50),
    fk_Pessoa_id INT NOT NULL,
    PRIMARY KEY (codigo, fk_Pessoa_id)
);

CREATE TABLE Dono_do_veiculo (
    fk_Pessoa_id INT NOT NULL PRIMARY KEY
);

CREATE TABLE Veiculo (
    placa VARCHAR (7),
    chassi VARCHAR(17),
    fk_Dono_do_veiculo_fk_Pessoa_id INT NOT NULL,
    PRIMARY KEY (chassi)
);

CREATE TABLE Lavagem (
    fk_Funcionario_codigo VARCHAR(50),
    fk_Funcionario_fk_Pessoa_id INT,
    fk_Veiculo_chassi VARCHAR(17),
    data DATE NOT NULL
);
 
ALTER TABLE Funcionario ADD CONSTRAINT FK_Funcionario
    FOREIGN KEY (fk_Pessoa_id)
    REFERENCES Pessoa (id)
    ON DELETE CASCADE;
 
ALTER TABLE Dono_do_veiculo ADD CONSTRAINT FK_Dono_do_veiculo
    FOREIGN KEY (fk_Pessoa_id)
    REFERENCES Pessoa (id)
    ON DELETE CASCADE;
 
ALTER TABLE Veiculo ADD CONSTRAINT FK_Veiculo
    FOREIGN KEY (fk_Dono_do_veiculo_fk_Pessoa_id)
    REFERENCES Dono_do_veiculo (fk_Pessoa_id)
    ON DELETE RESTRICT;
 
ALTER TABLE Lavagem ADD CONSTRAINT FK_Lavagem_Funcionario
    FOREIGN KEY (fk_Funcionario_codigo, fk_Funcionario_fk_Pessoa_id)
    REFERENCES Funcionario (codigo, fk_Pessoa_id)
    ON DELETE RESTRICT;
 
ALTER TABLE Lavagem ADD CONSTRAINT FK_Lavagem_Chassi_Veiculo
    FOREIGN KEY (fk_Veiculo_chassi)
    REFERENCES Veiculo (chassi)
    ON DELETE RESTRICT;