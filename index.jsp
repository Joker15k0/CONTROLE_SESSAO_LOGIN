
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
    <title>World Airplane | Login</title>
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
            <span class="tagline">EXPLORE O MUNDO</span>

            <h1>O mundo está<br>esperando por você.</h1>

            <p>
                Encontre seu próximo destino, escolha seu voo
                e prepare-se para viver novas experiências.
            </p>

            <div class="features">
                <div>✈ Voos para diversos destinos</div>
                <div>◉ Reservas de forma simples</div>
                <div>✓ Segurança em sua viagem</div>
            </div>
        </section>

        <section class="login-card">

            <div class="card-icon">✈</div>

            <h2>Bem-vindo a bordo!</h2>
            <p class="subtitle">Entre na sua conta para continuar.</p>

            <form action="login.jsp" method="POST">

                <label for="usuario">Usuário</label>
                <input
                    type="text"
                    id="usuario"
                    name="usuario"
                    placeholder="Digite seu usuário"
                    required
                >

                <label for="senha">Senha</label>
                <input
                    type="password"
                    id="senha"
                    name="senha"
                    placeholder="Digite sua senha"
                    required
                >

                <button type="submit">
                    Entrar na minha conta <span>→</span>
                </button>

            </form>

            <div class="register">
                <p>Ainda não possui uma conta?</p>
                <a href="cadastro.jsp">Criar minha conta</a>
            </div>

            <div class="secure">
                <span>🔒</span> Acesso seguro à sua conta
            </div>

        </section>

    </main>

    <footer>
        © 2026 World Airplane — Conectando você ao mundo.
    </footer>

</body>
</html>
