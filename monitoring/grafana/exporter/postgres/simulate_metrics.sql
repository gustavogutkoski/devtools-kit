CREATE DATABASE test;

DROP TABLE IF EXISTS test_metrics;
CREATE TABLE test_metrics (
    id SERIAL PRIMARY KEY,
    data TEXT
);

-- Bulk inserts (generate WAL, write activity, and I/O)
INSERT INTO test_metrics (data)
SELECT md5(random()::text)
FROM generate_series(1, 50000);

-- Bulk updates (generate dead tuples and WAL)
UPDATE test_metrics
SET data = md5(random()::text)
WHERE id % 10 = 0;

-- Bulk deletes (more dead tuples)
DELETE FROM test_metrics
WHERE id % 15 = 0;

-- Simulate lock (execute in two terminals)
-- Terminal 1:
-- BEGIN;
-- UPDATE test_metrics SET data = 'lock' WHERE id = 1;

-- Terminal 2:
-- BEGIN;
-- UPDATE test_metrics SET data = 'locked' WHERE id = 1;

-- Loop of selects to generate cache hits and buffer usage
DO $$
BEGIN
    FOR i IN 1..10000 LOOP
        PERFORM * FROM test_metrics WHERE id = (random() * 50000)::int;
    END LOOP;
END $$;
