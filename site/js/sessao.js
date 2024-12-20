// sessão
function validarSessao() {
  var email = sessionStorage.EMAIL_USUARIO;
  var nome = sessionStorage.NOME_USUARIO;
  var fkEmpresa = sessionStorage.FK_EMPRESA;
  var empNome = sessionStorage.EMP_NOME; 

  var b_usuario = document.getElementById("b_usuario");
  var b_empresa = document.getElementById('b_empresa')

  if (email != null && nome != null) {
    b_usuario.innerHTML = nome;
    b_empresa.innerHTML = empNome;
  } else {
    window.location = "../pages/login.html";
  }
}

function limparSessao() {
  sessionStorage.clear();
  window.location = "./login.html";
}

// carregamento (loading)
function aguardar() {
  var divAguardar = document.getElementById("div_aguardar");
  divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
  var divAguardar = document.getElementById("div_aguardar");
  // divAguardar.style.display = "none";

  var divErrosLogin = document.getElementById("div_erros_login");
  if (texto) {
    divErrosLogin.style.display = "flex";
    divErrosLogin.innerHTML = texto;
  }
}
