
package br.com.controlesessao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {

    private static final String URL =
        "jdbc:mariadb://localhost:3306/autenticacaoMais?sslMode=disable";

    private static final String USUARIO = "root";

    private static final String SENHA = "";

    public static Connection conectar() throws SQLException {

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                "Driver MariaDB não encontrado no Tomcat.", e
            );
        }

        return DriverManager.getConnection(
            URL,
            USUARIO,
            SENHA
        );
    }
}
