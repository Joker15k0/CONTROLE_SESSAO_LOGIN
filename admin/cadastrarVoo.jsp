
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>
<%@ page import="br.com.controlesessao.VooDAO" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.sql.SQLException" %>

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
    String classeMensagem = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");

        try {
            String codigo = request.getParameter("codigo");
            String origem = request.getParameter("origem");
            String destino = request.getParameter("destino");

            LocalDate data = LocalDate.parse(request.getParameter("data"));
            LocalTime partida = LocalTime.parse(request.getParameter("partida"));
            LocalTime chegada = LocalTime.parse(request.getParameter("chegada"));

            BigDecimal preco = new BigDecimal(
                request.getParameter("preco").replace(",", ".")
            );

            int assentos = Integer.parseInt(request.getParameter("assentos"));

            VooDAO vooDAO = new VooDAO();

            boolean cadastrado = vooDAO.cadastrar(
                codigo, origem, destino, data,
                partida, chegada, preco, assentos
            );

            if (cadastrado) {
                mensagem = "Voo cadastrado com sucesso!";
                classeMensagem = "sucesso";
            } else {
                mensagem = "Não foi possível cadastrar. Confira os dados e horários.";
                classeMensagem = "erro";
            }

        } catch (Exception e) {
            mensagem = "Dados inválidos ou código de voo já cadastrado.";
            classeMensagem = "erro";
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar voo | World Airplane</title>

    <link rel="stylesheet" href="../css/estilo.css">

    <style>
        .voo-container {
            max-width: 850px;
            margin: 40px auto;
            padding: 30px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 5px 25px rgba(0,0,0,.08);
        }

        .voo-container h1 {
            color: #123b66;
            margin-bottom: 8px;
        }

        .voo-container p {
            color: #64748b;
            margin-bottom: 25px;
        }

        .voo-form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .campo {
            display: flex;
            flex-direction: column;
            gap: 7px;
        }

        .campo label {
            font-weight: 600;
            color: #334155;
        }

        .campo input {
            padding: 13px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
            width: 100%;
            box-sizing: border-box;
        }

        .campo input:focus {
            outline: none;
            border-color: #1683d8;
        }

        .campo.completo {
            grid-column: 1 / -1;
        }

        .btn-cadastrar {
            padding: 14px;
            border: none;
            border-radius: 8px;
            background: #0879c9;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-cadastrar:hover {
            background: #075fa0;
        }

        .mensagem {
            padding: 13px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .sucesso {
            background: #dcfce7;
            color: #166534;
        }

        .erro {
            background: #fee2e2;
            color: #991b1b;
        }

        .voltar {
            display: inline-block;
            margin-top: 22px;
            color: #0879c9;
            text-decoration: none;
            font-weight: bold;
        }

        @media (max-width: 600px) {
            .voo-form {
                grid-template-columns: 1fr;
            }

            .campo.completo {
                grid-column: auto;
            }

            .voo-container {
                margin: 20px 12px;
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<div class="voo-container">

    <h1>Cadastrar novo voo</h1>
    <p>Preencha as informações para adicionar um voo ao World Airplane.</p>

    <% if (!mensagem.isEmpty()) { %>
        <div class="mensagem <%= classeMensagem %>">
            <%= mensagem %>
        </div>
    <% } %>

    <form method="POST" action="cadastrarVoo.jsp" class="voo-form">

        <div class="campo">
            <label for="codigo">Código do voo</label>
            <input type="text" id="codigo" name="codigo"
                   placeholder="Ex.: WA101" maxlength="20" required>
        </div>

        <div class="campo">
            <label for="data">Data da viagem</label>
            <input type="date" id="data" name="data" required>
        </div>

        <div class="campo">
            <label for="origem">Origem</label>
            <input type="text" id="origem" name="origem"
                   placeholder="Ex.: São Paulo" maxlength="100" required>
        </div>

        <div class="campo">
            <label for="destino">Destino</label>
            <input type="text" id="destino" name="destino"
                   placeholder="Ex.: Rio de Janeiro" maxlength="100" required>
        </div>

        <div class="campo">
            <label for="partida">Horário de partida</label>
            <input type="time" id="partida" name="partida" required>
        </div>

        <div class="campo">
            <label for="chegada">Horário de chegada</label>
            <input type="time" id="chegada" name="chegada" required>
        </div>

        <div class="campo">
            <label for="preco">Preço da passagem (R$)</label>
            <input type="number" id="preco" name="preco"
                   placeholder="Ex.: 450.00" min="0.01"
                   step="0.01" required>
        </div>

        <div class="campo">
            <label for="assentos">Quantidade de assentos</label>
            <input type="number" id="assentos" name="assentos"
                   placeholder="Ex.: 180" min="1" required>
        </div>

        <div class="campo completo">
            <button type="submit" class="btn-cadastrar">
                Cadastrar voo
            </button>
        </div>

    </form>

    <a href="painelAdmin.jsp" class="voltar">
        ← Voltar ao painel administrativo
    </a>

</div>

</body>
</html>
