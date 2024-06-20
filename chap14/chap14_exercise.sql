--14장 제약조건
--무결성 : 데이터의 정확성과 일관성을 보장한다는 의미
-- 제약조건: 무결성을 지키기 위한 안전장치

/*
영역 무결성(DOMAIN INTEGRITY) : 
 - 저장 값의 적정여부확인, 적절한 형식, NULL 여부같은 정해 놓은 범위
개체 무결성 (ENTITY INTEGRITY) : 
 - 데이터를 유일하게 식별할 수 있는 값을 가지고 있어야하고
    NULL값이 될 수 없고 중복 불가
참조 무결성 (REFERENTIAL INTEGRITY) :
 - 참조 테이블 기본키로 존재해야하면 NULL 가능
 */
 
-- 14-1
CREATE TABLE TABLE_NOTNULL(
   LOGIN_ID  VARCHAR2(20) NOT NULL,
   LOGIN_PWD VARCHAR2(20) NOT NULL,
   TEL       VARCHAR2(20)
);

DESC TABLE_NOTNULL;

INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PWD, TEL)
VALUES ('TEST_ID_01', NULL, '010-1234-5678');

INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PWD)
VALUES ('TEST_ID_01', '1234');

SELECT*FROM TABLE_NOTNULL;

--14-4
SELECT * FROM TABLE_NOTNULL
   WHERE LOGIN_ID = 'TEST_ID_01';
   
UPDATE TABLE_NOTNULL
   SET LOGIN_PWD = NULL
 WHERE LOGIN_ID = 'TEST_ID_01';
 
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS
  WHERE TABLE_NAME = 'TABLE_NOTNULL';
-- C : CHECK, NOT NULL
-- U : UNIQUE
-- P : PRIMARY KEY
-- R : FOREIGN KEY

CREATE TABLE TABLE_NOTNULL2(
    LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN2_LGNID_NN NOT NULL,
    LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN2_LGNPW_NN NOT NULL,
    TEL VARCHAR2(20)
);

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS
  WHERE TABLE_NAME = 'TABLE_NOTNULL2';

-- 중요
ALTER TABLE TABLE_NOTNULL2
MODIFY(TEL CONSTRAINT TBLNN2_TEL_NN NOT NULL);

DESC TABLE_NOTNULL2;

-- 이미 생성된 제약 조건 이름 변경하기
-- 14 -12 PAGE 368
ALTER TABLE TABLE_NOTNULL2
RENAME CONSTRAINT TBLNN2_TEL_NN TO TBL2_TEL_NN;
-- 
SELECT * 
  FROM TABLE_NOTNULL;
  
ALTER TABLE TABLE_NOTNULL
MODIFY (TEL NOT NULL);

UPDATE TABLE_NOTNULL
   SET TEL = '010-1234-5678'
 WHERE LOGIN_ID = 'TEST_ID_01';
SELECT * FROM TABLE_NOTNULL;
 
SELECT * FROM TABLE_NOTNULL2; 

-- NOT NULL
-- UNIQUE
-- PRIMARY KEY
-- FOREIGN KEY
-- CHECK
-- DEFAULT

CREATE TABLE TABLE_UNIQUE(
   LOGIN_ID  VARCHAR2(20) UNIQUE,
   LOGIN_PWD VARCHAR2(20) NOT NULL,
   TEL VARCHAR2(20)
  );
  
  DESC TABLE_UNIQUE;
  
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME = 'TABLE_UNIQUE';
   
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
 VALUES('TEST_ID_01', 'PWD01', '010-1234-5678');

SELECT * FROM TABLE_UNIQUE;

INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
 VALUES('TEST_ID_02', 'PWD01', '010-1234-5678');
 COMMIT;
 INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
 VALUES('NULL', 'PWD01', '010-2345-6789');
 SELECT * FROM TABLE_UNIQUE;
 
 -- 14-20
SELECT*
  FROM TABLE_UNIQUE
 WHERE LOGIN_ID IS NULL;
 
UPDATE TABLE_UNIQUE
   SET LOGIN_ID ='TEST_ID_01'
 WHERE LOGIN_ID IS NULL;

CREATE TABLE TABLE_UNIQUE2(
    LOGIN_ID  VARCHAR2(20) CONSTRAINT TBLUNQ2_LGNID_UNQ UNIQUE,
    LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLUNQ2_LFNPW_NN NOT NULL,
    TEL VARCHAR2(20)
);

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME LIKE 'TABLE_UNIQUE%';
 
SELECT * FROM TABLE_UNIQUE;

ALTER TABLE TABLE_UNIQUE
MODIFY(TEL UNIQUE);

UPDATE TABLE_UNIQUE
   SET TEL = NULL;
 
SELECT * FROM TABLE_UNIQUE2;

ALTER TABLE TABLE_UNIQUE2
MODIFY(TEL CONSTRAINT TBLUNQ_TEL_UNQ UNIQUE);
ALTER TABLE TABLE_UNIQUE2
RENAME CONSTRAINT TBLUNQ_TEL_UNQ TO TBLUNQ2_TEL_UNQ;

