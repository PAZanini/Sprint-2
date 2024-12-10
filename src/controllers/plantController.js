var plantModel = require("../models/plantModel");

function listarPlant(req, res) {
    var fkEmpresa = req.body.fkEmpresa;
    if (fkEmpresa == undefined) {
        res.status(400).send("Algum parametro está undefined!");
      } else {
    plantModel.listarPlant(fkEmpresa).then((resultado) => {
      res.status(200).json(resultado);
    });
    
    console.log('TO NO CONTROLLER');
  }
}

  module.exports = {
    listarPlant,
  };