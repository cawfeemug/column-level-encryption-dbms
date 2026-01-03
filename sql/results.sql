SELECT
  dataset_size,
  enc_mode,
  test_name,
  ROUND(AVG(elapsed_ms),2) avg_ms,
  MIN(elapsed_ms) min_ms,
  MAX(elapsed_ms) max_ms
FROM perf_results
WHERE test_name NOT LIKE 'STORAGE_%'
GROUP BY dataset_size, enc_mode, test_name
ORDER BY dataset_size, test_name, enc_mode;

SELECT
  dataset_size,
  test_name,
  ROUND(AVG(elapsed_ms), 2) AS avg_ms,
  MIN(elapsed_ms)           AS min_ms,
  MAX(elapsed_ms)           AS max_ms
FROM perf_results
WHERE enc_mode = 'BASELINE'
  AND dataset_size IN (10000, 20000, 30000)
  AND test_name NOT LIKE 'STORAGE_%'
GROUP BY dataset_size, test_name
ORDER BY dataset_size, test_name;

SELECT
  dataset_size,
  test_name,
  ROUND(AVG(elapsed_ms), 2) AS avg_ms,
  MIN(elapsed_ms)           AS min_ms,
  MAX(elapsed_ms)           AS max_ms
FROM perf_results
WHERE enc_mode = 'ENC'
  AND dataset_size IN (10000, 20000, 30000)
  AND test_name NOT LIKE 'STORAGE_%'
GROUP BY dataset_size, test_name
ORDER BY dataset_size, test_name;


SELECT *
FROM perf_results
WHERE test_name LIKE 'STORAGE_%'
ORDER BY dataset_size, enc_mode;
