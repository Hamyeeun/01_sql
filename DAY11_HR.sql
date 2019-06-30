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

-- 7) 단일행 함수 
----- 1. 숫자 함수 : MOD(), ROUND(), TRUNC(), CEIL(), FLOOR(), WIDTH_BUCKET()
----- (1) 10을 3으로 나눈 나머지를 1회만 출력하시오
SELECT mod(10,3)
  FROM dual
;

----- (2) employees 테이블에서 모든 직원에게 각 급여의 0.35% 를 추가 수당으로 줄 때 
--        소숫점 두째자리에서 반올림하여 조회하시오.
-- 이 때 first_name과 원래 급여, 추가 수당, 원래 급여와 추가 수당 값을 더한 총 급여를 조회하시오
SELECT e.first_name                        "성"
      , e.salary                           "원래 급여"
      , round(e.salary*0.35, 1)            "추가 수당"
      , e.salary + round(e.salary*0.35, 1) "총 급여"
  FROM employees e
;

----- (3) employees 테이블에서 모든 직원에게 각 급여의 0.35% 를 추가 수당으로 줄 때 
--        소숫점 첫째 자리까지만 남기고 버림하여 조회하시오.
-- 이 때 first_name과 원래 급여, 추가 수당, 원래 급여와 추가 수당 값을 더한 총 급여를 조회하시오
SELECT e.first_name                       "성"
      , e.salary                          "원래 급여"
      , trunc(e.salary*0.35,1)            "추가 수당"
      , e.salary + trunc(e.salary*0.35,1) "총 급여"
  FROM employees e
;

----- 2. 문자 함수 : INITCAP(), LOWER(), UPPER(), LENGTH(), LENGTHB(), CONCAT(), SUBSTR(), INSTR(),
--                   LAPD(), RPAD(), LTRIM(), RTRIM(), TRIM(), NVL(), NVL2(), NULLIF()

----- (1) CONCAT(str1,str2)을 이용하여 '선문대학교','안녕하세요'를 출력하시오
SELECT concat('선문대학교 ','안녕하세요') "인사"
  FROM dual
;
----- (2) '선문대학교에 입학한것을 환영합니다'라는 문구에서 환영합니다만 출력하시오
SELECT SUBSTR('선문대학교에 입학한것을 환영합니다',14,18) "환영합니다"
  FROM dual
;
----- (3) employees 테이블에서 commission_pct가 null이면 null 대신 0이 출력되도록 조회하시오.
--        성(first_name), 이름(last_name), 급여(salary), 수당(commission_pct) 조회
SELECT e.first_name                "성"
      , e.last_name                "이름"
      , e.salary                   "급여"
      , NVL(e.commission_pct, 0) "수당"
  FROM employees e
;


----- 3. 날짜 함수 : YYYY, YY, MM, MONTH(Month), MON(Mon), DD, D, DAY, DY, FM
--                   sysdate, MONTHS_BETWEEN(), ADD_MONTH(), NEXT_DAY(), LAST_DAY(), ROUNT(), TRUNC()
----- 4. 데이터 타입 변환 함수 : TO_CHAR(), TO_NUMBER(), TO_DATE()

----- (1) 오늘의 날짜를 '2019-00-00  0요일 입니다'형태로 조회하시오
SELECT to_char(sysdate, 'YYYY-MM-DD DAY') ||' 입니다' "오늘의 날짜"
  FROM dual
;

----- (2) employees 테이블에서 직원들의 입사일을 '0000-00-00 0요일 입사했습니다.'형태로 조회하시오
--        성(first_name), 이름(last_name), 입사일(hire_date)
SELECT e.first_name                                                "성"   
      , e.last_name                                                "이름"
      , to_char(e.hire_date, 'YYYY-MM-DD DAY') || ' 입사했습니다.' "입사일"
  FROM employees e
 ORDER BY e.hire_date
;

----- (3) 각 직원이 몇월에 입사했는지 first_name 과 '0월에 입사했습니다'형태로 조회하시오.
--        1 ~ 12월 까지 차례로 조회할것.
SELECT e.first_name                                          "성"
      ,to_char(e.hire_date,' FMMM') || '월에 입사했습니다.' "입사 월"
  FROM employees e
 ORDER BY to_number(to_char(e.hire_date,' FMMM')) 
;



