
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>

<%
response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");

jakarta.servlet.http.HttpSession sessao = request.getSession(false);

// Verifica se existe uma sessão
if (sessao == null) {
    response.sendRedirect("index.jsp");
    return;
}

// Recupera os dados da sessão
String usuario = (String) sessao.getAttribute("usuario");
String token = (String) sessao.getAttribute("token");

// Verifica se existem usuário e token
if (usuario == null || token == null) {
    sessao.invalidate();
    response.sendRedirect("index.jsp");
    return;
}

// Confere o token no banco de dados
try {

    UsuarioDAO dao = new UsuarioDAO();

    boolean autorizado = dao.validarToken(
        usuario,
        token,
        sessao.getId()
    );

    if (!autorizado) {
        sessao.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }

} catch (Exception e) {

    application.log("Erro ao verificar autorização", e);

    sessao.invalidate();
    response.sendRedirect("index.jsp");
    return;
}
%>
