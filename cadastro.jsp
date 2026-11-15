
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Cadastro de usuário</title>

    <link rel="stylesheet" href="css/estilo.css">
</head>

<body>

    <div class="container">

        <h2>Criar conta</h2>

        <p>Preencha os dados para cadastrar seu usuário.</p>

        <form action="salvarCadastro.jsp" method="POST">

            <label for="usuario">Usuário:</label>
            <input
                type="text"
                id="usuario"
                name="usuario"
                maxlength="50"
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

            <button type="submit">Cadastrar</button>

        </form>

        <p>Já possui uma conta?</p>
        <p><a href="index.jsp">Voltar para o login</a></p>

    </div>

</body>
</html>
