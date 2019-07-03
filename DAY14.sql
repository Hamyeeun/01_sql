-- DAY14 : DML ���

--------------------------------------------
-- 3) DELETE : ���̺����� ������� �����͸� ����

-- DELETE ���� ����
DELETE [FROM] ���̺��̸� [���̺���Ī]
 WHERE ����
;

-- 1. WHERE ������ �ִ� DELETE ����
-- ���� �� Ŀ��
COMMIT;

-- member ���̺����� gender �� 'F'�� �����͸� ����

DELETE member m
 WHERE m.gender = 'R' -- ��Ÿ�� R�� ���ߴٸ�
;
-- 0�� �� ��(��) �����Ǿ����ϴ�.
-- �� ����� ������ ������ ���� ������ ��������� �ȴ�.
-- ������ ������ ���� 0���� ������ 
-- ����, gender �÷��� R���� �ִ� ���� ���� ������
-- �������� ���� ����� �´�.
-- �츮�� ���ϴ� ����� �ƴ� ��

DELETE member m
 WHERE m.gender = 'F'
;

-- 1 �� ��(��) �����Ǿ����ϴ�.
-- WHERE ������ �����ϴ� ��� �࿡ ���ؼ� ���� ����
-- gender �� 'F'�� ���� 1�� ������
-- ������ Ư���� ���� �� PK�� �ƴ� �������� �����ϴ� ����
-- �����ؾ���

-- ���� ������ �ǵ���
ROLLBACK;

-- ���� 'M004' ���� �����ϴ� ���� �����̸� PK�� �����ؾ� ��
DELETE member m
 WHERE m.member_id = 'M004'
;
-- 1 �� ��(��) �����Ǿ����ϴ�.
COMMIT;
-- Ŀ�� �Ϸ�.


--- 2. WHERE ������ ���� DELETE ����
-- WHERE ������ �ƾ� ����(����) �� ��� ��ü ���� ����
DELETE member;
-- 8�� �� ��(��) �����Ǿ����ϴ�.
ROLLBACK;

--- 3. DELETE�� WHERE �� �������� ����
-- ��) �ּҰ� '�ƻ��'�� ����� ��� ����
DELETE member m
 WHERE m.address = '�ƻ��'
;

-- (1) �ּҰ� '�ƻ��'�� ����� id�� ��ȸ
SELECT m.member_id
  FROM member m
 WHERE m.address = '�ƻ��'
;


-- (2) �����ϴ� ���� ����
DELETE member m
 WHERE m.member_id = ?
;


-- (3) (2)���� �������� �ۼ�
DELETE member m
 WHERE m.member_id IN (SELECT m.member_id
                         FROM member m
                        WHERE m.address = '�ƻ��')
;

-- 3�� �� ��(��) �����Ǿ����ϴ�.
ROLLBACK;
-- �ѹ� �Ϸ�.


------------------------------------------------------------------------------------------
-- DELETE vs. TRUNCATE
/*
   1. TRUNCATE �� DDL �� ���ϴ� ���ɾ�
      ���� ROLLBACK ������ �������� ����
      �� �� ���۵� DDL �� �ǵ��� �� ����
      
   2. TRUNCATE �� DDL �̱� ������ 
      WHERE ������ ������ �Ұ��� �ϹǷ�
      Ū�� �����͸� �����Ͽ� �����ϴ� ���� �Ұ���
      
      ���� ����!
*/
-- new_member �� TRUNCATE �� �߶� ����.

-- TRUNCATE ���� �Ŀ� �ǵ��ư� COMMIT���� ����
COMMIT;

-- new_member �� �߶󳻱�
TRUNCATE TABLE new_member;
-- Table NEW_MEMBER��(��) �߷Ƚ��ϴ�.

-- �ǵ����� �õ�
ROLLBACK;
-- �ѹ� �Ϸ�.

-- �ѹ��� �����ε� ��������
-- TRUNCATE ������ ����� ���ÿ� �ڵ�Ŀ���� �̷�����Ƿ�
-- TRUNCATE �� �� ������ �ѹ� ������ Ŀ���������� ����.

