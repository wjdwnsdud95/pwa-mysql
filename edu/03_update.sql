-- UPDATE 문
UPDATE employees
SET
	fire_at = NOW()
	,deleted_at = NOW()
WHERE
	emp_id = 100005
;

-- 내 연봉 변경
UPDATE salaries
SET
	salary = 30000000
WHERE
	emp_id = 100005
;

-- 내 아이디로 접근해서 값 잘 가져왔는지 체크
select *
FROM  salaries
WHERE
	emp_id = 100005
;