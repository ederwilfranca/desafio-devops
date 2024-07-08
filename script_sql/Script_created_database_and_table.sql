-- Definindo o nome da base de dados
DO $$DECLARE
    db_name TEXT := 'db_comments';
BEGIN
    -- Criação da base de dados, se não existir
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = db_name) THEN
        EXECUTE format('CREATE DATABASE %I', db_name);
    END IF;
END$$;

-- Conectando à base de dados criada ou já existente
\c db_comments;

-- Definindo o nome da tabela 
DO $$DECLARE
    table_name TEXT := 'comments';
BEGIN
    -- Criação da tabela, se não existir
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = table_name) THEN
        EXECUTE format('
            CREATE TABLE %I (
                id SERIAL PRIMARY KEY,
                email VARCHAR(120) NOT NULL,
                comment TEXT NOT NULL,
                content_id VARCHAR(50) NOT NULL
            )', table_name);
    END IF;
END$$;
