var database = require("../database/config");

function enviar(empresa, email, assunto, mensagem) {
    console.log("ACESSEI O USUARIO MODEL \n function enviar():", empresa, email, assunto, mensagem);
    
    var instrucaoSql = `
        INSERT INTO contatoSite (empresa, email, assunto, mensagem) VALUES ('${empresa}', '${email}', '${assunto}', '${mensagem}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    enviar
};
