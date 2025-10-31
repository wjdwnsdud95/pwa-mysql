-- INSERT 문
-- 신규 데이터를 저장하기 위해 사용하는 문
INSERT INTO employees(
  `name`
  ,birth
  ,gender
  ,hire_at
  ,fire_at
  ,sup_id
  ,created_at
  ,updated_at
  ,deleted_at
)
VALUES(
   '정준영'
  ,'2000-01-01'
  ,'M'
  ,'2025-10-31'
  ,NULL
  ,NULL
  ,NOW()
  ,NOW()
  ,NULL
);

SELECT *
FROM employees
WHERE
	`name` = '정준영'
	AND birth = '2000-01-01'
	AND hire_at = '2025-10-31'
;

-- 자신의 연봉 데이터를 넣어 주세요.
-- INSERT INTO salaries(
--   emp_id
--   ,salary
--   ,start_at
--   ,end_at
--   ,created_at
--   ,updated_at
--   ,deleted_at
-- )
-- VALUES(
--   99
--   ,10000000000
--   ,'2025-10-31'
--   ,NULL
--   ,NOW()
--   ,NOW()
--   ,NULL
-- );
INSERT INTO salaries(
  emp_id
  ,salary
  ,start_at
)
VALUES(
  100005
  ,10000000000
  ,'2025-10-31'
);

-- SELECT INSERT
INSERT INTO salaries (
  emp_id
  ,salary
  ,start_at
)
SELECT
	emp_id
	,10000000000
	,created_at
FROM employees
WHERE
	`name` = '정준영'
	AND birth = '2000-01-01'
	AND hire_at = '2025-10-31'
;