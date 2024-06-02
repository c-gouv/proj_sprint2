var database = require("../database/config");

function buscarSilosPorComplexo(complexoId) {

  var instrucaoSql = `SELECT s.*,
  (SELECT COUNT(*) FROM monitoramento
  JOIN sensor ON idSensor = fkSensor
  JOIN silo ON sensor.fkSilo = silo.idSilo
  JOIN complexo ON silo.fkComplexo = complexo.idComplexo
  where dataHora LIKE '2024-03-18%' AND minute(dataHora) = 0 AND second(dataHora) = 0 
  AND silo.idSilo= s.idSilo) as qtdAlertas
  FROM silo s WHERE s.fkComplexo = ${complexoId};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarSilosPorComplexo
}
