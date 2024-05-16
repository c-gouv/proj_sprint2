function userOptions() {
    let menu = document.getElementById("menuPerfil");
    let estadoAtual = menu.classList.contains("show") ? "show" : "hidden";
    let novoEstado = estadoAtual === "show" ? "hidden" : "show";

    let icon = document.getElementById("pfIcon");
    let iconAtual = icon.classList.contains("fa-angle-up") ? "fa-angle-up" : "fa-angle-down";
    let novoIcon = iconAtual === "fa-angle-up" ? "fa-angle-down" : "fa-angle-up";

    icon.classList.remove(iconAtual);
    icon.classList.add(novoIcon);

    menu.classList.remove(estadoAtual);
    menu.classList.add(novoEstado);
}
function fecharMenu() {
    let cabecalho = document.getElementById("header");
    header.classList.remove("exibirMenu")
}
function exibirMenu() {
    let cabecalho = document.getElementById("header");
    header.classList.add("exibirMenu")
}
function voltarHome() { 
    window.location.href="home.html"
}
function mudarTema() {
    let icon = document.getElementById("themeIcon");
    let iconAtual = icon.classList.contains("fa-moon") ? "fa-moon" : "fa-sun";
    let novoIcon = iconAtual === "fa-moon" ? "fa-sun" : "fa-moon";
    document.body.classList.toggle("light-theme");
    icon.classList.remove(iconAtual);
    icon.classList.add(novoIcon);
    if(novoIcon == "fa-sun"){
     mudarTemaChart(humidityChart, '#000')
     mudarTemaChart(tempGrafico, '#000')
    }else{
     mudarTemaChart(humidityChart, '#fff')
     mudarTemaChart(tempGrafico, '#fff')
    }
  }