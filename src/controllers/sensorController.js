var sensorModel = require("../models/sensorModel");

function graficoDiario(req, res) {
    var idPLANTACAO = req.body.idPLANTACAO;

  if (idPLANTACAO == undefined) {
    res.status(400).send("Algum parametro está undefined!");
  } else {
    sensorModel
      .graficoDiario(idPLANTACAO)
      .then(function (resultado) {
        res.json(resultado);
        res.status(200);
      })
      .catch(function (erro) {
        console.log(erro);
        console.log(
          "\nErro graficoDiario ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

function graficoMensal(req, res) {
    var idPLANTACAO = req.body.idPLANTACAO;

    sensorModel
    .graficoMensal(idPLANTACAO)
    .then(function (resultado) {
      res.json(resultado);

      res.status(200).json(resultado); // Define o status antes de enviar o JSON
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "\nErro graficoMensal ",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function umiMax(req, res) {
    var idPlant = req.body.idPlant;
    var idEmpresa = req.body.idEmpresa;
    console.log('TO NO CONTROLLER');

    if (idPlant == undefined) {
        res.status(400).send("Platação não definida (umidade máxima)")
    } 

    sensorModel.umiMax(idPlant, idEmpresa)
        .then(
        function(resposta){
        res.json({
            max: resposta[0].Maximo
        })
        console.log(lista[0].Maximo + ' to no res.json');
        res.status(200).send("Umidade máxima selecionada")
    }).catch(function(erro){
        res.status(500).json(erro.sqlMensage);
    }) 
}

function umiMin(req, res) {
    var idPlant = req.body.idPlant;
    var idEmpresa = req.body.idEmpresa;

    if (idPlant == undefined) {
        res.status(400).send("Plantação não definida (umidade mínima)")
    }

    sensorModel.umiMin(idPlant, idEmpresa)
    .then(
      function(resposta){
        res.json({
            min: resposta[0].Minimo
        })
        res.status(200).send("Umidade mínima selecionada")
    }).catch(function(erro){
        res.status(500).json(erro.sqlMensage)
    })
}

module.exports = {
    graficoDiario,
    graficoMensal,
    umiMax,
    umiMin
}