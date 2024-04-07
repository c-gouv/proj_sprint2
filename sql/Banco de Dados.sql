CREATE DATABASE fitteya;
USE fitteya;

-- CRIAR UMA TABELA DE CADASTRO DE USUÁRIO/RESPONSÁVEL DA EMPRESA, ONDE 1 USUÁRIO PODE TER MAIS DE UMA EMPRESA
CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45),
    telefone CHAR(11)
);

-- COMPLEXO - CONJUNTO DE SILOS
CREATE TABLE complexo(
    idComplexo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    estado CHAR(2) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    fkUsuario INT,
    CONSTRAINT fkEmpresaUsuario FOREIGN KEY (fkUsuario) REFERENCES idUsuario(idUsuario)
);

INSERT INTO empresa
VALUES  (default, 'TrigoBrasil', 'contato@trigobrasil.com', '5512345678', 'email', 'João Silva', 'SP', 'São Paulo', 'Rua das Trigoiras', 123, null),
        (default, 'TrigoForte', 'info@trigoforte.com', '5543219876', 'telefone', 'Ana Oliveira', 'RS', 'Porto Alegre', 'Avenida do Trigo', 456, null),
        (default, 'GrãosPampas', 'sac@graospampas.com', '5588996655', 'email', 'Pedro Santos', 'RS', 'Caxias do Sul', 'Rua dos Grãos', 789, null),
        (default, 'MoinhoReal', 'atendimento@moinhoreal.com', '5577889900', 'telefone', 'Maria Fernandes', 'PR', 'Curitiba', 'Avenida do Moinho', 321, null);

CREATE TABLE contatoSite(
    idContatoSite INT PRIMARY KEY AUTO_INCREMENT,
    empresa VARCHAR(100),
    email VARCHAR(200) NOT NULL,
    assunto VARCHAR(100) NOT NULL,
    mensagem VARCHAR(500) NOT NULL
);

CREATE TABLE silo ( 
    idSilo INT PRIMARY KEY AUTO_INCREMENT,
    estado CHAR(2) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    fkComplexo INT,
    fkTipoTrigo INT,
    CONSTRAINT fkComplexoSilo FOREIGN KEY (fkComplexo) REFERENCES complexo(idComplexo),
    CONSTRAINT fkTrigoSilo FOREIGN KEY (fkTipoTrigo) REFERENCES tipoTrigo(idTipoTrigo)
);

INSERT INTO silo 
VALUES  (default, 'RS', 'Porto Alegre', 2),
        (default, 'RS', 'Caxias do Sul', 3),
        (default, 'SP', 'São Paulo', 1),    
        (default, 'PR', 'Curitiba', 4);    
        
CREATE TABLE tiposTrigo(
	idTipoTrigo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    temperaturaIdeal DECIMAL(4,2),
    humidadeIdeal DECIMAL(4,2)
);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    fkSilo INT,
    CONSTRAINT fkSensorSilo FOREIGN KEY (fkSilo) REFERENCES silo(idSilo)
);

INSERT INTO sensor 
VALUES  (default, 1),
        (default, 2),
        (default, 3),
        (default, 4),
        (default, 3),
        (default, 2);

CREATE TABLE monitoramento ( 
    idMonitoramento INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    humidade DECIMAL(4,2),
    data DATETIME,
    fkSensor INT,
    CONSTRAINT fkSensorMonitoramento FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor) 
);

INSERT INTO monitoramento
VALUES  (default, 14.23, 10.00,'2024-03-21 13:30:00', 1),
        (default, 20.24, 12.00,'2024-03-20 10:45:00', 2),
        (default, 25.25, 25.00,'2024-03-19 14:00:30', 3),
        (default, 18.20, 13.00,'2024-03-18 12:00:00', 4),
        (default, 13.12, 10.00,'2024-03-17 11:45:30', 5),
        (default, 16.02, 9.0,'2024-03-16 10:20;50', 6);
        

SELECT nome FROM complexo;

SELECT estado, cidade FROM silo;

SELECT silo.idSilo, complexo.nome, temperatura, humidade FROM monitoramento
JOIN sensor ON sensor.idSensor = monitoramento.fkSensor
JOIN silo ON sensor.fkSilo = silo.idSilo
JOIN complexo ON complexo.fkSilo = complexo.idComplexo;
