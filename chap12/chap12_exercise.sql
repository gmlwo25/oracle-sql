-- 12�� DDL Data Definition Language
-- �ڵ����� COMMIT; 
CREATE TABLE EMP_DDL(
     EMPNO    NUMBER(4),
     ENAME    VARCHAR2(10),
     JOB      VARCHAR2(9),
     MGR      NUMBER(4),
     HIREDATE DATE,
     SAL      NUMBER(7, 2),
     COMM     NUMBER(7, 2),
     DEPTNO   NUMBER(2)
);     

-- ���̺� ��/ �� �� ������Ģ
-- 1. ���ڷ� ���ۺҰ�, 2. ����� 30��, �ѱ��� 15��
-- 3. ���� ����� ������ ���̺��̸� �ߺ� �Ұ� 
-- 4. Ư������ $,#,_ �� ����� �� �ִ�. EX)EMP#90_OB
-- 5. SELECT, FROM ���� ���̺� �̸����� ���Ұ�

-- ���� ���̺� �� ����ȭ ����Ʈ�� �����Ͽ� �� ���̺� �����ϱ�
CREATE TABLE DEPT_DDL
    AS SELECT * FROM DEPT;
    
DESC DEPT_DDL;

SELECT * FROM DEPT_DDL;

-- �ٸ� ���̺��� �Ϻθ� �����Ͽ� ���̺� �����ϱ�
CREATE TABLE EMP_DDL_30
    AS SELECT * FROM EMP WHERE DEPTNO=30;
    
SELECT * FROM EMP_DDL_30;

-- ���� ���̺��� �� ������ ���� �� ���̺� ����
CREATE TABLE EMPDEPT_DDL
    AS SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
            , E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC
        FROM EMP E, DEPT D
       WHERE 1 <> 1;
       
SELECT * FROM EMPDEPT_DDL;

-- 12-6 EMP ���̺� �����Ͽ� ���̺� ���� ����
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;
SELECT * FROM EMP_ALTER;  
--�÷��߰�
ALTER TABLE EMP_ALTER
  ADD HP VARCHAR2(20);
  
SELECT * FROM EMP_ALTER;

-- 12-8 �÷��� ����
ALTER TABLE EMP_ALTER
RENAME COLUMN HP TO TEL;

SELECT * FROM EMP_ALTER;
DESC EMP_ALTER;
--�÷� ������ ����
ALTER TABLE EMP_ALTER
MODIFY EMPNO NUMBER(5);

-- �÷� ����
ALTER TABLE EMP_ALTER
DROP COLUMN TEL;
SELECT *FROM EMP_ALTER;

-- ���̺� �� ����
RENAME EMP_ALTER TO EMP_RENAME;

DESC EMP_ALTER;
DESC EMP_RENAME;

TRUNCATE TABLE EMP_RENAME;

DROP TABLE EMP_RENAME;

-- �ر� ���� �� �� ��!
CREATE TABLE EMP_HW(
  EMPNO    NUMBER(4),
  ENAME    VARCHAR2(10),
  JOB      VARCHAR2(9),
  MGR      NUMBER(4),
  HIREDATE DATE,
  SAL      NUMBER(7,2),
  COMM     NUMBER(7,2),
  DEPTNO   NUMBER(2)
  );
  
DESC EMP_HW;

--2��
ALTER TABLE EMP_HW
  ADD BIGO VARCHAR2(20);

DESC EMP_HW;

--3��
ALTER TABLE EMP_HW
MODIFY BIGO VARCHAR(30);

DESC EMP_HW;

--4��
ALTER TABLE EMP_HW
RENAME COLUMN BIGO TO REMARK;

SELECT * FROM EMP_HW;

--5��
INSERT INTO EMP_HW(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
    SELECT  E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
      FROM EMP E;
    
SELECT * FROM EMP_HW;

--6��
DROP TABLE EMP_HW;

