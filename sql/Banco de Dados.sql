CREATE DATABASE fitteya;

USE fitteya;

-- CRIAR UMA TABELA DE CADASTRO DE USUÁRIO/RESPONSÁVEL DA EMPRESA, ONDE 1 USUÁRIO PODE TER MAIS DE UM COMPLEXO
CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    telefoneFixo VARCHAR(8),
    telefoneCel VARCHAR(11),
    email VARCHAR(45)
);

INSERT INTO empresa
VALUES  (default, 'TrigoBrasil', '22223333', '11912345678', 'contato@trigobrasil.com.br'),
        (default, 'TrigoCeara', '33334444', '85987654321', 'contato@trigoceara.com.br'),
        (default, 'TrigoSãoPaulo', '55556666', '11876543210', 'contato@trigosp.com.br');

CREATE TABLE usuario(
	idUsuario INT AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    telefone CHAR(11) UNIQUE,
    senha VARCHAR(244),
    fkAdm INT,
    fkEmpresa INT,
    CONSTRAINT fkUsuarioAdm FOREIGN KEY (fkAdm) REFERENCES usuario(idUsuario),
    CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    CONSTRAINT pkUsuarioEmpresa PRIMARY KEY (idUsuario, fkEmpresa)
);

INSERT INTO usuario VALUES 
	(default, 'Carlinhos', 'carlinhos@gmail.com', '11999999999', 'fa2d4e0f016d8fcaf758d307c857b3e3', null, 1),
	(default, 'João Victor', 'joao@gmail.com', '11999999998', '3dfcab79ed21fd89c9eb25e9864a6155', 1, 1),
	(default, 'Erick Gomes', 'erick@gmail.com', '11999999997', '4da77e6afb73aaaabd18cdfe8d3e0262', null, 2),
	(default, 'Cauã Gouvea', 'gouvea@gmail.com', '11999999996', '0e3a650faff671a35b335526bae4aa05', 3, 2);

-- COMPLEXO - CONJUNTO DE SILOS
CREATE TABLE complexo(
    idComplexo INT AUTO_INCREMENT,
    nome VARCHAR(100),
    estado CHAR(2) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    fkEmpresa INT,
    CONSTRAINT fkEmpresaComplexo FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    CONSTRAINT pkComplexoEmpres PRIMARY KEY (idComplexo, fkEmpresa)
);

INSERT INTO complexo
VALUES  (default, 'TrigoBrasil',  'SP', 'São Paulo', 'Rua das Trigoiras', 123, 1),
        (default, 'TrigoForte', 'RS', 'Porto Alegre', 'Avenida do Trigo', 456, 2),
        (default, 'GrãosPampas', 'RS', 'Caxias do Sul', 'Rua dos Grãos', 789, 3),
        (default, 'MoinhoReal', 'PR', 'Curitiba', 'Avenida do Moinho', 321, 3);

CREATE TABLE parametro(
	idParametro INT PRIMARY KEY AUTO_INCREMENT,
    temperaturaMin DECIMAL(4, 2),
    temperaturaMax DECIMAL(4, 2),
    umidadeMin DECIMAL (4, 2),
    umidadeMax DECIMAL (4, 2)
);

INSERT INTO parametro
VALUES 	(DEFAULT, 15, 18, 13, 16);

CREATE TABLE silo ( 
    idSilo INT AUTO_INCREMENT,
    nome VARCHAR(45),
    fkComplexo INT,
    fkMedida INT,
    CONSTRAINT fkComplexoSilo FOREIGN KEY (fkComplexo) REFERENCES complexo(idComplexo),
    CONSTRAINT fkSiloParametro FOREIGN KEY (fkMedida) REFERENCES parametro(idParametro),
    CONSTRAINT pkSiloParametro PRIMARY KEY (idSilo, fkMedida)
);

INSERT INTO silo VALUES  
	(default, 'SILO 1', 1, 1),
	(default, 'SILO 2', 2, 1),
	(default, 'SILO 3', 3, 1),
	(default, 'SILO 4',  4, 1);

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
    idMonitoramento INT AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    umidade DECIMAL(4,2),
    dataHora DATETIME,
    fkSensor INT,
    CONSTRAINT fkSensorMonitoramento FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
    CONSTRAINT pkMonitoramentoSensor PRIMARY KEY (idMonitoramento, fkSensor)
);

SELECT * FROM monitoramento;

CREATE TABLE alerta(
	idAlerta INT AUTO_INCREMENT,
    status VARCHAR(45),
    motivo VARCHAR(45),
    fkMonitoramento INT,
    CONSTRAINT fkMonitoramentoAlerta FOREIGN KEY (fkMonitoramento) REFERENCES monitoramento(idMonitoramento),
    CONSTRAINT pkMonitoramentoAlerta PRIMARY KEY (idAlerta, fkMonitoramento)
);

INSERT INTO monitoramento
VALUES  (default, 14.23, 10.00,'2024-03-21 13:30:00', 1),
        (default, 20.24, 12.00,'2024-03-20 10:45:00', 2),
        (default, 25.25, 25.00,'2024-03-19 14:00:30', 3),
        (default, 18.20, 13.00,'2024-03-18 12:00:00', 4);
        
INSERT INTO alerta
VALUES  (default, 'Estado Crítico', 'Temperatura Elevada', 3),
		(default, 'Estado Crítico', 'Umidade Elevada', 3);
        
SELECT * FROM usuario;
SELECT * FROM complexo;
SELECT * FROM silo;
SELECT * FROM sensor;
SELECT * FROM monitoramento;

SELECT usuario.nome as usuarioName, empresa.nome, complexo.nome as complexoNome, silo.*, sensor.idSensor, monitoramento.* 
FROM usuario JOIN empresa ON usuario.fkEmpresa = empresa.idEmpresa
JOIN complexo ON complexo.fkEmpresa = empresa.idEmpresa
JOIN silo ON silo.fkComplexo = complexo.idComplexo
JOIN sensor ON sensor.fkSilo = silo.idSilo
JOIN monitoramento ON monitoramento.fkSensor = sensor.idSensor; 
        
CREATE TABLE leads(
    idContatoSite INT PRIMARY KEY AUTO_INCREMENT,
    empresa VARCHAR(100),
    email VARCHAR(200) NOT NULL,
    assunto VARCHAR(100) NOT NULL,
    mensagem VARCHAR(500) NOT NULL
);

INSERT INTO leads VALUES 
	(default, 'TrigoBrasil', 'contato@trigobrasil.com', 'Contrato', 'Gostaria de mais informações'),
	(default, 'TrigoCeara', 'contato@trigoceara.com', 'Contrato', 'Gostaria de mais informações'),
	(default, 'TrigoSãoPaulo', 'contato@trigosaopaulo.com', 'Contrato', 'Gostaria de mais informações');
    
select * from monitoramento
join sensor
where dataHora like '2024-03-18%' and minute(dataHora) = 0 and second(dataHora) = 0;