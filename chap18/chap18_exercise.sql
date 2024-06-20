-- 18장 커서와 예외처리
SET SERVEROUTPUT ON;

-- 18-1
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC 
      INTO V_DEPT_ROW
      FROM DEPT
     WHERE DEPTNO = 40;
     DBMS_OUTPUT.PUT_LINE('DEPTNO: '||V_DEPT_ROW.DEPTNO);
     DBMS_OUTPUT.PUT_LINE('DNAME: '||V_DEPT_ROW.DNAME);
     DBMS_OUTPUT.PUT_LINE('LOC: '||V_DEPT_ROW.LOC);
END;
/

-- 명시적 커서 선언
DECLARE
    --ROW변수 <- 커서 데이터 로우 입력받을 변수
    V_DEPT_ROW DEPT%ROWTYPE;
    --1. 명시적 커서 선언
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = 40;
BEGIN
    -- 커서 열기
    OPEN C1;
    LOOP
      -- 3. FETCH
      FETCH C1 INTO V_DEPT_ROW;
      EXIT WHEN C1%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('DEPTNO: '||V_DEPT_ROW.DEPTNO);
      DBMS_OUTPUT.PUT_LINE('DNAME: '||V_DEPT_ROW.DNAME);
      DBMS_OUTPUT.PUT_LINE('LOC: '||V_DEPT_ROW.LOC);
    END LOOP;
    -- 4. 커서 닫기
    CLOSE C1;
END;
/

--18-3
DECLARE
    --ROW변수 <- 커서 데이터 로우 입력받을 변수
    V_DEPT_ROW DEPT%ROWTYPE;
    --1. 명시적 커서 선언
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT;
BEGIN
    -- 커서 열기
    OPEN C1;
    LOOP
      -- 3. FETCH
      FETCH C1 INTO V_DEPT_ROW;
      EXIT WHEN C1%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('DEPTNO: '||V_DEPT_ROW.DEPTNO 
                          ||', DNAME: '||V_DEPT_ROW.DNAME 
                          ||', LOC: '||V_DEPT_ROW.LOC);
    END LOOP;
    -- 4. 커서 닫기
    CLOSE C1;
END;
/

-- 18-4
DECLARE
-- 명시적 커서 선언
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT;
BEGIN
    FOR c1_rec IN C1 LOOP
       DBMS_OUTPUT.PUT_LINE('DEPTNO:'||c1_rec.DEPTNO 
        ||', DNAME: '||c1_rec.DNAME 
        ||', LOC: '||c1_rec.LOC);
    
    END LOOP;
END;
/
--18-5
DECLARE
    -- 커서 데이터를 입력할 변수 ㅅㄴ언
    V_DEPT_ROW DEPT%ROWTYPE;
    -- 명시적 커서 선언
    CURSOR C1(p_deptno DEPT.DEPTNO%TYPE) IS
       SELECT DEPTNO, DNAME, LOC
         FROM DEPT
         WHERE DEPTNO = p_deptno;
    
BEGIN
-- 10번 부서 처리를 위해 커서 사용
    OPEN C1(10);
    LOOP
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('DEPTNO: '||V_DEPT_ROW.DEPTNO 
            ||', DNAME: '||V_DEPT_ROW.DNAME 
            ||', LOC: '||V_DEPT_ROW.LOC);
    END LOOP;
    CLOSE C1;
-- 20번 부서 처리를 위해 커서 사용
   OPEN C1(20);
    LOOP
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('DEPTNO: '||V_DEPT_ROW.DEPTNO 
            ||', DNAME: '||V_DEPT_ROW.DNAME 
            ||', LOC: '||V_DEPT_ROW.LOC);
    END LOOP;
END;
/
--18-6
-- FOR IN 문 사용 파라미터 있는 커서 사용
DECLARE
    --사용자가 입력한 부서 번호를 저장하는 변수선언
    v_deptno DEPT.DEPTNO%TYPE;
    -- 명시적 커서 선언
    CURSOR C1(p_deptno DEPT.DEPTNO%TYPE) IS
       SELECT DEPTNO, DNAME, LOC
         FROM DEPT
         WHERE DEPTNO = p_deptno;
