-- day04

-- (6) 연산자 2. 비교연산자
--     비교연산자는 SELECT 절에 사용할 수 없음
--     WHERE, HAVING절에만 사용할 수 있음.

-- 22) 급여가 2000이 넘는 직원의 사번, 이름, 급여를 조회
SELECT e.empno 사번
      , e.ename 이름
      , e.sal 급여
  FROM emp e
 WHERE e.sal>2000
;
/*
사번,   이름,   급여
-------------------------
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
*/

-- 급여가 1000 이상인 직원의 사번, 이름, 급여를 조회
SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e
 WHERE e.sal>=1000
;
/*
EMPNO,  ENAME,  SAL
-------------------------
7499	ALLEN	1600
7521	WARD	1250
7566	JONES	2975
7654	MARTIN	1250
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7844	TURNER	1500
7902	FORD	3000
7934	MILLER	1300
*/

-- 급여가 1000 이상이며 2000보다 작은 직원의
-- 사번, 이름, 급여를 조회
SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e
 WHERE e.sal>=1000 
   AND e.sal<2000
;
/*
EMPNO,  ENAME,  SAL
---------------------------
7499	ALLEN	1600
7521	WARD	1250
7654	MARTIN	1250
7844	TURNER	1500
7934	MILLER	1300
*/

-- comm(수당) 값이 0보다 큰 직원의 
-- 사번, 이름, 급여, 수당을 조회 
SELECT e.empno
      , e.ename
      , e.sal
      , e.comm
  FROM emp e
 WHERE e.comm>0
;
/*
EMPNO,  ENAME,  SAL,    COMM
------------------------------
7499	ALLEN	1600	300
7521	WARD	1250	500
7654	MARTIN	1250	1400
*/

/*
==> **위의 comm > 0 조건의 실행 결과에서 알 수 있는 것
comm컬럼의 값이(null)인 사람들의 행은
처음부터 비교 대상에 들지 않음에 주의해야 한다
(null) 값은 비교연산자, 산술연산자로 연산할 수 없는 값이다.

단, 정렬에서는 null값은 가장 큰 값으로 취급한다.

*/

--23) null 데이터 관련 문제
--    SALESMAN(영업사원) 직무를 가진 사람의 실제 수령금을 계산하여
--    사번, 이름, 직무, 실 수령금을 조회
SELECT e.empno
      , e.ename
      , e.job
      ,e.sal
      ,e.comm
      ,e.sal + e.comm "실 수령금"
  FROM emp e
;

/*
EMPNO,  ENAME,  JOB,        SAL,    COMM,   실 수령금
--------------------------------------------------------
7369	SMITH	CLERK	    800		
7499	ALLEN	SALESMAN	1600	300	    1900
7521	WARD	SALESMAN	1250	500	    1750
7566	JONES	MANAGER	    2975		
7654	MARTIN	SALESMAN	1250	1400	2650
7698	BLAKE	MANAGER	    2850		
7782	CLARK	MANAGER	    2450		
7839	KING	PRESIDENT	5000		
7844	TURNER	SALESMAN	1500	0	    1500
7900	JAMES	CLERK	    950		
7902	FORD	ANALYST	    3000		
7934	MILLER	CLERK	    1300		
*/
-- ==> NULL 데이터는 산술연산자로 연산 불가능한 값
SELECT e.empno
      , e.ename
      , e.job
      ,e.sal
      ,e.comm
      ,e.sal + e.comm "실 수령금"
  FROM emp e
 WHERE e.job='SALESMAN'
;
/*
EMPNO,  ENAME,  JOB,        SAL,    COMM,   실 수령금
--------------------------------------------------
7499	ALLEN	SALESMAN	1600	300	    1900
7521	WARD	SALESMAN	1250	500	    1750
7654	MARTIN	SALESMAN	1250	1400	2650
7844	TURNER	SALESMAN	1500	0	    1500
*/

-- (6) 연산자 3. 논리 연산자
--     NOT 연산자

-- 24) 급여가 2000보다 적지 않은 직원의
--     사번, 이름, 급여를 조회
SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e
 WHERE e.sal>=2000
;
--NOT을 쓴 쿼리
SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e
 WHERE NOT e.sal<2000
;

/*
EMPNO,  ENAME,  SAL
--------------------------
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
*/

-- (6) 연산자 4. SQL 연산자
-- IN 연산자: 비교하고자 하는 기준 값이
--            제시된 목록에 존재하면 참으로 판단

-- 25) 급여가 800,3000,5000 중에 하나인 직원의
--     사번, 이름, 급여를 조회
SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e
 WHERE e.sal IN (800, 3000, 5000)
;
-- OR 연산자와 3개의 조건으로 동일한 결과를 내는 쿼리

SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e
 WHERE e.sal= 800
    OR e.sal= 3000
    OR e.sal= 5000
;

/*
EMPNO,  ENAME,  SAL
----------------------
7369	SMITH	800
7839	KING	5000
7902	FORD	3000
*/

------------------------------------
-- LIKE 연산자 : 유사 값을  검색할 때 사용.
--               정확한 값을 알지 못할 때 사용.

-- LIKE 연산자의 패턴 문자 : 유사값 검색을 위해
--                           연산자와 함께 사용하는 기호
-- % :이 기호의 자리에 0자릿수 이상의 모든 문자가 올 수 있음을 의미
-- _ : 이 기호의 자리에 1자리의 모든 문자가 올 수 있음

-- 26) 이름이 J로 시작하는 직원의
--     사번, 이름 조회
SELECT e.empno
      , e.ename 
  FROM emp e
 WHERE e.ename LIKE 'J%'
