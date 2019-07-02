-- DAY13

--------------------------
-- ����Ŭ�� Ư���� �÷� 2����
-- ����ڰ� ������ ��� �ڵ����� �����Ǵ� �÷�

-- 1. ROWID : ���������� ��ũ�� ����� ��ġ�� ����Ű�� ��
--            ������ ��ġ�̹Ƿ� �� ��� �ݵ�� ������ ���� �� �ۿ� ����
--            ORDER BY ���� ���� ������� �ʴ� ��


-- 2. ROWNUM : ��ȸ�� ����� ù��° ����� 1�� �����ϴ� ��
------------------------------------------------------

-- ��) emp ���̺��� 'SMITH'�� ��ȸ
SELECT e.empno
      , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

-- ROWID �� ���� ��ȸ
SELECT rowid
      , e.empno
      , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
/*
ROWID,              EMPNO,  ENAME
----------------------------------
AAAR9ZAAHAAAACXAAA	7369	SMITH
*/

-- ROWNUM �� ���� ��ȸ
SELECT rownum
      , e.empno
      , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;

/*
ROWNUM, EMPNO, ENAME
-------------------------
1	    7369   SMITH
*/

--------------------------------
-- ORDER BY ���� ���� ROWNUM �� ����Ǵ� ��� Ȯ��
-- (1) ORDER BY �� ���� ���� ROWNUM
SELECT rownum
      , e.empno
      , e.ename
  FROM emp e
;
/*
ROWNUM, EMPNO, ENAME
------------------------
1	    7777	JJ
2	    8888	J_JAMES
3	    7369	SMITH
4	    7499	ALLEN
5	    7521	WARD
6	    7566	JONES
7	    7654	MARTIN
8	    7698	BLAKE
9	    7782	CLARK
10	    7839	KING
11	    7844	TURNER
12	    7900	JAMES
13	    7902	FORD
14	    7934	MILLER
*/

-- (2) ename ������ �������� ���� �� �� Ȯ��
SELECT rownum
      , e.empno
      , e.ename
  FROM emp e
 ORDER BY e.ename
;

/*
ROWNUM, EMPNO,  ENAME
-------------------------
4	    7499	ALLEN
8	    7698	BLAKE
9	    7782	CLARK
13	    7902	FORD
12	    7900	JAMES
1	    7777	JJ
6	    7566	JONES
2	    8888	J_JAMES
10	    7839	KING
7	    7654	MARTIN
14	    7934	MILLER
3	    7369	SMITH
11	    7844	TURNER
5	    7521	WARD
*/
-- ==> ROWNUM �� ORDER BY ���� ������ ���� �ʴ� ��ó�� ���� �� ����
--     SUB-QUERY ���� ������ ����.

-- (4) SUB-QUERY �� ���� �� ROWNUM �� �� Ȯ��
SELECT rownum
      , a.empno
      , a.ename
      , a.numrow
  FROM (SELECT rownum numrow
              , e.empno
              , e.ename
          FROM emp e
         ORDER BY e.ename)A
;

/*
ROWNUM, EMPNO, ENAME, NUMROW
----------------------------
1	    7499	ALLEN	4
2	    7698	BLAKE	8
3	    7782	CLARK	9
4	    7902	FORD	13
5	    7900	JAMES	12
6	    7777	JJ	    1
7	    7566	JONES	6
8	    8888	J_JAMES	2
9	    7839	KING	10
10	    7654	MARTIN	7
11	    7934	MILLER	14
12	    7369	SMITH	3
13	    7844	TURNER	11
14	    7521	WARD	5
*/

-- �̸��� A�� ���� ������� ��ȸ
SELECT rownum
      , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
;

/*
ROWNUM, ENAME
---------------
1	    J_JAMES
2	    ALLEN
3	    WARD
4	    MARTIN
5	    BLAKE
6	    CLARK
7	    JAMES
*/

-- �̸��� A�� ���� ������� �̸������� ���� �� ��ȸ
SELECT rownum
      , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
 ORDER BY e.ename
;
/*
ROWNUM, ENAME
-----------------
2	    ALLEN
5	    BLAKE
6	    CLARK
7	    JAMES
1	    J_JAMES
4	    MARTIN
3	    WARD
*/

-- �̸��� s�� ���� ������� ��ȸ
-- �̶�, ROWNUM, ROWIDȮ��
SELECT rownum
      , e.rowid
      , e.ename
  FROM emp e
 WHERE e.ename LIKE '%S%'
 ORDER BY e.ename