BEGIN
    -- INPUT_DEPTNO에 부서번호 입력받고  v_deptno에 대입
    v_deptno := &INPUT_DEPTNO;
    --커서 FOR LOOP 시작. C1커서에 v_deptno를 대입
    FOR c1_rec IN c1(v_deptno) LOOP
       DBMS_OUTPUT.PUT_LINE('DEPTNO: '||c1.rec.DEPTNO 
            ||', DNAME: '||c1_rec.DNAME 
            ||', LOC: '||c1_rec.LOC);
   END LOOP;         
END;
/
-- 16-7
BEGIN
 UPDATE DEPT SET DNAME = 'DATABASE'
  WHERE DEPTNO = 50;
  
  DBMS_OUTPUT.PUT_LINE('갱신된 행의 수:' || SQL%ROWCOUNT);
  IF (SQL%FOUND) THEN
    DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 :true');
  ELSE
     DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 :false');
   END IF;  
   
  IF (SQL%ISOPEN) THEN
    DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 :true');
   ELSE
    DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : false');
   END IF;
   
  END;
/

-- 예외처리:
-- 오류가 발생해도 프로그램이 비정상 종료 되지 않도록 하는 처리

DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     EXCEPTION 
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');
END;
/

-- 18-10 예외발생 후의 코드 실행 여부 확인하기
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     DBMS_OUTPUT.PUT_LINE('예외가 발생하면 이 문장은 실행되지 않습니다.');

     EXCEPTION 
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');    
            
END;
/

-- 예외 이름

/*
DUP_VAL_ON_INDEX : UNIQUE 인덱스가 있는 열에 중복 값을 저장 시
NO_DATA_FOUND : SELECT INTO 문에서 결과 행이 하나도 없을 경우
VALUE_ERROR: 산술, 변환, 잘림, 제약 조건 오류가 발생시
TOO_MANY_ROWS : SELECT INTO 문의 결과 행이 다중행 출력 시
*/

DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     DBMS_OUTPUT.PUT_LINE('예외가 발생하면 이 문장은 실행되지 않습니다.');

     EXCEPTION 
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 요구보다 많은 행 추출 오류 발생');  
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 수치 또는 값 오류 발생');    
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 사전 정의 외 오류발생');
            
END;
/



DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     DBMS_OUTPUT.PUT_LINE('예외가 발생하면 이 문장은 실행되지 않습니다.');

     EXCEPTION 
       WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('예외처리 : 사전 정의 외 오류발생');
            DBMS_OUTPUT.PUT_LINE('SQLCODE :' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('SQLERRM:' || SQLERRM);
            
END;
/
--  중간문제
-- Q1-1) 1부터 숫자중 홀수 10개만 출력하기
--(IF  조건문 없이 
--반복문  BASIC LOOP 와 WHILE LOOP 각각의 방법으로 출력해보세요)

DECLARE
  V_NUM NUMBER :=1; --초기식
  V_CNT NUMBER :=1;
BEGIN
    LOOP
    EXIT WHEN V_CNT >10; --조건식
    DBMS_OUTPUT.PUT_LINE(V_NUM);
    V_NUM := V_NUM+2;
    V_CNT := V_CNT +1;
    END LOOP;
END;
/

DECLARE
  V_NUM NUMBER :=1; --초기식
  V_CNT NUMBER :=1;
BEGIN
    WHILE V_CNT <11 LOOP
    DBMS_OUTPUT.PUT_LINE(V_NUM);
    V_NUM := V_NUM+2;
    V_CNT := V_CNT +1;
    END LOOP;
END;
/

