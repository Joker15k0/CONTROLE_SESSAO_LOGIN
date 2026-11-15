# Sistema de Controle de Sessão em Login

## 1. Sobre o projeto

Este projeto foi desenvolvido em Java com JSP e MariaDB, com o objetivo de implementar um sistema de autenticação e controle de sessões de usuários.

O sistema permite cadastrar usuários, realizar login, validar sessões e impedir que uma mesma conta mantenha duas sessões autorizadas simultaneamente.

## 2. Tecnologias utilizadas

- Java
- JSP (JavaServer Pages)
- Apache Tomcat 11
- MariaDB
- JDBC
- HTML5
- CSS3
- PBKDF2 com HmacSHA256

## 3. Funcionalidades

- Cadastro de usuários.
- Autenticação por usuário e senha.
- Armazenamento seguro de senhas utilizando hash PBKDF2.
- Geração de tokens aleatórios para autenticação.
- Validação de token e identificador da sessão no banco de dados.
- Controle de uma sessão autorizada por usuário.
- Invalidação do token ao realizar logout.
- Bloqueio de sessões anteriores após um novo login na mesma conta.

## 4. Segurança

O projeto utiliza alguns mecanismos de segurança:

- **PBKDF2WithHmacSHA256:** utilizado para gerar o hash das senhas.
- **Salt aleatório:** cada senha recebe um salt individual.
- **SecureRandom:** utilizado para gerar tokens imprevisíveis.
- **PreparedStatement:** utilizado nas consultas SQL para evitar SQL Injection.
- **Validação no banco de dados:** verifica se o token e o ID da sessão correspondem à autorização vigente.
- **Encerramento de sessão:** remove os dados da sessão local e invalida o token no banco durante o logout.

## 5. Estrutura do projeto

```text
CONTROLE_SESSAO_LOGIN/
│
├── index.jsp
├── login.jsp
├── painel.jsp
├── autorizo.jsp
├── logout.jsp
├── cadastro.jsp
├── salvarCadastro.jsp
│
├── css/
│
├── database/
│   └── banco.sql
│
├── src/
│   └── br/
│       └── com/
│           └── controlesessao/
│               ├── Conexao.java
│               ├── Seguranca.java
│               └── UsuarioDAO.java
│
└── WEB-INF/
    ├── classes/
    │   └── br/com/controlesessao/
    │
    └── lib/
        └── mariadb-java-client-4.0.0.jar
```

## 6. Configuração do banco de dados

Primeiro, instale e inicie o MariaDB.

Execute o script localizado em:

`database/banco.sql`

O script cria o banco de dados `autenticacaoMais` e a tabela responsável pelo armazenamento dos usuários e das informações de autenticação.

### Estrutura da tabela

| Campo | Descrição |
|---|---|
| id | Identificador do usuário |
| usuario | Nome de usuário |
| senhaHash | Hash da senha |
| tokenVigente | Token de autenticação atual |
| sessaoUltima | Identificador da sessão autorizada |
| dataHoraUltimaAutorizacao | Data e hora do último login |

## 7. Configuração da conexão

O arquivo `Conexao.java` contém os parâmetros de conexão com o MariaDB.

Configuração utilizada no ambiente local:

- Servidor: localhost
- Porta: 3306
- Banco: autenticacaoMais
- Usuário: root

Ajuste as credenciais conforme a configuração do seu ambiente.

## 8. Como executar

1. Instale o JDK.
2. Instale e inicie o MariaDB.
3. Execute o arquivo `database/banco.sql`.
4. Configure a conexão no arquivo `Conexao.java`.
5. Verifique se o driver MariaDB está em `WEB-INF/lib`.
6. Compile as classes Java para `WEB-INF/classes`.
7. Disponibilize a pasta do projeto no diretório `webapps` do Apache Tomcat 11.
8. Inicie o servidor Tomcat.
9. Acesse pelo navegador:

`http://localhost:8080/CONTROLE_SESSAO_LOGIN/`

## 9. Funcionamento do controle de sessão

Quando um usuário realiza login, o sistema verifica suas credenciais e gera um token aleatório.

Esse token e o identificador da sessão são armazenados no banco de dados.

Quando ocorre um novo login utilizando a mesma conta, o token anterior é substituído pelo novo.

Assim, a sessão anterior deixa de ser autorizada quando tenta acessar novamente uma página protegida.

## 10. Testes realizados

- Cadastro de usuários.
- Login com credenciais válidas.
- Bloqueio de credenciais inválidas.
- Logout e encerramento da sessão.
- Bloqueio de acesso ao painel após logout.
- Login simultâneo com contas diferentes.
- Novo login na mesma conta em outro navegador.
- Bloqueio da sessão anterior após a substituição do token.

## 11. Observação

Este projeto foi desenvolvido para fins acadêmicos e de aprendizado sobre autenticação, segurança de senhas e controle de sessões.

Para utilização em produção, devem ser adotadas configurações adicionais de segurança, incluindo credenciais protegidas, conexão TLS com o banco de dados e configuração adequada do servidor.

## 12. Autor

Projeto acadêmico desenvolvido como atividade de estudo de desenvolvimento Java, banco de dados e segurança da informação.