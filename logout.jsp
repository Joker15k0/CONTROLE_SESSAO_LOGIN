
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>

<%
response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");

jakarta.servlet.http.HttpSession sessao = request.getSession(false);

if (sessao != null) {

    String usuario = (String) sessao.getAttribute("usuario");
    String token = (String) sessao.getAttribute("token");

    try {
        if (usuario != null && token != null) {

            UsuarioDAO dao = new UsuarioDAO();

            dao.invalidarToken(usuario, token);
        }
    } catch (Exception e) {
        application.log("Erro ao invalidar token", e);
    }

    sessao.invalidate();
}

response.sendRedirect("index.jsp");
%>
