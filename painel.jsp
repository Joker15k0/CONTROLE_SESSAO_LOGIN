
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="autorizo.jsp" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Painel - Controle de Sessão</title>

    <link rel="stylesheet" href="css/estilo.css">
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
