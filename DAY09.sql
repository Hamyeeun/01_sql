-- DAY09 : 

-- 2. ������ �Լ�(�׷� �Լ�)

-- 1) COUNT(*) : FROM���� ������
--               Ư�� ���̺��� ���� ���(������ ����)�� �����ִ� �Լ�
--               NULL���� ó���ϴ� "����"�� �׷��Լ�

--    COUNT(expr) : expr ���� ������ ���� NULL�� �����ϰ� �����ִ� �Լ�
-- ����) dept, salgrade ���̺��� ��ü ������ ���� ��ȸ

-- 1. dept���̺��� ��ȸ
SELECT d.*
FROM dept d
;
/*
DEPTNO, DNAME,      LOC
------------------------------
    10	ACCOUNTING	NEW YORK
    20	RESEARCH	DALLAS
    30	SALES	    CHICAGO
    40	OPERATIONS	BOSTON
*/
/* ������ �Լ��� ���� ����: 
    10	ACCOUNTING	NEW YORK ======> SUBSTR(dname, 1, 5)-----> ACCOU
    20	RESEARCH	DALLAS   ======> SUBSTR(dname, 1, 5)-----> 
    30	SALES	    CHICAGO
    40	OPERATIONS	BOSTON
*/

/* �׷� �Լ��� ���� ����: 
    10	ACCOUNTING	NEW YORK
    20	RESEARCH	DALLAS
    30	SALES	    CHICAGO
    40	OPERATIONS	BOSTON
*/
-- 2. dept ���̺��� ������ ���� ��ȸ : COUNT(*) ���

SELECT COUNT(*) "�μ� ����"
  FROM dept d
;
/*
�μ� ����
-----------
        4
*/

-- salgrade(�޿����) ���̺��� �޿� ��� ������ ��ȸ
SELECT COUNT(*) "�޿���� ����"
  FROM salgrade
;

/*
�޿���� ����
--------------
            5
*/

SELECT s.*
  FROM salgrade s
;

/*
1	700	    1200 =======> 
2	1201	1400 =======>
3	1401	2000 =======> COUNT(*) : 5
4	2001	3000 =======>
5	3001	9999 =======>
*/

-- COUNT(expr) �� NULL�����͸� ó������ ���ϴ� �� Ȯ���� ���� ������ �߰�
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ')
COMMIT;

-- emp ���̺��� job �÷��� ������ ������ ī��Ʈ
SELECT COUNT(e.job) "������ ������ ������ ��"
  FROM emp e
;
/*
������ ������ ������ ��
------------------------
                    14
*/

/*
9999	J_JAMES	    CLERK     =============>
8888	J%JANMES	CLERK     =============>
7777	JJ	        (null)    =============>
7369	SMITH	    CLERK     =============>
7499	ALLEN	    SALESMAN  =============>
7521	WARD	    SALESMAN  =============>
7566	JONES	    MANAGER   =============>
7654	MARTIN	    SALESMAN  =============>
7698	BLAKE	    MANAGER   =============> ������ ���� ���� �÷��� job��
7782	CLARK	    MANAGER   =============> null �� �� ���� ó���� ���� �ʴ´�.
7839	KING	    PRESIDENT =============>
7844	TURNER	    SALESMAN  =============> COUNT(e.job) = 14
7900	JAMES	    CLERK     =============>
7902	FORD	    ANALYST   =============>
7934	MILLER	    CLERK     =============>
*/

-- ����) ȸ�翡 �Ŵ����� ������ ������ ����ΰ�
--       ��Ī : ��簡 �ִ� ������ ��

SELECT COUNT(e.mgr) "��簡 �ִ� ������ ��"
  FROM emp e
;
/*
��簡 �ִ� ������ ��
----------------------
                   11
*/

-- ����) �޴��� ���� �ð� �ִ� ������ ����ΰ�?
-- 1. emp���̺� mgr �÷��� ������ ���¸� �ľ�
-- 2. mgr �÷��� ������ ���¸� �ľ�
SELECT DISTINCT e.mgr
  FROM emp e
;
/*
MGR
-----
7782
7698
7902
7566
(null)
7839
*/

-- 3. �ߺ������� ���ŵ� ����� ī��Ʈ

SELECT COUNT(DISTINCT e.mgr) "�Ŵ��� ��"
  FROM emp e
;
/*
�Ŵ��� ��
---------
       5
*/