------------------------------------------------------------------
-- TCL : Transaction Control Language
-- 1) COMMIT
-- 2) ROLLBACK

-- 3) SAVEPOINT
--- 1. member ���̺��� 1���� �߰�

--- 1.1 INSERT ���� Ŀ������ ����
COMMIT;

-- 1.2 DML : INSERT �۾� ����
INSERT INTO member m (m.member_id, m.member_name)
VALUES ('M010', 'ȫ�浿')
;
-- 1 �� ��(��) ���ԵǾ����ϴ�.

--- 1.3 1�� �߰����� �߰� ���� ����
SAVEPOINT do_insert;
-- Savepoint��(��) �����Ǿ����ϴ�.

-- 2. ȫ�浿�� �ּҸ� ������Ʈ
--- 2.1 DML : UPDATE �۾� ����
UPDATE member m
   SET m.address = '������'
 WHERE m.member_id = 'M010'
;

-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
--- 2.2 �ּ� �������� �߰� ����
SAVEPOINT do_update_addr;
-- Savepoint��(��) �����Ǿ����ϴ�.

-- 3. ȫ�浿�� ��ȭ��ȣ ������Ʈ
UPDATE member m
   SET m.phone = '9999'
 WHERE m.member_id = 'M010'
;
-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
--- 3.2 ��ȭ��ȣ �������� �߰� ����
SAVEPOINT do_update_phone;
-- Savepoint��(��) �����Ǿ����ϴ�.

-- 4. ȫ�浿�� ���� ������Ʈ
--4.1 DML : UPDATE �۾� ����
UPDATE member m
   SET m.gender = 'F'
 WHERE m.member_id = 'M010'
;

-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
--- 4.2 ���� �������� �߰� ����
SAVEPOINT do_update_gender;
-- Savepoint��(��) �����Ǿ����ϴ�.

-- ������� �ϳ��� Ʈ���������� 4���� DML ���� ���� �ִ� ��Ȳ
-- ���� COMMIT ���� �ʾ����Ƿ� Ʈ�������� �������ᰡ �ƴ� ��Ȳ
---------------------------------------------------------------
-- ȫ�浿�� ������ ROLLBACK �ó�����

-- 1. �ּ� ���������� �´µ�, ��ȭ��ȣ, ������ �߸� �����ߴٰ� ����
--    ����� ������ �߸� ����
--    : �ǵ��ư� SAVEPOINT = do_update_addr
ROLLBACK do_update_addr; -- �ѹ� ���̺�����Ʈ�� �߸� ������ ��

-- �ѹ� �Ϸ�.

-- 2. �ּ�, ��ȭ��ȣ ���������� �¾Ұ�, ���� ������ �߸��Ǿ���.
ROLLBACK TO do_update_phone;
/*
ORA-01086: 'DO_UPDATE_PHONE' �������� �� ���ǿ� �������� �ʾҰų� 
            �������մϴ�.
01086. 00000 -  "savepoint '%s' never established in this session or is invalid"

  SAVEPOINT ���� ������ �ִ�.
  do_update_addr �� do_update_phone ���� �ռ� ������ �����̱⶧����
  ������� ROLLBACK TO �� �Ͼ��
  �� �� ������ SAVEPOINT �� ��� ���� ��.
*/

-- 3. 2���� ROLLBACK TO ���� �Ŀ� �ǵ��� �� �ִ� ����
ROLLBACK TO do_insert; -- insert �� ����
ROLLBACK;              -- ���� ���� ����
---------------------------------------------------------
-- ��Ÿ ��ü : SEQUENCE, INDEX, VIEW

-- SEQUENCE : �⺻ Ű(PK) ������ ���Ǵ� �Ϸù�ȣ ���� ��ü

