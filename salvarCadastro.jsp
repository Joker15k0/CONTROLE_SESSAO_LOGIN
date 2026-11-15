
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
    <title>Resultado do cadastro</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f1f3f6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .container {
            background: white;
            width: 350px;
            padding: 35px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 15px #0002;
        }

        h2 {
            color: #222;
        }

        p {
            color: #444;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            background: #1769aa;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
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
