(() => {
    document.getElementById("chamarHeaderInstitucional").innerHTML = `<header>
    <nav class="navbar">
      <div class="navbarLogo">
        <img src="../assets/img/logo.svg">
        Fitteya Tech
      </div>
      <div class="navbarButtons">
        <ul>
          <a href="index.html">Início</a>
          <a href="sobre.html">Sobre Nós</a>
          <a href="contato.html">Contato</a>
          <a href="hist.html">Nossa História</a>
          <a href="calc.html">Simulador Financeiro</a>
        </ul>
        <button onclick="loginScreen()">Login</button>
      </div>
    </nav>
  </header>`
})();