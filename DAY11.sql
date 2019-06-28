-- DAY11
----- 7. ���ΰ� ��������
-- (2) �������� : Sub-Query

--   SELECT, FROM, WHERE ���� ���� �� �ִ�.

-- ����) BLAKE�� ����(job)�� ������ ������ ������ ��ȸ
-- 1. BLAKE �� ������ ��ȸ(��������)
SELECT e.job
  FROM emp e
 WHERE e.ename = 'BLAKE'
;

/*
MANAGER
*/

-- 2. 1�� ����� ����(���� ����)
-- ����(job)�� MANAGER �� ����� ��ȸ�Ͽ���.
SELECT e.empno 
      , e.ename
  FROM emp e
 WHERE e.job = 'MANAGER'
;

-- ���������� WHERE ���� ���� ��
-- MANAGER �� �ڸ��� 1�� ������ ������ ����.
SELECT e.empno 
      , e.ename
  FROM emp e
 WHERE e.job = (SELECT e.job
                   FROM emp e
                  WHERE e.ename = 'BLAKE')
;

-- ==> ���� ������ WHERE �� () ��ȣ �ȿ� ���޵Ǵ� ����
--     1�� ������ ����� MANAGER ��� ���̴�.

---------------------------------------------------
-- �������� ���� �� �ǽ�
-- 1. �� ȸ���� ��� �޿����� �޿��� ���� �޴� ������ ��� ��ȸ�Ͽ���.
--    ���, �̸�, �޿�
-- a) ȸ���� �޿� ��հ��� ���ϴ� ���� 
SELECT AVG(e.sal)
  FROM emp e
;
/*
AVG(E.SAL)
-------------------------------------------
1933.928571428571428571428571428571428571
*/

-- b) �� ��� ���� ���� �����Ͽ� �� ������ �޿��� ���� ������ ���ϴ� ����
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
-- c) b�� �������� ��հ� �ڸ��� (a)�� ������ ��ü
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

-- 2. �޿��� ��� �޿����� ũ�鼭
--    ����� 7700�� ���� ���� ������ ��ȸ�Ͻÿ�.
--    ���, �̸�, �޿��� ��ȸ
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


-- 3. �� �������� �ִ� �޿��� �޴� ���� ����� ��ȸ�Ͽ���.
--    ���, �̸�, ����, �޿��� ��ȸ

-- a) �������� �ִ� �޿��� ���ϴ� ���� : �׷��Լ�(MAX), �׷�ȭ ���� �÷�(job)
SELECT e.job
      , MAX(e.sal) "�ִ� �޿�"
  FROM emp e
 GROUP BY e.job
;

/*
JOB,    �ִ� �޿�
-----------------
CLERK	    1300
SALESMAN	1600
ANALYST	    3000
MANAGER	    2975
PRESIDENT	5000
*/
-- b) (a)���� ������ �ִ� �޿��� job�� ��ġ�ϴ��� �����ϴ� ����
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
-- c) (b)���� ���� ���� (a)�� ������ ��ü
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
-- 4. �� ���� �Ի��ο��� ���η� ����Ͻÿ�.
--    ������� : 1�� ~ 12������ �����Ͽ� ���
--  "�Ի��", "�ο���"
---------------------------
--    1��       3
--    2��       2
--  ...
--   12��       2
---------------------------
-- a) ������ �Ի� ���� ����
SELECT TO_CHAR(e.hiredate,'FMMM')||'��' "�Ի� ��"
  FROM emp e
;


-- b) �Ի� ���� �ο��� ī��Ʈ
SELECT TO_CHAR(e.hiredate,'FMMM')||'��' "�Ի� ��"
      , COUNT(*)
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate,'FMMM')
 ORDER BY "�Ի� ��"
;

-- c) �Ի� ���� ���� ������ �����ؾ� ������ �½��ϴ�.

SELECT TO_NUMBER(TO_CHAR(e.hiredate,'FMMM')) "�Ի� ��"
      , COUNT(*)
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate,'FMMM')
 ORDER BY "�Ի� ��"
;

-- d) (c)�� ����� FROM ���� ������ �� �� '��'�� �ٿ��� ��

SELECT a.month || '��' "�Ի� ��"
      , a.cnt "�ο�(��)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate,'FMMM')) month
              , COUNT(*) cnt
          FROM emp e
         GROUP BY TO_CHAR(e.hiredate,'FMMM')
         ORDER BY month) a
;

/*
�Ի� ��, �ο�(��)
--------------------
1��	    1
2��	    2
4��	    1
5��	    1
6��	    3
9��	    2
11��	1
12��	3
*/

