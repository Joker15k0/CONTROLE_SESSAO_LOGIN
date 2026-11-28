
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>

<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");

String usuario = (String) session.getAttribute("usuario");
String token = (String) session.getAttribute("token");
String perfil = (String) session.getAttribute("tipo_usuario");

if (usuario == null || token == null || !"ADMIN".equals(perfil)) {
    response.sendRedirect("../index.jsp");
    return;
}

UsuarioDAO dao = new UsuarioDAO();

if (!dao.validarToken(usuario, token, session.getId())) {
    session.invalidate();
    response.sendRedirect("../index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel Administrativo - World Airplane</title>
    <link rel="stylesheet" href="../css/estilo.css">

    <style>
        .admin-container {
            max-width: 1100px;
            margin: 50px auto;
            padding: 25px;
        }

        .admin-header {
            background: #0b2d52;
            color: white;
            padding: 30px;
            border-radius: 16px;
            margin-bottom: 25px;
        }

        .admin-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .admin-card {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0,0,0,.08);
        }

        .admin-card h2 {
            color: #0b2d52;
        }

        .admin-card p {
            color: #64748b;
        }

        .admin-card a {
            display: inline-block;
            margin-top: 12px;
            color: #0875d1;
            font-weight: bold;
            text-decoration: none;
        }

        .admin-card a:hover {
            text-decoration: underline;
        }

        .admin-logout {
            display: inline-block;
            margin-top: 20px;
            color: white !important;
            text-decoration: none !important;
            background: #dc3545;
            padding: 10px 18px;
            border-radius: 8px;
        }
    </style>
</head>

<body>

<header class="topbar">
    <div class="logo">
        <span class="logo-icon">✈</span>
        <span>WORLD <strong>AIRPLANE</strong></span>
    </div>
    <span class="top-message">Área administrativa</span>
</header>

<main class="admin-container">

    <section class="admin-header">
        <h1>Painel do Administrador</h1>
        <p>Bem-vindo, <strong><%= usuario %></strong>!</p>
        <p>Gerencie as operações da World Airplane.</p>

        <a href="../logout.jsp" class="admin-logout">Sair do sistema</a>
    </section>

    <section class="admin-grid">

        <article class="admin-card">
            <h2>✈️ Voos</h2>
            <p>Cadastrar e gerenciar voos.</p>

            <a href="listarVoos.jsp">Gerenciar voos</a>
            <br>
            <a href="cadastrarVoo.jsp" class="btn">Cadastrar novo voo</a>
        </article>

        <article class="admin-card">
            <h2>👥 Passageiros</h2>
            <p>Consultar passageiros cadastrados.</p>
            <a href="listarPassageiros.jsp">Ver passageiros</a>
        </article>

        <article class="admin-card">
            <h2>🎫 Reservas</h2>
            <p>Consultar e gerenciar reservas.</p>
            <a href="#">Ver reservas</a>
        </article>

        <article class="admin-card">
            <h2>💰 Preços</h2>
            <p>Gerenciar valores das passagens.</p>
            <a href="#">Gerenciar preços</a>
        </article>

    </section>

</main>

</body>
</html>
