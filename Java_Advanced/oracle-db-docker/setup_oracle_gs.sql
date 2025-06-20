-- Habilita a criação de usuários sem aspas (necessário em versões recentes do Oracle)
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- Crie o usuário para a aplicação.
CREATE USER global IDENTIFIED BY paulo1;

-- Conceda as permissões necessárias para o usuário da aplicação
GRANT CONNECT, RESOURCE TO global;
GRANT UNLIMITED TABLESPACE TO global;

-- Alterne para o schema do usuário da aplicação para que todos os objetos abaixo sejam criados nele
ALTER SESSION SET CURRENT_SCHEMA = global;

-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2025-05-27 22:41:07 BRT
--   site:      Oracle Database 21c
--   tipo:      Oracle Database 21c

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY
-- predefined type, no DDL - XMLTYPE

CREATE TABLE tb_cliente3 (
    data_nascimento VARCHAR2(10) NOT NULL,
    sobrenome       VARCHAR2(100) NOT NULL,
    documento       VARCHAR2(18) NOT NULL,
    id_cliente      NUMBER NOT NULL,
    nome            VARCHAR2(100) NOT NULL
)
ORGANIZATION HEAP NOCOMPRESS
    NOCACHE
        NOPARALLEL
    NOROWDEPENDENCIES DISABLE ROW MOVEMENT;

ALTER TABLE tb_cliente3
    ADD CONSTRAINT tb_cliente3_pk PRIMARY KEY ( id_cliente ) NOT DEFERRABLE ENABLE VALIDATE;

CREATE TABLE tb_clientecontato3 (
    tb_cliente3_id_cliente NUMBER NOT NULL,
    tb_contato3_id_contato NUMBER NOT NULL
)
ORGANIZATION HEAP NOCOMPRESS
    NOCACHE
        NOPARALLEL
    NOROWDEPENDENCIES DISABLE ROW MOVEMENT;

ALTER TABLE tb_clientecontato3
    ADD CONSTRAINT tb_clientecontato3_pk PRIMARY KEY ( tb_cliente3_id_cliente,
                                                       tb_contato3_id_contato ) NOT DEFERRABLE ENABLE VALIDATE;

CREATE TABLE tb_clienteendereco3 (
    tb_cliente3_id_cliente   NUMBER NOT NULL,
    tb_endereco3_id_endereco NUMBER NOT NULL
)
ORGANIZATION HEAP NOCOMPRESS
    NOCACHE
        NOPARALLEL
    NOROWDEPENDENCIES DISABLE ROW MOVEMENT;

ALTER TABLE tb_clienteendereco3
    ADD CONSTRAINT tb_clienteendereco3_pk PRIMARY KEY ( tb_cliente3_id_cliente,
                                                        tb_endereco3_id_endereco ) NOT DEFERRABLE ENABLE VALIDATE;

CREATE TABLE tb_contato3 (
    id_contato   NUMBER NOT NULL,
    ddd          VARCHAR2(3) NOT NULL,
    telefone     VARCHAR2(15) NOT NULL,
    celular      VARCHAR2(15) NOT NULL,
    whatsapp     VARCHAR2(15) NOT NULL,
    email        VARCHAR2(255) NOT NULL,
    tipo_contato VARCHAR2(50) NOT NULL
)
ORGANIZATION HEAP NOCOMPRESS
    NOCACHE
        NOPARALLEL
    NOROWDEPENDENCIES DISABLE ROW MOVEMENT;

ALTER TABLE tb_contato3
    ADD CONSTRAINT tb_contato3_pk PRIMARY KEY ( id_contato ) NOT DEFERRABLE ENABLE VALIDATE;

CREATE TABLE tb_endereco3 (
    id_endereco NUMBER NOT NULL,
    cep         VARCHAR2(9) NOT NULL,
    numero      NUMBER(5) NOT NULL,
    logradouro  VARCHAR2(255) NOT NULL,
    bairro      VARCHAR2(255) NOT NULL,
    localidade  VARCHAR2(100) NOT NULL,
    uf          VARCHAR2(2) NOT NULL,
    complemento VARCHAR2(255) NOT NULL,
    latitude    NUMBER(10, 7) NOT NULL,
    longitude   NUMBER(10, 7) NOT NULL
)
ORGANIZATION HEAP NOCOMPRESS
    NOCACHE
        NOPARALLEL
    NOROWDEPENDENCIES DISABLE ROW MOVEMENT;

ALTER TABLE tb_endereco3
    ADD CONSTRAINT tb_endereco3_pk PRIMARY KEY ( id_endereco ) NOT DEFERRABLE ENABLE VALIDATE;

