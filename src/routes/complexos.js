var express = require("express");
var router = express.Router();

var complexoController = require("../controllers/complexoController");

router.get("/:empresaId", function (req, res) {
  complexoController.buscarComplexosPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  complexoController.cadastrar(req, res);
})

module.exports = router;