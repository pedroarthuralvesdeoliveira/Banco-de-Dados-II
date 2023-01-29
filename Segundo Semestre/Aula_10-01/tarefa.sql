CREATE TABLE Ambulatorios (
    nroa INT NOT NULL,
    andar FLOAT NOT NULL,
    capacidade INT,
    PRIMARY KEY (nroa)
);

CREATE TABLE Medicos (
    codm INT NOT NULL,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    especialidade CHAR(20),
    cpf NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    nroa INT,
    PRIMARY KEY (codm),
    FOREIGN KEY (nroa)
        REFERENCES Ambulatorios (nroa)
);

CREATE TABLE Pacientes (
    codp INT NOT NULL,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cidade VARCHAR(30),
    cpf NUMERIC(11) UNIQUE,
    doenca VARCHAR(40) NOT NULL,
    PRIMARY KEY (codp)
);

CREATE TABLE Funcionarios (
    codf INT NOT NULL,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cpf NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    salario FLOAT,
    cargo VARCHAR(20),
    PRIMARY KEY (codf)
);

CREATE TABLE Consultas (
    codm INT NOT NULL,
    codp INT NOT NULL,
    data DATE,
    hora TIME,
    PRIMARY KEY (codm, codp, data, hora),
    FOREIGN KEY (codm)
        REFERENCES Medicos (codm),
    FOREIGN KEY (codp)
        REFERENCES Pacientes (codp)
);

ALTER TABLE 
	Funcionarios 
ADD 
	nroa INT; 
    
ALTER TABLE 
	Funcionarios 
ADD foreign key 
	(nroa)
        REFERENCES Ambulatorios (nroa);
        
CREATE INDEX 
	nroa
ON 
	Medicos (nroa);
    
CREATE INDEX 
	doenca
ON 
	Pacientes (doenca);
    
ALTER TABLE
	Pacientes
DROP INDEX 
	doenca;
    
ALTER TABLE
	Funcionarios
DROP COLUMN  
	cargo;
    
ALTER TABLE 
	Funcionarios
DROP FOREIGN KEY 
	funcionarios_ibfk_1;
    
ALTER TABLE
	Funcionarios
DROP COLUMN  
	nroa;
    
INSERT INTO 
	Ambulatorios (nroa, andar, capacidade) 
VALUES 
	(1, 1, 30), 
    (2, 1, 50), 
    (3, 2, 40), 
    (4, 2, 25), 
    (5, 2, 55);
    
INSERT INTO 
	Medicos (codm, nome, idade, especialidade, cpf, cidade, nroa)
VALUES
	(1, 'Joao', 40, 'ortopedia', 10000100000, 'Florianopolis', 1),
    (2, 'Maria', 42, 'traumatologia', 10000110000, 'Blumenau', 2),
    (3, 'Pedro', 51, 'pediatria', 11000100000, 'São Jose', 2),
    (4, 'Carlos', 28, 'ortopedia', 11000110000, 'Joinville', null),
	(5, 'Marcia', 33, 'neurologia', 11000111000, 'Biguacu', 3);
    
INSERT INTO 
	Pacientes (codp, nome, idade, cidade, cpf, doenca)
VALUES
	(1, 'Ana', 20, 'Florianopolis', 20000200000, 'gripe'),
    (2, 'Paulo', 24, 'Palhoca', 20000220000, 'fratura'),
    (3, 'Lucia', 30, 'Biguacu', 22000200000, 'tendinite'),
    (4, 'Carlos', 28, 'Joinville', 11000110000, 'sarampo');
    
    
INSERT INTO
	Funcionarios (codf, nome, idade, cidade, salario, cpf)
VALUES
	(1, 'Rita', 32, 'Sao Jose', 1200, 20000100000),
    (2, 'Maria', 55, 'Palhoca', 1220, 30000110000),
    (3, 'Caio', 44, 'Florianopolise', 1100, 41000100000),
    (4, 'Carlos', 44, 'Florianopolis', 1200, 51000100000),
	(5, 'Paula', 33, 'Florianopolis', 2500, 61000111000);
    
INSERT INTO 
	Consultas (codm, codp, data, hora)
VALUES
	(1, 1, '2006-06-12', '14:00'),
    (1, 4, '2006-06-13', '10:00'),
    (2, 1, '2006-06-13', '09:00'),
    (2, 2, '2006-06-13', '11:00'),
    (2, 3, '2006-06-14', '14:00'),
    (2, 4, '2006-06-14', '17:00'),
    (3, 1, '2006-06-19', '18:00'),
    (3, 3, '2006-06-12', '10:00'),
    (3, 4, '2006-06-19', '13:00'),
    (4, 4, '2006-06-20', '13:00'),
	(4, 4, '2006-06-22', '19:30');
     
UPDATE Pacientes 
SET 
    cidade = 'Ilhota'
WHERE
    codp = 2;
    
UPDATE Consultas
SET 
	data = '2006-07-04', hora = '12:00'
WHERE
	codp = 4 AND codm = 1;
    
UPDATE Pacientes 
SET 
    doenca = 'cancer', idade = 21
WHERE
    codp = 1;

UPDATE Consultas
SET 
	hora = '14:30'
WHERE
	codp = 4 AND codm = 3;

DELETE FROM Funcionarios 
WHERE
    codf = 4;

DELETE FROM Consultas
WHERE
	hora > '19';
    
DELETE FROM Pacientes
WHERE 
	doenca = 'cancer' OR idade < 10;
    
DELETE FROM Medicos
WHERE 
	cidade = 'Biguacu' AND cidade = 'Palhoca';
    
SELECT 
	codp, nome
FROM 
	Pacientes
WHERE idade > 25 AND doenca IN ('tendinite', 'fratura', 'gripe', 'sarampo');

SELECT 
	MAX(salario) AS MaiorSalario,
    MIN(salario) AS MenorSalario
FROM Funcionarios;

SELECT 
    AVG(salario) AS MediaSalarial
FROM
    Funcionarios;
    
SELECT
	SUM(salario) AS CustoTotalPagamento
FROM 
	Funcionarios;
    
SELECT 
    AVG(Medicos.idade) AS MediaIdade,
    COUNT(DISTINCT Ambulatorios.nroa) AS TotalAmbulatorios
FROM
    Ambulatorios
        INNER JOIN
    Medicos ON Medicos.nroa = Medicos.nroa;

SELECT 
    Medicos.nome, Medicos.cpf
FROM
    Medicos 
INNER JOIN
    Pacientes
		ON Medicos.cpf = Pacientes.cpf;
        
