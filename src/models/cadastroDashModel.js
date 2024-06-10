var database = require("../database/config");

function cadastrar(nome, email, senha, idEmpresa, cargoId) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha);
    
    var instrucaoSql = `
        INSERT INTO usuario (nome, email, senha, fkEmpresa, fkCargo) VALUES ('${nome}', '${email}', '${senha}', '${idEmpresa}', '${cargoId}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarUsuariosPorEmpresa(empresaId) {
    const instrucaoSql = `
        SELECT nome, email FROM usuario WHERE fkEmpresa = ${empresaId};
    `;
    return database.executar(instrucaoSql);
}

module.exports = {
    cadastrar,
    listarUsuariosPorEmpresa
};