;
/*
ROWNUM,    ROWID,       ENAME
-----------------------------
4	AAAR9ZAAHAAAACXAAJ	JAMES
3	AAAR9ZAAHAAAACXAAD	JONES
1	AAAR9ZAAHAAAACUAAD	J_JAMES
2	AAAR9ZAAHAAAACXAAA	SMITH
*/

-- �̸��� S�� ���� ������� ��ȸ ����� 
-- SUB-QUERY �� ������ ���� ROWNU, ROWID Ȯ��
SELECT rownum
      , a.rowid
      , a.ename
 FROM (SELECT e.rowid
             , e.ename
         FROM emp e
        WHERE e.ename LIKE '%S%'
        ORDER BY e.ename) a
;

/*
ROWNUM,     ROWID,      ENAME
--------------------------------
1	AAAR9ZAAHAAAACXAAJ	JAMES
2	AAAR9ZAAHAAAACXAAD	JONES
3	AAAR9ZAAHAAAACUAAD	J_JAMES
4	AAAR9ZAAHAAAACXAAA	SMITH
*/

-- ROWNUM���� �� �� �ִ� ����
-- emp ���̺��� �޿��� ���� �޴� ���� 5���� ��ȸ�Ͻÿ�

-- 1. �޿��� ���� ���� ����
SELECT e.empno
      , e.ename
      , e.sal
  FROM emp e
 ORDER BY e.sal DESC
;
-- 2. 1�� ����� SUB-QUERY ��FROM���� ����ϰ�
--    ������������ ROWNUM�� ���� ��ȸ
SELECT ROWNUM
      , a.*
  FROM (SELECT e.empno
              , e.ename
              , e.sal
          FROM emp e
         ORDER BY e.sal DESC) a
;

-- 3. �� ��, rownum <= 5 ���� �߰�
SELECT ROWNUM
      , a.*
  FROM (SELECT e.empno
              , e.ename
              , e.sal
          FROM emp e
         ORDER BY e.sal DESC) a
 WHERE rownum <= 5
;

----------------------------------------------
-- DDL : ������ ���۾�
----------------------------------------------
-- 1) INSERT : ���̺� ������ ��(row)�� �߰��ϴ� 

-- MEMBER ���̺� ������ �߰� ����
DROP TABLE member;
CREATE TABLE member
(  member_id     VARCHAR2(4)   
 , member_name  VARCHAR2(15)  NOT NULL
 , phone         VARCHAR2(4)   -- NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 , reg_data      DATE           DEFAULT sysdate
 , address       VARCHAR2(30)
 , major         VARCHAR2(50)
 , birth_month   NUMBER(2)
 , gender        VARCHAR(1)     
 , CONSTRAINT PK_MEMBER PRIMARY KEY (member_id)
 , CONSTRAINT CK_MEMBER CHECK (gender IN ('F','M'))
 , CONSTRAINT CK_BIRTH CHECK (birth_month BETWEEN 1 and 12)
);

-- 1. INTO ������ �÷��̸� ������ ������ �߰�
--    : VALUES ���� �ݵ�� ��ü �÷��� �����͸� ������� ��� ����
INSERT INTO MEMBER 
VALUES ('M001', '�ڼ���', '9155', sysdate, '������', '����', 3, 'M');

INSERT INTO MEMBER 
VALUES ('M002', '������', '1418', sysdate, '������', NULL, NULL, 'M');
/*
INSERT INTO MEMBER 
VALUES ('M002', '������', '1418', sysdate, '������', 'M')
-- ��ó�� VALUES ���� ������ ���� ������ ��ü �÷��� ���� ��ġ���� ������
-- �Ʒ��� ���� ������ �߻��ϹǷ�, NULL �����͸� �Է��ؼ��� �÷� ���� �����ش�.

���� �߻� �����: 271 ��: 13
���� ���� -
SQL ����: ORA-00947: ���� ���� ������� �ʽ��ϴ�
00947. 00000 -  "not enough values"
*/

INSERT INTO MEMBER 
VALUES ('M003', '�̺���', '0186', sysdate, NULL, NULL, 3, 'M');

INSERT INTO MEMBER 
VALUES ('M004', '�蹮��', NULL, sysdate, 'û�ֽ�', '�Ͼ�', 3, 'F');

INSERT INTO MEMBER 
VALUES ('M005', '����ȯ', '0322', sysdate, '�Ⱦ��', '����', 3, NULL);

COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
*/

