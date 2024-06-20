-- 16-1 PL/SQL ����
SET SERVEROUTPUT ON; --ȭ�鿡 ��� Ȱ��ȭ(â�� ų������ �ؾ���!!)

BEGIN 
    DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;

-- �ּ�����ϱ�
DECLARE
-- �����̸� �ڷ��� := �� �Ǵ� ���� ����Ǵ� ���� ǥ����;
     V_EMPNO NUMBER(4) := 7788;
     V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO );
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_ENAME );
END;
/
-- ����� ���� ������ �� ����ϱ�
DECLARE 
     V_TAX CONSTANT NUMBER(1) := 3;
BEGIN
     DBMS_OUTPUT.PUT_LINE('V_TEX :' || V_TAX);
END;
/

-- ������ �⺻�� �����ϱ�

DECLARE 
    V_DEPTNO NUMBER(2) DEFAULT 10; -- �⺻�� 10 ����
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO: '|| V_DEPTNO);
END;
/

--16-7 ������ NOT NULL �����ϰ� ���� ������ �� ����ϱ�
DECLARE 
    V_DEPTNO NUMBER(2) NOT NULL := 10; -- �⺻�� 10 ����
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO: '|| V_DEPTNO);
END;
/

-- NOT NULL �� �⺻�� ���� ����
DECLARE 
    V_DEPTNO NUMBER(2) NOT NULL DEFAULT 10; -- �⺻�� 10 ���� NOT NULL
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO: '|| V_deptno);
END;
/
-- �ĺ��� �̸� ���̴� ��Ģ
-- ��ҹ��ڸ� �������� �ʽ��ϴ�.
-- ���� �� �ȿ��� �ĺ��ڴ� �����ؾ� �ϸ� �ߺ� �Ұ�
-- ���ڷ� ����, 30byte(�ѱ��� 2byte, ����� 1byte), ($,#,_) ��밡�� , sqlŰ���� �Ұ�(select, from, where..)

-- ������ �ڷ��� ( �߿� )
-- ��Į�� : ����, ���ڿ�, ��¥ ��� ���� ����Ŭ���� �⺻���� ������ ���� �ڷ���
-- ������ : Ư�� ���̺� ���� �ڷ����̳� �ϳ��� �౸���� ����

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO :' || V_DEPTNO);
END;
/

--16-10
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC
      INTO V_DEPT_ROW
      FROM DEPT
     WHERE DEPTNO = 40;
     
     DBMS_OUTPUT.PUT_LINE('DEPTNO : '|| V_DEPT_ROW.DEPTNO);
     DBMS_OUTPUT.PUT_LINE('DNAME : '|| V_DEPT_ROW.DNAME);
     DBMS_OUTPUT.PUT_LINE('LOC : '|| V_DEPT_ROW.LOC);
END;
/

SELECT * FROM DEPT WHERE DEPTNO = 40;

-- 16-3 ���� ��� - IF �� CASE �� ��� ����
-- IF ���ǽ� THEN
-- ELSIF ���ǽ� THEN
-- ELSE
-- END IF;

-- ������ �Էµ� ���� Ȧ�� ���� �˾ƺ���
DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
         DBMS_OUTPUT.PUT_LINE('V_NUMBER�� Ȧ���Դϴ�!');
    END IF;
END;
/

DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� Ȧ���Դϴ�!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� ¦���Դϴ�!');
    END IF;
END;
/

-- �Է��� ������ ��� �������� ����ϱ�
DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    IF V_SCORE >= 90 THEN
       DBMS_OUTPUT.PUT_LINE('A����');
    ELSIF V_SCORE >=80 THEN
        DBMS_OUTPUT.PUT_LINE('B����');
    ELSIF V_SCORE >=70 THEN
        DBMS_OUTPUT.PUT_LINE('C����');
    ELSIF V_SCORE >=60 THEN
        DBMS_OUTPUT.PUT_LINE('D����');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F����');   
    END IF;    
END;
/
/*
����1) ������ȣ�� 7900  �� ���������� ����غ�����
  -- v_no||' '||v_name||' '||v_sal 
-- ��°��: ������ȣ�� 7900  �� �������� : 7900 JAMES 950
*/
DECLARE
    v_no EMP.EMPNO%TYPE;
    v_name EMP.ENAME%TYPE;
    v_sal EMP.SAL%TYPE;
BEGIN
    SELECT EMPNO, ENAME, SAL
      INTO v_no, v_name, v_sal
      FROM EMP
     WHERE EMPNO = 7900;
     
     DBMS_OUTPUT.PUT_LINE('������ȣ�� 7900�� �������� :' || v_no || ' ' || v_name|| ' ' ||v_sal);
END;
/

-- ��2) ������ȣ�� 7900  �� ����������  ROWTYPE ������ Ȱ���Ͽ� ������ ����غ�����.
DECLARE
    V_EMP_ROW EMP%ROWTYPE; 
