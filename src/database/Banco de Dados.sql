CREATE DATABASE fitteya;

USE fitteya;

-- CRIAR UMA TABELA DE CADASTRO DE USUÁRIO/RESPONSÁVEL DA EMPRESA, ONDE 1 USUÁRIO PODE TER MAIS DE UM COMPLEXO
CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(45),
    nomeFantasia VARCHAR(45),
    telefoneFixo VARCHAR(8),
    email VARCHAR(45),
    cnpj char(14)
);

INSERT INTO empresa
VALUES  (default, 'Agricultores Unidos do Brasil Ltda.','TrigoBrasil', '22223333','contato@trigobrasil.com.br', '42841532000132'),
        (default, 'Agrícola Nordestina de Trigo S.A.','TrigoCeara', '33334444', 'contato@trigoceara.com.br', '73967214000165'),
        (default, 'Agroindústria Paulista de Trigo Ltda.','TrigoSãoPaulo', '55556666', 'contato@trigosp.com.br', '20513786000104');

CREATE TABLE cargo(
	idCargo INT PRIMARY KEY AUTO_INCREMENT,
    tipoCargo VARCHAR(45)
);

INSERT INTO cargo(tipoCargo)
VALUES 	('Administração'),
		('Leitura'),
        ('Edição');

CREATE TABLE usuario(
	idUsuario INT AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    telefone CHAR(11) UNIQUE,
    senha VARCHAR(244),
    fkEmpresa INT,
    fkCargo INT,
    CONSTRAINT fkCargoUsuario FOREIGN KEY (fkCargo) REFERENCES cargo(idCargo),
    CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    CONSTRAINT pkUsuarioCargoEmpresa PRIMARY KEY (idUsuario, fkEmpresa, fkCargo)
);

INSERT INTO usuario VALUES 
	(default, 'Carlinhos', 'carlinhos@gmail.com', '11999999999', 'fa2d4e0f016d8fcaf758d307c857b3e3', 1, 1),
	(default, 'João Victor', 'joao@gmail.com', '11999999998', '3dfcab79ed21fd89c9eb25e9864a6155', 2, 2),
	(default, 'Erick Gomes', 'erick@gmail.com', '11999999997', '4da77e6afb73aaaabd18cdfe8d3e0262', 3, 3),
	(default, 'Cauã Gouvea', 'gouvea@gmail.com', '11999999996', '0e3a650faff671a35b335526bae4aa05', 1, 2);

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
    temperaturaMinPerigo DECIMAL(5, 2),
    temperaturaMinCuidado DECIMAL(5, 2),
    temperaturaMaxPerigo DECIMAL(5, 2),
    temperaturaMaxCuidado DECIMAL(5, 2),
    umidadeMinPerigo DECIMAL (5, 2),
    umidadeMinCuidado DECIMAL (5, 2),
    umidadeMaxPerigo DECIMAL (5, 2),
    umidadeMaxCuidado DECIMAL (5, 2)
);

INSERT INTO parametro
VALUES 	(DEFAULT, 10, 15, 20, 18, 7, 10, 16, 13);

CREATE TABLE silo ( 
    idSilo INT AUTO_INCREMENT,
    nome VARCHAR(45),
    fkComplexo INT,
    fkParametro INT,
    CONSTRAINT fkComplexoSilo FOREIGN KEY (fkComplexo) REFERENCES complexo(idComplexo),
    CONSTRAINT fkSiloParametro FOREIGN KEY (fkParametro) REFERENCES parametro(idParametro),
    CONSTRAINT pkSiloParametro PRIMARY KEY (idSilo, fkParametro)
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
    temperatura DECIMAL(5,2),
    umidade DECIMAL(5,2),
    dataHora DATETIME,
    fkSensor INT,
    CONSTRAINT fkSensorMonitoramento FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
    CONSTRAINT pkMonitoramentoSensor PRIMARY KEY (idMonitoramento, fkSensor)
);

SELECT * FROM monitoramento;

