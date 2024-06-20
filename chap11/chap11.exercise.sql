-- 11��
-- TCL
CREATE TABLE DEPT_TCL
    AS SELECT *
         FROM DEPT;
 
INSERT INTO DEPT_TCL VALUES (50, 'DATABASE', 'SEOUL');

UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;         

DELETE FROM DEPT_TCL WHERE DNAME ='RESEARCH';

SELECT *FROM DEPT_TCL;

COMMIT;

-- ����(SESSION): � Ȱ���� ���� �ð��̳� �Ⱓ�� ����
-- ���ӽ��� ~ ��������

-- �б� �ϰ���
-- �� ���ǿ��� ���̺� �����͸� ������
-- �ٸ� ���ǿ����� Ȯ�������� ������ �����͸� �����ִ� Ư��
-- ����A : sql developer
-- ����B : ���� ȭ�� sql plus
SELECT * FROM DEPT_TCL;
DELETE FROM DEPT_TCL WHERE DEPTNO = 50;
SELECT * FROM DEPT_TCL;
COMMIT;

-- LOCK : Ư�� ���ǿ��� �������� �����ʹ� �Ϸ�(C/R) �Ǳ� ������
--     �ٸ� ���ǿ��� ������ �� ���� ����
SELECT * FROM DEPT_TCL;

UPDATE DEPT_TCL SET LOC = 'SEOUL'
 WHERE DEPTNO = 30;
 
COMMIT;
SELECT *FROM DEPT_TCL;

--�ر� ���� �� �� ��!
CREATE TABLE DEPT_HW
    AS SELECT * FROM DEPT;
    
SELECT * FROM DEPT_HW;

UPDATE DEPT_HW
   SET DNAME = 'DATABASE'
   ,   LOC = 'SEOUL'
 WHERE DEPTNO =30;
 SELECT * FROM DEPT_HW;
ROLLBACK;

SELECT * FROM DEPT_HW;