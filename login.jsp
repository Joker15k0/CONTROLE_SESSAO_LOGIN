
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.util.Base64" %>

<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");

String usuario = request.getParameter("usuario");
String senha = request.getParameter("senha");

String mensagem = "Usuário ou senha incorretos.";

if (usuario == null || usuario.trim().isEmpty()
        || senha == null || senha.isEmpty()) {

    mensagem = "Informe o usuário e a senha.";

} else {

    try {
        jakarta.servlet.http.HttpSession sessao = request.getSession();

        request.changeSessionId();

        byte[] bytesToken = new byte[32];
        new SecureRandom().nextBytes(bytesToken);

        String token = Base64.getUrlEncoder()
            .withoutPadding()
            .encodeToString(bytesToken);

        String idSessao = sessao.getId();

        UsuarioDAO dao = new UsuarioDAO();

        String perfil = dao.autenticarEAtualizarTokenEObterPerfil(
            usuario,
            senha,
            token,
            idSessao
        );

        if (perfil != null) {

            sessao.setAttribute("usuario", usuario.trim());
            sessao.setAttribute("token", token);
            sessao.setAttribute("tipo_usuario", perfil);

            if ("ADMIN".equals(perfil)) {
                response.sendRedirect("admin/painelAdmin.jsp");
            } else {
                response.sendRedirect("painel.jsp");
            }

            return;

        } else {

            sessao.invalidate();
        }

    } catch (Exception e) {

        application.log("Erro durante a autenticação", e);

        mensagem = "Erro ao realizar login. Verifique o servidor.";
    }
}
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Acesso não autorizado - World Airplane</title>

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

    <main class="result-main">

        <section class="result-card">

            <div class="result-icon error-icon">!</div>

            <h1>Não foi possível entrar</h1>

            <p><%= mensagem %></p>

            <a href="index.jsp" class="result-button">
                Voltar ao login →
            </a>

            <div class="secure">
                🔒 Acesso protegido - World Airplane
            </div>

        </section>

    </main>

    <footer>
        © 2026 World Airplane — Conectando você ao mundo.
    </footer>

</body>
</html>
