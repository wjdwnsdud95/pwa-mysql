-- INDEX 확인
SHOW INDEX FROM employees;

-- 쿼리 불러오는 시간 0.032초
SELECT * FROM employees WHERE `name` = '주정웅';

-- INDEX 생성
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`)
;

-- INDEX 생성 후 쿼리 불러오는 시간 0.000초
SELECT * FROM employees WHERE `name` = '주정웅';

-- INDEX 삭제
ALTER TABLE employees
DROP INDEX idx_employees_name
;