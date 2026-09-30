CREATE DATABASE	alo_camara
	CHARACTER SET utf8mb4
	COLLATE utf8mb4_unicode_ci;

show databases;
USE alo_camara;

select DATABASE();

CREATE TABLE partidos (
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, 
    sigla VARCHAR(20) NOT NULL UNIQUE
    );

show tables;
USE alo_camara;

SHOW TABLES;
SELECT * FROM partidos;

CREATE TABLE vereadores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    partido_id BIGINT NOT NULL,
    regiao VARCHAR(50),
    foto VARCHAR(500),
    email VARCHAR(150),
    telefone VARCHAR(20),
    biografia TEXT,

    CONSTRAINT fk_vereador_partido
        FOREIGN KEY (partido_id)
        REFERENCES partidos(id)
);
SELECT * FROM vereadores;
SELECT
    v.nome AS vereador,
    p.nome AS partido,
    p.sigla
FROM vereadores v
INNER JOIN partidos p
    ON v.partido_id = p.id;
    
    
CREATE TABLE usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255),
    telefone VARCHAR(20),
    cpf VARCHAR(14) UNIQUE,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE acoes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    usuario_id BIGINT NOT NULL,
    vereador_id BIGINT NULL,

    tipo ENUM(
        'SOLICITACAO',
        'SUGESTAO',
        'RECLAMACAO',
        'DENUNCIA',
        'ELOGIO'
    ) NOT NULL,

    protocolo VARCHAR(30) NOT NULL UNIQUE,

    bairro VARCHAR(100),
    endereco VARCHAR(255),
    categoria VARCHAR(100),
    localizacao VARCHAR(255),

    descricao TEXT NOT NULL,

    status ENUM(
        'RECEBIDO',
        'EM_ANALISE',
        'EM_ANDAMENTO',
        'RESPONDIDO',
        'RESOLVIDO',
        'FINALIZADO'
    ) NOT NULL DEFAULT 'RECEBIDO',

    data_criacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_acao_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id),

    CONSTRAINT fk_acao_vereador
        FOREIGN KEY (vereador_id)
        REFERENCES vereadores(id)
);

CREATE TABLE projetos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    vereador_id BIGINT NOT NULL,

    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    status VARCHAR(50),
    data_criacao DATE,

    CONSTRAINT fk_projeto_vereador
        FOREIGN KEY (vereador_id)
        REFERENCES vereadores(id)
);

CREATE TABLE eventos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    tipo ENUM(
        'SESSAO',
        'AUDIENCIA',
        'COMISSAO'
    ) NOT NULL,

    titulo VARCHAR(200) NOT NULL,
    data_evento DATE NOT NULL,
    hora_evento TIME NOT NULL,
    local VARCHAR(255),
    participantes INT DEFAULT 0
);

CREATE TABLE notificacoes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    usuario_id BIGINT NOT NULL,

    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,

    tipo ENUM(
        'PROTOCOLO',
        'AVISO'
    ) NOT NULL,

    lida BOOLEAN NOT NULL DEFAULT FALSE,

    data_criacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notificacao_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
);
SHOW TABLES;



