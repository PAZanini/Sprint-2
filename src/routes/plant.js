var express = require("express");
var router = express.Router();

var plantController = require("../controllers/plantController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/listarPlant", function (req, res) {
  plantController.listarPlant(req, res);
});

module.exports = router;