// importa os bibliotecas necessários
const serialport = require('serialport');
const express = require('express');
const mysql = require('mysql2');

// constantes para configurações
const SERIAL_BAUD_RATE = 9600;
const SERVIDOR_PORTA = 3300;

// habilita ou desabilita a inserção de dados no banco de dados
const HABILITAR_OPERACAO_INSERIR = true;

// função para comunicação serial
const serial = async (
    valoresSensorAnalogico,
) => {

    // conexão com o banco de dados MySQL     COLOQUE O SEU USUARIO DO BANCO DE DADOS NA HORA
    let poolBancoDados = mysql.createPool(
        {
            host: '10.18.35.150',
            user: 'aluno',
            password: 'Sptech#2024',
            database: 'WaterWorks',
            port: 3307
        }
    ).promise();

    // lista as portas seriais disponíveis e procura pelo Arduino
    const portas = await serialport.SerialPort.list();
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);
    if (!portaArduino) {
        throw new Error('O arduino não foi encontrado em nenhuma porta serial');
    }

    // configura a porta serial com o baud rate especificado
    const arduino = new serialport.SerialPort(
        {
            path: portaArduino.path,
            baudRate: SERIAL_BAUD_RATE
        }
    );

    // evento quando a porta serial é aberta
    arduino.on('open', () => {
        console.log(`A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`);
    });

    // processa os dados recebidos do Arduino
    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' })).on('data', async (data) => {
        console.log(data);
        const valores = data.split(';');
        const sensorAnalogico = parseFloat(valores[0]);
        // armazena os valores dos sensores nos arrays correspondentes
        valoresSensorAnalogico.push(sensorAnalogico);

        // insere os dados no banco de dados (se habilitado)
        if (HABILITAR_OPERACAO_INSERIR) {
            var agora = Date.now(); // Pega o timestamp atual
            var obj = new Date(agora); // Cria o objeto Date

    // Pega o ano, mês (adiciona 1, pois o mês começa de 0), dia, hora, minuto e segundo
            var ano = obj.getFullYear();
            var mes = (obj.getMonth() + 1).toString().padStart(2, '0'); // Adiciona 1 ao mês, pois é baseado em 0
            var dia = obj.getDate().toString().padStart(2, '0');
            var hora = obj.getHours().toString().padStart(2, '0');
            var minuto = obj.getMinutes().toString().padStart(2, '0');
            var segundo = obj.getSeconds().toString().padStart(2, '0');

            var dataFormatada = `'${ano}-${mes}-${dia} ${hora}:${minuto}:${segundo}'`;


            // este insert irá inserir os dados na tabela "medida"
            await poolBancoDados.execute(
                // `INSERT INTO medida(dht11_umidadade, momento, fk_aquario)VALUES(${sensorAnalogico}, ${dataFormatada}, 2)
                `INSERT INTO registro (dadoSensor, fkSensor, dataRegistro)VALUES (${sensorAnalogico}, 1, ${dataFormatada});`,
            );
            console.log("valores inseridos no banco: ", sensorAnalogico + ' e', dataFormatada);

        }

    });

    // evento para lidar com erros na comunicação serial
    arduino.on('error', (mensagem) => {
        console.error(`Erro no arduino (Mensagem: ${mensagem}`)
    });
}

// função para criar e configurar o servidor web
const servidor = (
    valoresSensorAnalogico,
) => {
    const app = express();

    // configurações de requisição e resposta
    app.use((request, response, next) => {
        response.header('Access-Control-Allow-Origin', '*');
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });

    // inicia o servidor na porta especificada
    app.listen(SERVIDOR_PORTA, () => {
        console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });

    // define os endpoints da API para cada tipo de sensor
    app.get('/sensores/analogico', (_, response) => {
        return response.json(valoresSensorAnalogico);
    });
    
}

// função principal assíncrona para iniciar a comunicação serial e o servidor web
(async () => {
    // arrays para armazenar os valores dos sensores
    const valoresSensorAnalogico = [];
    // inicia a comunicação serial
    await serial(
        valoresSensorAnalogico,   
    );

    // inicia o servidor web
    servidor(
        valoresSensorAnalogico,
        
    );
})();