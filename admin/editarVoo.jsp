
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>
<%@ page import="br.com.controlesessao.VooDAO" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalTime" %>

<%
    String usuario = (String) session.getAttribute("usuario");
    String token = (String) session.getAttribute("token");
    String tipo = (String) session.getAttribute("tipo_usuario");

    if (usuario == null || token == null || !"ADMIN".equals(tipo)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    UsuarioDAO usuarioDAO = new UsuarioDAO();

    if (!usuarioDAO.validarToken(usuario, token, session.getId())) {
        session.invalidate();
        response.sendRedirect("../index.jsp");
        return;
    }

    String mensagem = "";
    String classe = "";
    String[] voo = null;
    int id = 0;

    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect("listarVoos.jsp");
        return;
    }

    VooDAO vooDAO = new VooDAO();

    try {
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            request.setCharacterEncoding("UTF-8");

            String codigo = request.getParameter("codigo");
            String origem = request.getParameter("origem");
            String destino = request.getParameter("destino");

            LocalDate data = LocalDate.parse(request.getParameter("data"));
            LocalTime partida = LocalTime.parse(request.getParameter("partida"));
            LocalTime chegada = LocalTime.parse(request.getParameter("chegada"));

            BigDecimal preco = new BigDecimal(request.getParameter("preco"));
            int assentos = Integer.parseInt(request.getParameter("assentos"));

            boolean atualizado = vooDAO.atualizar(
                id, codigo, origem, destino,
                data, partida, chegada, preco, assentos
            );

            if (atualizado) {
                response.sendRedirect("listarVoos.jsp?editado=1");
                return;
            } else {
                mensagem = "Não foi possível atualizar. Confira os dados.";
                classe = "erro";
            }
        }

        voo = vooDAO.buscarPorId(id);

        if (voo == null) {
            response.sendRedirect("listarVoos.jsp");
            return;
        }

    } catch (Exception e) {
        application.log("Erro ao editar voo", e);
        mensagem = "Erro ao processar os dados. Verifique os valores informados.";
        classe = "erro";

        voo = vooDAO.buscarPorId(id);

        if (voo == null) {
            response.sendRedirect("listarVoos.jsp");
            return;
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar voo | World Airplane</title>

    <link rel="stylesheet" href="../css/estilo.css">

    <style>
        body {
            background: #f1f5f9;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,.07);
        }

        h1 {
            color: #123b66;
        }

        .formulario {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
            margin-top: 25px;
        }

        .campo {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .campo label {
            font-weight: bold;
            color: #334155;
        }

        .campo input {
            padding: 13px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
        }

        .completo {
            grid-column: 1 / -1;
        }

        .salvar {
            padding: 14px;
            border: none;
            border-radius: 8px;
            background: #0879c9;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .salvar:hover {
            background: #075fa0;
        }

        .erro {
            padding: 12px;
            border-radius: 8px;
            background: #fee2e2;
            color: #991b1b;
            margin-top: 15px;
        }

        .voltar {
            display: inline-block;
            margin-top: 20px;
            color: #0879c9;
            text-decoration: none;
            font-weight: bold;
        }

        @media(max-width: 600px) {
            .formulario {
                grid-template-columns: 1fr;
            }

            .completo {
                grid-column: auto;
            }

            .container {
                margin: 15px;
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Editar voo ✈️</h1>
    <p>Altere as informações do voo selecionado.</p>

    <% if (!mensagem.isEmpty()) { %>
        <div class="<%= classe %>"><%= mensagem %></div>
    <% } %>

    <form method="POST" action="editarVoo.jsp?id=<%= id %>" class="formulario">

        <div class="campo">
            <label>Código do voo</label>
            <input type="text" name="codigo"
                   value="<%= voo[1] %>" maxlength="20" required>
        </div>

        <div class="campo">
            <label>Data da viagem</label>
            <input type="date" name="data"
                   value="<%= voo[4] %>" required>
        </div>

        <div class="campo">
            <label>Origem</label>
            <input type="text" name="origem"
                   value="<%= voo[2] %>" maxlength="100" required>
        </div>

        <div class="campo">
            <label>Destino</label>
            <input type="text" name="destino"
                   value="<%= voo[3] %>" maxlength="100" required>
        </div>

        <div class="campo">
            <label>Horário de partida</label>
            <input type="time" name="partida"
                   value="<%= voo[5].substring(0,5) %>" required>
        </div>

        <div class="campo">
            <label>Horário de chegada</label>
            <input type="time" name="chegada"
                   value="<%= voo[6].substring(0,5) %>" required>
        </div>

        <div class="campo">
            <label>Preço (R$)</label>
            <input type="number" name="preco"
                   value="<%= voo[7] %>" min="0.01"
                   step="0.01" required>
        </div>

        <div class="campo">
            <label>Quantidade de assentos</label>
            <input type="number" name="assentos"
                   value="<%= voo[8] %>" min="1" required>
        </div>

        <div class="campo completo">
            <button type="submit" class="salvar">
                Salvar alterações
            </button>
        </div>

    </form>

    <a href="listarVoos.jsp" class="voltar">
        ← Voltar para os voos
    </a>

</div>

</body>
</html>