----- 5. DECODE
----- (1) employees 테이블에서 직업id(job_id)에 따라 보너스를 준다고 할 때 직업id(job_id)와 보너스 를 조회하시오
/*
AC_ACCOUNT : 0.02
AC_MGR     : 0.02
AD_ASST    : 0.021
AD_PRES    : 0.021
AD_VP      : 0.021
FI_ACCOUNT : 0.022
FI_MGR     : 0.022
HR_REP     : 0.023
IT_PROG    : 0.024
MK_MAN     : 0.025
MK_REP     : 0.025
PR_REP     : 0.026
PU_CLERK   : 0.027
PU_MAN     : 0.027
SA_MAN     : 0.028
SA_REP     : 0.028
SH_CLERK   : 0.029
ST_CLERK   : 0.03
ST_MAN     : 0.03
*/        
SELECT DISTINCT e.job_id
      , DECODE(e.job_id , 'AC_ACCOUNT', e.salary * 0.02
                        , 'AC_MGR'    , e.salary * 0.02
                        , 'AD_ASST'   , e.salary * 0.021
                        , 'AD_PRES'   , e.salary * 0.021
                        , 'AD_VP'     , e.salary * 0.021
                        , 'FI_ACCOUNT', e.salary * 0.022
                        , 'FI_MGR'    , e.salary * 0.022
                        , 'HR_REP'    , e.salary * 0.023
                        , 'IT_PROG'   , e.salary * 0.024
                        , 'MK_MAN'    , e.salary * 0.025
                        , 'MK_REP'    , e.salary * 0.025
                        , 'PR_REP'    , e.salary * 0.026
                        , 'PU_CLERK'  , e.salary * 0.027
                        , 'PU_MAN'    , e.salary * 0.027
                        , 'SA_MAN'    , e.salary * 0.028
                        , 'SA_REP'    , e.salary * 0.028
                        , 'SH_CLERK'  , e.salary * 0.029
                        , 'ST_CLERK'  , e.salary * 0.030
                        , 'ST_MAN'    , e.salary * 0.030) "보너스"
  FROM employees e
 ORDER BY e.job_id
;

----- (2) employees 테이블에서 부서번호를 조회하고 무슨 부서인지 조회하시오
--        first_name, deptment_id, 부서명
--        또한 부서id가 null 값이면 '-'로 조회되게 하시오
SELECT e.first_name     "성"
      , e.department_id "부서 id"
      ,DECODE(e.department_id, 10, 'Administration'
                             , 20, 'Marketing'
                             , 30, 'Purchasing'
                             , 40, 'Human Resources'
                             , 50, 'Shipping'
                             , 60, 'IT'
                             , 70, 'Public Relations'
                             , 80, 'Sales'
                             , 90, 'Executive'
                             , 100, 'Finance'
                             , 110, 'Accounting', '-') "부서명"
  FROM employees e
 ORDER BY e.department_id
;

----- (3) locations 테이블 에서 city와 city의 초성을 조회하시오
--        ex) 도시명     초성
-------------------------------------------------------------
--            Beijing    초성이 B로 시작하는 도시입니다.

SELECT l.city  "도시명"
      , DECODE(l.city, 'Beijing', '초성이 B로 시작하는 도시입니다.'
                     , 'Bern', '초성이 B로 시작하는 도시입니다.'
                     , 'Bombay', '초성이 B로 시작하는 도시입니다.'
                     , 'Geneva', '초성이 G로 시작하는 도시입니다.'
                     , 'Hiroshima', '초성이 H로 시작하는 도시입니다.'
                     , 'London', '초성이 L로 시작하는 도시입니다.'
                     , 'Mexico City', '초성이 M로 시작하는 도시입니다.'
                     , 'Munich', '초성이 M로 시작하는 도시입니다.'
                     , 'Oxford', '초성이 O로 시작하는 도시입니다.'
                     , 'Roma', '초성이 R로 시작하는 도시입니다.'
                     , 'Sao Paulo', '초성이 S로 시작하는 도시입니다.'
                     , 'Seattle', '초성이 S로 시작하는 도시입니다.'
                     , 'Singapore', '초성이 S로 시작하는 도시입니다.'
                     , 'South Brunswick', '초성이 S로 시작하는 도시입니다.'
                     , 'South San Francisco', '초성이 S로 시작하는 도시입니다.'
                     , 'Southlake', '초성이 S로 시작하는 도시입니다.'
                     , 'Stretford', '초성이 S로 시작하는 도시입니다.'
                     , 'Sydney', '초성이 S로 시작하는 도시입니다.'
                     , 'Tokyo', '초성이 T로 시작하는 도시입니다.'
                     , 'Toronto', '초성이 T로 시작하는 도시입니다.'
                     , 'Utrecht', '초성이 U로 시작하는 도시입니다.'
                     , 'Venice', '초성이 V로 시작하는 도시입니다.'
                     , 'Whitehorse', '초성이 W로 시작하는 도시입니다.') "초성"
  FROM locations l
