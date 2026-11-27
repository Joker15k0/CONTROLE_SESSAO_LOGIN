
package br.com.controlesessao;

import java.sql.Connection;
import java.sql.SQLException;

public class TesteConexao {

    public static void main(String[] args) {

        try (Connection conexao = Conexao.conectar()) {

            System.out.println("CONEXAO REALIZADA COM SUCESSO!");

            System.out.println(
                "Banco conectado: " + conexao.getCatalog()
            );

        } catch (SQLException erro) {

            System.out.println("ERRO NA CONEXAO!");

            erro.printStackTrace();
        }
    }
}
