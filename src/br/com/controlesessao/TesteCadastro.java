
package br.com.controlesessao;

public class TesteCadastro {

    public static void main(String[] args) {

        UsuarioDAO dao = new UsuarioDAO();

        try {

            boolean cadastrado = dao.cadastrar(
                "caio",
                "Senha@123"
            );

            if (cadastrado) {
                System.out.println("USUARIO CADASTRADO COM SUCESSO!");
            } else {
                System.out.println("USUARIO JA EXISTE OU DADOS INVALIDOS.");
            }

        } catch (Exception e) {
            System.out.println("ERRO AO CADASTRAR USUARIO!");
            e.printStackTrace();
        }
    }
}
