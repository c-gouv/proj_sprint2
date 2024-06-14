var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.post("/ultimoAlerta", function (req, res) {
    medidaController.buscarUltimoAlerta(req, res);
});

router.post("/ultimas", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.post("/kpis", function (req, res) {
    medidaController.buscarKpisHistorico(req, res);
});

router.get("/tempo-real/:idSilo", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/alertas/:idSilo", function (req, res) {
    medidaController.buscarAlertasDoSilo(req, res);
})

router.post("/buscarPaginaAlerta", function (req, res) {
    medidaController.buscarPaginaAlertas(req, res);
})

module.exports = router;