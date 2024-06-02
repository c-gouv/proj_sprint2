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

function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fkEmpresa) complexo VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarComplexosPorEmpresa,
  buscarComplexoPorId,
  cadastrar
}