-- ����) �μ��� ������ ������ ����̳� �ִ°�?
SELECT COUNT(e.deptno) "�μ� ���� �ο�"
  FROM emp e
;
/*
�μ� ���� �ο�
---------------
            12
*/

-- COUNT(*) �� �ƴ� COUNT(expr)�� ����� ��쿡��
SELECT COUNT(e.deptno) "�μ� ���� �ο�"
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
--  �� ������ ����� ī��Ʈ �� ������ ������ �� ����

-- ����) ��ü �ο�, �μ� ���� �ο�, �μ� �̹��� �ο� ���Ͻÿ�
SELECT COUNT(*) "��ü �ο�"
      , COUNT(e.deptno) "�μ� ���� �ο�"
      , COUNT(*)-COUNT(e.deptno) "�μ� �̹��� �ο�"
  FROM emp e
;
/*
��ü �ο�, �μ� ���� �ο�, �μ� �̹��� �ο�
---------------------------------------------
       15	          12	              3
*/

-- SUM(expr) : NULL �׸� �����ϰ�
--             �ջ� ������ ���� ��� ���� ����� ���
-- SALESMAN ���� ���� ������ ���غ���
SELECT SUM(e.comm) "���� ����"
  FROM emp e
;
/*
���� ����
---------
     2200
*/

/*
COMM
------
   300  =========>
   500  =========>
   1400 =========>  SUM(e.comm)   ======> 2200 : �ڵ����� NULL �� �÷� ����
   0    =========>
 
*/
SELECT SUM(e.comm) "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

-- ���� ���� ����� ���� ��� ���� ���� $, ���ڸ� ���� �б�
SELECT to_char(SUM(e.comm),'$9,999') "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
���� ����
----------
 $2,200
*/

-- 3) AVG(expr) : NULL�� �����ϰ� ���� ������ �׸��� ��� ����� ����

-- SALESMAN�� ���� ����� ���غ���

SELECT AVG(e.comm) "SALESMAN�� ���� ���"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

/*
SALESMAN�� ���� ���
--------------------
               550
*/

-- ���� ��� ����� ��� ���� $, ���ڸ� ���� �б�

SELECT to_char(AVG(e.comm),'$9,999') "SALESMAN�� ���� ���"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

/*
SALESMAN�� ���� ���
---------------------
 $550
*/

-- 4) MAX(expr) : expr�� ������ �� �� �ִ밪�� ����
--                expr�� ������ ���� ���ĺ� �� ���ʿ� ��ġ�� ���ڸ�
--                �ִ����� ���

-- �̸��� ���� ������ ����
SELECT MAX(e.ename) "�̸��� ���� ������ ����"
  FROM emp e
;
/*
�̸��� ���� ������ ����
-----------------------
WARD
*/

-- 4) MAX(expr) : expr�� ������ �� �� �ִ밪�� ����
--                expr�� ������ ���� ���ĺ� �� ���ʿ� ��ġ�� ���ڸ�
--                �ִ����� ���

-- �̸��� ���� ó���� ����
SELECT MIN(e.ename) "�̸��� ���� ó���� ����"
  FROM emp e
;

/*
�̸��� ���� ó���� ����
-----------------------
ALLEN
*/

-- 3. GROUP BY ���� ���
-- ����) �� �μ����� �޿��� ����, ���, �ִ�, �ּҸ� ��ȸ

--    �� �μ����� �޿��� ������ ��ȸ�Ϸ���
--    ���� : SUM()�� ���
--    �׷�ȭ ������ �μ���ȣ(deptno)�� ���
--    GROUP BY ���� �����ؾ� ��
-- a) ���� emp ���̺��� �޿� ������ ���ϴ� ���� �ۼ�
SELECT SUM(e.sal)
  FROM emp e
;

-- b) �μ� ��ȣ�� �������� �׷�ȭ ����
--    SUM()�� �׷��Լ���.
--    GROUP BY ���� �����Ϸ��� �׷�ȭ�� �����ϴ�.
--    �׷�ȭ�� �Ϸ��� ���� �÷��� GROUP BY ���� �����ؾ� ��.

SELECT e.deptno �μ���ȣ--�׷�ȭ �����÷����� SELECT ���� ����
      , SUM(e.sal) "�μ� �޿� ����" --�׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno --�׷�ȭ ���� �÷����� GROUP BY ���� ����
ORDER BY e.deptno
;