ALTER TABLE TABLE_UNIQUE2
DROP CONSTRAINT TBLUNQ2_TEL_UNQ;

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME LIKE 'TABLE_UNIQUE%';
 
--PRIMARY KEY : NOT NULL + UNIQUE
CREATE TABLE TABLE_PK(
   LOGIN_ID VARCHAR2(20) PRIMARY KEY,
   LOGIN_PWD VARCHAR2(20) NOT NULL,
   TEL VARCHAR2(20)
);
 
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME LIKE 'TABLE_PK%';
 
CREATE TABLE TABLE_PK2(
   LOGIN_ID VARCHAR2(20) CONSTRAINT TBLPK2_LFNID_PK PRIMARY KEY,  -- 이름 지정
   LOGIN_PWD VARCHAR2(20)  NOT NULL, -- 이름지정않음
   TEL VARCHAR2(20)
); 

CREATE TABLE TABLE_NAME(
     COL1 VARCHAR2(20), 
     COL2 VARCHAR2(20),
     COL3 VARCHAR2(20),
     PRIMARY KEY(COL1),
     CONSTRAINT CONSTRAINT_NAME UNIQUE(COL2)
);

INSERT INTO TABLE_PK(LOGIN_ID, LOGIN_PWD, TEL)
 VALUES('TEST_ID_01', 'PWD01', '010-1234-5678');

INSERT INTO TABLE_PK(LOGIN_PWD, TEL)
 VALUES('PWD02', '010-2345-6789');

-- EMP 테이블과 DEPT 테이블의 제약조건
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
     , R_OWNER, R_CONSTRAINT_NAME
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME IN ('EMP_PK', 'DEPT_FK');
 
 INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 VALUES(9999, '홍길동', 'CLERK', 7788, '2024-06-13', 1200, NULL, 99);
 
CREATE TABLE DEPT_FK(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

CREATE TABLE EMP_PK (
  EMPNO NUMBER(4) CONSTRAINT EMPRK_EMPNO_PK PRIMARY KEY,
  ENAME VARCHAR2(10),
  JOB   VARCHAR2(9),
  MGR   NUMBER(4),
  HIREDATE DATE,
  SAL   NUMBER(7,2),
  COMM  NUMBER(7,2),
  DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK (DEPTNO)
);

SELECT * FROM DEPT_FK;

INSERT INTO DEPT_FK
VALUES(10, 'TEST_DNAME', 'TEST_LOC');

INSERT INTO EMP_PK
VALUES(9999,'TEST_NAME', 'TEST_JOB',NULL, '2001/01/01', 3000, NULL, 10);

COMMIT;

DELETE FROM DEPT_FK
 WHERE DEPTNO = 10;
 
-- CHECK : 입력 값의 범위 퍄턴을 정의 할때 사용
CREATE TABLE TABLE_CHECK(
   LOGIN_ID VARCHAR2(20) CONSTRAINT TBLCK_LOGINID_PK PRIMARY KEY,
   LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD) > 3),
   TEL VARCHAR(20)
   );
   
INSERT INTO TABLE_CHECK
VALUES ('TEST_ID', '1234', '010-1234-5678');

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME LIKE 'TABLE_CHECK';
 
--14-7 기본값을 정하는 DEFAULT
CREATE TABLE TABLE_DEFAULT(
  LOGIN_ID   VARCHAR2(20) CONSTRAINT TBLCK2_LGNID_PK PRIMARY KEY,
  LOGIN_PWD  VARCHAR2(20) DEFAULT '1234', 
  TEL        VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT
VALUES ('TEST_ID', NULL, '010-1234-5678');

INSERT INTO TABLE_DEFAULT(LOGIN_ID, TEL)
VALUES ('TEST_ID2', '010-1234-5678');

SELECT * FROM TABLE_DEFAULT;

-- 잊기 전에 한 번더 !
CREATE TABLE DEPT_CONST(
DEPTNO NUMBER(2) CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR2(14) CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE,
LOC VARCHAR(13) CONSTRAINT DEPTCONST_LOC_NN NOT NULL
);

CREATE TABLE EMP_CONST(
EMPNO    NUMBER(4) CONSTRAINT EMPCONST_EMPNO_PK PRIMARY KEY,
ENAME    VARCHAR2(10) CONSTRAINT EMPCONST_ENAME_NN NOT NULL,
JOB      VARCHAR2(9),
TEL      VARCHAR2(20) CONSTRAINT EMPCONST_TEL_UNQ UNIQUE,
HIREDATE DATE, 
SAL      NUMBER(7,2) CONSTRAINT EMPCONST_SAL_CHK CHECK (SAL BETWEEN 1000 AND 9999),
COMM     NUMBER(7,2),
DEPTNO   NUMBER(2) CONSTRAINT EMPCONST_DEPTNO_FK REFERENCES DEPT_CONST(DEPTNO)
);

SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='