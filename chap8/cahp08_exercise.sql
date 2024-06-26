-- 8장 조인
-- 8-1 카티션 곱
SELECT * FROM EMP;  -- 14
SELECT * FROM DEPT;  --4
SELECT 14 *4 FROM DUAL; ---56
SELECT * 
  FROM EMP, DEPT
 ORDER BY EMPNO;
 
-- 8-2 동등조인
SELECT * 
  FROM EMP, DEPT
 WHERE EMP.DEPTNO = DEPT.DEPTNO
 ORDER BY EMPNO;

-- 8-3
SELECT E.EMPNO, E.ENAME, D.DNAME, D.DEPTNO
  FROM EMP E, DEPT D 
 WHERE E.DEPTNO = D.DEPTNO
 ORDER BY E.EMPNO;
 
SELECT J.JOB_ID, J.JOB_TITLE
         , H.START_DATE, H.END_DATE
  FROM JOBS J, JOB_HISTORY H
  WHERE J.JOB_ID = H.JOB_ID(+)
  ;
 
SELECT COUNT(*) FROM JOBS;
  
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME
      , D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);
  
SELECT *
  FROM LOCATIONS L, COUNTRIES C
 WHERE L.COUNTRY_ID = C.COUNTRY_ID;  -- 동등조인
  
SELECT *
  FROM COUNTRIES;
  
--8-4 두 테이블에서 국가코드가 똑같은 이름
-- 주의: 열의 정의가 애매합니다 테이블 지정.컬럼명
SELECT L.LOCATION_ID,
       C.COUNTRY_ID, C.COUNTRY_NAME
  FROM LOCATIONS L, COUNTRIES C
 WHERE L.COUNTRY_ID = C.COUNTRY_ID; -- 동등조인
 
 -- 8-5
 SELECT EMPNO, ENAME, D.DEPTNO, D.DNAME, D.LOC
   FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
 ORDER BY D.DEPTNO, E.EMPNO;
 
-- 8-6 급여가 3000이상인 직원정보와 부서정보
 SELECT EMPNO, ENAME, D.DEPTNO, D.DNAME, D.LOC
   FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
    AND E.SAL >=3000;
    
-- 1분 복습
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
      , D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
  AND E.SAL <= 2500
  AND E.EMPNO <= 9999
  ORDER BY E.EMPNO;
  
--비등가 조인 : 등가조인 이외 방식

-- 8-7 급여 범위를 지정하는 조건식으로 조인
SELECT * 
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
 
SELECT *
  FROM EMPLOYEES E, JOBS J
 WHERE E.SALARY BETWEEN J.MIN_SALARY AND J.MAX_SALARY;

SELECT *
  FROM EMPLOYEES E, JOB_HISTORY H
  WHERE E.HIRE_DATE BETWEEN H.START_DATE AND H.END_DATE;
  
-- 자체조인
SELECT *
  FROM EMP E;
  
SELECT E.EMPNO, E.ENAME 사원명, M.ENAME 관리자명
  FROM EMP E, EMP M
 WHERE E.MGR = M.EMPNO;
 
SELECT *
  FROM EMPLOYEES M;
  
SELECT E.EMPLOYEE_ID, E.FIRST_NAME || ' '|| E.LAST_NAME 사원명
    ,  E.MANAGER_ID, M.FIRST_NAME || ' ' ||M.LAST_NAME 관리자명
  FROM EMPLOYEES E, EMPLOYEES M
 WHERE E.MANAGER_ID = M.EMPLOYEE_ID;
 
 
 -- 8-9 14명 외부조인 직원 정보 위주 모두
 SELECT E.EMPNO, E.ENAME 사원명, M.ENAME 관리자명
  FROM EMP E, EMP M
 WHERE E.MGR = M.EMPNO(+); -- LEFT OUTER JOIN
 
SELECT E.EMPNO, E.ENAME 사원명 FROM EMP E;

-- 8-10
 SELECT E.EMPNO, E.ENAME 사원명, M.ENAME 관리자명
  FROM EMP E, EMP M
 WHERE E.MGR(+) = M.EMPNO; -- RIGHT OUTER JOIN
 
 --JOIN 중간문제
--1번
 SELECT C.COUNTRY_NAME, L.STATE_PROVINCE, L.STREET_ADDRESS
   FROM COUNTRIES C, LOCATIONS L
  WHERE C.COUNTRY_ID = L.COUNTRY_ID ;
  
--2번
SELECT J.JOB_ID, J.JOB_TITLE, H.START_DATE, H.END_DATE
  FROM JOBS J, JOB_HISTORY H
 WHERE J.JOB_ID=H.JOB_ID;
 
--3번
SELECT E.FIRST_NAME, E.LAST_NAME,D.DEPARTMENT_NAME, J.JOB_TITLE
  FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
  WHERE E.DEPARTMENT_ID= D.DEPARTMENT_ID
   AND  E.JOB_ID = J.JOB_ID;
   
--4번   
SELECT C.COUNTRY_ID, C.COUNTRY_NAME, L.CITY
  FROM COUNTRIES C, LOCATIONS L
 WHERE C.COUNTRY_ID=L.COUNTRY_ID(+)
 ORDER BY C.COUNTRY_ID;
 
