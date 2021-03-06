-- DAY14 : DML 계속

--------------------------------------------
-- 3) DELETE : 테이블에서 행단위로 데이터를 삭제

-- DELETE 구문 구조
DELETE [FROM] 테이블이름 [테이블별칭]
 WHERE 문장
;

-- 1. WHERE 조건이 있는 DELETE 구문
-- 삭제 전 커밋
COMMIT;

-- member 테이블에서 gender 가 'F'인 데이터를 삭제

DELETE member m
 WHERE m.gender = 'R' -- 오타로 R을 비교했다면
;
-- 0개 행 이(가) 삭제되었습니다.
-- 이 결과는 구문에 오류는 없기 때문에 정상실행은 된다.
-- 하지만 지워진 행이 0개인 이유는 
-- 단지, gender 컬럼에 R값이 있는 행이 없기 때문에
-- 정상적인 실행 결과가 맞다.
-- 우리가 원하는 결과가 아닐 뿐

DELETE member m
 WHERE m.gender = 'F'
;

-- 1 행 이(가) 삭제되었습니다.
-- WHERE 조건을 만족하는 모든 행에 대해서 삭제 진행
-- gender 가 'F'인 행이 1개 였던것
-- 하지만 특정행 삭제 시 PK가 아닌 조건으로 삭제하는 것은
-- 주의해야함

-- 삭제 데이터 되돌림
ROLLBACK;

-- 만약 'M004' 행을 삭제하는 것이 목적이면 PK로 삭제해야 함
DELETE member m
 WHERE m.member_id = 'M004'
;
-- 1 행 이(가) 삭제되었습니다.
COMMIT;
-- 커밋 완료.


--- 2. WHERE 조건이 없는 DELETE 구문
-- WHERE 조건이 아얘 누락(생략) 된 경우 전체 행을 삭제
DELETE member;
-- 8개 행 이(가) 삭제되었습니다.
ROLLBACK;

--- 3. DELETE의 WHERE 에 서브쿼리 조합
-- 예) 주소가 '아산시'인 사람을 모두 삭제
DELETE member m
 WHERE m.address = '아산시'
;

-- (1) 주소가 '아산시'인 멤버의 id를 조회
SELECT m.member_id
  FROM member m
 WHERE m.address = '아산시'
;


-- (2) 삭제하는 메인 쿼리
DELETE member m
 WHERE m.member_id = ?
;


-- (3) (2)번의 메인쿼리 작성
DELETE member m
 WHERE m.member_id IN (SELECT m.member_id
                         FROM member m
                        WHERE m.address = '아산시')
;

-- 3개 행 이(가) 삭제되었습니다.
ROLLBACK;
-- 롤백 완료.


------------------------------------------------------------------------------------------
-- DELETE vs. TRUNCATE
/*
   1. TRUNCATE 는 DDL 에 속하는 명령어
      따라서 ROLLBACK 지점을 생성하지 않음
      한 번 실핼된 DDL 은 되돌릴 수 없음
      
   2. TRUNCATE 는 DDL 이기 떄문에 
      WHERE 조건절 조합이 불가능 하므로
      큭정 데이터를 선별하여 삭제하는 것이 불가능
      
      사용시 주의!
*/
-- new_member 를 TRUNCATE 로 잘라내 보자.

-- TRUNCATE 실행 후에 되돌아갈 COMMIT지점 생성
COMMIT;

-- new_member 를 잘라내기
TRUNCATE TABLE new_member;
-- Table NEW_MEMBER이(가) 잘렸습니다.

-- 되돌리기 시도
ROLLBACK;
-- 롤백 완료.

-- 롤백은 성공인듯 보이지만
-- TRUNCATE 명령은 실행과 동시에 자동커밋이 이루어지므로
-- TRUNCATE 이 후 시점이 롤백 가능한 커밋지점으로 잡힘.

------------------------------------------------------------------
-- TCL : Transaction Control Language
-- 1) COMMIT
-- 2) ROLLBACK

-- 3) SAVEPOINT
--- 1. member 테이블에 1행을 추가

--- 1.1 INSERT 전에 커밋지점 생성
COMMIT;

-- 1.2 DML : INSERT 작업 실행
INSERT INTO member m (m.member_id, m.member_name)
VALUES ('M010', '홍길동')
;
-- 1 행 이(가) 삽입되었습니다.

--- 1.3 1행 추가까지 중간 상태 저장
SAVEPOINT do_insert;
-- Savepoint이(가) 생성되었습니다.

-- 2. 홍길동의 주소를 업데이트
--- 2.1 DML : UPDATE 작업 실행
UPDATE member m
   SET m.address = '율도국'
 WHERE m.member_id = 'M010'
;

-- 1 행 이(가) 업데이트되었습니다.
--- 2.2 주소 수정까지 중간 저장
SAVEPOINT do_update_addr;
-- Savepoint이(가) 생성되었습니다.

