
package br.com.controlesessao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class TesteSenha {

    public static void main(String[] args) {

        String usuario = "caio_teste2";
        String novaSenha = "Teste@123";

        try {

            // Gerar novo hash
            String novoHash = Seguranca.gerarHash(novaSenha);

            String sql = """
                UPDATE autenticacaoMais
                SET senhaHash = ?,
                    tokenVigente = NULL,
                    sessaoUltima = NULL
                WHERE usuario = ?
                """;

            try (Connection conexao = Conexao.conectar();
                 PreparedStatement comando =
                     conexao.prepareStatement(sql)) {

                comando.setString(1, novoHash);
                comando.setString(2, usuario);

                int linhas = comando.executeUpdate();

                if (linhas == 1) {
                    System.out.println("SENHA ATUALIZADA COM SUCESSO!");
                    System.out.println("Usuario: " + usuario);
                    System.out.println("Nova senha: " + novaSenha);
                } else {
                    System.out.println("USUARIO NAO ENCONTRADO!");
                }
            }

        } catch (Exception e) {
            System.out.println("ERRO AO ATUALIZAR SENHA:");
            e.printStackTrace();
        }
    }
}
