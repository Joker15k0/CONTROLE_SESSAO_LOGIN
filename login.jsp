
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
        // Cria ou recupera a sessão e renova seu identificador
        jakarta.servlet.http.HttpSession sessao = request.getSession();

        request.changeSessionId();

        // Gera um token aleatório e exclusivo
        byte[] bytesToken = new byte[32];
        new SecureRandom().nextBytes(bytesToken);

        String token = Base64.getUrlEncoder()
            .withoutPadding()
            .encodeToString(bytesToken);

        String idSessao = sessao.getId();

        UsuarioDAO dao = new UsuarioDAO();

        boolean autorizado = dao.autenticarEAtualizarToken(
            usuario,
            senha,
            token,
            idSessao
        );

        if (autorizado) {

            sessao.setAttribute("usuario", usuario);
            sessao.setAttribute("token", token);

            response.sendRedirect("painel.jsp");
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
    <title>Login não autorizado</title>

    <style>
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
            text-align: center;
            box-shadow: 0 4px 15px #0002;
        }

        h2 {
            color: #222;
        }

        p {
            color: #444;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            background: #1769aa;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>

<body>

    <div class="container">

        <h2>Login não autorizado</h2>

        <p><%= mensagem %></p>

        <a href="index.jsp">Voltar ao login</a>

    </div>

</body>
</html>