-- 1. ������ ���� : ���۹�ȣ : 1, �ִ� : 30, ����Ŭ�� ���� 
DROP SEQUENCE seq_member_id;
CREATE SEQUENCE seq_member_id
START WITH 1
MAXVALUE 30
NOCYCLE
;

-- Sequence SEQ_MEMBER_ID��(��) �����Ǿ����ϴ�.

-- �������� ��ü�̱� ������ DDL �����Ѵ�.
-- �������� �����Ǹ� �ý��� īŻ�α׿� �����Ѵ�.
-- user_sequences
SELECT s.sequence_name
      , s.min_value
      , s.max_value
      , s.cycle_flag
      , s.increment_by
  FROM user_sequences s
 WHERE s.s
;
/*
SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, CYCLE_FLAG, INCREMENT_BY
-------------------------------------------------------------
SEQ_MEMBER_ID	        1	     30	          N	            1
*/

-- ���� ������ ������ �ѹ� �� �õ��ϸ�
/*

*/

/*--------------------------------------------------
   ��Ÿ�����͸� �����ϴ� ���� ��ųʸ�
   -------------------------------------------------
   ���Ἲ �������� : user_constraints
   ������ �������� : user_sequences
   ���̺� �������� : user_tables
   �ε��� �������� : user_indexes
   ��ü�� �������� : user_objects
   -------------------------------------------------
*/

-- 2. ������ ��� 
--  : ������ �������� SELECT �������� ��밡��
-- (1) NEXTVAL : �������� ������ȣ�� ��
--               CREATE �ǰ����� �ݵ�� ���� 1�� 
--               NEXTVAL�� ȣ���� �Ǿ�� ������ ����

-- ���� : �������̸�.NEXTVAL
SELECT SEQ_MEMBER_ID.NEXTVAL
  FROM dual
;
-- MAXVALUE �̻� �����ϸ� ������ ������ �߻�
/* 
ORA-08004: ������ SEQ_MEMBER_ID.NEXTVAL exceeds MAXVALUE�� ��ʷ� �� �� �����ϴ�
08004. 00000 -  "sequence %s.NEXTVAL %s %sVALUE and cannot be instantiated"
*/

-- (2) CURRVAL : ���������� ���� ������ ��ȣ�� Ȯ��
--               ������ ���� �� ���� 1���� NEXTVAL ȣ���� ������
--               ������ ��ȣ�� ���� �� ����.
--               ��, �������� ���� ��Ȱ��ȭ ����
--      ���� : �������̸�.CURRVAL
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;
/*
ORA-08002: ������ SEQ_MEMBER_ID.CURRVAL��
           �� ���ǿ����� ���� �Ǿ� ���� �ʽ��ϴ�
08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
*/

-- 3. ������ ���� : ALTER SEQUENCE
-- ������ SEQ_MEMBER_ID �� MAXVALUE ������ NOMAXVALUE �� ����
ALTER SEQUENCE SEQ_MEMBER_ID
NOMAXVALUE
;
-- Sequence SEQ_MEMBER_ID��(��) ����Ǿ����ϴ�.

-- SEQ_MEMBER_ID �� INCREMENT �� 10���� �����Ϸ���
ALTER SEQUENCE SEQ_MEMBER_ID
INCREMENT BY 10
;
-- Sequence SEQ_MEMBER_ID��(��) ����Ǿ����ϴ�.

ALTER SEQUENCE SEQ_MEMBER_ID
CYCLE
;
-- Sequence SEQ_MEMBER_ID��(��) ����Ǿ����ϴ�.
-- 4. ������ ���� : DROP SEQUENCE
DROP SEQUENCE seq_member_id;
-- Sequence SEQ_MEMBER_ID��(��) �����Ǿ����ϴ�.

-- ������ ������ CURRENTVAL ��ȸ �õ�
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;
/*
ORA-02289: �������� �������� �ʽ��ϴ�.
02289. 00000 -  "sequence does not exist"
*/

-------------------------------------------------------------
-- new_member ���̺��� ������ �Է½� ������ Ȱ��

