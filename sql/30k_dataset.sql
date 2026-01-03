BEGIN
  load_dataset(30000, 90000);
END;
/

SELECT COUNT(*) FROM users_plain;
SELECT COUNT(*) FROM users_enc;
SELECT COUNT(*) FROM transactions_t;

BEGIN
  run_timed_test_save(30000,'BASELINE','POINT_SELECT',
    'SELECT * FROM users_plain WHERE user_id = 5000', 10, NULL);
END;
/

BEGIN
  run_timed_test_save(30000,'BASELINE','RANGE_SELECT_COUNT',
    q'[SELECT COUNT(*) FROM users_plain
       WHERE created_at BETWEEN DATE '2024-03-01' AND DATE '2024-06-30']',
    10, NULL);
END;
/

BEGIN
  run_timed_test_save(30000,'BASELINE','JOIN_SELECT_COUNT',
    q'[SELECT COUNT(*)
       FROM users_plain u
       JOIN transactions_t t ON u.user_id = t.user_id
       WHERE t.amount > 200
         AND t.txn_date BETWEEN DATE '2024-04-01' AND DATE '2024-07-31']',
    10, NULL);
END;
/

BEGIN
  run_timed_test_save(30000,'BASELINE','SEARCH_EMAIL_COUNT',
    q'[SELECT COUNT(*) FROM users_plain
       WHERE email = 'user5000@mail.com']',
    10, NULL);
END;
/

BEGIN
  run_timed_test_save(30000,'BASELINE','BULK_INSERT_1000',
    q'[INSERT INTO users_plain (user_id, full_name, email, created_at, salary, dept)
       SELECT (SELECT MAX(user_id) FROM users_plain) + LEVEL,
              'New User '||LEVEL,
              'new'||LEVEL||'@mail.com',
              SYSDATE - MOD(LEVEL,30),
              4000 + MOD(LEVEL,2000),
              'IT'
       FROM dual CONNECT BY LEVEL<=1000]',
    3, NULL);
END;
/

BEGIN
  run_timed_test_save(30000,'BASELINE','BULK_UPDATE_IT',
    q'[UPDATE users_plain SET salary = salary * 1.02 WHERE dept = 'IT']',
    5, NULL);
END;
/

BEGIN
  save_storage_snapshot(30000,'BASELINE','baseline storage');
END;
/

BEGIN
  run_timed_test_save(30000,'ENC','POINT_SELECT',
    'SELECT * FROM users_enc WHERE user_id = 5000', 10, NULL);
END;
/

BEGIN
  run_timed_test_save(30000,'ENC','RANGE_SELECT_COUNT',
    q'[SELECT COUNT(*) FROM users_enc
       WHERE created_at BETWEEN DATE '2024-03-01' AND DATE '2024-06-30']',
    10, NULL);
END;
/

BEGIN
  run_timed_test_save(30000,'ENC','JOIN_SELECT_COUNT',
    q'[SELECT COUNT(*)
       FROM users_enc u
       JOIN transactions_t t ON u.user_id = t.user_id
       WHERE t.amount > 200
         AND t.txn_date BETWEEN DATE '2024-04-01' AND DATE '2024-07-31']',
    10, NULL);
END;

BEGIN
  run_timed_test_save(30000,'ENC','SEARCH_EMAIL_COUNT',
    q'[SELECT COUNT(*) FROM users_enc
       WHERE email = 'user5000@mail.com']',
    10, NULL);
END;
/

BEGIN
  run_timed_test_save(30000,'ENC','BULK_INSERT_1000',
    q'[INSERT INTO users_enc (user_id, full_name, email, created_at, salary, dept)
       SELECT (SELECT MAX(user_id) FROM users_enc) + LEVEL,
              'New User '||LEVEL,
              'new'||LEVEL||'@mail.com',
              SYSDATE - MOD(LEVEL,30),
              4000 + MOD(LEVEL,2000),
              'IT'
       FROM dual CONNECT BY LEVEL<=1000]',
    3, NULL);
END;
/
