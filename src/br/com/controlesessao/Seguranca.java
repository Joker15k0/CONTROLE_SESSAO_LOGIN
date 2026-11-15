
package br.com.controlesessao;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class Seguranca {

    private static final int ITERACOES = 210000;
    private static final int TAMANHO_HASH = 256;

    public static String gerarHash(String senha) throws Exception {

        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);

        PBEKeySpec spec = new PBEKeySpec(
            senha.toCharArray(),
            salt,
            ITERACOES,
            TAMANHO_HASH
        );

        SecretKeyFactory factory =
            SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

        byte[] hash = factory.generateSecret(spec).getEncoded();

        spec.clearPassword();

        return ITERACOES + "$"
            + Base64.getEncoder().encodeToString(salt) + "$"
            + Base64.getEncoder().encodeToString(hash);
    }

    public static boolean verificarSenha(
        String senha,
        String hashArmazenado
    ) throws Exception {

        String[] partes = hashArmazenado.split("\\$");

        int iteracoes = Integer.parseInt(partes[0]);

        byte[] salt = Base64.getDecoder().decode(partes[1]);
        byte[] hashOriginal = Base64.getDecoder().decode(partes[2]);

        PBEKeySpec spec = new PBEKeySpec(
            senha.toCharArray(),
            salt,
            iteracoes,
            hashOriginal.length * 8
        );

        SecretKeyFactory factory =
            SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

        byte[] hashDigitado = factory.generateSecret(spec).getEncoded();

        spec.clearPassword();

        return MessageDigest.isEqual(hashOriginal, hashDigitado);
    }
}
