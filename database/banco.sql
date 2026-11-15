
CREATE DATABASE IF NOT EXISTS autenticacaoMais
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE autenticacaoMais;

CREATE TABLE IF NOT EXISTS autenticacaoMais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    senhaHash VARCHAR(255) NOT NULL,
    tokenVigente VARCHAR(64) DEFAULT NULL,
    sessaoUltima VARCHAR(128) DEFAULT NULL,
    dataHoraUltimaAutorizacao DATETIME DEFAULT NULL
);