INSERT INTO monitoramento
VALUES  (default, 14.23, 10.00,'2024-03-21 13:30:00', 1),
        (default, 20.24, 12.00,'2024-03-20 10:45:00', 2),
        (default, 25.25, 25.00,'2024-03-19 14:00:30', 3),
        (default, 18.20, 13.00,'2024-03-18 12:00:00', 4);

-- INSERTS PARA TESTES DE QTD_DE_ALERTAS
INSERT INTO monitoramento VALUES 
(default, 20.00, 15.00, '2024-03-18 15:00:00', 4),
(default, 20.00, 15.00, '2024-03-18 17:00:00', 4);

INSERT INTO monitoramento VALUES 
(default, 25.00, 13.00, '2024-03-18 10:00:00', 3),
(default, 28.00, 10.00, '2024-03-18 11:00:00', 3);


           
SELECT * FROM usuario;
SELECT * FROM empresa;
SELECT * FROM complexo;
SELECT * FROM silo;
SELECT * FROM sensor;
SELECT * FROM monitoramento;

SELECT usuario.nome as usuarioName, empresa.nomeFantasia, complexo.nome as complexoNome, silo.*, sensor.idSensor, monitoramento.* 
FROM usuario JOIN empresa ON usuario.fkEmpresa = empresa.idEmpresa
JOIN complexo ON complexo.fkEmpresa = empresa.idEmpresa
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

CREATE VIEW vw_historicoHora AS 
select monitoramento.* from monitoramento
join sensor ON idSensor = fkSensor
where dataHora like '2024-03-18%' and minute(dataHora) = 0 and second(dataHora) = 0;

CREATE VIEW vw_alertas AS
SELECT monitoramento.* from monitoramento
JOIN sensor ON idSensor = fkSensor
JOIN silo ON idSilo = fkSilo
JOIN parametro ON idParametro = fkParametro
WHERE 
temperatura<temperaturaMinPerigo OR
temperatura<temperaturaMinCuidado OR
temperatura>temperaturaMaxPerigo OR
temperatura>temperaturaMaxCuidado OR
umidade<umidadeMinPerigo OR
umidade<umidadeMinCuidado OR
umidade>umidadeMaxPerigo OR
umidade>umidadeMaxCuidado;

SELECT * FROM vw_alertas;

-- QTD DE SILOS EM ALERTAS DO COMPLEXO 'X'
select COUNT(*) from monitoramento
join sensor ON idSensor = fkSensor
join silo on sensor.fkSilo = silo.idSilo
join complexo on silo.fkComplexo = complexo.idComplexo
where dataHora like '2024-03-18%' and minute(dataHora) = 0 and second(dataHora) = 0 AND complexo.idComplexo = 3;

-- LISTA DE COMPLEXOS E QUANTOS SILO ESTÃO EM ALERTAS NAS ÚLTIMAS 24H
SELECT c.* ,
(select COUNT(*) from monitoramento
join sensor ON idSensor = fkSensor
join silo on sensor.fkSilo = silo.idSilo
join complexo on silo.fkComplexo = complexo.idComplexo
where dataHora like '2024-03-18%' and minute(dataHora) = 0 and second(dataHora) = 0 
AND complexo.idComplexo = c.idComplexo) as qtdSilosAlertas
FROM complexo c WHERE c.fkEmpresa = 3;

-- LISTAS DE SILOS DE UM DETERMINANDO COMPLEXO COM A QTD DE ALERTAS EM CADA SILO NAS ULTIMAS 24H
SELECT s.*,
(select COUNT(*) from monitoramento
join sensor ON idSensor = fkSensor
join silo on sensor.fkSilo = silo.idSilo
join complexo on silo.fkComplexo = complexo.idComplexo
where dataHora like '2024-03-18%' and minute(dataHora) = 0 and second(dataHora) = 0 
AND silo.idSilo= s.idSilo) as qtdAlertas
FROM silo s WHERE s.fkComplexo = 3;