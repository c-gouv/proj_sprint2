CREATE DATABASE fitteya;
USE fitteya;

-- CRIAR UMA TABELA DE CADASTRO DE USUÁRIO/RESPONSÁVEL DA EMPRESA, ONDE 1 USUÁRIO PODE TER MAIS DE UM COMPLEXO
CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45),
    telefone CHAR(11),
    senha VARCHAR(244)
);

INSERT INTO usuario VALUES 
	(default, 'Carlinhos', 'carlinhos@gmail.com', '11999999999', 'fa2d4e0f016d8fcaf758d307c857b3e3'),
	(default, 'João Victor', 'joao@gmail.com', '11999999998', '3dfcab79ed21fd89c9eb25e9864a6155'),
	(default, 'Erick Gomes', 'erick@gmail.com', '11999999997', '4da77e6afb73aaaabd18cdfe8d3e0262'),
	(default, 'Cauã Gouvea', 'gouvea@gmail.com', '11999999996', '0e3a650faff671a35b335526bae4aa05');


-- COMPLEXO - CONJUNTO DE SILOS
CREATE TABLE complexo(
    idComplexo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    estado CHAR(2) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    fkUsuario INT,
    CONSTRAINT fkEmpresaUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

INSERT INTO complexo
VALUES  (default, 'TrigoBrasil',  'SP', 'São Paulo', 'Rua das Trigoiras', 123, 1),
        (default, 'TrigoForte', 'RS', 'Porto Alegre', 'Avenida do Trigo', 456, 2),
        (default, 'GrãosPampas', 'RS', 'Caxias do Sul', 'Rua dos Grãos', 789, 3),
        (default, 'MoinhoReal', 'PR', 'Curitiba', 'Avenida do Moinho', 321, 4);

CREATE TABLE silo ( 
    idSilo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    temperaturaMax DECIMAL(4, 2),
    temperaturaMin DECIMAL(4, 2),
    umidadeMax DECIMAL (4, 2),
    umidadeMin DECIMAL (4, 2),
    fkComplexo INT,
    CONSTRAINT fkComplexoSilo FOREIGN KEY (fkComplexo) REFERENCES complexo(idComplexo)
);

INSERT INTO silo VALUES  
	(default, 'SILO 1', 20.00, 00.00, 18.00, 00.00, 1),
	(default, 'SILO 2', 15.00, 00.00, 13.00, 00.00, 2),
	(default, 'SILO 3', 30.00, 00.00, 16.00, 00.00, 3),
	(default, 'SILO 4', 20.00, 00.00, 10.00, 00.00, 4);


CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    fkSilo INT,
    CONSTRAINT fkSensorSilo FOREIGN KEY (fkSilo) REFERENCES silo(idSilo)
);

INSERT INTO sensor 
VALUES  (default, 1),
        (default, 2),
        (default, 3),
        (default, 4);

CREATE TABLE monitoramento ( 
    idMonitoramento INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    humidade DECIMAL(4,2),
    dataHora DATETIME,
    fkSensor INT,
    CONSTRAINT fkSensorMonitoramento FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor) 
);

CREATE TABLE historico(
	idHistorico INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    humidade DECIMAL(4,2),
    data DATETIME,
    fkSensor INT,
    CONSTRAINT fkSensorMonitoramento FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor) 
);

CREATE TABLE alerta(
	idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    motivo VARCHAR(100),
    dataHora DATETIME,
    temperaturaMomento DECIMAL(4,2),
    humidadeMomento DECIMAL(4,2),
    fkSensor INT,
    CONSTRAINT fkSensorAlerta FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

INSERT INTO monitoramento
VALUES  (default, 14.23, 10.00,'2024-03-21 13:30:00', 1),
        (default, 20.24, 12.00,'2024-03-20 10:45:00', 2),
        (default, 25.25, 25.00,'2024-03-19 14:00:30', 3),
        (default, 18.20, 13.00,'2024-03-18 12:00:00', 4);
        
SELECT * FROM usuario;
SELECT * FROM complexo;
SELECT * FROM silo;
SELECT * FROM sensor;
SELECT * FROM monitoramento;

SELECT usuario.nome as usuarioName, complexo.nome as complexoNome, silo.*, sensor.idSensor, monitoramento.* 
FROM usuario JOIN complexo ON complexo.fkUsuario = usuario.idUsuario
JOIN silo ON silo.fkComplexo = complexo.idComplexo
JOIN sensor ON sensor.fkSilo = silo.idSilo
JOIN monitoramento ON monitoramento.fkSensor = sensor.idSensor; 
        
  
        
CREATE TABLE contatoSite(
    idContatoSite INT PRIMARY KEY AUTO_INCREMENT,
    empresa VARCHAR(100),
    email VARCHAR(200) NOT NULL,
    assunto VARCHAR(100) NOT NULL,
    mensagem VARCHAR(500) NOT NULL
);

INSERT INTO contatoSite VALUES 
	(default, 'TrigoBrasil', 'contato@trigobrasil.com', 'Contrato', 'Gostaria de mais informações'),
	(default, 'TrigoCeara', 'contato@trigoceara.com', 'Contrato', 'Gostaria de mais informações'),
	(default, 'TrigoSãoPaulo', 'contato@trigosaopaulo.com', 'Contrato', 'Gostaria de mais informações');