-- Q2-1
--문제6) 사원테이블에서 30 번 부서인 사원의 사원번호, 이름, 직책 출력하기  (cursor 사용)
---- (v_emp.EMPNO || '  ' || v_emp.ENAME || '  ' || v_emp.job)
--1. 선언 OPEN   FETCH CLOSE      2. FOR   IN 

DECLARE
    v_emp EMP%ROWTYPE;
    CURSOR C1 IS
        SELECT * FROM EMP WHERE DEPTNO = 30;
BEGIN
    OPEN C1;
    LOOP
        FETCH C1 INTO v_emp;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp.EMPNO || '  ' || v_emp.ENAME || '  ' || v_emp.job);
    END LOOP;
    CLOSE C1;
    
END;
/

DECLARE
    CURSOR c1 IS
    SELECT EMPNO, ENAME, JOB
      FROM EMP
     WHERE DEPTNO = 30;
BEGIN
    FOR c1_rec IN c1 LOOP
    DBMS_OUTPUT.PUT_LINE('EMPNO :' ||c1_rec.EMPNO 
                         ||', ENAME :'|| c1_REC.ENAME
                         ||', JOB : ' ||c1_rec.JOB);
    END LOOP;
END;
/
set serveroutput on;
-- 잊기 전에 한 번 더!
--1번
DECLARE
    v_emp EMP%ROWTYPE;
    CURSOR C1 IS
        SELECT * FROM EMP; -- 1. 명시적 커서 선언
BEGIN
    OPEN C1; -- 2. 커서 열기
    LOOP
        FETCH C1 INTO v_emp;  --3. 커서 패치 사용
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('EMPNO : ' || v_emp.EMPNO || ', ENAME : ' || v_emp.ENAME || ', JOB :  ' || v_emp.job
                               || ', SAL : ' || v_emp.sal|| ', DEPTNO :' || v_emp.deptno  );
    END LOOP;
    CLOSE C1; --4. 커서 닫기
    
END;
/

DECLARE
    v_emp EMP%ROWTYPE;
    CURSOR C1 IS
        SELECT * FROM EMP; -- 1. 명시적 커서 선언
BEGIN
--    OPEN C1; -- 2. 커서 열기
--    LOOP
--        FETCH C1 INTO v_emp;  --3. 커서 패치 사용
    FOR v_emp IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE('EMPNO : ' || v_emp.EMPNO || ', ENAME : ' || v_emp.ENAME || ', JOB :  ' || v_emp.job
                               || ', SAL : ' || v_emp.sal|| ', DEPTNO :' || v_emp.deptno  );
    END LOOP;
--    CLOSE C1; --4. 커서 닫기
    
END;
/

--2번
DECLARE
    v_wrong DATE;
BEGIN
    SELECT ENAME 
      INTO v_wrong -- INTO는 단일행 결과만 대입 받을 수 있음
      FROM EMP
     WHERE EMPNO = 7369;
     
     DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류가 발생하였습니다.' ||
                TO_CHAR(SYSDATE, '[ YYYY"년"MM"월"DD"일" HH24"시"MI"분"SS"초"]'));
        DBMS_OUTPUT.PUT_LINE('SQLCODE: '|| TO_CHAR(SQLCODE));    
        DBMS_OUTPUT.PUT_LINE('SQLERRM: '|| TO_CHAR(SQLERRM));  
END;
/

DECLARE
    v_wrong VARCHAR2(20);
BEGIN
    SELECT ENAME 
      INTO v_wrong -- INTO는 단일행 결과만 대입 받을 수 있음
      FROM EMP
     WHERE EMPNO = 7369;
     
     DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류가 발생하였습니다. ||
                TO_CHAR(SYSDATE, '[YYYY"년"MM"월"DD"일" HH24"시"MI"분"SS"초"]'));
        DBMS_OUTPUT.PUT_LINE('SQLCODE: '|| TO_CHAR(SQLCODE));    
        DBMS_OUTPUT.PUT_LINE('SQLERRM: '|| TO_CHAR(SQLERRM));  
END;
/