-- 3. 홍길동의 전화번호 업데이트
UPDATE member m
   SET m.phone = '9999'
 WHERE m.member_id = 'M010'
;
-- 1 행 이(가) 업데이트되었습니다.
--- 3.2 전화번호 수정까지 중간 저장
SAVEPOINT do_update_phone;
-- Savepoint이(가) 생성되었습니다.

-- 4. 홍길동의 성별 업데이트
--4.1 DML : UPDATE 작업 실행
UPDATE member m
   SET m.gender = 'F'
 WHERE m.member_id = 'M010'
;

-- 1 행 이(가) 업데이트되었습니다.
--- 4.2 성별 수정까지 중간 저장
SAVEPOINT do_update_gender;
-- Savepoint이(가) 생성되었습니다.

-- 여기까지 하나의 트랜젝션으로 4개의 DML 쿼리 묶여 있는 상황
-- 아직 COMMIT 되지 않았으므로 트랜젝션의 정상종료가 아닌 상황
---------------------------------------------------------------
-- 홍길동의 데이터 ROLLBACK 시나리오

-- 1. 주소 수정까지는 맞는데, 전화번호, 성별을 잘못 수정했다고 착각
--    사실은 성별만 잘못 수정
--    : 되돌아갈 SAVEPOINT = do_update_addr
ROLLBACK do_update_addr; -- 롤백 세이브포인트를 잘못 설정한 것

-- 롤백 완료.

-- 2. 주소, 전화번호 수정까지는 맞았고, 성별 수정만 잘못되었음.
ROLLBACK TO do_update_phone;
/*
ORA-01086: 'DO_UPDATE_PHONE' 저장점이 이 세션에 설정되지 않았거나 
            부적합합니다.
01086. 00000 -  "savepoint '%s' never established in this session or is invalid"

  SAVEPOINT 에는 순서가 있다.
  do_update_addr 이 do_update_phone 보다 앞서 생성된 지점이기때문에
  여기까지 ROLLBACK TO 가 일어나면
  그 후 생성된 SAVEPOINT 는 모두 삭제 됨.
*/

-- 3. 2번의 ROLLBACK TO 수행 후에 되돌릴 수 있는 지점
ROLLBACK TO do_insert; -- insert 후 시점
ROLLBACK;              -- 최초 시작 시점
---------------------------------------------------------
-- 기타 객체 : SEQUENCE, INDEX, VIEW

-- SEQUENCE : 기본 키(PK) 등으로 사용되는 일련번호 생성 객체

-- 1. 시퀀스 생성 : 시작번호 : 1, 최대 : 30, 사이클이 없는 
DROP SEQUENCE seq_member_id;
CREATE SEQUENCE seq_member_id
START WITH 1
MAXVALUE 30
NOCYCLE
;

-- Sequence SEQ_MEMBER_ID이(가) 생성되었습니다.

-- 시퀀스는 객체이기 때문에 DDL 생성한다.
-- 시퀀스가 생성되면 시스템 카탈로그에 저장한다.
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

-- 만약 시퀀스 생성을 한번 더 시도하면
/*

*/

/*--------------------------------------------------
   메타데이터를 저장하는 유저 딕셔너리
   -------------------------------------------------
   무결성 제약조건 : user_constraints
   시퀀스 생성정보 : user_sequences
   테이블 생성정보 : user_tables
   인덱스 생성정보 : user_indexes
   객체들 생성정보 : user_objects
   -------------------------------------------------
*/

-- 2. 시퀀스 사용 
--  : 생성된 시퀀스는 SELECT 구문에서 사용가능
-- (1) NEXTVAL : 시퀀스의 다음번호를 얻어냄
--               CREATE 되고나서 반드시 최초 1번 
--               NEXTVAL이 호출이 되어야 생성이 시작

-- 사용법 : 시퀀스이름.NEXTVAL
SELECT SEQ_MEMBER_ID.NEXTVAL
  FROM dual
;
-- MAXVALUE 이상 생성하면 다음의 오류가 발생
/* 
ORA-08004: 시퀀스 SEQ_MEMBER_ID.NEXTVAL exceeds MAXVALUE은 사례로 될 수 없습니다
08004. 00000 -  "sequence %s.NEXTVAL %s %sVALUE and cannot be instantiated"
*/

-- (2) CURRVAL : 시퀀스에서 현재 생성된 번호를 확인
--               시퀀스 생성 후 최초 1번의 NEXTVAL 호출이 없으면
--               현재의 번호를 얻을 수 없음.
--               즉, 시퀀스는 아직 비활성화 상태
--      사용법 : 시퀀스이름.CURRVAL
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;
/*
ORA-08002: 시퀀스 SEQ_MEMBER_ID.CURRVAL은
           이 세션에서는 정의 되어 있지 않습니다
08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
*/

