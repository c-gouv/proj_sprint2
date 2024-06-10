var express = require("express");
var router = express.Router();

var cadastroDashController = require("../controllers/cadastroDashController");

// Recebendo os dados do HTML e direcionando para a função cadastrar de cadastroDashController.js
router.post("/cadastrar", function (req, res) {
    cadastroDashController.cadastrar(req, res);
});

// Rota para listar os usuários por empresa
router.get("/listarUsuarios/:empresaId", function (req, res) {
    cadastroDashController.listarUsuariosPorEmpresa(req, res);
});

module.exports = router;
