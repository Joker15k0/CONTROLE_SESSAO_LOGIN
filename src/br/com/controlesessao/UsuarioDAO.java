
package br.com.controlesessao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    // CADASTRAR USUARIO: cadastro publico sempre cria USUARIO
    public boolean cadastrar(String usuario, String senha) throws Exception {

        if (usuario == null || usuario.trim().isEmpty()
                || senha == null || senha.isEmpty()) {
            return false;
        }

        String sql = """
            INSERT INTO autenticacaoMais
            (usuario, senhaHash, tipo_usuario, tokenVigente,
             sessaoUltima, dataHoraUltimaAutorizacao)
            VALUES (?, ?, 'USUARIO', NULL, NULL, NULL)
            """;

        String hash = Seguranca.gerarHash(senha);

        try (Connection conexao = Conexao.conectar();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setString(1, usuario.trim());
            comando.setString(2, hash);

            comando.executeUpdate();
            return true;

        } catch (SQLException e) {

            if (e.getErrorCode() == 1062) {
                return false;
            }

            throw e;
        }
    }

    // AUTENTICAR E RETORNAR O PERFIL DO USUARIO
    // Retorna "USUARIO", "ADMIN" ou null se o login falhar.
    public String autenticarEAtualizarTokenEObterPerfil(
            String usuario,
            String senha,
            String token,
            String idSessao) throws Exception {

        if (usuario == null || usuario.trim().isEmpty()
                || senha == null || senha.isEmpty()
                || token == null || idSessao == null) {
            return null;
        }

        String sqlConsulta = """
            SELECT senhaHash, tipo_usuario
            FROM autenticacaoMais
            WHERE usuario = ?
            """;

        String sqlAtualizacao = """
            UPDATE autenticacaoMais
            SET tokenVigente = ?,
                sessaoUltima = ?,
                dataHoraUltimaAutorizacao = NOW()
            WHERE usuario = ?
            """;

        try (Connection conexao = Conexao.conectar()) {

            String hashArmazenado;
            String perfil;

            try (PreparedStatement consulta =
                    conexao.prepareStatement(sqlConsulta)) {

                consulta.setString(1, usuario.trim());

                try (ResultSet resultado = consulta.executeQuery()) {

                    if (!resultado.next()) {
                        return null;
                    }

                    hashArmazenado = resultado.getString("senhaHash");
                    perfil = resultado.getString("tipo_usuario");
                }
            }

            if (!Seguranca.verificarSenha(senha, hashArmazenado)) {
                return null;
            }

            if (!"USUARIO".equals(perfil) && !"ADMIN".equals(perfil)) {
                return null;
            }

            try (PreparedStatement atualizacao =
                    conexao.prepareStatement(sqlAtualizacao)) {

                atualizacao.setString(1, token);
                atualizacao.setString(2, idSessao);
                atualizacao.setString(3, usuario.trim());

                if (atualizacao.executeUpdate() == 1) {
                    return perfil;
                }

                return null;
            }
        }
    }

    // METODO ANTIGO MANTIDO PARA COMPATIBILIDADE
    public boolean autenticarEAtualizarToken(
            String usuario,
            String senha,
            String token,
            String idSessao) throws Exception {

        return autenticarEAtualizarTokenEObterPerfil(
                usuario, senha, token, idSessao) != null;
    }

    // VALIDAR TOKEN DA SESSAO
    public boolean validarToken(
            String usuario,
            String token,
            String idSessao) throws SQLException {

        String sql = """
            SELECT id
            FROM autenticacaoMais
            WHERE usuario = ?
              AND tokenVigente = ?
              AND sessaoUltima = ?
            """;

        try (Connection conexao = Conexao.conectar();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setString(1, usuario);
            comando.setString(2, token);
            comando.setString(3, idSessao);

            try (ResultSet resultado = comando.executeQuery()) {
                return resultado.next();
            }
        }
    }

    // INVALIDAR TOKEN DA SESSAO
    public void invalidarToken(String usuario, String token)
            throws SQLException {

        String sql = """
            UPDATE autenticacaoMais
            SET tokenVigente = NULL,
                sessaoUltima = NULL
            WHERE usuario = ?
              AND tokenVigente = ?
            """;

        try (Connection conexao = Conexao.conectar();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setString(1, usuario);
            comando.setString(2, token);

            comando.executeUpdate();
        }
    }
}
