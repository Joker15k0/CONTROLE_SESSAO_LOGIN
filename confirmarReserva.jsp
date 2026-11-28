
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>
<%@ page import="br.com.controlesessao.ReservaDAO" %>
<%@ page import="br.com.controlesessao.Conexao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

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

    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("listarVoosPassageiro.jsp");
        return;
    }

    int vooId;
    int quantidade;
    int usuarioId = 0;

    try {
        vooId = Integer.parseInt(request.getParameter("vooId"));
        quantidade = Integer.parseInt(request.getParameter("quantidade"));

        if (vooId <= 0 || quantidade <= 0) {
            throw new NumberFormatException();
        }

    } catch (Exception e) {
        response.sendRedirect("listarVoosPassageiro.jsp");
        return;
    }

    // BUSCAR ID DO PASSAGEIRO
    String sqlUsuario =
        "SELECT id FROM autenticacaoMais WHERE usuario = ?";

    try (Connection conexao = Conexao.conectar();
         PreparedStatement comando = conexao.prepareStatement(sqlUsuario)) {

        comando.setString(1, usuario);

        try (ResultSet resultado = comando.executeQuery()) {
            if (resultado.next()) {
                usuarioId = resultado.getInt("id");
            }
        }
    }

    if (usuarioId <= 0) {
        throw new Exception("Não foi possível localizar o passageiro.");
    }

    // REALIZAR RESERVA
    ReservaDAO reservaDAO = new ReservaDAO();

    boolean sucesso = reservaDAO.reservar(
        usuarioId,
        vooId,
        quantidade
    );
%>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <title>Confirmação de reserva - World Airplane</title>
</head>

<body>

    <h1>World Airplane</h1>

    <% if (sucesso) { %>

        <h2>Reserva realizada com sucesso!</h2>

        <p>Passageiro: <%= usuario %></p>

        <p>Sua reserva foi registrada no banco de dados.</p>

        <p>Quantidade de passageiros: <%= quantidade %></p>

        <h3>Boa viagem!</h3>

        <a href="listarVoosPassageiro.jsp">
            Ver outros voos
        </a>

    <% } else { %>

        <h2>Não foi possível realizar a reserva.</h2>

        <p>Verifique se o voo está disponível e possui assentos suficientes.</p>

        <a href="listarVoosPassageiro.jsp">
            Voltar aos voos
        </a>

    <% } %>

    <br><br>

    <a href="painel.jsp">Voltar ao painel</a>

</body>
</html>
