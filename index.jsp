
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Se já estiver autenticado, direciona para o painel
    if (session.getAttribute("token") != null) {
        response.sendRedirect("painel.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login - Controle de Sessão</title>

    <link rel="stylesheet" href="css/estilo.css">
</head>

<body>

    <div class="container">

        <h2>Controle de Sessão</h2>

        <p>Acesse sua conta para continuar</p>

        <form action="login.jsp" method="POST">

            <label for="usuario">Usuário:</label>
            <input
                type="text"
                id="usuario"
                name="usuario"
                placeholder="Digite seu usuário"
                required
            >

            <label for="senha">Senha:</label>
            <input
                type="password"
                id="senha"
                name="senha"
                placeholder="Digite sua senha"
                required
            >

            <button type="submit">Entrar</button>

        </form>

        <div class="cadastro">
            <p>Não possui uma conta?</p>
            <a href="cadastro.jsp">Criar conta</a>
        </div>

    </div>

</body>
</html>