-- PK �������ǿ� ����Ǵ� ������ �߰� �õ� : M005�� �̹� ����
INSERT INTO MEMBER 
VALUES ('M005', 'Ȩ�浿', '0001', sysdate, '������', '����', 3, 'M');
-- ORA-00001: ���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ�

-- GENDER �÷��� CHECK ���������� �����ϴ� ������ �߰� �õ�
-- GENDER �÷���, 'F', 'M', NULL ���� ���� �߰��ϸ�
INSERT INTO MEMBER 
VALUES ('M006', 'Ȩ�浿', '0001', sysdate, '������', '����', 3, 'G');
-- ORA-02290: üũ ��������(SCOTT.CK_MEMBER)�� ����Ǿ����ϴ�

-- BIRTH_MONTH �÷��� 1 ~ 12 ���� ���ڰ� �Է� �õ�
INSERT INTO MEMBER 
VALUES ('M006', 'Ȩ�浿', '0001', sysdate, '������', '����', 13, 'M');
-- ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ�

-- MEMBER_NAME�� NULL�Է� �õ�
INSERT INTO MEMBER 
VALUES ('M006', NULL, '0001', sysdate, '������', '����', 13, 'M');
-- ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_NAME") �ȿ� ������ �� �����ϴ�

INSERT INTO MEMBER 
VALUES ('M006', 'ȫ�浿', '0001', sysdate, '������', '����', 5, 'M');
COMMIT;

-- 2. INTO ���� �÷� �̸��� ����� ����� ������ �߰�
--    : VALUES ���� INTO�� �������
--      ���� Ÿ��, ������ ���߾ �ۼ�

INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007', '������');
COMMIT;

/*
1 �� ��(��) ���ԵǾ����ϴ�.

Ŀ�� �Ϸ�.
*/
INSERT INTO MEMBER (member_id, member_name, gender)
VALUES ('M008', '������', 'M');
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.

Ŀ�� �Ϸ�.

: ����� member_id, member_name, reg_date, gender
  �÷�� ���� �� �� Ȯ��
*/

-- ���̺� ���� ������ �������
-- INTO ���� �÷��� ���� �� �� �ִ�.
INSERT INTO MEMBER (birth_month, member_name, member_id)
VALUES (7, '������', 'M009');
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.

Ŀ�� �Ϸ�.
*/


-- INTO ���� �÷� ������ VALUES ���� ���� ���� ����ġ
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M010', '���', 'M');
/*
SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ�
00913. 00000 -  "too many values"
*/

-- INTO ���� VALUES ���� ������ ������
-- ���� Ÿ���� ��ġ���� ���� ��
-- ���� ������ �÷��� birth_month�� '�Ѿ�'�̶�� ���ڸ�
-- �߰��Ϸ��� �õ�
INSERT INTO MEMBER (member_id, member_name, birth_month)
VALUES ('M010', '���', '�Ѿ�');
/*
���� ���� -
ORA-01722: ��ġ�� �������մϴ�
*/

-- �ʼ� �Է� �÷��� �������� ���� ��
-- member_id : PK, member_name : NOT NULL
INSERT INTO MEMBER (birth_month, address, gender)
VALUES (12, '��������', 'F');
-- ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_ID") �ȿ� ������ �� �����ϴ�

-----------------------------------------------------------------------------------
-- ������ �Է� : SUB-QUERY �� ����Ͽ� ����

-- ���� ����
INSERT INTO ���̺��̸�
SELECT ����; -- ��������

/*
CREATE TABLE ���̺��̸�
AS
SELECT ....
 : ���������� �����͸� �����ϸ鼭 �� ���̺��� ����
 
 vs.
 
INSERT INTO ���̺��̸�
SELECT ����;
 : �̹� ������� ���̺� �����͸� �����ؼ� �߰�
*/

-- new_member ����
DROP TABLE new_member;
-- Table NEW_MEMBER��(��) �����Ǿ����ϴ�.

-- member �����ؼ� ���̺� ����
CREATE TABLE new_member
AS
SELECT m.*
  FROM member m
 WHERE 1 = 2
;
-- Table NEW_MEMBER��(��) �����Ǿ����ϴ�.

-- ������ �Է� ���������� new_member ���̺� ������ �߰�
-- �̸� ��� ���ڰ� '��'�� ������� ������ �߰�
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.member_name LIKE '_��_'
;
COMMIT;
/* 
3�� �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
*/

