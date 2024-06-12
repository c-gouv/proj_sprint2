var alertas = [];

function obterdados(idSilo) {
    fetch(`/medidas/tempo-real/${idSilo}`)
        .then(resposta => {
            if (resposta.status == 200) {
                resposta.json().then(resposta => {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);

                    alertar(resposta, idSilo);
                });
            } else {
                console.error(`Nenhum dado encontrado para o id ${idSilo} ou erro na API`);
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do aquario p/ gráfico: ${error.message}`);
        });

}

function alertar(resposta, idSilo) {
    var temp = resposta[0].temperatura;
    var umid = resposta[0].umidade;


    var limitesTemp = {
        muito_quente: Number(resposta[0].tempMaxPerigo),
        quente: Number(resposta[0].tempMaxCuidado),
        frio: Number(resposta[0].tempMinCuidado),
        muito_frio: Number(resposta[0].tempMinPerigo)
    };

    var limitesUmid = {
        encharcado: Number(resposta[0].umidMaxPerigo),
        muito_umido: Number(resposta[0].umidMaxCuidado),
        pouco_umido: Number(resposta[0].umidMinCuidado),
        seco: Number(resposta[0].umidMinPerigo)
    };
    // KPI TEMPERATURA
    document.getElementById("perigo_temp_kpi").innerHTML = `> ${limitesTemp.muito_quente}ºC ou < ${limitesTemp.muito_frio}ºC`
    document.getElementById("cuidado_temp_kpi").innerHTML = `> ${limitesTemp.quente}ºC ou < ${limitesTemp.frio}ºC`
    document.getElementById("ideal_temp_kpi").innerHTML = `< ${limitesTemp.quente}ºC e > ${limitesTemp.frio}ºC`
   
    document.getElementById("perigo_umid_kpi").innerHTML = `> ${limitesUmid.encharcado}% ou < ${limitesUmid.seco}%`
    document.getElementById("cuidado_umid_kpi").innerHTML = `> ${limitesUmid.muito_umido}% ou < ${limitesUmid.pouco_umido}%`
    document.getElementById("ideal_umid_kpi").innerHTML = `< ${limitesUmid.muito_umido}% e > ${limitesUmid.pouco_umido}%`

    var classe_temperatura = 'content_value';
    var classe_umidade = 'content_value';

    // VALIDANDO LIMITES DA TEMPERATURA
    if (temp >= limitesTemp.muito_quente || temp <= limitesTemp.muito_frio) {
        classe_temperatura = 'content_value perigo';

    }
    else if (temp >= limitesTemp.quente || temp <= limitesTemp.frio) {
        classe_temperatura = 'content_value alerta';

    }
    else if (temp < limitesTemp.quente && temp > limitesTemp.frio) {
        classe_temperatura = 'content_value ideal';

    }

    // VALIDANDO LIMITES DA UMIDADE
    if (umid >= limitesUmid.encharcado || umid <= limitesUmid.seco) {
        classe_umidade = 'content_value perigo';

    }
    else if (umid >= limitesUmid.muito_umido || umid <= limitesUmid.pouco_umido) {
        classe_umidade = 'content_value alerta';

    }
    else if (umid < limitesUmid.muito_umido && umid > limitesUmid.pouco_umido) {
        classe_umidade = 'content_value ideal';

    }

    var cardTemp;
    var cardUmid;

    document.getElementById(`monitoramento_temperatura`).innerHTML = temp;
    document.getElementById(`monitoramento_umidade`).innerHTML = umid;

    if (document.getElementById(`back_temp`)) {
        cardTemp = document.getElementById(`back_temp`)
        cardTemp.className = classe_temperatura;
    }

    if (document.getElementById(`back_umid`)) {
        cardUmid = document.getElementById(`back_umid`)
        cardUmid.className = classe_umidade;
    }
}

// function exibirAlerta(temp, idAquario, grauDeAviso, grauDeAvisoCor) {
//     var indice = alertas.findIndex(item => item.idAquario == idAquario);

//     if (indice >= 0) {
//         alertas[indice] = { idAquario, temp, grauDeAviso, grauDeAvisoCor }
//     } else {
//         alertas.push({ idAquario, temp, grauDeAviso, grauDeAvisoCor });
//     }

//     exibirCards();
// }

// function removerAlerta(idAquario) {
//     alertas = alertas.filter(item => item.idAquario != idAquario);
//     exibirCards();
// }

// function exibirCards() {
//     alerta.innerHTML = '';

//     for (var i = 0; i < alertas.length; i++) {
//         var mensagem = alertas[i];
//         alerta.innerHTML += transformarEmDiv(mensagem);
//     }
// }

// function transformarEmDiv({ idAquario, temp, grauDeAviso, grauDeAvisoCor }) {

//     var descricao = JSON.parse(sessionStorage.AQUARIOS).find(item => item.id == idAquario).descricao;
//     return `
//     <div class="mensagem-alarme">
//         <div class="informacao">
//             <div class="${grauDeAvisoCor}">&#12644;</div> 
//             <h3>${descricao} está em estado de ${grauDeAviso}!</h3>
//             <small>Temperatura capturada: ${temp}°C.</small>   
//         </div>
//         <div class="alarme-sino"></div>
//     </div>
//     `;
// }

function atualizacaoPeriodica() {
    obterdados(sessionStorage.ID_SILO)

    setTimeout(atualizacaoPeriodica, 2000);
}
