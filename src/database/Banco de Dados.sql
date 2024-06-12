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
	(default, 'Carlinhos', 'carlinhos@gmail.com', '11999999999', '417e024eaa6c935a4877d7c6bd64630ee9650e48728656d96c673fa4a5e99f37', 1, 1),
	(default, 'João Victor', 'joao@gmail.com', '11999999998', '898d803f737fc386d17332ff318febe5e70a6fdc23e8d8b0ecafaceaeed1efc6', 2, 2),
	(default, 'Erick Gomes', 'erick@gmail.com', '11999999997', 'a6d60db309101bed41cefa2c3016f012e16b6c3ed5037b53f5f6dca4f717904a', 3, 3),
	(default, 'Cauã Gouvea', 'gouvea@gmail.com', '11999999996', '6b5e5cced76093e0e76f7221ea7a243fefa516e81eeeb422fd5874ba3a1cdff5', 1, 2);

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


INSERT INTO monitoramento VALUES 
(default, 50.00, 5.00, '2024-03-18 21:00:00', 4);

           
SELECT * FROM usuario;
SELECT * FROM empresa;
SELECT * FROM complexo;
SELECT * FROM silo;
SELECT * FROM sensor;
SELECT * FROM monitoramento;
SELECT * FROM parametro;

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


-- HISTORICO POR HORA DO SILO
select truncate(monitoramento.temperatura, 1) as temperatura,
truncate(monitoramento.umidade, 1) as umidade, 
DATE_FORMAT(monitoramento.dataHora, '%H:%i') as hora 
from monitoramento
join sensor ON idSensor = fkSensor
join silo on fkSensor = idSilo
where dataHora like '2024-03-18%' and minute(dataHora) = 0 and second(dataHora) = 0 and idSilo = 4 LIMIT 24;

-- KPIs do historico por hora
select
coalesce(truncate(max(monitoramento.temperatura), 1), 0) as tempMax,
coalesce(truncate(min(monitoramento.temperatura), 1), 0) as tempMin,
coalesce(truncate(avg(monitoramento.temperatura), 1), 0) as tempMedia,
coalesce(truncate(max(monitoramento.umidade), 1), 0) as umidMax,
coalesce(truncate(min(monitoramento.umidade), 1), 0) as umidMin,
coalesce(truncate(avg(monitoramento.umidade), 1), 0) as umidMedia
from monitoramento
join sensor ON idSensor = fkSensor
join silo on fkSensor = idSilo
where dataHora like '2024-03-18%' and minute(dataHora) = 0 and second(dataHora) = 0 and idSilo = 4;

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

-- ULTIMO REGISTRO + OS PARAMETROS DO SILO
SELECT truncate(m.temperatura, 1) as temperatura, 
	truncate(m.umidade, 1) as umidade, 
    m.dataHora, 
	round(p.temperaturaMinPerigo) as tempMinPerigo, 
	round(p.temperaturaMaxPerigo) as tempMaxPerigo,
	round(p.temperaturaMinCuidado) as tempMinCuidado,
	round(p.temperaturaMaxCuidado) as tempMaxCuidado,
	round(p.umidadeMinPerigo) as umidMinPerigo,
	round(p.umidadeMaxPerigo) as umidMaxPerigo,
    round(p.umidadeMinCuidado) as umidMinCuidado,
	round(p.umidadeMaxCuidado) as umidMaxCuidado
    FROM monitoramento as m 
	JOIN sensor as s ON m.fkSensor = s.idSensor
	JOIN silo as si ON s.fkSilo = si.idSilo 
    JOIN parametro p ON si.fkParametro = p.idParametro
    WHERE si.idSilo = 1 
    ORDER BY m.idMonitoramento DESC LIMIT 1;

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

SELECT 
TRUNCATE(SUM(temperatura)/COUNT(fkSensor), 2) mediaTemperatura, 
TRUNCATE(SUM(umidade)/COUNT(fkSensor), 2) mediaUmidade 
FROM monitoramento 
JOIN sensor ON fkSensor = idSensor 
JOIN silo ON fkSilo = idSilo 
WHERE fkComplexo = 1 
AND dataHora > NOW() - INTERVAL 1 DAY;

SELECT silo.nome maisCritico, MAX(temperatura), MAX(umidade) FROM vw_alertas
JOIN sensor ON fkSensor = idSensor 
JOIN silo ON fkSilo = idSilo
WHERE fkComplexo = 1
AND dataHora > NOW() - INTERVAL 1 DAY
GROUP BY silo.nome, temperatura, umidade
ORDER BY temperatura DESC, umidade DESC
LIMIT 1;

SELECT COUNT(DISTINCT idSilo) emAlerta FROM vw_alertas
JOIN sensor ON fkSensor = idSensor 
JOIN silo ON fkSilo = idSilo 
WHERE fkComplexo = 1
AND dataHora > NOW() - INTERVAL 1 DAY;