-- �÷��� ����� ������ �Է�
INSERT INTO new_member (member_id, member_name, phone)
SELECT m.member_id
      , m.member_name
      , m.phone
  FROM member m
 WHERE m.member_id < 'M004'
;
COMMIT;

/*
3�� �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
*/
-- new_member �� �߰��� �� ��� ����
DELETE new_member;
COMMIT;

-- ������� ��� �� ������ ����
UPDATE "SCOTT"."MEMBER" 
   SET BIRTH_MONTH = '1' 
 WHERE MEMBER_ID = 'M002'
 ;
UPDATE "SCOTT"."MEMBER" 
   SET BIRTH_MONTH = '2' 
 WHERE MEMBER_ID = 'M007'
 ;
UPDATE "SCOTT"."MEMBER" 
   SET BIRTH_MONTH = '1' 
 WHERE MEMBER_ID = 'M008'
 ;
COMMIT;
---------------------------------------

-- ����) new_member ���̺�
--       member ���̺�κ��� �����͸� �����Ͽ� ������ �Է��� �Ͻÿ�.
--       ��, member ���̺��� �����Ϳ��� ������� birth_month�� 
--       Ȧ������ ����鸸 ��ȸ�Ͽ� �Է��Ͻÿ�.
DELETE new_member;
COMMIT;

INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE MOD(m.birth_month, 2) = 1
;
COMMIT;
/*
8�� �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
*/

------------------------------------------------------------

-- 2) UPDATE : ���̺��� ��(���ڵ�)�� ����
--             WHERE �������� ���տ� ����

--             1�ุ �����ϰų� ���� �� ������ ����
--             ���� ���� �����Ǵ� ���� �ſ� ���ǰ� �ʿ�!!

-- UPDATE ���� ����
UPDATE ���̺��
   SET �÷�1 = ��1
     [,�÷�2 = ��2]
     ...
     [,�÷�n = ��n]
 [WHERE ����]
;
-- ��) ȫ�浿�� �̸��� �����õ�
UPDATE member m -- ���̺� ��Ī
   SET m.member_name = '�浿��'
 WHERE m.member_id = 'M006'
 -- PK�� ã�ƾ� ��Ȯ�� ȫ�浿 ���� ã�ư� �� ����
;
COMMIT;
/*
1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
Ŀ�� �Ϸ�.
*/

-- ��) �蹮�� ����� ��ȭ��ȣ ���ڸ� ������Ʈ
--     �ʱ⿡ INSERT ��  NULL �� �����͸� ���� ���� ���
--     �Ŀ� ������ ������ �߻��� �� �ִ�.
--     �̷���� UPDATE �������� ó��
UPDATE member m
   SET m.phone = '1392'
 WHERE m.member_id = 'M004'
;
COMMIT;

-- ��) ������(M009) ����� ������ ����
--     ������
UPDATE member m
   SET m.major = '������'
-- WHERE m.member_id = 'M009' --�Ǽ��� WHERE�� ����
;
/*
9�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
: WHERE ������ ���� ������ ��� �࿡ ���ؼ�
  major �÷��� ��� ������ �Ͼ ���
  
  ==> DML �۾� �Ǽ�,
      ������ : �׷��� UPDATE ���� ������ �ƴ϶�� ��
*/
-- COMMIT �۾� ���� �ǵ����� ROLLBACK �������
-- �߸��� ������Ʈ �ǵ�����

ROLLBACK;
-- �ѹ� �Ϸ�.
-- M004 ����� ��ȭ��ȣ�� ������Ʈ �� ���� ������ Ŀ���̹Ƿ�
-- �� ������ �����ͷ� ����

-- M009 ����� major ������Ʈ ����
UPDATE member m
   SET m.major = '������'
 WHERE m.member_id = 'M009'
;
-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
COMMIT; -- ��������� ���������� �ݿ��Ѵ�.
-- Ŀ�� �Ϸ�.

-- ���� �÷� ������Ʈ(2�� �̻��� �÷��� �ѹ��� ������Ʈ)
-- ��) ������(M008) ����� ��ȭ��ȣ, �ּ�, ������ �ѹ��� ������Ʈ
-- SET ���� ������Ʈ �� �÷��� ���� ����

UPDATE member m
   SET m.phone = '4119'
      , m.address = '�ƻ��'
      , m.major = '�Ͼ�'
 WHERE m.member_id = 'M008'
;
-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
COMMIT;
-- Ŀ�� �Ϸ�.

