
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>
<%@ page import="br.com.controlesessao.VooDAO" %>
<%@ page import="java.util.List" %>

<%!
    public String escapar(String valor) {
        if (valor == null) return "";
        return valor.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>

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

    List<String[]> voos = null;
    String erro = null;

    try {
        VooDAO vooDAO = new VooDAO();
        voos = vooDAO.listarTodos();
    } catch (Exception e) {
        application.log("Erro ao listar voos", e);
        erro = "Não foi possível carregar os voos. Verifique o banco de dados.";
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Gerenciar voos | World Airplane</title>

    <link rel="stylesheet" href="../css/estilo.css">

    <style>
        body {
            background: #f1f5f9;
            font-family: Arial, sans-serif;
        }

        .container-voos {
            max-width: 1250px;
            margin: 40px auto;
            padding: 25px;
            background: white;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0,0,0,.06);
        }

        .cabecalho {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        h1 {
            color: #123b66;
            margin: 0 0 8px;
        }

        .subtitulo {
            color: #64748b;
        }

        .btn {
            display: inline-block;
            padding: 12px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            background: #0879c9;
            color: white;
        }

        .tabela-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1050px;
        }

        th, td {
            padding: 14px 12px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }

        th {
            background: #123b66;
            color: white;
        }

        tr:hover td {
            background: #f8fafc;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            background: #dcfce7;
            color: #166534;
            font-size: 12px;
            font-weight: bold;
        }

        .btn-editar {
            display: inline-block;
            padding: 8px 12px;
            border-radius: 6px;
            background: #0879c9;
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .btn-editar:hover {
            background: #075fa0;
        }

        .erro {
            background: #fee2e2;
            color: #991b1b;
            padding: 15px;
            border-radius: 8px;
        }

        .vazio {
            padding: 30px;
            text-align: center;
            color: #64748b;
        }

        .voltar {
            display: inline-block;
            margin-top: 25px;
            color: #0879c9;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="container-voos">

    <div class="cabecalho">
        <div>
            <h1>Gerenciamento de voos</h1>
            <p class="subtitulo">
                Consulte os voos cadastrados no World Airplane.
            </p>
        </div>

        <a href="cadastrarVoo.jsp" class="btn">
            + Cadastrar voo
        </a>
    </div>

    <% if (erro != null) { %>

        <div class="erro">
            <%= escapar(erro) %>
        </div>

    <% } else if (voos.isEmpty()) { %>

        <div class="vazio">
            <h3>Nenhum voo cadastrado</h3>
            <p>Cadastre o primeiro voo para começar.</p>
        </div>

    <% } else { %>

        <div class="tabela-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Código</th>
                        <th>Origem</th>
                        <th>Destino</th>
                        <th>Data</th>
                        <th>Partida</th>
                        <th>Chegada</th>
                        <th>Preço</th>
                        <th>Assentos</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>

                <tbody>
                    <% for (String[] voo : voos) { %>
                        <tr>
                            <td><%= escapar(voo[0]) %></td>
                            <td><strong><%= escapar(voo[1]) %></strong></td>
                            <td><%= escapar(voo[2]) %></td>
                            <td><%= escapar(voo[3]) %></td>
                            <td><%= escapar(voo[4]) %></td>
                            <td><%= escapar(voo[5]) %></td>
                            <td><%= escapar(voo[6]) %></td>
                            <td>R$ <%= escapar(voo[7]) %></td>
                            <td><%= escapar(voo[8]) %></td>

                            <td>
                                <span class="status">
                                    <%= escapar(voo[9]) %>
                                </span>
                            </td>

                            <td>
                                <a class="btn-editar"
                                   href="editarVoo.jsp?id=<%= escapar(voo[0]) %>">
                                    ✏️ Editar
                                </a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    <% } %>

    <a href="painelAdmin.jsp" class="voltar">
        ← Voltar ao painel administrativo
    </a>

</div>

</body>
</html>
