
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
        mensagem = "Usuário cadastrado com sucesso!";
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

    <title>Resultado do cadastro</title>

    <link rel="stylesheet" href="css/estilo.css">
</head>

<body>

    <div class="container">

        <h2>Resultado</h2>

        <p><%= mensagem %></p>

        <% if (sucesso) { %>
            <a href="index.jsp">Ir para o login</a>
        <% } else { %>
            <a href="cadastro.jsp">Voltar ao cadastro</a>
        <% } %>

    </div>

</body>
</html>