-- 3. 시퀀스 수정 : ALTER SEQUENCE
-- 생성한 SEQ_MEMBER_ID 의 MAXVALUE 설정을 NOMAXVALUE 로 변경
ALTER SEQUENCE SEQ_MEMBER_ID
NOMAXVALUE
;
-- Sequence SEQ_MEMBER_ID이(가) 변경되었습니다.

-- SEQ_MEMBER_ID 의 INCREMENT 를 10으로 변경하려면
ALTER SEQUENCE SEQ_MEMBER_ID
INCREMENT BY 10
;
-- Sequence SEQ_MEMBER_ID이(가) 변경되었습니다.

ALTER SEQUENCE SEQ_MEMBER_ID
CYCLE
;
-- Sequence SEQ_MEMBER_ID이(가) 변경되었습니다.
-- 4. 시퀀스 삭제 : DROP SEQUENCE
DROP SEQUENCE seq_member_id;
-- Sequence SEQ_MEMBER_ID이(가) 삭제되었습니다.

-- 삭제된 시퀀스 CURRENTVAL 조회 시도
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;
/*
ORA-02289: 시퀀스가 존재하지 않습니다.
02289. 00000 -  "sequence does not exist"
*/

-------------------------------------------------------------
-- new_member 테이블에 데이터 입력시 시퀀스 활용

-- new_member id 컬럼에 사용할 시퀀스 신규 생성
/*
  시퀀스 이름 : seq_new_member_id
  시작번호 : START WITH 1
  증가 값 : INCREMENT BY 1
  최대번호 : NOMAXVALE
  사이클여부 : NOCYCLE
*/
CREATE SEQUENCE seq_new_member_id
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
;
-- Sequence SEQ_NEW_MEMBER_ID이(가) 생성되었습니다.

-- new_member의 member_id를 M001, M002.... 증가하는 형태로 조합
SELECT 'M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0) AS member_id
  FROM dual
;
INSERT INTO new_member(member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0)
           , '홍길동')
;

INSERT INTO new_member(member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL,3,0)
           , '허균')
;

COMMIT;

------------------------------------------------------------------------------------
-- INDWX : 데이터 검색(조회)시 일정한 검색 속도 보장을 위해
--         DBMS 가 관리하는 객체


-- 1. user_indexes 테이블에서 이미 존재하는 INDWX 조회 
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

-- 2. 테이블의 주키(PRIMARY KEY)컬럼에 대해서는 DBMS가
--    자동으로 인덱스 생성함을 알 수 있음.
--    UNIQUE 에 대해서도 인덱스를 자동으로 생성함
--    한 번 인덱스가 생성된 컬럼에 대해서는 중복생성 불가능
-- 예) member 테이블의 MEMBER_ID 컬럼에 대해 인덱스 생성 시도
CREATE INDEX idx_member_id
ON member (member_id)
;
/*
ORA-01408: 열 목록에는 이미 인덱스가 작성되어 있습니다
01408. 00000 -  "such column list already indexed"

==> PK_MEMBER 라는 이름과 다른 IDX_MEMBER_ID 로 시도해도
    같은 컬럼에 대해서는 인덱스가 두 개 생성되지 않음.
*/

-- 3. 복사 테이블 new_member 에는 PK가 없기 때문에 인덱스도 없는 상태
-- (1) new_member 의 member_id 컬럼에 인덱스 생성

CREATE INDEX idx_new_member_id
ON new_member (member_id)
;
-- Index IDX_NEW_MEMBER_ID이(가) 생성되었습니다.

-- 인덱스 생성 확인 후 DROP
DROP INDEX idx_new_member_id;
-- Index IDX_NEW_MEMBER_ID이(가) 삭제되었습니다.

-- DESC 정렬로 생성
CREATE INDEX idx_new_member_id
ON new_member (member_id DESC)
;
-- Index IDX_NEW_MEMBER_ID이(가) 생성되었습니다.
DROP INDEX idx_new_member_id;
-- Index IDX_NEW_MEMBER_ID이(가) 삭제되었습니다.

-- 인덱스 대상 컬럼의 값이 UNIQUE 함이 확실하다면
-- UNIQUE INDEX 로 생성 가능
CREATE UNIQUE INDEX idx_new_member_id
ON new_member (member_id)
;
-- INDEX IDX_NEW_MEMBER_ID이(가) 생성되었습니다.

SELECT i.index_name
      , i.index_type
      , i.table_name
      , i.include_column
  FROM user_indexes i
;

-- INDEX 가 SELECT 에 사용 될 때
-- 빠른 검색을 위해서 명시적으로 SELECT 에 사용하는 경우 존재
-- HINT 절을 SELECT 에 사용한다.

commit;










