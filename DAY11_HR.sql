-- HR 계정 활성화
ALTER SESSION
  SET "_ORACLE_SCRIPT"=true
  ;
@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_main

-- 1번 입력 : HR
-- 2번 입력 : HR
-- 3번 입력 : HR
-- 4번 입력 : $ORACLE_HOME/demo/cchema/log/
-- 1 ~ 4 입력 후 HR 계정 테이블 생성됨.

-- HR로 작업
-- SELECT 문 ~ JOIN, SUB-QUERY까지
-- 파일명 : day11_HR이름.sql 작성 후 이메일로 전송!

-- 1. SELECT문
----- (1) EMPLOYEES 테이블의 FIRST_NAME을 조회
SELECT first_name
  FROM employees
;

----- (2) JOBS 테이블의 JOB_ID와 JOB_TITLE을 조회
SELECT job_id
      , job_title
  FROM jobs
;
----- (3) REGIONS 테이블의 REGION_NAME을 조회하시오
SELECT region_name
  FROM regions
;

-- 2. DISTINCT문
----- (1) EMPLOYEES 테이블에서 JOB_ID를 중복없이 조회하시오
SELECT DISTINCT job_id
  FROM employees
;

----- (2) DEPARTMENTS 테이블에서 LOCATION ID 를 중복없이 조회하시오
SELECT DISTINCT location_id
  FROM departments
;

----- (3) CONTRIES 테이블에서 REGION_ID를 중복 없이 조회하시오
SELECT DISTINCT region_id
  FROM countries
;

-- 3. ORDER BY 절
----- (1) EMPLOYEES 테이블에서 FIRST_NAME 순서로 오름차순 정렬 하시오
SELECT employee_id
      , first_name
      , last_name
  FROM employees
 ORDER BY first_name
;
----- (2) COUNTRIES 테이블에서 REGION_ID 순서로 내림 차순 정렬하시오.
SELECT country_id
      , country_name
      , region_id
  FROM COUNTRIES
 ORDER BY region_id DESC
;
----- (3) COUNTRIES 테이블에서 COUNTRY_NAME 순서로 오름 차순 정렬 후 
--        REGION_ID 순서로 내림 차순 정렬하시오.
SELECT country_id
      , country_name
      , region_id
  FROM COUNTRIES
 ORDER BY country_name
         , region_id DESC
;

-- 4. ALIAS(별칭)
----- (1) EMPLOYEES 테이블에서 아이디(employee_id), 성(first_name), 
--        이름(last_name)과 입사 년도(hire_date)를 조회하시오
SELECT employee_id "아이디"
      , first_name  "성"
      , last_name   "이름"
      , hire_date   "입사 년도"
  FROM employees
;

----- (2) DEPARTMENTS 테이블에서 부서 아이디(department_id), 부서 이름(department_name)
--        , 매니저 아이디(manager_id), 위치 아이디(lacation_id)를 조회하시오
SELECT department_id   "부서 아이디"
      , department_name "부서 이름"
      , manager_id      "매니저 아이디"
      , location_id     "위치 아이디"
  FROM departments
;
----- (3) REGIONS 테이블에서 지역 아이디(region_id), 지역 이름(region_name)
SELECT region_id   "지역 아이디"
      , region_name "지역 이름"
  FROM regions
;

-- 5. WHERE 절
----- (1) EMPLOYEES 테이블에서 job_id가 ST_MAN 인 사람의 first_name과 last_name 을 조회하시오
SELECT first_name
      , last_name
      , job_id
  FROM employees
 WHERE job_id = 'ST_MAN'
;

----- (2) JOBS 테이블에서 min_salary가 4000인 사람의 job_title을 조회하시오
SELECT j.job_title
      , j.min_salary
  FROM jobs j
 WHERE j.min_salary = 4000
;

----- (3) JOBS 테이블에서 job_title 이 Accountant인 사람의 job_id 를 조회하시오
SELECT j.job_id
      ,j.job_title
  FROM jobs j
 WHERE j.job_title = 'Accountant'
;

-- 6. 연산자
----- 1) 산술 연산자 : (), *, / , +, - 순서로 우선순위
----- (1) employees 테이블에서 직원들의 employee_id, first_name, salary, salary와
--        commission_pct를 더한 값을 구하시오
SELECT e.employee_id "직원 id"
      , e.first_name  "성"
      , e.salary      "급여"
      , e.salary + e.commission_pct "급여+수당" 
  FROM employees e
 ORDER BY "급여+수당"
;

----- (2) employees 테이블에서 직원들의 employee_id, first_name, salary, 연봉을 구하시오
SELECT e.employee_id "직원 id"
      , e.first_name  "성"
      , e.salary      "급여"
      , e.salary * 12 "연봉"
  FROM employees e
;

