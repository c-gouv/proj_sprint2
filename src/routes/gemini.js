var express = require("express");
var router = express.Router();

var geminiController = require("../controllers/geminiController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/perguntar", async (req, res) => {
    const pergunta = req.body.pergunta;

    try {
        const resultado = await geminiController.gerarResposta(pergunta);
        res.json( { resultado } );
    } catch (error) {
        res.status(500).json({ error: 'Erro interno do servidor' });
    }

});

module.exports = router;