-- new_member id �÷��� ����� ������ �ű� ����
/*
  ������ �̸� : seq_new_member_id
  ���۹�ȣ : START WITH 1
  ���� �� : INCREMENT BY 1
  �ִ��ȣ : NOMAXVALE
  ����Ŭ���� : NOCYCLE
*/
CREATE SEQUENCE seq_new_member_id
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
;
-- Sequence SEQ_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�.

-- new_member�� member_id�� M001, M002.... �����ϴ� ���·� ����
SELECT 'M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0) AS member_id
  FROM dual
;
INSERT INTO new_member(member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0)
           , 'ȫ�浿')
;

INSERT INTO new_member(member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0)
           , '���')
;

COMMIT;

------------------------------------------------------------------------------------
-- INDWX : ������ �˻�(��ȸ)�� ������ �˻� �ӵ� ������ ����
--         DBMS �� �����ϴ� ��ü


-- 1. user_indexes ���̺����� �̹� �����ϴ� INDWX ��ȸ 
SELECT i.index_name
      , i.index_type
      , i.table_name
      , i.include_column
  FROM user_indexes i
;
/*
INDEX_NAME,   INDEX_TYPE, TABLE_NAME,   INCLUDE_COLUMN
---------------------------------------------------
PK_DEPT	        NORMAL	    DEPT	
PK_EMP	        NORMAL	    EMP	
PK_MAIN3	    NORMAL	    MAIN_TABLE3	
PK_MAIN4	    NORMAL	    MAIN_TABLE4	
PK_MEMBER	    NORMAL	    MEMBER	
PK_SUB4	        NORMAL	    SUB_TABLE4	
SYS_C007516	    NORMAL	    CUSTOMER	
UQ_NICKNAME3	NORMAL	    MAIN_TABLE3	
UQ_NICKNAME4	NORMAL	    MAIN_TABLE4	
*/

-- 2. ���̺��� ��Ű(PRIMARY KEY)�÷��� ���ؼ��� DBMS��
--    �ڵ����� �ε��� �������� �� �� ����.
--    UNIQUE �� ���ؼ��� �ε����� �ڵ����� ������
--    �� �� �ε����� ������ �÷��� ���ؼ��� �ߺ����� �Ұ���
-- ��) member ���̺��� MEMBER_ID �÷��� ���� �ε��� ���� �õ�
CREATE INDEX idx_member_id
ON member (member_id)
;
/*
ORA-01408: �� ��Ͽ��� �̹� �ε����� �ۼ��Ǿ� �ֽ��ϴ�
01408. 00000 -  "such column list already indexed"

==> PK_MEMBER ��� �̸��� �ٸ� IDX_MEMBER_ID �� �õ��ص�
    ���� �÷��� ���ؼ��� �ε����� �� �� �������� ����.
*/

-- 3. ���� ���̺� new_member ���� PK�� ���� ������ �ε����� ���� ����
-- (1) new_member �� member_id �÷��� �ε��� ����

CREATE INDEX idx_new_member_id
ON new_member (member_id)
;
-- Index IDX_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�.

-- �ε��� ���� Ȯ�� �� DROP
DROP INDEX idx_new_member_id;
-- Index IDX_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�.

-- DESC ���ķ� ����
CREATE INDEX idx_new_member_id
ON new_member (member_id DESC)
;
-- Index IDX_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�.
DROP INDEX idx_new_member_id;
-- Index IDX_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�.

-- �ε��� ��� �÷��� ���� UNIQUE ���� Ȯ���ϴٸ�
-- UNIQUE INDEX �� ���� ����
CREATE UNIQUE INDEX idx_new_member_id
ON new_member (member_id)
;
-- INDEX IDX_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�.

SELECT i.index_name
      , i.index_type
      , i.table_name
      , i.include_column
  FROM user_indexes i
;

-- INDEX �� SELECT �� ��� �� ��
-- ���� �˻��� ���ؼ� ���������� SELECT �� ����ϴ� ��� ����
-- HINT ���� SELECT �� ����Ѵ�.











