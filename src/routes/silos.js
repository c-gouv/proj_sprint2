var express = require("express");
var router = express.Router();

var siloController = require("../controllers/siloController");

router.get("/:complexoId", function (req, res) {
    siloController.buscarSilosPorComplexo(req, res);
});


module.exports = router;