----- (3) employees 테이블에서 직원들의 employee_id, first_name, salary, 교통비가 20일 때 
--        job_id가 AD_VP인 직원들의 교통비를 제외한 급여를 구하시오
SELECT e.employee_id "직원 id"
      , e.job_id
      , e.first_name  "성"
      , e.salary      "급여"
      , e.salary - 30 "교통비 제외 급여"
  FROM employees e
 WHERE e.job_id = 'AD_VP'
;

----- 2) 비교 연산자 : =, <>, !=, <, >, <=, >=
----- (1) employees 테이블에서 월급이 9000 이상인 직원의 employee_id, first_name, last_name, salary 조회
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.salary > 9000
 ORDER BY e.salary
;

----- (2) employees 테이블에서 월급이 9000 이 아닌 직원의 employee_id, first_name, last_name, salary 조회
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.salary != 9000
 ORDER BY e.salary
;

----- (3) employees 테이블에서 월급이 12000 과 같거나 적은 직원의 employee_id, first_name, last_name, salary 조회
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.salary <= 12000
;

----- 3) 논리 연산자 : NOT, AND, OR
----- (1) employees 테이블에서 부서 번호가 50번이 아닌 직원의 
--        employee_id, first_name, last_name, department_id를 조회하시오
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.department_id
  FROM employees e
 WHERE NOT e.department_id = 50
 ORDER BY e.department_id
;

----- (2) employees 테이블에서 부서 번호가 50번이고 manager_id가 100인 사원의
--        employee_id, first_name, last_name, department_id, manager_id를 조회하시오
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.department_id
      , e.manager_id
  FROM employees e
 WHERE e.department_id = 50
   AND e.manager_id = 100
;

----- (3) employees 테이블에서 부서 번호가 50번이거나 manager_id가 103인 사원의
--        employee_id, first_name, last_name, department_id, manager_id를 조회하시오
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.department_id
      , e.manager_id
  FROM employees e
 WHERE e.department_id = 50
    OR e.manager_id = 103
;

----- 4) SQL 연산자 : IN, BETWEEN, IS NULL, IS NOT NULL, LIKE, EXIST
----- (1) employees 테이블에서 급여가 9000~19000 사이의 직원의 
--        employee_id, first_name, last_name, salary를 조회하시오
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.salary BETWEEN 9000 AND 19000
 ORDER BY e.salary
;

----- (2) employees 테이블에서 수당이 null이 아닌 직원의 
--        employee_id, first_name, last_name, salary, commition_pct를 조회하시오
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
      , e.commission_pct
  FROM employees e
 WHERE e.commission_pct IS NOT NULL
 ORDER BY e.commission_pct
;

----- (3) employees 테이블에서 직원의 first_name 이 'A'로 시작하는 직원의 
--        employee_id, first_name, last_name, salary를 조회하시오
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.first_name LIKE 'A%'
 ORDER BY e.employee_id
;

----- 5) 결합 연산자 : ||
----- (1) employees 테이블에서 전체 데이터를 대상으로 employee_id 와 월급여가 나오는 모습이
--        ex)'Steven'의 월급여는 $24000 입니다. 가 되도록 조회하시오

SELECT e.employee_id "직원 ID"
      , e.first_name || '의 월급여는 $'
                     || e.salary
                     || '입니다.' "월급여"
  FROM employees e
;
----- (2) JOB_HISTORY 테이블에서 JOB_ID와 언제 시작하였고 언제 끝나는지에 대하여
--        ex) 'IT_PROG는 01/01/13에 시작하였으며 06/07/24에 끝날 예정입니다.'의 형태로 조회 하시오.
SELECT j.job_id || '는 '
                || j.start_date
                || '에 시작하였으며 '
                || j.end_date
                || '에 끝날 예정입니다.' "job 일정"
  FROM job_history j
;
----- (3) LOCATIONS 테이블에서 어느나라(CITY)의 어느 위치에(STREET_ADDRESS) 위치하여 있는지
--        ex) 'Roma의 1297 Via Cola di Rie에 위치하였습니다'형태로 조회하시오.
SELECT l.city || '의 '
              || l.street_address
              || '에 위치하였습니다.' "위치"
  FROM locations l
;
----- 6) 집합 연산자 : UNION ALL, UNION, INTERSECT, MINUS
----- (1) 두 개의 SELECT 문을 연결시키되 LOCATION_ID의 중복을 인정하여 DEPARTMENTS 테이블을 조회하시오.
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d UNION ALL
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d
 WHERE d.location_id = 1700
;
----- (2) 두 개의 SELECT 문을 연결시키되 LOCATION_ID의 중복을 제거 한 후 DEPARTMENTS 테이블을 조회하시오.
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d UNION
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d
 WHERE d.location_id = 1700
;

----- (3) DEPARTMENTS 테이블에서 두 개의 SELECT 문을 연결시키되 LOCATION_ID의 중복 값만을 조회하시오.
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d INTERSECT
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d
 WHERE d.location_id = 1700
;

