var database = require("../database/config");

function buscarUltimasMedidas(idSilo, dataHoje) {

    var instrucaoSql = `select truncate(monitoramento.temperatura, 1) as temperatura,
truncate(monitoramento.umidade, 1) as umidade, 
DATE_FORMAT(monitoramento.dataHora, '%H:%i') as hora 
from monitoramento
join sensor ON idSensor = fkSensor
join silo on fkSensor = idSilo
where dataHora like '${dataHoje}%' 
and minute(dataHora) = 0 
and second(dataHora) = 0 
and idSilo = ${idSilo} LIMIT 24;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarKpisHistorico(idSilo, dataHoje) {

    var instrucaoSql = `select
coalesce(truncate(max(monitoramento.temperatura), 1), 0) as tempMax,
coalesce(truncate(min(monitoramento.temperatura), 1), 0) as tempMin,
coalesce(truncate(avg(monitoramento.temperatura), 1), 0) as tempMedia,
coalesce(truncate(max(monitoramento.umidade), 1), 0) as umidMax,
coalesce(truncate(min(monitoramento.umidade), 1), 0) as umidMin,
coalesce(truncate(avg(monitoramento.umidade), 1), 0) as umidMedia
from monitoramento
join sensor ON idSensor = fkSensor
join silo on fkSensor = idSilo
where dataHora like '${dataHoje}%' 
and minute(dataHora) = 0 
and second(dataHora) = 0 
and idSilo = ${idSilo};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idSilo) {

    var instrucaoSql = `SELECT truncate(m.temperatura, 1) as temperatura, 
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
    WHERE si.idSilo = ${idSilo} 
    ORDER BY m.idMonitoramento DESC LIMIT 1;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarKpisHistorico
}