BEGIN
    SELECT *
    INTO V_EMP_ROW
    FROM EMP
    WHERE EMPNO =7900;
    
    DBMS_OUTPUT.PUT_LINE('������ȣ�� 7900�� �������� :' || V_EMP_ROW.EMPNO || ' ' || V_EMP_ROW.ENAME|| ' ' ||V_EMP_ROW.SAL);
END;
/

-- ���� 3 EMP, DEPT �����ؼ� EMPNO 7900�� ����� ������ ����غ�����
  ( V_EMPNO|| ''|| V_ENMAE || '' || V_DEPTNO || ' '||V_DNAME)
DECLARE
    V_EMPNO  EMP.EMPNO%TYPE;
    V_ENAME  EMP.ENAME%TYPE;
    V_DEPTNO DEPT.DEPTNO%TYPE;
    V_DNAME  DEPT.DNAME%TYPE;
BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
      INTO V_EMPNO, V_ENAME, V_DEPTNO, V_DNAME
      FROM EMP E, DEPT D
     WHERE E.DEPTNO = D.DEPTNO
       AND E.EMPNO = 7900;
    
    DBMS_OUTPUT.PUT_LINE( V_EMPNO|| ''|| V_ENAME || '' || V_DEPTNO || ' '||V_DNAME);
END;
/
/*
����4) 7369����� �޿��� 10000�̻��̸� '��'�� 
5000 �̻��̸� '��'�� �����ϸ� '��' ��� 
(ex.   DBMS_OUTPUT.PUT_LINE( v_empno || '�� ����� �޿�' || v_sal || '�� '|| v_level);   )
*/

DECLARE 
    V_EMPNO EMP.EMPNO%TYPE;
    V_SAL   EMP.EMPNO%TYPE;
    V_LEVEL VARCHAR(10);
BEGIN
    SELECT EMPNO, SAL
      INTO V_EMPNO,V_SAL
      FROM EMP 
      WHERE EMPNO = 7369;
      IF V_SAL >= 10000 THEN V_LEVEL :='��';
      ELSIF V_SAL >= 5000 THEN V_LEVEL :='��';
      ELSE V_LEVEL := '��';
      END IF;
 DBMS_OUTPUT.PUT_LINE( V_EMPNO || '�� ����� �޿�' ||V_SAL || '�� '|| V_LEVEL  );
 
 END;
 /
 
 DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE TRUNC(V_SCORE/10)
      WHEN 10 THEN 
         DBMS_OUTPUT.PUT_LINE('A����');
      WHEN 9 THEN 
         DBMS_OUTPUT.PUT_LINE('B����');
      WHEN 8 THEN 
         DBMS_OUTPUT.PUT_LINE('C����');
      WHEN 7 THEN 
         DBMS_OUTPUT.PUT_LINE('D����');
      WHEN 6 THEN 
         DBMS_OUTPUT.PUT_LINE('E����');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F����');
    END CASE;    
END;
/

SELECT 87/10 FROM DUAL;

DECLARE
    V_SCORE NUMBER:= 87;
BEGIN
    CASE
         WHEN V_SCORE>=90 THEN DBMS_OUTPUT.PUT_LINE('A����');
         WHEN V_SCORE>=80 THEN DBMS_OUTPUT.PUT_LINE('B����');
         WHEN V_SCORE>=70 THEN DBMS_OUTPUT.PUT_LINE('C����');
         WHEN V_SCORE>=60 THEN DBMS_OUTPUT.PUT_LINE('D����');
         ELSE DBMS_OUTPUT.PUT_LINE('F����'); 
    END CASE;
    
END;    

--1.( �̸��� TURNER�� ����� ���� ����)�� �ϴ� ����� �����ȣ, �̸�, ����, �޿� ����
SELECT EMPNO, ENAME, SAL
  FROM EMP
 WHERE JOB = (SELECT JOB 
                FROM EMP
               WHERE ENAME = 'TURNER');

--2. EMP ���̺��� �����ȣ�� 7521�� ����� ������ ���� 
--      �޿��� 7934�� ����� �޿����� ���� ����� 
--    �����ȣ, �̸�, ������, �Ի���, �޿� ����
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL
  FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO= 7521)
  AND SAL  >(SELECT SAL FROM EMP WHERE EMPNO=7934 );

--3. EMP ���̺��� �޿��� ��պ��� ���� ����� �����ȣ, �̸�, ����, �޿�, �μ���ȣ ����
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
 WHERE SAL < (SELECT AVG(SAL)
                FROM EMP);

--4. �μ��� �ּұ޿��� 20�� �μ��� �ּұ޿����� ū �μ��� �μ���ȣ, �ּ� �޿� ����
SELECT DEPTNO, MIN(SAL)
  FROM EMP
 GROUP BY DEPTNO
 HAVING MIN(SAL) > (SELECT MIN(SAL)
                    FROM EMP
                   WHERE DEPTNO=20);

--5. ������ �޿� ��� �� ���� ���� �޿������ ������ �޿���� ����
SELECT JOB, AVG(SAL)
  FROM EMP
 GROUP BY JOB
HAVING AVG(SAL) = ( SELECT MIN(AVG(SAL))  
                      FROM EMP
                     GROUP BY JOB); 

