CREATE DATABASE test;

DROP TABLE IF EXISTS test_metrics;
CREATE TABLE test_metrics (
    id SERIAL PRIMARY KEY,
    data TEXT
);

-- Inserção em massa (gera WAL, atividade de escrita e IO)
INSERT INTO test_metrics (data)
SELECT md5(random()::text)
FROM generate_series(1, 50000);

-- Atualizações em massa (gera dead tuples e WAL)
UPDATE test_metrics
SET data = md5(random()::text)
WHERE id % 10 = 0;

-- Deleções (mais dead tuples)
DELETE FROM test_metrics
WHERE id % 15 = 0;

-- Simulação de lock (execute em dois terminais)
-- Terminal 1:
-- BEGIN;
-- UPDATE test_metrics SET data = 'lock' WHERE id = 1;

-- Terminal 2:
-- BEGIN;
-- UPDATE test_metrics SET data = 'locked' WHERE id = 1;

-- Loop de selects para gerar cache hits e uso de buffer
DO $$
BEGIN
    FOR i IN 1..10000 LOOP
        PERFORM * FROM test_metrics WHERE id = (random() * 50000)::int;
    END LOOP;
END $$;
