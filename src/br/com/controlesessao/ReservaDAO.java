
package br.com.controlesessao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class ReservaDAO {

    // REALIZAR RESERVA
    public boolean reservar(int usuarioId, int vooId, int quantidade)
            throws SQLException {

        if (usuarioId <= 0 || vooId <= 0 || quantidade <= 0) {
            return false;
        }

        String sqlVoo = """
            SELECT preco, quantidade_assentos, status
            FROM voos
            WHERE id = ?
            """;

        String sqlReserva = """
            INSERT INTO reservas
            (usuario_id, voo_id, quantidade_passageiros,
             valor_total, status)
            VALUES (?, ?, ?, ?, 'CONFIRMADA')
            """;

        try (Connection conexao = Conexao.conectar()) {

            conexao.setAutoCommit(false);

            try {
                BigDecimal preco;
                int assentos;
                String status;

                try (PreparedStatement consulta =
                        conexao.prepareStatement(sqlVoo)) {

                    consulta.setInt(1, vooId);

                    try (ResultSet resultado = consulta.executeQuery()) {

                        if (!resultado.next()) {
                            conexao.rollback();
                            return false;
                        }

                        preco = resultado.getBigDecimal("preco");
                        assentos = resultado.getInt("quantidade_assentos");
                        status = resultado.getString("status");
                    }
                }

                // VERIFICAR STATUS E ASSENTOS
                if (!"DISPONIVEL".equalsIgnoreCase(status)
                        || assentos < quantidade) {
                    conexao.rollback();
                    return false;
                }

                BigDecimal total = preco.multiply(
                    BigDecimal.valueOf(quantidade)
                );

                // CADASTRAR RESERVA
                try (PreparedStatement comando =
                        conexao.prepareStatement(sqlReserva)) {

                    comando.setInt(1, usuarioId);
                    comando.setInt(2, vooId);
                    comando.setInt(3, quantidade);
                    comando.setBigDecimal(4, total);

                    comando.executeUpdate();
                }

                // ATUALIZAR ASSENTOS DISPONIVEIS
                String sqlAtualizar = """
                    UPDATE voos
                    SET quantidade_assentos = quantidade_assentos - ?
                    WHERE id = ?
                    AND quantidade_assentos >= ?
                    """;

                try (PreparedStatement atualizar =
                        conexao.prepareStatement(sqlAtualizar)) {

                    atualizar.setInt(1, quantidade);
                    atualizar.setInt(2, vooId);
                    atualizar.setInt(3, quantidade);

                    if (atualizar.executeUpdate() != 1) {
                        conexao.rollback();
                        return false;
                    }
                }

                conexao.commit();
                return true;

            } catch (SQLException e) {
                conexao.rollback();
                throw e;

            } finally {
                conexao.setAutoCommit(true);
            }
        }
    }

    // LISTAR RESERVAS DE UM PASSAGEIRO
    public List<String[]> listarPorUsuario(int usuarioId)
            throws SQLException {

        List<String[]> reservas = new ArrayList<>();

        String sql = """
            SELECT r.id, v.codigo_voo, v.origem, v.destino,
                   r.quantidade_passageiros, r.valor_total,
                   r.status, r.data_reserva
            FROM reservas r
            INNER JOIN voos v ON r.voo_id = v.id
            WHERE r.usuario_id = ?
            ORDER BY r.data_reserva DESC
            """;

        try (Connection conexao = Conexao.conectar();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setInt(1, usuarioId);

            try (ResultSet resultado = comando.executeQuery()) {

                while (resultado.next()) {
                    reservas.add(new String[] {
                        String.valueOf(resultado.getInt("id")),
                        resultado.getString("codigo_voo"),
                        resultado.getString("origem"),
                        resultado.getString("destino"),
                        String.valueOf(resultado.getInt("quantidade_passageiros")),
                        resultado.getBigDecimal("valor_total").toString(),
                        resultado.getString("status"),
                        resultado.getTimestamp("data_reserva").toString()
                    });
                }
            }
        }

        return reservas;
    }
}
