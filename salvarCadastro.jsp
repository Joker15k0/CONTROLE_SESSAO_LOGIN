
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>

<%
request.setCharacterEncoding("UTF-8");

String usuario = request.getParameter("usuario");
String senha = request.getParameter("senha");

String mensagem;
boolean sucesso = false;

try {
    UsuarioDAO dao = new UsuarioDAO();

    sucesso = dao.cadastrar(usuario, senha);

    if (sucesso) {
        mensagem = "Sua conta foi criada com sucesso! Agora você já pode acessar o World Airplane.";
    } else {
        mensagem = "Usuário já existe ou os dados são inválidos.";
    }

} catch (Exception e) {
    mensagem = "Erro ao realizar o cadastro. Verifique a conexão com o banco.";
    application.log("Erro no cadastro de usuário", e);
}
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Resultado do cadastro - World Airplane</title>

    <link rel="stylesheet" href="css/estilo.css">
</head>

<body>

    <header class="topbar">
        <div class="logo">
            <span class="logo-icon">✈</span>
            <span>WORLD <strong>AIRPLANE</strong></span>
        </div>

        <span class="top-message">Sua viagem começa aqui</span>
    </header>

    <main class="result-main">

        <section class="result-card">

            <% if (sucesso) { %>

                <div class="result-icon">✓</div>

                <h1>Cadastro realizado!</h1>

            <% } else { %>

                <div class="result-icon error-icon">!</div>

                <h1>Não foi possível cadastrar</h1>

            <% } %>

            <p><%= mensagem %></p>

            <% if (sucesso) { %>

                <a href="index.jsp" class="result-button">
                    Ir para o login →
                </a>

            <% } else { %>

                <a href="cadastro.jsp" class="result-button">
                    Voltar ao cadastro →
                </a>

            <% } %>

            <div class="secure">
                ✈ World Airplane — Conectando você ao mundo.
            </div>

        </section>

    </main>

</body>
</html>
