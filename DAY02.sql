-- DAY 02
-- SCOTT 계정 EMP 테이블 조회
SELECT *
From emp;

-- SCOTT 계정 DEPT 테이블 조회
SELECT *
FROM dept;

--1)emp 테이블에서 job컬럼 조회
SELECT job
FROM emp;

--2)emp 테이블에서 중복을 제거하여
-- job컬럼을 조회
SELECT DISTINCT job
FROM emp;
-- => 각 JOB이 한번씩만 조회된 결과를 얻을 수 있다.
--    이결과로 회사에는 다섯 종류의 JOB이 있음을 확인할 수 있다.

/*다중행 주석
JOB
---------
CLERK
SALESMAN
ANALYST
MANAGER
PRESIDENT
*/
