var express = require("express");
var router = express.Router();

var complexoController = require("../controllers/complexoController");

router.get("/listar/:empresaId", function (req, res) {
  complexoController.buscarComplexosPorEmpresa(req, res);
});

router.get("/:complexoId", function (req, res) {
  complexoController.buscarComplexoPorId(req, res);
});

router.get("/silosEmAlerta/:complexoId", function (req, res) {
  complexoController.silosEmAlerta(req, res);
});

router.get("/siloMaisCritico/:complexoId", function (req, res) {
  complexoController.siloMaisCritico(req, res);
});

router.get("/temperaturaUmidadeMedia/:complexoId", function (req, res) {
  complexoController.temperaturaUmidadeMedia(req, res);
});

router.post("/cadastrar", function (req, res) {
  complexoController.cadastrar(req, res);
})

module.exports = router;