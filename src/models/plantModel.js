var database = require("../database/config");

function listarPlant(fkEmpresa) {
    var instrucaoSql = `SELECT * FROM plantacao WHERE fkMatriz = ${fkEmpresa};`;
  
    return database.executar(instrucaoSql);
  }

module.exports = { listarPlant };