SELECT L.LOCATION_ID, L.CITY, L.COUNTRY_ID
  FROM LOCATIONS L, COUNTRIES C
 WHERE L.COUNTRY_ID = C.COUNTRY_ID;

--5번
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID=  D.DEPARTMENT_ID(+)
 ORDER BY E.EMPLOYEE_ID;
 
--6번
SELECT E.EMPLOYEE_ID, E.FIRST_NAME || ' '|| E.LAST_NAME 직원명
    ,  E.MANAGER_ID, M.FIRST_NAME || ' ' || M.LAST_NAME 관리자명
  FROM EMPLOYEES E, EMPLOYEES M
 WHERE E.MANAGER_ID= M.EMPLOYEE_ID 
 ORDER BY E.EMPLOYEE_ID;
 
 -- SQL-99
 -- NATURAL JOIN : 등가 조인 대신
 SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
      , E.SAL, E.COMM, DEPTNO, D.DNAME, D.LOC
  FROM EMP E NATURAL JOIN DEPT D
 ORDER BY DEPTNO, E.EMPNO;
 
-- JOIN ~ USING
 SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
      , E.SAL, E.COMM, DEPTNO, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D USING(DEPTNO)
 WHERE SAL >= 3000
 ORDER BY DEPTNO, E.EMPNO;
 
 -- JOIN ~ON
 SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE
      , E.SAL, E.COMM, E.DEPTNO, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO)
 WHERE SAL >= 3000
 ORDER BY E.DEPTNO, E.EMPNO;
 
 -- 8-14 SQL-99 외부조인
 SELECT E.EMPNO, E.ENAME, E.MGR, E.ENAME 관리자명, D.DNAME
   FROM EMP E LEFT OUTER JOIN EMP M ON(E.MGR = M.EMPNO)  -- 14
   JOIN DEPT ON(E.DEPTNO = D.DEPTNO); 
   
--1분 복습   
--JOIN ~ USING EMP, DEPT 조인 SQL99 DEPTNO
-- 급여는 3000이상이며 직속상관이 반드시 있어야 합니다.
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM
         , D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D USING(DEPTNO)
 WHERE E.SAL>=3000 AND E.MGR IS NOT NULL
 ORDER BY DEPTNO, E.EMPNO;
 
 
 SELECT E.EMPNO, E.ENAME, E.MGR, E.ENAME 관리자명
   FROM EMP E LEFT OUTER JOIN EMP M ON(E.MGR = M.EMPNO); -- 21
 
 SELECT E.EMPNO, E.ENAME, E.MGR, E.ENAME 관리자명
   FROM EMP E FULL OUTER JOIN EMP M ON(E.MGR = M.EMPNO);  -- 22 

--잊기전에 한번더!
--1번
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL 
FROM DEPT D, EMP E
WHERE D.DEPTNO= E.DEPTNO 
   AND E.SAL>2000
ORDER BY D.DEPTNO;

SELECT D.DEPTNO, D.DNAME,E.EMPNO, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO)
WHERE E.SAL>2000
ORDER BY D.DEPTNO;

--2번
SELECT D.DEPTNO, D.DNAME, TRUNC(AVG(E.SAL)) AS AVG_SAL, MAX(E.SAL) AS MAX_SAL, MIN(E.SAL) AS MIN_SAL, COUNT(*) AS CNT
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO 
group by D.DEPTNO, D.DNAME
ORDER BY D.DEPTNO;

SELECT D.DEPTNO, D.DNAME, TRUNC(AVG(E.SAL)) AS AVG_SAL, MAX(E.SAL) AS MAX_SAL, MIN(E.SAL) AS MIN_SAL, COUNT(*) AS CNT
FROM DEPT D JOIN EMP E ON(E.DEPTNO = D.DEPTNO)
GROUP BY D.DEPTNO, D.DNAME
ORDER BY D.DEPTNO;


--3번
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
  FROM DEPT D, EMP E
WHERE D.DEPTNO=E.DEPTNO(+)
ORDER BY D.DEPTNO, D.DNAME;


SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
  FROM DEPT D LEFT OUTER JOIN EMP E ON(D.DEPTNO = E.DEPTNO)
 ORDER BY D.DEPTNO, D.DNAME;

--4번
 
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.MGR, E.SAL, E.DEPTNO, S.LOSAL, S.HISAL, S.GRADE, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME 
  FROM DEPT D, EMP E, EMP M, SALGRADE S
 WHERE D.DEPTNO = E.DEPTNO(+)
 AND  E.SAL BETWEEN S.LOSAL(+) AND S.HISAL
 AND E.MGR =  M.EMPNO(+)
 ORDER BY D.DEPTNO, E.EMPNO;
  
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.MGR, E.SAL, E.DEPTNO, S.LOSAL, S.HISAL, S.GRADE, M.EMPNO AS MGR_EMPNO, M.ENAME AS MGR_ENAME 
FROM DEPT D LEFT OUTER JOIN EMP E  ON(D.DEPTNO= E.DEPTNO)
 LEFT OUTER JOIN SALGRADE S ON( E.SAL BETWEEN S.LOSAL AND S.HISAL)
 LEFT OUTER JOIN EMP M ON( E.MGR =  M.EMPNO)
 ORDER BY D.DEPTNO, E.EMPNO;
 
