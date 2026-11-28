
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>

<%
    request.setCharacterEncoding("UTF-8");

    String usuario = (String) session.getAttribute("usuario");
    String token = (String) session.getAttribute("token");
    String perfil = (String) session.getAttribute("tipo_usuario");

    if (usuario == null || token == null || !"ADMIN".equals(perfil)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    UsuarioDAO dao = new UsuarioDAO();

    if (!dao.validarToken(usuario, token, session.getId())) {
        session.invalidate();
        response.sendRedirect("../login.jsp");
        return;
    }

    String[] passageiro = null;
    String erro = null;

    try {
        int id = Integer.parseInt(request.getParameter("id"));
        passageiro = dao.buscarPassageiroPorId(id);

        if (passageiro == null) {
            erro = "Passageiro não encontrado.";
        }

    } catch (Exception e) {
        erro = "Não foi possível consultar o passageiro.";
        application.log("Erro ao consultar passageiro", e);
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Passageiro - World Airplane</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px;
            font-family: Arial, sans-serif;
            background: #f1f5f2;
            color: #26352b;
        }

        .container {
            max-width: 700px;
            margin: 40px auto;
        }

        h1 {
            color: #176b3a;
        }

        .painel {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.07);
        }

        .informacao {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        .informacao strong {
            display: inline-block;
            width: 150px;
            color: #176b3a;
        }

        .voltar {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 18px;
            background: #176b3a;
            color: white;
            text-decoration: none;
            border-radius: 8px;
        }

        .erro {
            color: #b42318;
            background: #fff0ef;
            padding: 15px;
            border-radius: 8px;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Detalhes do passageiro</h1>

    <div class="painel">

        <% if (erro != null) { %>

            <p class="erro"><%= erro %></p>

        <% } else { %>

            <div class="informacao">
                <strong>ID:</strong>
                <%= passageiro[0] %>
            </div>

            <div class="informacao">
                <strong>Usuário:</strong>
                <%= passageiro[1] %>
            </div>

            <div class="informacao">
                <strong>Perfil:</strong>
                PASSAGEIRO
            </div>

        <% } %>

        <a class="voltar" href="listarPassageiros.jsp">
            Voltar para passageiros
        </a>

    </div>

</div>

</body>
</html>
