--15장 사용자 관리

-- 스키마 : 데이터베이스에서 데이터 간 관계, 구조, 제약조놰건 등
--         데이터를 저장, 관리하기 위해 정의한 데이터베이스 구조의 범위
--         - 데이터베이스에 접속한 사용자와 연결된 객체를 의미

-- connect sys/oracle as sysdba;
-- alter user hr identified by 1234 account unlock;

CREATE USER ORCLSTUDY
IDENTIFIED BY ORACLE;

CREATE TABLE TEMP(
  COL1 VARCHAR2(20),
  COL2 VARCHAR2(20)
);
-- 권한 부여
GRANT SELECT ON TEMP TO ORCLSTUDY;

GRANT INSERT ON TEMP TO ORCLSTUDY;

-- 권한 취소
REVOKE SELECT, INSERT ON TEMP FROM ORCLSTUDY;

-- 사용자 생성 : CREATE USER
--   권한 부여 : GRANT
--   권한 취소 : REVOKE

GRANT SELECT ON EMP TO PREV_HW;
GRANT SELECT ON DEPT TO PREV_HW;
GRANT SELECT ON SALGRADE TO PREV_HW;

REVOKE SELECT ON SALGRADE FROM PREV_HW;