;

/*
EMPNO,  ENAME
-----------------
7566	JONES
7900	JAMES
*/

-- 이름이 M으로 시작하는 직원의
-- 사번, 이름 조회
SELECT e.empno
      , e.ename
  FROM emp e
 WHERE e.ename LIKE 'M%'
;
/*
EMPNO,  ENAME
---------------
7654	MARTIN
7934	MILLER
*/

-- 이름에 M이 들어가는 직원의 사번, 이름 조회
SELECT e.empno
      , e.ename
  FROM emp e
 WHERE e.ename LIKE '%M%'
;
/*
EMPNO,  ENAME
-----------------
7369	SMITH
7654	MARTIN
7900	JAMES
7934	MILLER
*/

-- 이름의 3번째 자리에 M이 들어가는 직원의
-- 사번, 이름 조회
SELECT e.empno
      , e.ename
  FROM emp e
 WHERE e.ename LIKE '__M%'-- 패턴 인식 문자 _를 두번 사용하여 
                           -- M 앞자리를 2글자로 제한
;
/*
EMPNO,  ENAME
----------------
7900	JAMES
*/

-- 이름의 둘째자리부터 LA가 들어가는 이름을 가진 직원의
-- 사번, 이름 조회
SELECT e.empno
      , e.ename
  FROM emp e
 WHERE e.ename LIKE'_LA%'
;
/*
EMPNO,  ENAME
---------------
7698	BLAKE
7782	CLARK
*/

-- 다음의 명령을 실행
INSERT INTO "SCOTT"."EMP" (EMPNO,ENAME, JOB)
VALUES ('9999','J_JANME', 'CLERK')
;
INSERT INTO "SCOTT"."EMP" (EMPNO,ENAME, JOB)
VALUES ('8888','J%JANME', 'CLERK')
;

COMMIT;

--이름이 J_로 시작하는 직원의 사번, 이름을 조회
-- : 조회하려는 값에 패턴인식문자(%, _)가 들어 있는 데이터는
--   어떻게 조회할 것인가?

SELECT e.empno
      , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J_%'
;
-- => 위처럼 LIKE 조건을 작성하면 J뒤에 적어도 한글자가 있는
--    이름을 가진 직원이 모두 검색됨. 원하는 결과가 아니다.

--    패턴 인식 문자를 조회하려면 ESCAPE문자를 사용해야 된다.
--  =>패턴 인식 문자를 무효화 하려면 ESCAPE문자를 사용해야 한다.
SELECT e.empno
      , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J\_%' ESCAPE '\'
;
/*
EMPNO,  ENAME
--------------------
9999	J_JAMES
*/

SELECT e.empno
      , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J\%%' ESCAPE '\'
;
-- 8888 J%JAMES
/*
EMPNO,  ENAME
-----------------
8888	J%JANME
*/

--IS NULL : 비교하려고 하는 컬럼의 값이 NULL 일 때 true(참)
--          비교하려 하는 컬럼의 값이 NULL이 아니면 false(거짓)


--IS NULL : 비교하려고 하는 컬럼의 값이 NULL이 아니면 true(참)
--          비교하려 하는 컬럼의 값이 NULL이면 false(거짓)

-- NULL값 을 가진 컬럼은 비교연산자(=,!=,<>)와 연산이 불가능하므로
-- NULL값 비교를 위한 연산자가 따로 존재함에 주의!

-- col = NULL ==> NULL에 대해서는 동일비교 연산자(=)를 사용 못함.
-- col != NULL
-- col <> NULL ==>NULL에 대해서는
--                다름을 비교하는 연산자(!=,<>)를 사용 못함.

-- 상사(mgr)가 지정되지 않은 직원의
-- 사번, 이름, 상사사번(mgr) 조회

SELECT e.empno
      , e.ename
      , e.mgr
  FROM emp e
 WHERE e.mgr IS NULL --NULL데이터는 IS 연산자로
                     --비교해야 함
;
/*
EMPNO,  ENAME,       MGR
---------------------------
9999	J_JAMES	
8888	J%JANMES	
7839	KING	
*/

-- 상사(mgr)가 지정된 직원의
-- 사번, 이름, 상사사번(mgr) 조회
SELECT e.empno
      , e.ename
      , e.mgr
  FROM emp e
 WHERE e.mgr IS NOT NULL
 --e.mgr!=NULL/e.mgr<>NULL
 --라고 쓸 수 없음! 써도 구문 오류는 없고, 실행이 되는 것에 주의!
 -- 비교 연산자 !=,<> 사용시 실행 결과는
 -- 인출된 모든 행 : 0
 -- 이런경우에 실행이 되기때문에 오류를 찾기 어려우므로
 -- NULL 데이터를 다룰 때 항상 주의해야한다.
;
/*
EMPNO,  ENAME,  MGR
-------------------------
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

-----------------------------------
-- BETWEEN a AND b : 범위 포함 비교 연산자
-- a <= sal <=b : 이러한 범위 연산자와 동일

--28) 급여가 500~1200 사이인 직원의
--    사번, 이름, 급여 조회
SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e 
 WHERE e.sal BETWEEN 500 AND 1200
;
/*
EMPNO,  ENAME,  SAL
----------------------
7369	SMITH	800
7900	JAMES	950
*/

--BETWEEN 500 AND 1200과 같은 결과를 내는 비교연산자로 변경
SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e
 WHERE e.sal>=500 AND e.sal<=1200
;
/*
EMPNO,  ENAME,  SAL
----------------------
7369	SMITH	800
7900	JAMES	950
*/