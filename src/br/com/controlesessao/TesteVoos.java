
package br.com.controlesessao;

import java.util.List;

public class TesteVoos {

    public static void main(String[] args) throws Exception {

        VooDAO dao = new VooDAO();

        List<String[]> voos = dao.listarVoosDisponiveis();

        System.out.println("Quantidade de voos: " + voos.size());

        for (String[] voo : voos) {
            System.out.println(
                voo[1] + " | " +
                voo[2] + " | " +
                voo[3] + " | " +
                voo[9]
            );
        }
    }
}