;

----- 6. CASE

----- (1) employees 테이블에서 직업id(job_id)에 따라 보너스를 준다고 할 때 직업id(job_id)와 보너스 를 조회하시오
/*
AC_ACCOUNT : 0.02
AC_MGR     : 0.02
AD_ASST    : 0.021
AD_PRES    : 0.021
AD_VP      : 0.021
FI_ACCOUNT : 0.022
FI_MGR     : 0.022
HR_REP     : 0.023
IT_PROG    : 0.024
MK_MAN     : 0.025
MK_REP     : 0.025
PR_REP     : 0.026
PU_CLERK   : 0.027
PU_MAN     : 0.027
SA_MAN     : 0.028
SA_REP     : 0.028
SH_CLERK   : 0.029
ST_CLERK   : 0.03
ST_MAN     : 0.03
*/        
SELECT DISTINCT e.job_id
      , CASE e.job_id WHEN 'AC_ACCOUNT' THEN e.salary * 0.02
                      WHEN 'AC_MGR'     THEN e.salary * 0.02
                      WHEN 'AD_ASST'    THEN e.salary * 0.021
                      WHEN 'AD_PRES'    THEN e.salary * 0.021
                      WHEN 'AD_VP'      THEN e.salary * 0.021
                      WHEN 'FI_ACCOUNT' THEN e.salary * 0.022
                      WHEN 'FI_MGR'     THEN e.salary * 0.022
                      WHEN 'HR_REP'     THEN e.salary * 0.023
                      WHEN 'IT_PROG'    THEN e.salary * 0.024
                      WHEN 'MK_MAN'     THEN e.salary * 0.025
                      WHEN 'MK_REP'     THEN e.salary * 0.025
                      WHEN 'PR_REP'     THEN e.salary * 0.026
                      WHEN 'PU_CLERK'   THEN e.salary * 0.027
                      WHEN 'PU_MAN'     THEN e.salary * 0.027
                      WHEN 'SA_MAN'     THEN e.salary * 0.028
                      WHEN 'SA_REP'     THEN e.salary * 0.028
                      WHEN 'SH_CLERK'   THEN e.salary * 0.029
                      WHEN 'ST_CLERK'   THEN e.salary * 0.030
                      WHEN 'ST_MAN'     THEN e.salary * 0.030
                      END AS "보너스"
  FROM employees e
 ORDER BY e.job_id
;

----- (2) cuntries 테이블에서 나라 이름(country_name)에 따라 어느 대륙인지 조회하시오
--        ex)  나라이름    대륙
--            argentina   Americas
SELECT c.country_name  "나라이름"
     , CASE c.region_id WHEN 1 THEN 'Europe'
                        WHEN 2 THEN 'Americas'
                        WHEN 3 THEN 'Asia'
                        WHEN 4 THEN 'Middle East and Africa'
     END "대륙"
  FROM countries c
 ORDER BY "나라이름"
;

----- (3) employees 테이블에서 급여 등급을 조회하시오
--        first_name, salary, 급여 등급
SELECT e.first_name "성"
      , e.salary    "급여"
      , CASE WHEN e.salary BETWEEN 2000  AND 4000  THEN 1
             WHEN e.salary BETWEEN 4000  AND 6000  THEN 2
             WHEN e.salary BETWEEN 6000  AND 8000  THEN 3
             WHEN e.salary BETWEEN 8000  AND 10000 THEN 4
             WHEN e.salary BETWEEN 10000 AND 20000 THEN 5
             WHEN e.salary BETWEEN 20000 AND 30000 THEN 6
             END "급여 등급"
  FROM employees e
 ORDER BY e.salary
;

-- 8) 복수행 함수(그룹함수)
------ 1. GROUP BY
------ 2. HAVING

----- (1) employees 테이블에서 직업 id의 종류를 조회하시오
SELECT e.job_id
  FROM employees e
 GROUP BY e.job_id
;

----- (2) employees 테이블에서 IT_PROG의 직업 id를 조회하시오
SELECT e.job_id
  FROM employees e
 GROUP BY e.job_id
