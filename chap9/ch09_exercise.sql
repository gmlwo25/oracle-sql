-- 9장 서브쿼리
-- 9-1 JONES인 사원의 급여 출력
SELECT SAL
  FROM EMP
 WHERE ENAME = 'JONES';
 
-- 9-2 급여가 2975보다 높은 사원 출력
SELECT *
  FROM EMP
 WHERE SAL > 2975;
 
-- 9-3 서브쿼리
SELECT *
  FROM EMP
 WHERE SAL > (SELECT SAL
                FROM EMP
               WHERE ENAME = 'JONES'); -- 2975
               
-- 서브쿼리 특징
-- 1. 괄호로 묶어서 사용 2. 특수한 경우 제외, 서브쿼리에는 ORDER BY 절 사용 불가
-- 3. 메인쿼리 비교대상과 데이터 개수와 자료형 고려
-- 4. 서브쿼리가 단일행인지 다중행인지에 따라 연산자 고려

-- 1분 복습 : 사원정보 중에서 사원 이름이 ALLEN인 사원의 추가 수당보다 많은 추가수당 받은 사원
SELECT *
  FROM EMP
 WHERE COMM > (SELECT COMM
                 FROM EMP
                WHERE ENAME = 'ALLEN');
                
-- 9-4 SCOTT보다 먼저 입사한 직원
SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE 
                     FROM EMP 
                    WHERE ENAME = 'SCOTT');

-- 다른 예
SELECT *
  FROM EMPLOYEES
 WHERE SALARY = (SELECT SALARY
                   FROM EMPLOYEES
                  WHERE HIRE_DATE = '2006/01/03');


--단일행 서브쿼리와 함수
-- 9-5 사원정보에서 평균급여보다 많이 받는 사람을 출력
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
         D.DEPTNO,D.DNAME,D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL>(SELECT AVG(SAL)
                FROM EMP);

-- 1분 복습
--전체 사원의 평균 급여 보다 작거나 같은 급여를 받고있는
-- 20번 부서의 사원 및 부서정보를 구하도록 쿼리를 작성하세요
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
         D.DEPTNO,D.DNAME,D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL <=(SELECT AVG(SAL)
                 FROM EMP);
                 
-- 다중행 서브쿼리 연산자: IN, ANY/SOME, ALL, EXISTS
--9-6
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20, 30);
 
 -- 9-7 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
 SELECT *
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
                  FROM EMP
                 GROUP BY DEPTNO);
                 
-- ANY, SOME 연산자
-- (조건식을 사용한 결과가 하나라도  TRUE라면
-- 메인쿼리 조건식을 TRUE로 반환해주는 연산자)
-- 9-9
 SELECT *
  FROM EMP
 WHERE SAL = ANY (SELECT MAX(SAL)
                    FROM EMP
                   GROUP BY DEPTNO);
                   
-- 9-10  
 SELECT *
  FROM EMP
 WHERE SAL = SOME (SELECT MAX(SAL)
                    FROM EMP
                   GROUP BY DEPTNO);
                   
