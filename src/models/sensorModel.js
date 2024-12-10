var database = require("../database/config")

function graficoDiario() {
    var instrucao = `
    SELECT p.nome as Plantação, dadoSensor as dadoSensor, dataRegistro AS dtRegistro FROM plantacao as p JOIN sensor on fkPlantacao = idPLANTACAO 
	JOIN registro as dados on fkSensor = idSensor 
    WHERE idPLANTACAO = ${idPlant} and date(dataRegistro) = curdate() order by dataRegistro DESC limit 5;`

    console.log("Executando a instrução SQL (gráfico diário): \n" + instrucao);
    return database.executar(instrucao);
}

function graficoMensal() {
    var instrucao = `
    SELECT Mes, AVG(dadoSensor) AS media_valor
    FROM vw_mes2 where year(dataRegistro) = year(curdate())
    GROUP BY Mes 
    ORDER BY FIELD(Mes, 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');`

    console.log("Executando a instrução SQL (gráfico mensal): \n" + instrucao);
    return database.executar(instrucao);
}

function umiMax(idPlant, idEmpresa) {
    console.log('to no model', idEmpresa, idPlant);
    var instrucaoSql = `
    SELECT MAX(dadoSensor) AS Maximo FROM registro AS r
	JOIN sensor AS s ON r.fkSensor = s.idSensor
	JOIN plantacao AS p ON s.fkPlantacao = p.idPlantacao
    JOIN empresa AS e ON p.fkMatriz = e.idEmpresa
    WHERE idPlantacao = ${idPlant} AND idEmpresa = ${idEmpresa} AND date(dataRegistro) = curdate();
    `

    return database.executar(instrucaoSql);
}

function umiMin(idPlant, idEmpresa) {
    console.log('to no model', idEmpresa, idPlant);
    var instrucaoSql = `
    SELECT MIN(dadoSensor) AS Minimo FROM registro AS r
	JOIN sensor AS s ON r.fkSensor = s.idSensor
	JOIN plantacao AS p ON s.fkPlantacao = p.idPlantacao
    JOIN empresa AS e ON p.fkMatriz = e.idEmpresa
    WHERE idPlantacao = ${idPlant} AND idEmpresa = ${idEmpresa} and date(dataRegistro) = curdate();
    `

    return database.executar(instrucaoSql);
}


module.exports = {
    graficoDiario,
    graficoMensal,
    umiMax,
    umiMin
}