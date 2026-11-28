
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.VooDAO" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>

<%
    request.setCharacterEncoding("UTF-8");

    String usuario = (String) session.getAttribute("usuario");
    String token = (String) session.getAttribute("token");
    String tipoUsuario = (String) session.getAttribute("tipo_usuario");

    if (usuario == null || token == null
            || !"USUARIO".equals(tipoUsuario)) {
        response.sendRedirect("login.jsp");
        return;
    }

    UsuarioDAO usuarioDAO = new UsuarioDAO();

    if (!usuarioDAO.validarToken(usuario, token, session.getId())) {
        session.invalidate();
        response.sendRedirect("login.jsp");
        return;
    }

    VooDAO vooDAO = new VooDAO();
    List<String[]> voos = vooDAO.listarVoosDisponiveis();
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Voos disponíveis - World Airplane</title>
</head>

<body>

    <h1>World Airplane</h1>
    <h2>Voos disponíveis</h2>

    <p>Bem-vindo, <%= usuario %>!</p>

    <p>
        <a href="painel.jsp">Voltar ao painel</a>
        |
        <a href="logout.jsp">Sair</a>
    </p>

    <hr>

    <% if (voos.isEmpty()) { %>

        <h3>Nenhum voo disponível no momento.</h3>

    <% } else { %>

        <table border="1" cellpadding="10" cellspacing="0">

            <tr>
                <th>Código</th>
                <th>Origem</th>
                <th>Destino</th>
                <th>Data</th>
                <th>Partida</th>
                <th>Chegada</th>
                <th>Preço</th>
                <th>Assentos disponíveis</th>
                <th>Ação</th>
            </tr>

            <% for (String[] voo : voos) { %>

                <tr>
                    <td><%= voo[1] %></td>
                    <td><%= voo[2] %></td>
                    <td><%= voo[3] %></td>
                    <td><%= voo[4] %></td>
                    <td><%= voo[5] %></td>
                    <td><%= voo[6] %></td>
                    <td>R$ <%= voo[7] %></td>
                    <td><%= voo[8] %></td>

                    <td>
                        <a href="reservarVoo.jsp?id=<%= voo[0] %>">
                            Reservar
                        </a>
                    </td>
                </tr>

            <% } %>

        </table>

    <% } %>

</body>
</html>