-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원정보 출력하기
SELECT *
  FROM EMP
 WHERE SAL < ANY ( SELECT SAL 
                     FROM EMP
                    WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;   --2850보다 작게 받는 사원      
 
 -- < ANY는 서브쿼리에 MAX 함수를 사용한 경우
 SELECT *
  FROM EMP
 WHERE SAL < ( SELECT MAX(SAL) 
                 FROM EMP
                WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;  
 
-- 30번 부서 사원들의 최소급여 보다 많은 급여를 받는 사원정보
-- 다중행 연산자 사용
SELECT *
  FROM EMP
 WHERE SAL > ANY  (SELECT SAL
                     FROM EMP
                    WHERE DEPTNO = 30);
                    
-- ALL 연산자 : 모두 만족
--9-14 부서번호가 30번인 사원들으 최소급여보다 더 적은 급여를 맏는 사원 출력
SELECT*
  FROM EMP
 WHERE SAL < ALL (SELECT SAL
                    FROM EMP
                  WHERE DEPTNO = 30);
     
 -- 9-15 부서번호가 30번인 사원들의 최대급여 보다 더 많은 급여를 받는 사람 출력
SELECT *
  FROM EMP
WHERE SAL> ALL ( SELECT SAL
                  FROM EMP
                  WHERE DEPTNO =30);
                
 -- EXISTS연산자 : 서브쿼리 결과 값이 존재하는 경우
 -- 실습 9-16
  SELECT *
    FROM EMP
   WHERE EXISTS (SELECT DNAME
                   FROM DEPT
                  WHERE DEPTNO = 10);

-- 9-17
  SELECT *
    FROM EMP
   WHERE EXISTS (SELECT 1
                   FROM DEPT
                  WHERE DEPTNO = 50);
                  
-- 다중행연산자 사용
-- EMP 테이블의 사원중에 10번 부서에 속한 모든 사원들보다
-- 일찍 입사한 사원 정보를 출력
SELECT *
  FROM EMP
 WHERE HIREDATE < ALL (SELECT HIREDATE
                         FROM EMP
                        WHERE DEPTNO =10);
                        
-- 상관 쿼리
-- : 메인쿼리와 서브쿼리 간에 서로 상관 참조하는 쿼리
-- 사원이 한명이라도 있는 부서명 출력
SELECT DNAME
  FROM DEPT D
 WHERE EXISTS ( SELECT 1 FROM EMP WHERE DEPTNO = D.DEPTNO);
 
 SELECT DNAME
  FROM DEPT D
 WHERE DEPTNO IN ( SELECT DISTINCT DEPTNO FROM EMP);
 -- WHERE DEPTNO IN( 10,20,30);
 
SELECT EMPNO FROM EMP WHERE DEPTNO = 10; -- ACCOUNTING 
SELECT EMPNO FROM EMP WHERE DEPTNO = 20; -- RESEARCH
SELECT EMPNO FROM EMP WHERE DEPTNO = 30; -- SALES
SELECT EMPNO FROM EMP WHERE DEPTNO = 40; 

SELECT * FROM EMP;

-- 비교할 열이 여러개인 다중열 서브쿼리
-- 9-18
SELECT *
  FROM EMP
 WHERE (DEPTNO,SAL) IN (SELECT DEPTNO, MAX(SAL) 
                          FROM EMP
                        GROUP BY DEPTNO);
 
 --SELECT절의 서브쿼리 : 스칼라쿼리 , 상관쿼리                      
 SELECT E.EMPNO, E.ENAME, E.DEPTNO
       ,(SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
   FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO;
  
 SELECT E.EMPNO, E.ENAME, E.DEPTNO
         ,D.DNAME
   FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO;        
 
-- FROM절에 사용하는 서브쿼리와 WITH절
-- 9-19 / 인라인 뷰
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO
     , D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10
     , (SELECT * FROM DEPT) D
 WHERE E10.DEPTNO = D.DEPTNO;
 
-- 9-20 WITH절 사용하기 / FROM절에 써준걸 미리 앞에서 명시해주는 것
WITH
E10 AS (SELECT *
          FROM EMP 
         WHERE DEPTNO = 10), 
  D AS (SELECT * 
          FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO
     , D.DNAME, D.LOC
  FROM E10, D
 WHERE E10.DEPTNO = D.DEPTNO;
 
-- 한 발 더 나가기 : 상호 연관 서브쿼리 =상관쿼리
-- 각 부서의 최소 급여보다 많이 받는 사원?
SELECT *
  FROM EMP E1
 WHERE SAL > (SELECT MIN(SAL)
                FROM EMP E2
               WHERE E2.DEPTNO = E1.DEPTNO)
 ORDER BY DEPTNO, SAL;
 
-- 9-21 SELECT절에 서브쿼리(스칼라쿼리) 사용하기
SELECT EMPNO, ENAME, JOB, SAL
     , (SELECT GRADE
          FROM SALGRADE
         WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE
     , DEPTNO
     , (SELECT DNAME
          FROM DEPT
         WHERE DEPTNO = E.DEPTNO) AS DNAME
     , MGR
     , (SELECT ENAME
          FROM EMP
          WHERE EMPNO = E.MGR) AS MGR
  FROM EMP E;
  
  --잊기전에 한번더!
  -- 1번
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND JOB =(SELECT JOB
               FROM EMP 
              WHERE ENAME='ALLEN');
                
 -- 2번
 SELECT E.EMPNO , E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
   FROM EMP E, DEPT D, SALGRADE S
  WHERE  E.DEPTNO = D.DEPTNO
    AND  SAL BETWEEN S.LOSAL AND S.HISAL
    AND  SAL > (SELECT AVG(SAL)
                   FROM EMP)
  ORDER BY E.SAL DESC, E.EMPNO       
  ;
 
-- 3번
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO =10 
   AND JOB NOT IN (SELECT JOB
                     FROM EMP
                    WHERE DEPTNO=30 );
                
-- 4번
--다중행
SELECT E.EMPNO, E.ENAME,E.SAL,S.GRADE
  FROM EMP E, SALGRADE S
 WHERE SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > ALL(SELECT SAL  
                   FROM EMP
                  WHERE JOB='SALESMAN')
  ORDER BY E.EMPNO;                 

--단일행                
SELECT E.EMPNO, E.ENAME,E.SAL,S.GRADE
  FROM EMP E, SALGRADE S
 WHERE SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > (SELECT MAX(SAL) 
                FROM EMP
               WHERE JOB='SALESMAN')
  ORDER BY E.EMPNO;      
  
--중간문제
--1번
SELECT FIRST_NAME, LAST_NAME, JOB_ID, SALARY
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                            FROM DEPARTMENTS
                            WHERE DEPARTMENT_NAME = 'IT');

--2번
 SELECT DEPARTMENT_ID, DEPARTMENT_NAME
   FROM DEPARTMENTS
  WHERE LOCATION_ID =  (SELECT LOCATION_ID
                          FROM LOCATIONS 
                         WHERE STATE_PROVINCE= 'California');
 
 --3번
SELECT CITY, STATE_PROVINCE, STREET_ADDRESS
  FROM LOCATIONS
 WHERE COUNTRY_ID IN (SELECT COUNTRY_ID
                        FROM COUNTRIES
                       WHERE REGION_ID = 3);

--4번
SELECT FIRST_NAME, LAST_NAME, JOB_ID, SALARY
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                           FROM DEPARTMENTS
                          WHERE MANAGER_ID IS NOT NULL);
--5번
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
  FROM DEPARTMENTS 
 WHERE LOCATION_ID NOT IN(SELECT LOCATION_ID
                            FROM LOCATIONS
                           WHERE CITY = 'Seattle');




-- 6번
SELECT CITY, STATE_PROVINCE, STREET_ADDRESS
  FROM LOCATIONS
 WHERE COUNTRY_ID IN (SELECT COUNTRY_ID
  FROM COUNTRIES 
 WHERE REGION_ID = (SELECT REGION_ID 
                     FROM REGIONS
                    WHERE REGION_NAME = 'Europe'));
