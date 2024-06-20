--15�� ����� ����

-- ��Ű�� : �����ͺ��̽����� ������ �� ����, ����, �������R�� ��
--         �����͸� ����, �����ϱ� ���� ������ �����ͺ��̽� ������ ����
--         - �����ͺ��̽��� ������ ����ڿ� ����� ��ü�� �ǹ�

-- connect sys/oracle as sysdba;
-- alter user hr identified by 1234 account unlock;

CREATE USER ORCLSTUDY
IDENTIFIED BY ORACLE;

CREATE TABLE TEMP(
  COL1 VARCHAR2(20),
  COL2 VARCHAR2(20)
);
-- ���� �ο�
GRANT SELECT ON TEMP TO ORCLSTUDY;

GRANT INSERT ON TEMP TO ORCLSTUDY;

-- ���� ���
REVOKE SELECT, INSERT ON TEMP FROM ORCLSTUDY;

-- ����� ���� : CREATE USER
--   ���� �ο� : GRANT
--   ���� ��� : REVOKE

GRANT SELECT ON EMP TO PREV_HW;
GRANT SELECT ON DEPT TO PREV_HW;
GRANT SELECT ON SALGRADE TO PREV_HW;

REVOKE SELECT ON SALGRADE FROM PREV_HW;
