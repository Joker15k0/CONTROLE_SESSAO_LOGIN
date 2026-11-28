
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="br.com.controlesessao.UsuarioDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

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

    List<String[]> passageiros = new ArrayList<>();
    String erro = null;

    try {
        passageiros = dao.listarPassageiros();
    } catch (Exception e) {
        erro = "Não foi possível carregar os passageiros.";
        application.log("Erro ao listar passageiros", e);
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passageiros - World Airplane</title>

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
            max-width: 1000px;
            margin: 0 auto;
        }

        .topo {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        h1 {
            color: #176b3a;
            margin: 0;
        }

        .voltar {
            background: #176b3a;
            color: white;
            padding: 12px 18px;
            text-decoration: none;
            border-radius: 8px;
        }

        .painel {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.07);
        }

        .contador {
            color: #176b3a;
            font-weight: bold;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e5e5e5;
        }

        th {
            background: #176b3a;
            color: white;
        }

        tr:hover {
            background: #f4faf5;
        }

        .vazio {
            text-align: center;
            padding: 30px;
            color: #777;
        }

        .erro {
            color: #b42318;
            background: #fff0ef;
            padding: 15px;
            border-radius: 8px;
        }

        .detalhes {
            background: #176b3a;
            color: white;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 6px;
        }

        @media (max-width: 600px) {
            body {
                padding: 15px;
            }

            .painel {
                padding: 12px;
                overflow-x: auto;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="topo">
        <h1>Passageiros cadastrados</h1>

        <a class="voltar" href="painelAdmin.jsp">
            Voltar ao painel
        </a>
    </div>

    <div class="painel">

        <% if (erro != null) { %>

            <p class="erro"><%= erro %></p>

        <% } else { %>

            <p class="contador">
                Total de passageiros: <%= passageiros.size() %>
            </p>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome de usuário</th>
                        <th>Perfil</th>
                        <th>Ações</th>
                    </tr>
                </thead>

                <tbody>

                <% if (passageiros.isEmpty()) { %>

                    <tr>
                        <td colspan="4" class="vazio">
                            Nenhum passageiro cadastrado.
                        </td>
                    </tr>

                <% } else { %>

                    <% for (String[] passageiro : passageiros) { %>

                        <tr>
                            <td><%= passageiro[0] %></td>
                            <td><%= passageiro[1] %></td>
                            <td>PASSAGEIRO</td>
                            <td>
                                <a class="detalhes"
                                   href="detalhesPassageiro.jsp?id=<%= passageiro[0] %>">
                                    Ver detalhes
                                </a>
                            </td>
                        </tr>

                    <% } %>

                <% } %>

                </tbody>
            </table>

        <% } %>

    </div>

</div>

</body>
</html>
