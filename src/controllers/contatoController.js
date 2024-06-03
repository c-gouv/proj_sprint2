var contatoModel = require("../models/contatoModel");

function enviar(req, res) {
    var empresaVar = req.body.empresaServer;
    var emailVar = req.body.emailServer;
    var assuntoVar = req.body.assuntoServer;
    var mensagemVar = req.body.mensagemServer;
    
    if (empresaVar == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (emailVar == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (assuntoVar == undefined) {
        res.status(400).send("Seu assunto está undefined!");
    } else if (mensagemVar == undefined) {
        res.status(400).send("Sua mensagem está undefined!");
    } else {
        contatoModel.enviar(empresaVar, emailVar, assuntoVar, mensagemVar)
            .then(function (resultado) {
                res.json(resultado);
            })
            .catch(function (erro) {
                console.log(erro);
                console.log("Houve um erro ao enviar a mensagem! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

module.exports = {
    enviar
};