CREATE TABLE tb_enderecoeventos3 (
    tb_endereco3_id_endereco NUMBER NOT NULL,
    tb_eonet3_id_eonet       NUMBER NOT NULL
)
ORGANIZATION HEAP NOCOMPRESS
    NOCACHE
        NOPARALLEL
    NOROWDEPENDENCIES DISABLE ROW MOVEMENT;

ALTER TABLE tb_enderecoeventos3
    ADD CONSTRAINT tb_enderecoeventos3_pk PRIMARY KEY ( tb_endereco3_id_endereco,
                                                        tb_eonet3_id_eonet ) NOT DEFERRABLE ENABLE VALIDATE;

CREATE TABLE tb_eonet3 (
    id_eonet NUMBER NOT NULL,
    json     CLOB NULL,
    data     TIMESTAMP WITH LOCAL TIME ZONE NULL,
    eonet_id VARCHAR2(50) NOT NULL
)
ORGANIZATION HEAP NOCOMPRESS
    NOCACHE
        NOPARALLEL
    NOROWDEPENDENCIES DISABLE ROW MOVEMENT;

ALTER TABLE tb_eonet3
    ADD CONSTRAINT tb_eonet3_pk PRIMARY KEY ( id_eonet ) NOT DEFERRABLE ENABLE VALIDATE;

ALTER TABLE tb_clientecontato3
    ADD CONSTRAINT tb_clientecontato3_tb_cliente3_fk FOREIGN KEY ( tb_cliente3_id_cliente )
        REFERENCES tb_cliente3 ( id_cliente );

ALTER TABLE tb_clientecontato3
    ADD CONSTRAINT tb_clientecontato3_tb_contato3_fk FOREIGN KEY ( tb_contato3_id_contato )
        REFERENCES tb_contato3 ( id_contato );

ALTER TABLE tb_clienteendereco3
    ADD CONSTRAINT tb_clienteendereco3_tb_cliente3_fk FOREIGN KEY ( tb_cliente3_id_cliente )
        REFERENCES tb_cliente3 ( id_cliente );

ALTER TABLE tb_clienteendereco3
    ADD CONSTRAINT tb_clienteendereco3_tb_endereco3_fk FOREIGN KEY ( tb_endereco3_id_endereco )
        REFERENCES tb_endereco3 ( id_endereco );

ALTER TABLE tb_enderecoeventos3
    ADD CONSTRAINT tb_enderecoeventos3_tb_endereco3_fk FOREIGN KEY ( tb_endereco3_id_endereco )
        REFERENCES tb_endereco3 ( id_endereco );

ALTER TABLE tb_enderecoeventos3
    ADD CONSTRAINT tb_enderecoeventos3_tb_eonet3_fk FOREIGN KEY ( tb_eonet3_id_eonet )
        REFERENCES tb_eonet3 ( id_eonet );

CREATE SEQUENCE tb_cliente3_id_cliente_seq START WITH 1 INCREMENT BY 1 NOMINVALUE NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_cliente3_id_cliente_trg BEFORE
    INSERT ON tb_cliente3
    FOR EACH ROW
    WHEN ( new.id_cliente IS NULL )
BEGIN
    :new.id_cliente := tb_cliente3_id_cliente_seq.nextval;
END;
/

CREATE SEQUENCE tb_contato3_id_contato_seq START WITH 1 INCREMENT BY 1 NOMINVALUE NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_contato3_id_contato_trg BEFORE
    INSERT ON tb_contato3
    FOR EACH ROW
    WHEN ( new.id_contato IS NULL )
BEGIN
    :new.id_contato := tb_contato3_id_contato_seq.nextval; -- CORRIGIDO AQUI
END;
/

CREATE SEQUENCE tb_endereco3_id_endereco_seq START WITH 1 INCREMENT BY 1 NOMINVALUE NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_endereco3_id_endereco_trg BEFORE
    INSERT ON tb_endereco3
    FOR EACH ROW
    WHEN ( new.id_endereco IS NULL )
BEGIN
    :new.id_endereco := tb_endereco3_id_endereco_seq.nextval;
END;
/

CREATE SEQUENCE tb_eonet3_id_eonet_seq START WITH 1 INCREMENT BY 1 NOMINVALUE NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tb_eonet3_id_eonet_trg BEFORE
    INSERT ON tb_eonet3
    FOR EACH ROW
    WHEN ( new.id_eonet IS NULL )
BEGIN
    :new.id_eonet := tb_eonet3_id_eonet_seq.nextval;
END;
/