HAVING e.job_id = 'IT_PROG'
;
----- (3) employees 테이블에서 매니저를 맡은 직원의 사번을 조회하시오.(NULL값 제외)
SELECT e.manager_id
  FROM employees e
 GROUP BY e.manager_id
HAVING e.manager_id IS NOT NULL
;

------ 3. COUNT(), SUM(), AVG(), MAX(), MIN(), STDDEV(), VARIANCE()

----- (1) employees 테이블에서 직원 수를 조회하여라
SELECT count(*)
  FROM employees e
;

----- (2) employees 테이블에서 직업ID가 PU_CLERK인 사람들의 평균 급여를 조회하시오
--        직업ID(job_id), 평균급여 조회
SELECT e.job_id       "직업ID"
      , AVG(e.salary) "평균 급여"
  FROM employees e
 WHERE e.job_id = 'PU_CLERK'
 GROUP BY e.job_id
;

----- (3) employees 테이블에서 매니저를 맡은 직원의 사번과 몇명의 직원을 맡았는지 조회하시오.(NULL값 제외)
SELECT e.manager_id "매니저 사번"
      , COUNT(*) "아래 직원"
  FROM employees e
 GROUP BY e.manager_id
HAVING e.manager_id IS NOT NULL
;


-- 9) 조인 : CARTITION JOIN, EQUI JOIN, NON-EQUI JOIN, OUTER JOIN, SELF JOIN

----- (1) 어떤 직원이 어느부서에서 일하는지 조회하여라
--        first_name, department_id, department_name
SELECT e.first_name      "성"
      , e.department_id  "부서ID"
      , d.department_name"부서명"
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
ORDER BY e.department_id
;

----- (2) 각 job_id의 시작일과 종료일, job_title과 최저급여를 조회하여라
--        job_id, job_title, start_date, end_date, min_salary 조회.
SELECT j1.job_id      "작업ID"
      , j1.job_title  "작업 명"
      , j2.start_date "작업 시작일"
      , j2.end_date   "작업 종료일"
      , j1.min_salary "최저급여"
  FROM jobs j1, job_history j2
 WHERE j1.job_id = j2.job_id
 ORDER BY j2.start_date
;

----- (3) 각 대륙에 위치한 지역은 몇 곳인지 조회하시오.
SELECT r.region_name "대륙"
      , COUNT(*)     "위치한 나라(수)"
  FROM regions r, countries c
 WHERE c.region_id = r.region_id
 GROUP BY r.region_name
;

----- (4) employees 테이블에서 매니저를 맡고 있는 직원의 first_name과 몇명을 맡고 있는지 조회하여라
SELECT e1.first_name  "매니저 이름"
      , e2.manager_id "매니저 사번"
      , COUNT(*)      "관리하는 사원(수)"
  FROM employees e1, employees e2
 WHERE e1.employee_id = e2.manager_id
 GROUP BY e2.manager_id, e1.first_name
 ORDER BY COUNT(*) DESC
;

-- 10) 서브쿼리

----- (1) 각 직무별로 최대 급여를 받는 직원을 조사하시오
SELECT e.employee_id  "직원ID"
     , e.first_name   "성"
     , e.job_id       "직무ID"
     , e.salary       "급여"
  FROM employees e
 WHERE (e.job_id, e.salary) IN (SELECT e.job_id
                                      , MAX(e.salary) max_sal
                                  FROM employees e
                                 GROUP BY  e.job_id)
 ORDER BY e.job_id
;

----- (2) 각 직무별로 입사를 먼저한 직원을 조사하시오
SELECT e.job_id       "직무ID"
     , e.first_name   "성"
     , e.employee_id  "직원ID"
     , e.hire_date    "입사일"
  FROM employees e
 WHERE (e.job_id, e.hire_date) IN (SELECT e.job_id
                                        , MIN(e.hire_date)
                                  FROM employees e
                                 GROUP BY  e.job_id)
 ORDER BY e.job_id
;
----- (3) Southlake와 같은 나라에 있는 도시들을 조회하여라.
--        도시 이름, 나라이름, 위치한 거리 조회
SELECT l.city           "도시"
      , l.country_id    "위치한 나라"
      , l.street_address"주소"
  FROM locations l
 WHERE l.country_id = (SELECT l.country_id
                         FROM locations l
                        WHERE l.city = 'Southlake')
;