--6. ������ �ִ� �޿��� �޴� ����� �����ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ ����
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
                FROM EMP
               GROUP BY JOB);
             
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
  FROM EMP             
 WHERE (JOB,SAL) IN (SELECT JOB, MAX(SAL) FROM EMP GROUP BY JOB);            

7. 30�� �μ��� �ּұ޿��� �޴� ������� ���� �޿��� �޴� ����� 
�����ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ, �� 30�� �μ��� �����ϰ� ����
SELECT EMPNO, JOB, HIREDATE, SAL ,DEPTNO
  FROM EMP
WHERE DEPTNO != 30
  AND  SAL> (SELECT MIN(SAL)
               FROM EMP
              WHERE DEPTNO=30);
              
8. BLAKE�� ���� ��縦 ���� ����� �̸�,����, ����ȣ ����
SELECT ENAME, JOB, MGR
  FROM EMP
 WHERE MGR = (SELECT MGR
                FROM EMP
               WHERE ENAME='BLAKE');

SET SERVEROUTPUT ON;

-- 16-17
DECLARE
    V_NUM NUMBER := 0;  -- �ʱ��
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1; -- ������
       -- EXIT WHEN V_NUM > 4;
       IF V_NUM > 4 THEN
            EXIT;
       END IF;
    END LOOP;
END;
/
-- WHILE LOOP
DECLARE 
    V_NUM NUMBER := 0; --�ʱ��
BEGIN
    WHILE V_NUM < 4 LOOP -- ���ǽ�
        DBMS_OUTPUT.PUT_LINE('���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM +1; -- ������
    END LOOP;
END;
/

-- 16-19 FOR LOOP
BEGIN
    FOR I IN  REVERSE 0..4 LOOP -- 0���� 4���� ���� JAVA FOR(INT I=0; I<=4; I++) REVERSE: ���� 
        DBMS_OUTPUT.PUT_LINE('���� I�� �� :' || I);
    END LOOP;   
END;
/
-- 16-21 CONTINUE��
BEGIN
    FOR I IN 0..4 LOOP 
        CONTINUE WHEN MOD (I, 2) = 1;
        DBMS_OUTPUT.PUT_LINE('���� I�� �� :' || I);
    END LOOP;   
END;
/

-- �ر� ���� �� �� ��!
--1�� ���� 1���� 10������ ���� �� Ȧ���� ����ϴ� PL/SQL ���α׷� �ۼ�

BEGIN 
    FOR I IN 0..10 LOOP
    CONTINUE WHEN MOD (I,2)=0;
    DBMS_OUTPUT.PUT_LINE('���� I�� ��:' || I);
    END LOOP;
END;
/

DECLARE
    I NUMBER :=0;
BEGIN
    WHILE  I < 10 LOOP
     I:= I+1;
     IF MOD(I,2) = 0 THEN
        CONTINUE;
     END IF;
        -- CONTINUE WHEN MOD(I,2) = 0;
          DBMS_OUTPUT.PUT_LINE('���� I�� ��:' || I);
     END LOOP;     
END;
/

SELECT * FROM DEPTNO;

--2��
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 10;
BEGIN
    IF V_DEPTNO = 10 THEN
     DBMS_OUTPUT.PUT_LINE('DNAME : ACCOUNTING');
    ELSIF V_DEPTNO = 20 THEN
      DBMS_OUTPUT.PUT_LINE('DNAME : RESEARCH');
    ELSIF V_DEPTNO = 30 THEN
     DBMS_OUTPUT.PUT_LINE('DNAME : SALES');
    ELSIF V_DEPTNO = 40 THEN
      DBMS_OUTPUT.PUT_LINE('DNAME : OPERATIONS');
    ELSE  
      DBMS_OUTPUT.PUT_LINE('DNAME : N/A');
    END IF;
END;
/

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 10;
BEGIN
    CASE
     WHEN V_DEPTNO = 10 THEN
     DBMS_OUTPUT.PUT_LINE('DNAME : ACCOUNTING');
     WHEN V_DEPTNO = 20 THEN
      DBMS_OUTPUT.PUT_LINE('DNAME : RESEARCH');
     WHEN V_DEPTNO = 30 THEN
     DBMS_OUTPUT.PUT_LINE('DNAME : SALES');
     WHEN V_DEPTNO = 40 THEN
      DBMS_OUTPUT.PUT_LINE('DNAME : OPERATIONS');
    ELSE  
      DBMS_OUTPUT.PUT_LINE('DNAME : N/A');
    END CASE;
END;
/

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 20;
    V_DEPT_NAME DEPT.DNAME%TYPE;
BEGIN
    SELECT DNAME
      INTO V_DEPT_NAME
      FROM DEPT
     WHERE DEPTNO = V_DEPTNO;
     
    DBMS_OUTPUT.PUT_LINE('DNAME : '|| V_DEPT_NAME);

      EXCEPTION WHEN NO_DATA_FOUND THEN
        V_DEPT_NAME := 'N/A';
      DBMS_OUTPUT.PUT_LINE('DNAME : '|| V_DEPT_NAME);
END;
/