-- GROUP BY���� �׷�ȭ ���� �÷����� ������ �÷��� �ƴ� ����
-- SELECT ���� �����ϸ� ����, ���� �Ұ�
SELECT e.deptno �μ���ȣ--�׷�ȭ �����÷����� SELECT ���� ����
      , e.job -- �׷�ȭ ���� �÷��� �ƴѵ� SELECT ���� ���� -> ����!
      , SUM(e.sal) "�μ� �޿� ����" --�׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno --�׷�ȭ ���� �÷����� GROUP BY ���� ����
ORDER BY e.deptno
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

-- ����) �μ��� �޿��� ����, ���, �ִ�, �ּ�

SELECT e.deptno �μ���ȣ
      , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����"
      , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
      , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
      , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
ORDER BY e.deptno
;
/*
�μ���ȣ, �μ� �޿� ����, �μ� �޿� ���, �μ� �޿� �ִ�, �μ� �޿� �ּ�
10	        $8,750	        $2,916.67	    $5,000	        $1,300
20	        $6,775	        $2,258.33	    $3,000	          $800
30	        $9,400	        $1,566.67	    $2,850	          $950
*/
-- �μ���ȣ�� ������ ���
SELECT to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����"
      , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
      , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
      , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
ORDER BY e.deptno
;
/*
���� ������ ��������� ��Ȯ�ϰ� ��� �μ��� ������� �� �� ���ٴ� ������ ����

�׷���, GROUP BY ���� �����ϴ� ���� �÷��� SELECT ���� �Ȱ��� �����ϴ� ����
��� �ؼ��� ���Ѵ�.

SELECT ���� ������ �÷� �߿��� �׷��Լ��� ������ ���� �÷��� ���� ������
���� ������ ����Ǵ� ���̴�.
*/

-- ����) �μ���, ������ �޿��� ����, ���, �ִ�, �ּҸ� ���غ���.

SELECT e.deptno �μ���ȣ
      , e.job ����
      , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����"
      , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
      , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
      , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
ORDER BY e.deptno
;
/*
�μ���ȣ, ����,    �μ� �޿� ����, �μ� �޿� ���, �μ� �޿� �ִ�, �μ� �޿� �ּ�
10	      CLERK	    $1,300	        $1,300.00	    $1,300	 $1,300
10	      MANAGER	$2,450	        $2,450.00	    $2,450	 $2,450
10	      PRESIDENT	$5,000	        $5,000.00	    $5,000	 $5,000
20	      ANALYST	$3,000	        $3,000.00	    $3,000	 $3,000
20	      CLERK	    $800	        $800.00	        $800	   $800
20	      MANAGER	$2,975	        $2,975.00	    $2,975	 $2,975
30	      CLERK	    $950	        $950.00	        $950	   $950
30	      MANAGER	$2,850	        $2,850.00	    $2,850	 $2,850
30	      SALESMAN	$5,600	        $1,400.00	    $1,600	 $1,250
          CLERK				
					
*/

-- ������Ȳ
-- a) GROUP BY ���� �׷�ȭ ������ ������ ���
SELECT e.deptno �μ���ȣ
      , e.job ����
      , SUM(e.sal) "�μ� �޿� ����"
      , AVG(e.sal) "�μ� �޿� ���"
      , MAX(e.sal) "�μ� �޿� �ִ�"
      , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
ORDER BY e.deptno
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

-- b) SELECT ���� �׷��Լ��� �Ϲ� �÷��� ���� ����
--    GROUP BY �� ��ü�� ������ ���
SELECT e.deptno �μ���ȣ
      , e.job ����
      , SUM(e.sal) "�μ� �޿� ����"
      , AVG(e.sal) "�μ� �޿� ���"
      , MAX(e.sal) "�μ� �޿� �ִ�"
      , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
-- GROUP BY e.deptno, e.job
ORDER BY e.deptno
;
/*
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
00937. 00000 -  "not a single-group group function"
*/

-- ����) ����(job) �� �޿��� ����, ���, �ִ�, �ּҸ� ���غ���
--       ��Ī : ����, �޿�����, �޿����, �ִ�޿�, �ּұ޿�
SELECT e.job ����
      , SUM(e.sal) �޿����� 
      , AVG(e.sal) �޿����
      , MAX(e.sal) �ִ�޿�
      , MIN(e.sal) �ּұ޿�
  FROM emp e
 GROUP BY e.job
;

