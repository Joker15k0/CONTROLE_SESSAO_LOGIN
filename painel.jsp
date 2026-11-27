
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="autorizo.jsp" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Painel - Controle de Sessão</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f1f5f9;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .container {
            background: white;
            padding: 35px;
            border-radius: 12px;
            width: 420px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h1 {
            color: #1e40af;
        }

        .status {
            color: #15803d;
            font-weight: bold;
        }

        .botao {
            display: inline-block;
            background: #dc2626;
            color: white;
            padding: 12px 25px;
            border-radius: 6px;
            text-decoration: none;
            margin-top: 20px;
        }

        .botao:hover {
            background: #b91c1c;
        }
    </style>
</head>

<body>

    <div class="container">

        <h1>Controle de Sessão</h1>

        <h2>Bem-vindo, <%= usuario %>!</h2>

        <p class="status">Sessão autorizada!</p>

        <p>
            Seu ID de sessão:
        </p>

        <p>
            <%= session.getId() %>
        </p>

        <p>
            Seu acesso foi validado pelo banco de dados.
        </p>

        <a href="logout.jsp" class="botao">
            Sair do sistema
        </a>

    </div>

</body>
</html>
