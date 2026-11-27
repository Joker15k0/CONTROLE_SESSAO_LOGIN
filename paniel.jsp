
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="autorizo.jsp" %>

<%
String usuario = (String) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Painel - Controle de Sessão</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f1f3f6;
        }

        header {
            background: #1769aa;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        main {
            max-width: 800px;
            margin: 60px auto;
            padding: 35px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px #0002;
        }

        h1 {
            color: #222;
        }

        .informacao {
            padding: 20px;
            background: #eef5fc;
            border-radius: 8px;
            margin-top: 25px;
        }

        .botao {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 22px;
            background: #c62828;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>

<body>

    <header>
        <strong>Controle de Sessão</strong>
        <span>Área do usuário</span>
    </header>

    <main>

        <h1>Bem-vindo, <%= usuario %>!</h1>

        <p>Você entrou no sistema com sucesso.</p>

        <div class="informacao">
            <h3>Informações da sessão</h3>

            <p><strong>Usuário:</strong> <%= usuario %></p>

            <p><strong>ID da sessão:</strong>
                <%= session.getId() %>
            </p>

            <p><strong>Status:</strong> Autorizado</p>
        </div>

        <a class="botao" href="logout.jsp">Sair do sistema</a>

    </main>

</body>
</html>
