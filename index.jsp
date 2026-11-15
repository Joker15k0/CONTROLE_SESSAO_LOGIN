
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
    <title>Login - Controle de Sessão</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f1f3f6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background: white;
            width: 380px;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 4px 15px #0002;
        }

        h2 {
            text-align: center;
            color: #222;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-top: 18px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-top: 7px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            background: #1769aa;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background: #105386;
        }

        .cadastro {
            text-align: center;
            margin-top: 22px;
        }

        a {
            color: #1769aa;
            text-decoration: none;
        }
    </style>
</head>

<body>

    <div class="container">

        <h2>Controle de Sessão</h2>

        <form action="login.jsp" method="POST">

            <label>Usuário:</label>
            <input type="text" name="usuario" required>

            <label>Senha:</label>
            <input type="password" name="senha" required>

            <button type="submit">Entrar</button>

        </form>

        <div class="cadastro">
            <p>Não possui uma conta?</p>
            <a href="cadastro.jsp">Criar conta</a>
        </div>

    </div>

</body>
</html>
