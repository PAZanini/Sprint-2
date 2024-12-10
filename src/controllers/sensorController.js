var sensorModel = require("../models/sensorModel");

function graficoDiario(req, res) {
    var idPlant = req.body.idPlant;

    if (idPlant == undefined) {
        res.status(400).send("Plantação não definida (gráfico diário)");
    }

    sensorModel.graficoDiario(idPlant)
    .then(function(resposta){
        
        res.status(200).send("Gráfico diário selecionado");
    }
        ).catch(function(erro){
        res.status(500).json(erro.sqlMensage);
        }
    )
}

function graficoMensal(req, res) {
    var idPlant = req.body.idPlant

    if (idPlant == undefined) {
        res.status(400).send("Plantação não definida (gráfico mensal)");
    }

    sensorModel.graficoMensal(idPlant).then(function(resposta){
        res.status(200).send("Gráfico mensal selecionado")
    }).catch(function(erro){
        res.status(500).json(erro.sqlMensage);
    })
}

function umiMax(req, res) {
    var idPlant = req.body.idPServer;
    var idEmpresa = req.body.idEmpServer;
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
    var idEmpresa = req.body.idEmpServer;

    if (idPlant == undefined) {
        res.status(400).send("Plantação não definida (umidade mínima)")
    }

    sensorModel.umiMin(idPlant, idEmpresa).then(function(resposta){
        res.status(200).send("Umidade mínima selecionada")
        res.json({
            min: resposta[0].Minimo
        })
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