-- ��) '�Ⱦ��'�� ��� '����ȯ' ����� GENDER ���� ����
--      WHERE ���ǿ� �ּҸ� ���ϴ� ������ ���� ���
UPDATE member m
   SET m.gender = 'M'
 WHERE m.address = '�Ⱦ��'
;
-- WHERE ������ ����(X), WHERE ������ ���� ����(X)
-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
ROLLBACK;
-- �ѹ� �Ϸ�.
-- ���� ���� ����� ���� ���������� �۵��� ������ ��������
-- �����Ͱ� �پ������� ���۵��� ������ �ִ� �����̴�.
-- ���� UPDATE �ۼ��ÿ��� WHERE ������ �ۼ���
-- ���Ǹ� ��￩�� ��.

-- 1���� �����ϴ� �����̶�� �ݵ�� PK �÷��� ���ؾ� �Ѵ�.
-- PK �÷��� ��ü �࿡�� �����ϰ�
-- NOT NULL�� ����Ǵ� �÷��̹Ƿ�
-- �ݵ�� �� ���� ã�� �� �ִ� ���̱� ������, PK ����� �����

-- UPDATE ������ SELECT �������� ���
-- ��) ������(M008) ����� major��
--     ������(M002) ����� major�� ����

-- 1) M008�� major�� ���ϴ� SELECT
SELECT m.major
  FROM member m
 WHERE m.member_id = 'M008'
;

-- 2) M002 ����� major �� �����ϴ� UPDATE ���� �ۼ�
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m
                   WHERE m.member_id = 'M008')
 WHERE m.member_id = 'M002'
;
-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
COMMIT;
-- Ŀ�� �Ϸ�.

-- ���� SET ���� ����ϴ� ���������� ����� 
-- ��Ȯ�ϰ� 1�� 1���� 1���� ���� �ƴ� ��� ���� ����
UPDATE member m
   SET m.major = (SELECT m.major
                    FROM member m)
 WHERE m.member_id = 'M002'
;
-- ORA-01427: ���� �� ���� ���ǿ� 2�� �̻��� ���� ���ϵǾ����ϴ�.

UPDATE member m
   SET m.major = (SELECT m.major
                        , m.member_id
                    FROM member m
                   WHERE m.member_id = 'M008')
 WHERE m.member_id = 'M002'
;
-- SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ�

-- UPDATE �� �������� �����ϴ� ���
-- ��) M001 �� member_id ������ �õ�
--     : PK �÷����� �ߺ������� ������ �õ��ϴ� ���

UPDATE member m
   SET m.member_id = 'M002'
 WHERE m.member_id = 'M001'
;
-- ORA-00001: ���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ�

-- ��) NOT NULL �� member_name�� NULL �����ͷ�
--     ������Ʈ�� �õ��ϴ� ���
UPDATE member m
   SET m.member_name = NULL
 WHERE m.member_id = 'M001'
;
-- ORA-01407: NULL�� ("SCOTT"."MEMBER"."MEMBER_NAME")�� ������Ʈ�� �� �����ϴ�

-- ��) M001 �����Ϳ� ���ؼ�
--     birth_month �� -1 �� ���� �õ�
UPDATE member m
   SET m.birth_month = -1
 WHERE m.member_id = 'M001'
;
-- ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ�

--------------------------------------------------------------------------------
-- ������ �ǽ�

-- 1) PHONE �÷��� NULL�� �������
--    �ϰ������� '0000'���� ������Ʈ
--    PK�� �� �ʿ� ���� ����
UPDATE member m
   SET m.phone = '0000'
 WHERE m.phone IS NULL
;
COMMIT;
-- 2�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- 2) M001 ����� ������
--    NULL ������ ������Ʈ
--    PK�� �ɾ �����ؾ� �ϴ� ����
UPDATE member m
   SET m.major = NULL
 WHERE m.member_id = 'M001'
;
COMMIT;
-- 3) ADRESS �÷��� NULL �� �������
--    �ϰ������� '�ƻ��' �� ������Ʈ
--    PK�� �� �ʿ� ���� ����
UPDATE member m
   SET m.address = '�ƻ��'
 WHERE m.address IS NULL
;
COMMIT;
-- 4) M009 ����� NULL �����͸� 
--    ��� ������Ʈ
--    PHONE : 3581
--    ADDRESS : õ�Ƚ�
--    GENDER : M
UPDATE member m
   SET m.phone = '3581'
     , m.address = 'õ�Ƚ�'
     , m.gender = 'M'
 WHERE m.member_id = 'M009'
;
COMMIT;