--17장 레코드와 컬렉션

-- 레코드 : 자료형이 다른 여러 데이터를 저장할 수 있는 타입

--17-1
SET SERVEROUTPUT ON; 

DECLARE
    TYPE REC_DEPT IS RECORD(
        dept_no NUMBER(2) NOT NULL := 99,
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.dept_no := 99;
    dept_rec.dname := 'DATABASE';
    dept_rec.loc := 'SEOUL';


    DBMS_OUTPUT.PUT_LINE('DEPTNO: ' ||dept_rec.dept_no);
    DBMS_OUTPUT.PUT_LINE('DNAME: ' ||dept_rec.dname);
    DBMS_OUTPUT.PUT_LINE('LOC: ' ||dept_rec.loc);
    
END;
/

-- 레코드를 사용한 insert
CREATE TABLE DEPT_RECORD
AS SELECT*FROM DEPT;

SELECT * FROM DEPT_RECORD;

--17-3 
DECLARE
    TYPE REC_DEPT IS RECORD(
        dept_no NUMBER(2) NOT NULL := 99,
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.dept_no := 99;
    dept_rec.dname := 'DATABASE';
    dept_rec.loc := 'SEOUL';
    
    INSERT INTO DEPT_RECORD
    VALUES dept_rec;

--    DBMS_OUTPUT.PUT_LINE('DEPTNO: ' ||dept_rec.dept_no);
--    DBMS_OUTPUT.PUT_LINE('DNAME: ' ||dept_rec.dname);
--    DBMS_OUTPUT.PUT_LINE('LOC: ' ||dept_rec.loc);
    
END;
/
SELECT * FROM DEPT_RECORD;

--17-4
DECLARE
    TYPE REC_DEPT IS RECORD(
        dept_no NUMBER(2) NOT NULL := 99,
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.dept_no := 50;
    dept_rec.dname := 'DB';
    dept_rec.loc := 'SEOUL';
    
    UPDATE DEPT_RECORD
       SET ROW = dept_rec
     WHERE DEPTNO = 99;

--    DBMS_OUTPUT.PUT_LINE('DEPTNO: ' ||dept_rec.dept_no);
--    DBMS_OUTPUT.PUT_LINE('DNAME: ' ||dept_rec.dname);
--    DBMS_OUTPUT.PUT_LINE('LOC: ' ||dept_rec.loc);
    
END;
/

--17-5
DECLARE
    TYPE REC_DEPT IS RECORD(
        dept_no NUMBER(2) NOT NULL := 99,
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
    );
    
    TYPE REC_EMP IS RECORD (
        empno EMP.EMPNO%TYPE,
        ename EMP.ENAME%TYPE,
        dinfo REC_DEPT
    );
    emp_rec REC_EMP;
BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
      INTO emp_rec.empno, emp_rec.ename, 
           emp_rec.dinfo.dept_no, emp_rec.dinfo.dname, emp_rec.dinfo.loc
      FROM EMP E, DEPT D
     WHERE E.DEPTNO= D.DEPTNO
       AND E.EMPNO = 7788;
       
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || emp_rec.dinfo.dept_no);
END;
/

-- 17-2 
--자료형이 같은 여러 데이터를 저장하는 컬렉션

-- 17-6 연관배열
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
    INDEX  BY PLS_INTEGER;

    text_arr ITAB_EX;    
BEGIN
    text_arr(1) := '1st data';
    text_arr(2) := '2st data';
    text_arr(3) := '3st data';
    text_arr(4) := '4st data';
    
    DBMS_OUTPUT.PUT_LINE('text_arr(1) :' || text_arr(1));
    DBMS_OUTPUT.PUT_LINE('text_arr(2) :' || text_arr(2));
    DBMS_OUTPUT.PUT_LINE('text_arr(3) :' || text_arr(3));
    DBMS_OUTPUT.PUT_LINE('text_arr(4) :' || text_arr(4));
END;

-- 자바의 객체 배열 처럼
-- 레코드 타입의 연관배열 생성

-- 17 -7
DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno DEPT.DEPTNO%TYPE,
        dname DEPT.DNAME%TYPE
        );
     TYPE ITAB_DEPT IS TABLE OF REC_DEPT
     INDEX BY PLS_INTEGER;
     
     dept_arr ITAB_DEPT;
     idx PLS_INTEGER := 0;
BEGIN
    FOR i IN(SELECT DEPTNO, DNAME FROM DEPT) LOOP
       idx := idx+1;
       dept_arr(idx).deptno := i.DEPTNO;
       dept_arr(idx).dname := i.DNAME;
       
       DBMS_OUTPUT.PUT_LINE(dept_arr(idx).deptno||' '||dept_arr(idx).dname);
    END LOOP;
    
END;
/

DECLARE
    TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
    INDEX BY PLS_INTEGER;
    
    dept_arr ITAB_DEPT;
    idx PLS_INTEGER :=0;
BEGIN
    FOR i IN (SELECT * FROM DEPT) LOOP
        idx := idx+1;
        dept_arr(idx).deptno :=i.DEPTNO;
        dept_arr(idx).dname :=i.DNAME;
        dept_arr(idx).loc :=i.LOC;
        
        DBMS_OUTPUT.PUT_LINE(dept_arr(idx).deptno || ' : ' ||
                             dept_arr(idx).dname || ' : ' ||
                             dept_arr(idx).loc);
    
    END LOOP;
 
END;
/

-- 17-9 컬렉션 메서드 사용하기
DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
    INDEX BY PLS_INTEGER;
    
    text_arr ITAB_EX;
BEGIN
    text_arr(1) := '1st data';
    text_arr(2) := '2st data';
    text_arr(3) := '3st data';
    text_arr(50) := '50st data';
    
    DBMS_OUTPUT.PUT_LINE('text_arr.COUNT: '|| text_arr.COUNT);
    DBMS_OUTPUT.PUT_LINE('text_arr.FIRST: '|| text_arr.FIRST);
    DBMS_OUTPUT.PUT_LINE('text_arr.LAST: '|| text_arr.LAST);
    DBMS_OUTPUT.PUT_LINE('text_arr.PRIOR(50): '|| text_arr.PRIOR(50));
    DBMS_OUTPUT.PUT_LINE('text_arr.NEXT(50): '|| text_arr.NEXT(50));
   
END;
/

-- 복합자료형: 여러 데이터를 하나의 자료형으로 지정 사용 위해 직접 정의하는 자료형
-- 레코드: 여러 종류의 자료형을 하나의 변수에 저장 시 사용
-- 컬렉션: 특정 자료형의 데이터 여러개를 하나의 변수에 저장 시 사용


-- 잊기 전에 한 번 더!
--1번
CREATE TABLE EMP_RECORD
   AS SELECT * FROM EMP
       WHERE 3<>3;

SELECT * FROM EMP_RECORD;

DECLARE
    TYPE EMP_RECORD IS RECORD(
     empno EMP.EMPNO%TYPE, 
     ename EMP.ENAME%TYPE,
     job EMP.JOB%TYPE,
     mgr EMP.MGR%TYPE,
     hiredate EMP.HIREDATE%TYPE,
     sal EMP.SAL%TYPE,
     comm EMP.COMM%TYPE,
     deptno EMP.DEPTNO%TYPE
     );
      emp_rec EMP_RECORD;
BEGIN
 emp_rec.empno := 1111;
 emp_rec.ename :='TEST_USER';
 emp_rec.job :='TESCT_JOB';
 emp_rec.hiredate := '18/03/01';
 emp_rec.sal :='3000';
 emp_rec.deptno := 40;
 
 INSERT INTO EMP_RECORD
 VALUES emp_rec;
END;
/
select* from EMP_RECORD;

--2번
DECLARE
    TYPE ITAB_EMP IS TABLE OF EMP%ROWTYPE
    INDEX BY PLS_INTEGER;
    
    emp_arr ITAB_EMP;
    idx PLS_INTEGER := 0;
BEGIN
    FOR i IN(SELECT* FROM EMP)LOOP
    emp_arr(idx).empno:= I.EMPNO;
    emp_arr(idx).ename:= I.ENAME;
    emp_arr(idx).job:= I.JOB;
    emp_arr(idx).mgr:= I.MGR;
    emp_arr(idx).hiredate:= I.HIREDATE;
    emp_arr(idx).sal:= I.SAL;
    emp_arr(idx).comm:= I.COMM;
    emp_arr(idx).deptno:= I.DEPTNO;
    
    DBMS_OUTPUT.PUT_LINE(emp_arr(idx).empno||' : '||
                          emp_arr(idx).ename ||' : '||
                          emp_arr(idx).job ||' : '||
                          emp_arr(idx).mgr ||' : '||
                          emp_arr(idx).hiredate ||' : '||
                          emp_arr(idx).sal ||' : '||
                          emp_arr(idx).comm ||' : '||
                          emp_arr(idx).deptno);
    END LOOP;
END;
/
