var express = require("express");
var router = express.Router();

var complexoController = require("../controllers/complexoController");

router.get("listar/:empresaId", function (req, res) {
  complexoController.buscarComplexosPorEmpresa(req, res);
});

router.get("/:complexoId", function (req, res) {
  complexoController.buscarComplexoPorId(req, res);
});

router.post("/cadastrar", function (req, res) {
  complexoController.cadastrar(req, res);
})

module.exports = router;