/*
����,     �޿�����, �޿����, �ִ�޿�, �ּұ޿�
-------------------------------------------------
ANALYST	3000	 3,000.00	3000	3000
CLERK	3050	 1,016.67	1300	800
MANAGER	8275	 2,758.33	2975	2450
PRESIDENT	5000	 5,000.00	5000	5000
SALESMAN	5600	 1,400.00	1600	1250
(null)(null)(null)(null)(null)
*/

-- ���� null ������� ������ ��� ���� �̹������� ���

SELECT NVL(e.job, '���� �̹���') ����
      , SUM(e.sal) �޿����� 
      , to_char(AVG(e.sal),'9,999.99') �޿����
      , MAX(e.sal) �ִ�޿�
      , MIN(e.sal) �ּұ޿�
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job
;

-- �μ��� ����, ���, �ִ�, �ּ�
-- �μ���ȣ�� null�� ��� '�μ� �̹���'���� �з��ǵ��� ��ȸ
SELECT NVL(e.deptno,'�μ� �̹���') �μ���ȣ
      , e.job ����
      , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����"
      , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
      , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
      , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
ORDER BY e.deptno
;
/*
deptno�� ����, '�μ� �̹���'�� ���� ������ �̹Ƿ� Ÿ�� ����ġ��
  NVL()�� �۵����� ���Ѵ�.
  
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*/

-- �ذ��� : deptno �� ���� ����ȭ(to_char ���)
SELECT NVL(to_char(e.deptno),'�μ� �̹���') �μ���ȣ
      , e.job ����
      , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����"
      , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
      , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
      , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
ORDER BY e.deptno
;
-- ���ڸ� ���ڷ� ���� : ���� ������(||)�� ���
SELECT NVL(e.deptno ||'','�μ� �̹���') �μ���ȣ
      , e.job ����
      , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����"
      , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
      , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
      , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
ORDER BY e.deptno
;
-- NVL, DECODE, TO_CHAR�� ����
SELECT DECODE(NVL(e.deptno, 0), e.deptno, to_char(e.deptno)
                               , 0       , '�μ� �̹���') �μ���ȣ
      , e.job ����
      , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����"
      , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
      , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
      , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
ORDER BY e.deptno
;

---------- 4. HAVING ���� ���
-- GROUP BY ����� ������ �ɾ
-- �� ����� ������ �������� ���Ǵ� ��

-- HAVING ���� WHERE ���� ��������� 
-- SELECT ������ ���� ���������� 
-- GROUP BY �� ���� ���� ����Ǵ� WHERE���δ�
-- GROUP BY���� ������ �� ����.

-- ���� GROUP BY ���� ���� ������ ������
-- HAVING ������ �����Ѵ�.

-- ����) �μ��� �޿� ����� 2000 �̻��� �μ��� ��ȸ�Ͽ���.

-- a) �켱 �μ��� �޿� ����� ���Ѵ�.
SELECT e.deptno �μ���ȣ
      , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
;

-- b) �޿� ����� 2000 �̻��� ��ո� ������
--    HAVING���� ��� ����
SELECT e.deptno �μ���ȣ
      , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;
-- ����� ���� ����
SELECT e.deptno �μ���ȣ
      , to_char(AVG(e.sal), '$9,999.99') �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

/*
�μ���ȣ, �޿����
     10	  $2,916.67
     20	  $2,258.33
*/

-- ���� : HAVING ������ ��Ī�� ����� �� ����.
SELECT e.deptno �μ���ȣ
      , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING "�޿����" >= 2000 -- HAVING�� ��Ī�� ����� �� ����
;

/*
ORA-00904: "�޿����": �������� �ĺ���
00904. 00000 -  "%s: invalid identifier"
*/

-- HAVING ���� �����ϴ� ��� SELECT ������ ���� ���� ����
/*
1. FROM     ���� ���̺� �� �� ��θ� �������
2. WHERE    ���� ���ǿ� �´� �ุ �����ϰ�
3. GROUP BY ���� ���� �÷�, ��(�Լ� ��) ���� �׷�ȭ ����
4. HAVING   ���� ������ ������Ű�� �׷��ุ ����
5.          4���� ���õ� �׷� ������ ���� �࿡ ���ؼ�
6. SELECT   ���� ��õ� �÷�, ��(�Լ� ��)�� ���
7. ORDER BY �� �ִٸ� ���� ���ǿ� ���� �������� �Ͽ� ��� ���
*/