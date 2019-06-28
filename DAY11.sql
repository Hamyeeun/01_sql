-- DAY11
----- 7. 조인과 서브쿼리
-- (2) 서브쿼리 : Sub-Query

--   SELECT, FROM, WHERE 절에 사용될 수 있다.

-- 문제) BLAKE와 직무(job)가 동일한 직원의 정보를 조회
-- 1. BLAKE 의 직무를 조회(서브쿼리)
SELECT e.job
  FROM emp e
 WHERE e.ename = 'BLAKE'
;

/*
MANAGER
*/

-- 2. 1의 결과를 적용(메인 쿼리)
-- 직무(job)가 MANAGER 인 사람을 조회하여라.
SELECT e.empno 
      , e.ename
  FROM emp e
 WHERE e.job = 'MANAGER'
;

-- 메인쿼리는 WHERE 절의 조건 중
-- MANAGER 값 자리에 1의 쿼리가 통으로 들어간다.
SELECT e.empno 
      , e.ename
  FROM emp e
 WHERE e.job = (SELECT e.job
                   FROM emp e
                  WHERE e.ename = 'BLAKE')
;

-- ==> 메인 쿼리의 WHERE 절 () 괄호 안에 전달되는 값은
--     1번 쿼리의 결과인 MANAGER 라는 값이다.

---------------------------------------------------
-- 서브쿼리 수업 중 실습
-- 1. 이 회사의 평균 급여보다 급여를 많이 받는 직원을 모두 조회하여라.
--    사번, 이름, 급여
-- a) 회사의 급여 평균값을 구하는 쿼리 
SELECT AVG(e.sal)
  FROM emp e
;
/*
AVG(E.SAL)
-------------------------------------------
1933.928571428571428571428571428571428571
*/

-- b) 그 평균 값을 직접 적용하여 그 값보다 급여가 높은 직원을 구하는 쿼리
SELECT e.ename
      , e.sal
  FROM emp e
 WHERE e.sal > (1933.928571428571428571428571428571428571)
;
/*
ENAME,  SAL
--------------
JONES	2975
BLAKE	2850
CLARK	2450
KING	5000
FORD	3000
*/
-- c) b의 쿼리에서 평균값 자리에 (a)의 쿼리를 대체
SELECT e.ename
      , e.sal
  FROM emp e
 WHERE e.sal > (SELECT AVG(e.sal)
                   FROM emp e)
;
/*
ENAME,  SAL
---------------
JONES	2975
BLAKE	2850
CLARK	2450
KING	5000
FORD	3000
*/

-- 2. 급여가 평균 급여보다 크면서
--    사번이 7700번 보다 높은 직원을 조회하시오.
--    사번, 이름, 급여를 조회
SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e
 WHERE e.sal > (SELECT AVG(e.sal)
                   FROM emp e)
   AND e.empno > 7700
;
/*
EMPNO,  ENAME,  SAL
-----------------------
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
*/


-- 3. 각 직무별로 최대 급여를 받는 직원 목록을 조회하여라.
--    사번, 이름, 직무, 급여를 조회

-- a) 직무별로 최대 급여를 구하는 쿼리 : 그룹함수(MAX), 그룹화 기준 컬럼(job)
SELECT e.job
      , MAX(e.sal) "최대 급여"
  FROM emp e
 GROUP BY e.job
;

/*
JOB,    최대 급여
-----------------
CLERK	    1300
SALESMAN	1600
ANALYST	    3000
MANAGER	    2975
PRESIDENT	5000
*/
-- b) (a)에서 구해진 최대 급여와 job이 일치하는지 적용하는 쿼리
SELECT e.empno
      , e.ename
      , e.job
      , e.sal max
  FROM emp e
 WHERE (e.job = 'CLERK' AND e.sal = 1300)
    OR (e.job = 'SALESMAN' AND e.sal = 1600)
    OR (e.job = 'ANALYST' AND e.sal = 3000)
    OR (e.job = 'MANAGER' AND e.sal = 2975)
    OR (e.job = 'PRESIDENT' AND e.sal = 5000)
;
/*
EMPNO,  ENAME,  JOB,        SAL
---------------------------------
7934	MILLER	CLERK	    1300
7499	ALLEN	SALESMAN	1600
7902	FORD	ANALYST	    3000
7566	JONES	MANAGER	    2975
7839	KING	PRESIDENT	5000
*/
-- c) (b)에서 사용된 값을 (a)의 쿼리로 대체
SELECT e.empno
      , e.ename
      , e.job
      , e.sal
  FROM emp e
 WHERE (e.job, e.sal) IN (SELECT e.job
                        , MAX(e.sal)
                   FROM emp e
                  GROUP BY e.job)
;
/*
EMPNO,  ENAME,  JOB,        SAL
---------------------------------
7934	MILLER	CLERK	    1300
7499	ALLEN	SALESMAN	1600
7902	FORD	ANALYST	    3000
7566	JONES	MANAGER	    2975
7839	KING	PRESIDENT	5000
*/
-- 4. 각 월별 입사인원을 세로로 출력하시오.
--    출력형태 : 1월 ~ 12월까지 정렬하여 출력
--  "입사월", "인원명"
---------------------------
--    1월       3
--    2월       2
--  ...
--   12월       2
---------------------------
-- a) 직원의 입사 월만 추출
SELECT TO_CHAR(e.hiredate,'FMMM')||'월' "입사 월"
  FROM emp e
;


-- b) 입사 월별 인원을 카운트
SELECT TO_CHAR(e.hiredate,'FMMM')||'월' "입사 월"
      , COUNT(*)
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate,'FMMM')
 ORDER BY "입사 월"
;

-- c) 입사 월을 숫자 값으로 변경해야 정렬이 맞습니다.

SELECT TO_NUMBER(TO_CHAR(e.hiredate,'FMMM')) "입사 월"
      , COUNT(*)
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate,'FMMM')
 ORDER BY "입사 월"
;

-- d) (c)의 결과를 FROM 절에 통으로 들어간 후 '월'을 붙여야 함

SELECT a.month || '월' "입사 월"
      , a.cnt "인원(명)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate,'FMMM')) month
              , COUNT(*) cnt
          FROM emp e
         GROUP BY TO_CHAR(e.hiredate,'FMMM')
         ORDER BY month) a
;

/*
입사 월, 인원(명)
--------------------
1월	    1
2월	    2
4월	    1
5월	    1
6월	    3
9월	    2
11월	1
12월	3
*/

