
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.VooDAO" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>
<%@ page import="br.com.controlesessao.Conexao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
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

    int vooId;

    try {
        vooId = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect("listarVoosPassageiro.jsp");
        return;
    }

    VooDAO vooDAO = new VooDAO();
    String[] voo = vooDAO.buscarPorId(vooId);

    if (voo == null
            || !"DISPONIVEL".equalsIgnoreCase(voo[9])
            || Integer.parseInt(voo[8]) <= 0) {
        response.sendRedirect("listarVoosPassageiro.jsp");
        return;
    }

    BigDecimal preco = new BigDecimal(voo[7]);
%>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <title>Reservar voo - World Airplane</title>
</head>

<body>

    <h1>World Airplane</h1>

    <h2>Reservar voo</h2>

    <p>Passageiro: <%= usuario %></p>

    <hr>

    <h3>Detalhes do voo</h3>

    <p><strong>Código:</strong> <%= voo[1] %></p>
    <p><strong>Origem:</strong> <%= voo[2] %></p>
    <p><strong>Destino:</strong> <%= voo[3] %></p>
    <p><strong>Data:</strong> <%= voo[4] %></p>
    <p><strong>Partida:</strong> <%= voo[5] %></p>
    <p><strong>Chegada:</strong> <%= voo[6] %></p>
    <p><strong>Preço por passageiro:</strong> R$ <%= preco %></p>
    <p><strong>Assentos disponíveis:</strong> <%= voo[8] %></p>

    <hr>

    <h3>Escolha a quantidade de passageiros</h3>

    <form action="confirmarReserva.jsp" method="post">

        <input type="hidden" name="vooId"
               value="<%= vooId %>">

        <label for="quantidade">
            Quantidade de passageiros:
        </label>

        <input
            type="number"
            id="quantidade"
            name="quantidade"
            min="1"
            max="<%= voo[8] %>"
            value="1"
            required
        >

        <br><br>

        <button type="submit">
            Continuar para confirmação
        </button>

    </form>

    <br>

    <a href="listarVoosPassageiro.jsp">
        Voltar aos voos disponíveis
    </a>

</body>
</html>
