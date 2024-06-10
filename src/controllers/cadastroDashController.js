var cadastroDashModel = require("../models/cadastroDashModel");

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    let cargoId = 0;
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var empresaId = req.body.empresaServer;
    var cargo = req.body.cargoServer;

    if(cargo == 'Administracao'){
        cargoId = 1;
    } else if(cargo == 'Leitura'){
        cargoId = 2;
    } else if(cargo == 'Edicao'){
        cargoId = 3;
    }

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (empresaId == undefined) {
        res.status(400).send("Sua empresa está undefined!");
    } else if (cargo == undefined) {
        res.status(400).send("Seu cargo está undefined!");
    } else {
        // Passe os valores como parâmetro e vá para o arquivo cadastroDashModel.js
        cadastroDashModel.cadastrar(nome, email, senha, empresaId, cargoId)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function listarUsuariosPorEmpresa(req, res) {
    var empresaId = req.params.empresaId;

    cadastroDashModel.listarUsuariosPorEmpresa(empresaId)
        .then(function (resultado) {
            res.json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("\nHouve um erro ao listar os usuários! Erro: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}


module.exports = {
    cadastrar,
    listarUsuariosPorEmpresa
};
