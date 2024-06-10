var database = require("../database/config");

function buscarComplexosPorEmpresa(empresaId) {

  var instrucaoSql = `SELECT c.* ,
  (SELECT COUNT(*) FROM monitoramento
  JOIN sensor ON idSensor = fkSensor
  JOIN silo ON sensor.fkSilo = silo.idSilo
  JOIN complexo ON silo.fkComplexo = complexo.idComplexo
  where dataHora LIKE '2024-03-18%' AND minute(dataHora) = 0 AND second(dataHora) = 0 
  AND complexo.idComplexo = c.idComplexo) as qtdSilosAlertas
  FROM complexo c WHERE c.fkEmpresa = ${empresaId};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarComplexoPorId(complexoId) {

  var instrucaoSql = `SELECT * FROM complexo WHERE idComplexo = ${complexoId};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function silosEmAlerta(complexoId) {
  var instrucaoSql = `
    SELECT COUNT(DISTINCT idSilo) emAlerta FROM vw_alertas
    JOIN sensor ON fkSensor = idSensor
    JOIN silo ON fkSilo = idSilo
    WHERE fkComplexo = ${complexoId}
    AND dataHora > NOW() - INTERVAL 1 DAY;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function siloMaisCritico(complexoId) {
  var instrucaoSql = `
    (SELECT silo.nome maisCritico, MAX(temperatura), MAX(umidade) FROM vw_alertas
    JOIN sensor ON fkSensor = idSensor
    JOIN silo ON fkSilo = idSilo
    WHERE fkComplexo = ${complexoId}
    AND dataHora > NOW() - INTERVAL 1 DAY
    GROUP BY silo.nome, temperatura, umidade
    ORDER BY temperatura DESC, umidade DESC
    LIMIT 1)
    UNION
    (SELECT "Nenhum",0,0);
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function temperaturaUmidadeMedia(complexoId) {
  var instrucaoSql = `
    SELECT
    IFNULL(CONCAT(TRUNCATE(SUM(temperatura)/COUNT(fkSensor), 2), "°C"), "Nenhuma") mediaTemperatura,
    IFNULL(CONCAT(TRUNCATE(SUM(umidade)/COUNT(fkSensor), 2), "%"), "Nenhuma") mediaUmidade
    FROM monitoramento
    JOIN sensor ON fkSensor = idSensor
    JOIN silo ON fkSilo = idSilo
    WHERE fkComplexo = ${complexoId}
    AND dataHora > NOW() - INTERVAL 1 DAY;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fkEmpresa) complexo VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarComplexosPorEmpresa,
  buscarComplexoPorId,
  silosEmAlerta,
  siloMaisCritico,
  temperaturaUmidadeMedia,
  cadastrar
}
