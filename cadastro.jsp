
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
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

    <title>Cadastro - World Airplane</title>

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

    <main class="main-content">

        <section class="presentation">

            <div class="plane-icon">✈</div>

            <span class="tagline">COMECE SUA JORNADA</span>

            <h1>Seu próximo destino está esperando.</h1>

            <p>
                Crie sua conta no World Airplane e prepare-se
                para descobrir novos lugares e viver grandes experiências.
            </p>

            <div class="features">
                <div>✈ Encontre seu próximo voo</div>
                <div>◉ Organize suas viagens</div>
                <div>✓ Tenha suas reservas em um só lugar</div>
            </div>

        </section>

        <section class="login-card">

            <div class="card-icon">✈</div>

            <h2>Criar minha conta</h2>

            <p class="subtitle">
                Cadastre-se para começar a viajar.
            </p>

            <form action="salvarCadastro.jsp" method="POST">

                <label for="usuario">Nome de usuário</label>

                <input
                    type="text"
                    id="usuario"
                    name="usuario"
                    maxlength="50"
                    placeholder="Escolha seu usuário"
                    required
                >

                <label for="senha">Senha</label>

                <input
                    type="password"
                    id="senha"
                    name="senha"
                    placeholder="Crie sua senha"
                    required
                >

                <button type="submit">
                    Criar minha conta <span>→</span>
                </button>

            </form>

            <div class="register">

                <p>Já possui uma conta?</p>

                <a href="index.jsp">Voltar para o login</a>

            </div>

            <div class="secure">
                🔒 Seus dados protegidos
            </div>

        </section>

    </main>

    <footer>
        © 2026 World Airplane — Conectando você ao mundo.
    </footer>

</body>
</html>
