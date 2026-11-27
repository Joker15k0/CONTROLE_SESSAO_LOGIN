
package br.com.controlesessao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class VooDAO {

    // CADASTRAR VOO
    public boolean cadastrar(
            String codigo,
            String origem,
            String destino,
            LocalDate data,
            LocalTime partida,
            LocalTime chegada,
            BigDecimal preco,
            int assentos) throws SQLException {

        if (codigo == null || codigo.isBlank()
                || origem == null || origem.isBlank()
                || destino == null || destino.isBlank()
                || origem.equalsIgnoreCase(destino)
                || data == null || partida == null
                || chegada == null || preco == null
                || preco.compareTo(BigDecimal.ZERO) <= 0
                || assentos <= 0
                || !data.isAfter(LocalDate.now())
                || !chegada.isAfter(partida)) {
            return false;
        }

        String sql = """
            INSERT INTO voos
            (codigo_voo, origem, destino, data_partida,
             hora_partida, hora_chegada, preco,
             quantidade_assentos)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """;

        try (Connection conexao = Conexao.conectar();
             PreparedStatement comando = conexao.prepareStatement(sql)) {

            comando.setString(1, codigo.trim().toUpperCase());
            comando.setString(2, origem.trim());
            comando.setString(3, destino.trim());
            comando.setDate(4, java.sql.Date.valueOf(data));
            comando.setTime(5, java.sql.Time.valueOf(partida));
            comando.setTime(6, java.sql.Time.valueOf(chegada));
            comando.setBigDecimal(7, preco);
            comando.setInt(8, assentos);

            return comando.executeUpdate() == 1;
        }
    }

    // LISTAR TODOS OS VOOS
    public List<String[]> listarTodos() throws SQLException {

        List<String[]> voos = new ArrayList<>();

        String sql = """
            SELECT id, codigo_voo, origem, destino,
                   data_partida, hora_partida,
                   hora_chegada, preco,
                   quantidade_assentos, status
            FROM voos
            ORDER BY data_partida, hora_partida
            """;

        try (Connection conexao = Conexao.conectar();
             PreparedStatement comando = conexao.prepareStatement(sql);
             ResultSet resultado = comando.executeQuery()) {

            while (resultado.next()) {

                String[] voo = {
                    resultado.getString("id"),
                    resultado.getString("codigo_voo"),
                    resultado.getString("origem"),
                    resultado.getString("destino"),
                    resultado.getString("data_partida"),
                    resultado.getString("hora_partida"),
                    resultado.getString("hora_chegada"),
                    resultado.getString("preco"),
                    resultado.getString("quantidade_assentos"),
                    resultado.getString("status")
                };

                voos.add(voo);
            }
        }

        return voos;
    }


public String[] buscarPorId(int id) throws SQLException {
    String sql = """
        SELECT id, codigo_voo, origem, destino,
               data_partida, hora_partida, hora_chegada,
               preco, quantidade_assentos, status
        FROM voos
        WHERE id = ?
        """;

    try (Connection conexao = Conexao.conectar();
         PreparedStatement comando = conexao.prepareStatement(sql)) {

        comando.setInt(1, id);

        try (ResultSet resultado = comando.executeQuery()) {
            if (resultado.next()) {
                return new String[] {
                    resultado.getString("id"),
                    resultado.getString("codigo_voo"),
                    resultado.getString("origem"),
                    resultado.getString("destino"),
                    resultado.getString("data_partida"),
                    resultado.getString("hora_partida"),
                    resultado.getString("hora_chegada"),
                    resultado.getString("preco"),
                    resultado.getString("quantidade_assentos"),
                    resultado.getString("status")
                };
            }
        }
    }

    return null;
}

public boolean atualizar(
        int id,
        String codigo,
        String origem,
        String destino,
        LocalDate data,
        LocalTime partida,
        LocalTime chegada,
        BigDecimal preco,
        int assentos) throws SQLException {

    if (id <= 0 || codigo == null || codigo.isBlank()
            || origem == null || origem.isBlank()
            || destino == null || destino.isBlank()
            || origem.equalsIgnoreCase(destino)
            || data == null || partida == null || chegada == null
            || preco == null
            || preco.compareTo(BigDecimal.ZERO) <= 0
            || assentos <= 0
            || !data.isAfter(LocalDate.now())
            || !chegada.isAfter(partida)) {
        return false;
    }

    String sql = """
        UPDATE voos
        SET codigo_voo = ?, origem = ?, destino = ?,
            data_partida = ?, hora_partida = ?,
            hora_chegada = ?, preco = ?,
            quantidade_assentos = ?
        WHERE id = ?
        """;

    try (Connection conexao = Conexao.conectar();
         PreparedStatement comando = conexao.prepareStatement(sql)) {

        comando.setString(1, codigo.trim().toUpperCase());
        comando.setString(2, origem.trim());
        comando.setString(3, destino.trim());
        comando.setDate(4, java.sql.Date.valueOf(data));
        comando.setTime(5, java.sql.Time.valueOf(partida));
        comando.setTime(6, java.sql.Time.valueOf(chegada));
        comando.setBigDecimal(7, preco);
        comando.setInt(8, assentos);
        comando.setInt(9, id);

        return comando.executeUpdate() == 1;
    }

}

}

