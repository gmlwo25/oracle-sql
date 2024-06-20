-- 16-1 PL/SQL 구조
SET SERVEROUTPUT ON; --화면에 출력 활성화(창을 킬때마다 해야함!!)

BEGIN 
    DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;

-- 주석사용하기
DECLARE
-- 변수이름 자료형 := 값 또는 값이 도출되는 여러 표현식;
     V_EMPNO NUMBER(4) := 7788;
     V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO );
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_ENAME );
END;
/
-- 상수에 값을 대입한 후 출력하기
DECLARE 
     V_TAX CONSTANT NUMBER(1) := 3;
BEGIN
     DBMS_OUTPUT.PUT_LINE('V_TEX :' || V_TAX);
END;
/

-- 변수의 기본값 지정하기

DECLARE 
    V_DEPTNO NUMBER(2) DEFAULT 10; -- 기본값 10 설정
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO: '|| V_DEPTNO);
END;
/

--16-7 변수에 NOT NULL 설정하고 값을 대입한 후 출력하기
DECLARE 
    V_DEPTNO NUMBER(2) NOT NULL := 10; -- 기본값 10 설정
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO: '|| V_DEPTNO);
END;
/

-- NOT NULL 과 기본값 같이 설정
DECLARE 
    V_DEPTNO NUMBER(2) NOT NULL DEFAULT 10; -- 기본값 10 설정 NOT NULL
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO: '|| V_deptno);
END;
/
-- 식별자 이름 붙이는 규칙
-- 대소문자를 구별하지 않습니다.
-- 같은 블럭 안에서 식별자는 고유해야 하며 중복 불가
-- 문자로 시작, 30byte(한글은 2byte, 영어는 1byte), ($,#,_) 사용가능 , sql키워드 불가(select, from, where..)

-- 변수의 자료형 ( 중요 )
-- 스칼라 : 숫자, 문자열, 날짜 등과 같이 오라클에서 기본으로 정의해 놓은 자료형
-- 참조형 : 특정 테이블 열의 자료형이나 하나의 행구조를 참조

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

-- 16-3 조건 제어문 - IF 문 CASE 문 사용 가능
-- IF 조건식 THEN
-- ELSIF 조건식 THEN
-- ELSE
-- END IF;

-- 변수에 입력된 값이 홀수 인지 알아보기
DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
         DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다!');
    END IF;
END;
/

DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수입니다!');
    END IF;
END;
/

-- 입력한 정수가 어느 학점인지 출력하기
DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    IF V_SCORE >= 90 THEN
       DBMS_OUTPUT.PUT_LINE('A학점');
    ELSIF V_SCORE >=80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
    ELSIF V_SCORE >=70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
    ELSIF V_SCORE >=60 THEN
        DBMS_OUTPUT.PUT_LINE('D학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F학점');   
    END IF;    
END;
/
/*
문제1) 직원번호가 7900  인 직원정보를 출력해보세요
  -- v_no||' '||v_name||' '||v_sal 
-- 출력결과: 직원번호가 7900  인 직원정보 : 7900 JAMES 950
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
     
     DBMS_OUTPUT.PUT_LINE('직원번호가 7900인 직원정보 :' || v_no || ' ' || v_name|| ' ' ||v_sal);
END;
/

-- 문2) 직원번호가 7900  인 직원정보를  ROWTYPE 변수를 활용하여 데이터 출력해보세요.
DECLARE
    V_EMP_ROW EMP%ROWTYPE; 
BEGIN
    SELECT *
    INTO V_EMP_ROW
    FROM EMP
    WHERE EMPNO =7900;
    
    DBMS_OUTPUT.PUT_LINE('직원번호가 7900인 직원정보 :' || V_EMP_ROW.EMPNO || ' ' || V_EMP_ROW.ENAME|| ' ' ||V_EMP_ROW.SAL);
END;
/

-- 문제 3 EMP, DEPT 조인해서 EMPNO 7900인 사람의 정보를 출력해보세요
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
문제4) 7369사원의 급여가 10000이상이면 '상'을 
5000 이상이면 '중'을 그이하면 '하' 출력 
(ex.   DBMS_OUTPUT.PUT_LINE( v_empno || '번 사원의 급여' || v_sal || '는 '|| v_level);   )
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
      IF V_SAL >= 10000 THEN V_LEVEL :='상';
      ELSIF V_SAL >= 5000 THEN V_LEVEL :='중';
      ELSE V_LEVEL := '하';
      END IF;
 DBMS_OUTPUT.PUT_LINE( V_EMPNO || '번 사원의 급여' ||V_SAL || '는 '|| V_LEVEL  );
 
 END;
 /
 
 DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE TRUNC(V_SCORE/10)
      WHEN 10 THEN 
         DBMS_OUTPUT.PUT_LINE('A학점');
      WHEN 9 THEN 
         DBMS_OUTPUT.PUT_LINE('B학점');
      WHEN 8 THEN 
         DBMS_OUTPUT.PUT_LINE('C학점');
      WHEN 7 THEN 
         DBMS_OUTPUT.PUT_LINE('D학점');
      WHEN 6 THEN 
         DBMS_OUTPUT.PUT_LINE('E학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F학점');
    END CASE;    
END;
/

SELECT 87/10 FROM DUAL;

DECLARE
    V_SCORE NUMBER:= 87;
BEGIN
    CASE
         WHEN V_SCORE>=90 THEN DBMS_OUTPUT.PUT_LINE('A학점');
         WHEN V_SCORE>=80 THEN DBMS_OUTPUT.PUT_LINE('B학점');
         WHEN V_SCORE>=70 THEN DBMS_OUTPUT.PUT_LINE('C학점');
         WHEN V_SCORE>=60 THEN DBMS_OUTPUT.PUT_LINE('D학점');
         ELSE DBMS_OUTPUT.PUT_LINE('F학점'); 
    END CASE;
    
END;    

--1.( 이름이 TURNER인 사원과 같은 업무)를 하는 사람의 사원번호, 이름, 업무, 급여 추출
SELECT EMPNO, ENAME, SAL
  FROM EMP
 WHERE JOB = (SELECT JOB 
                FROM EMP
               WHERE ENAME = 'TURNER');

--2. EMP 테이블의 사원번호가 7521인 사원과 업무가 같고 
--      급여가 7934인 사원의 급여보다 많은 사원의 
--    사원번호, 이름, 담당업무, 입사일, 급여 추출
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL
  FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO= 7521)
  AND SAL  >(SELECT SAL FROM EMP WHERE EMPNO=7934 );

--3. EMP 테이블에서 급여의 평균보다 적은 사원의 사원번호, 이름, 업무, 급여, 부서번호 추출
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
 WHERE SAL < (SELECT AVG(SAL)
                FROM EMP);

--4. 부서별 최소급여가 20번 부서의 최소급여보다 큰 부서의 부서번호, 최소 급여 추출
SELECT DEPTNO, MIN(SAL)
  FROM EMP
 GROUP BY DEPTNO
 HAVING MIN(SAL) > (SELECT MIN(SAL)
                    FROM EMP
                   WHERE DEPTNO=20);

--5. 업무별 급여 평균 중 가장 작은 급여평균의 업무와 급여평균 추출
SELECT JOB, AVG(SAL)
  FROM EMP
 GROUP BY JOB
HAVING AVG(SAL) = ( SELECT MIN(AVG(SAL))  
                      FROM EMP
                     GROUP BY JOB); 

--6. 업무별 최대 급여를 받는 사원의 사원번호, 이름, 업무, 입사일, 급여, 부서번호 추출
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
                FROM EMP
               GROUP BY JOB);
             
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
  FROM EMP             
 WHERE (JOB,SAL) IN (SELECT JOB, MAX(SAL) FROM EMP GROUP BY JOB);            

7. 30번 부서의 최소급여를 받는 사원보다 많은 급여를 받는 사원의 
사원번호, 이름, 업무, 입사일, 급여, 부서번호, 단 30번 부서는 제외하고 추출
SELECT EMPNO, JOB, HIREDATE, SAL ,DEPTNO
  FROM EMP
WHERE DEPTNO != 30
  AND  SAL> (SELECT MIN(SAL)
               FROM EMP
              WHERE DEPTNO=30);
              
8. BLAKE와 같은 상사를 가진 사원의 이름,업무, 상사번호 추출
SELECT ENAME, JOB, MGR
  FROM EMP
 WHERE MGR = (SELECT MGR
                FROM EMP
               WHERE ENAME='BLAKE');

SET SERVEROUTPUT ON;

-- 16-17
DECLARE
    V_NUM NUMBER := 0;  -- 초기식
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1; -- 증감식
       -- EXIT WHEN V_NUM > 4;
       IF V_NUM > 4 THEN
            EXIT;
       END IF;
    END LOOP;
END;
/
-- WHILE LOOP
DECLARE 
    V_NUM NUMBER := 0; --초기식
BEGIN
    WHILE V_NUM < 4 LOOP -- 조건식
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM +1; -- 증감식
    END LOOP;
END;
/

-- 16-19 FOR LOOP
BEGIN
    FOR I IN  REVERSE 0..4 LOOP -- 0부터 4까지 포함 JAVA FOR(INT I=0; I<=4; I++) REVERSE: 역순 
        DBMS_OUTPUT.PUT_LINE('현재 I의 값 :' || I);
    END LOOP;   
END;
/
-- 16-21 CONTINUE문
BEGIN
    FOR I IN 0..4 LOOP 
        CONTINUE WHEN MOD (I, 2) = 1;
        DBMS_OUTPUT.PUT_LINE('현재 I의 값 :' || I);
    END LOOP;   
END;
/

-- 잊기 전에 한 번 더!
--1번 숫자 1부터 10까지의 숫자 중 홀수만 출력하는 PL/SQL 프로그램 작성

BEGIN 
    FOR I IN 0..10 LOOP
    CONTINUE WHEN MOD (I,2)=0;
    DBMS_OUTPUT.PUT_LINE('현재 I의 값:' || I);
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
          DBMS_OUTPUT.PUT_LINE('현재 I의 값:' || I);
     END LOOP;     
END;
/

SELECT * FROM DEPTNO;

--2번
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



