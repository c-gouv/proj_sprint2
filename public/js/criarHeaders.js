(() => {
    document.getElementById("menuLateral").innerHTML = `
        <div class="leftHeaderLogo">
            <img src="../assets/img/logo-extended.svg">
        </div>
        <div class="leftHeaderButtons">
            <a href="./dashboard-geral.html">
                <div class="menuSection selected">
                    <i class="fa-solid fa-gauge-high"></i>
                </div>
                <span class="selected">Dashboard</span>
            </a>
            <a href="./dashboard-cadastro.html">
                <div class="menuSection">
                    <i class="fa-solid fa-user"></i>
                </div>
                Cadastrar Usuário
            </a>
            <a href="./dashboard-ia.html">
            <div class="menuSection">
                <i class="fa-solid fa-headset"></i>
            </div>
            Suporte IA
            </a>
        </div>
        <button class="fecharMenu" onclick="fecharMenu()"> <i class="fa-solid fa-angle-left"></i> </button>`
})();

(() => {
    document.getElementById("header").innerHTML = `
            <nav class="navbar">
                <i class="fa-solid fa-bars" style="font-size: 25px; cursor: pointer;" onclick="exibirMenu()"></i>
                <div class="navbarButtons">
                    <div class="userArea" onclick="userOptions()">
                        <i class="fa-solid fa-angle-up" id="pfIcon"></i>
                        Olá Isaque
                        <img src="../assets/img/avatar_user.webp" class="pfpPicture">
                    </div>
                    <div>
                        <div class="dropdownContent hidden" id="menuPerfil"">
                      <a href=" #">Configurações do Usuário</a>
                            <a onclick="voltarHome()">Sair</a>
                        </div>
                    </div>
                    <div class="themeArea">
                        <i class="fa-solid tema fa-moon" id="themeIcon" onclick="mudarTema()"></i>
                    </div>
                </div>
            </nav>`
})();