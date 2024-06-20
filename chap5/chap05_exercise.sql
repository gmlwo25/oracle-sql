-- 5장: 더 정확하고 다양하게 결과를 출력하는 WHERE절과 연산자
-- 5-1  PAGE 94
SELECT *
  FROM EMP;
  
-- 5-2 부서번호가 30인 데이터(행)만 출력하기
SELECT *
  FROM EMP
 WHERE DEPTNO = 30;  -- '=' 비교연산자 같다면
 
-- 1분 복습
-- 사원번호가 7782인 사원 정보만 나오도록 쿼리문 작성
SELECT *
  FROM EMP
 WHERE EMPNO = 7782; 
  
-- 5-3 AND 연산자로 여러 개 조건식 사용
SELECT *
  FROM EMP 
 WHERE DEPTNO = 30
   AND JOB = 'SALESMAN';  -- 논리 연산자 AND, OR
   
-- 1분 복습 사원번호가 7499 이고 부서번호가 30인 사원정보만 나오도록 쿼리 작성
SELECT *
  FROM EMP
 WHERE EMPNO = 7499
   AND DEPTNO = 30;
   
-- 5-4 OR 연산자로 여러개의 출력 조건 사용하기
SELECT *
  FROM EMP
 WHERE DEPTNO = 30
    OR JOB = 'CLERK';
    
 SELECT *
   FROM EMP
  WHERE JOB = 'SALESMAN' 
     OR JOB = 'CLERK';   
     
-- 1분 복습:부서번호가 20 이거나 직업이 SALESMAN 인 사원정보 출력 쿼리 작성
SELECT *
  FROM EMP
 WHERE JOB='SALESMAN'
    OR DEPTNO = 20;
    
-- 5-5 산술연산자 : 급여 열에 12를 곱한 값이 36000인 행을 출력
SELECT *
  FROM EMP
 WHERE SAL * 12 = 36000;

-- 5-6 비교연산자 : 급여가 3000 이상인 사원정보 출력
SELECT *
  FROM EMP
 WHERE SAL>=3000;
 
-- 1분 복습
-- 급여가 2500이상이고 직업이 ANALYST인 사원정보만 나오도록 쿼리 작성
SELECT *
  FROM EMP
 WHERE JOB ='ANALYST'
   AND SAL >= 2500;
 
 -- 5-7 문자 대소 비교 가능
 SELECT *
   FROM EMP
  WHERE ENAME >= 'F';
  
-- 5-8
SELECT *
  FROM EMP
 WHERE ENAME <= 'FORZ';
 
 -- 등가 비교 연산자 같지않다 ( '<>', '!=', '^=' )
 -- 같다 '='
 -- 5-9
SELECT * 
  FROM EMP
 WHERE SAL != 3000;
 
 -- 5-10
SELECT * 
  FROM EMP
 WHERE SAL <> 3000;

 -- 5-11
SELECT * 
  FROM EMP
 WHERE SAL ^= 3000;
 
-- 5-12 논리 부정 연산자
SELECT *
  FROM EMP
 WHERE NOT SAL = 3000;
 
-- 5-13 
 -- IN 연산자 : 중요
 -- OR 연사자를 사용 여러 개 조건을 만족하는 데이터 출력
 SELECT *
   FROM EMP
  WHERE JOB = 'MANAGER'
     OR JOB = 'SALESMAN'
     OR JOB = 'CLERK';
     
-- 5-14
SELECT *
  FROM EMP
 WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');
 
-- 5-15 등가 비교 연산자와 AND 연산자 사용
SELECT *
  FROM EMP
 WHERE JOB != 'MANAGER'
   AND JOB <> 'SALESMAN'
   AND JOB ^= 'CLERK';
   
-- 5-16
SELECT *
  FROM EMP
 WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK'); 
 
-- 1분 복습
-- 부서 번호가 10, 20번인 사원정보 출력 쿼리 작성하세요
SELECT *
  FROM EMP
 WHERE DEPTNO IN(10,20);
 
-- 5-17 대소 비교연산자
SELECT *
  FROM EMP
 WHERE SAL >= 2000 AND SAL <= 3000; 
  
-- 5-18   BETWEEN A AND B 범위 많이 사용
SELECT *
  FROM EMP
 WHERE SAL BETWEEN 2000 AND 3000;  -- >=, <= 
 
-- 5-19   
SELECT *
  FROM EMP
 WHERE SAL NOT BETWEEN 2000 AND 3000; 
 
 -- LIKE 연산자와 와일드 카드 : 매우 중요 
 -- 5-20  -- 이름이 S로 시작하는 직원 출력
 SELECT *
   FROM EMP
  WHERE ENAME LIKE 'S%';  -- 와일드 카드: 특수문자 OR 문자열대체 OR 패턴
  
-- LIKE 연산자와 함께 사용할 수 있는 와일드 카드 '_'와 '%'
/*
- : 어떤 값이든 한개의 문자 데이터를 의미
% : 길이와 상관없이 모든 문자 데이터를 의미
*/
 
 
 -- 사원이름에 두번째 글자가 L 인 사원만 출력
 -- 5-21
 SELECT *
   FROM EMP
  WHERE ENAME LIKE '_L%';
  
-- 사원이름이 AM이 포함되어 있는 사원데이터만 출력
-- 5-22
SELECT *
  FROM EMP
 WHERE ENAME LIKE '%AM%';
 
-- 5-23
SELECT *
  FROM EMP
 WHERE ENAME NOT LIKE '%AM%'; 
 
--  _나 % 문자가 데이터로 포함된 경우가 간혹 있음

INSERT INTO EMP VALUES
(7999,'A_ADAM','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);

COMMIT;

SELECT *
  FROM EMP
 WHERE ENAME LIKE 'A_A%';
 
 SELECT * FROM EMP WHERE ENAME LIKE 'A@_A%' ESCAPE '@';
-- 7999	A_ADAM	CLERK	7902	80/12/17	800		20
 -- " \"HI HELLO\"   "
 
 DELETE FROM EMP WHERE ENAME LIKE 'A@_A%' ESCAPE '@';
 COMMIT;
 
 SELECT * FROM EMP;
 
 -- 연습문제
 -- 1번
 SELECT *
   FROM EMPLOYEES
  WHERE FIRST_NAME = 'David'; 
  
--2번
SELECT *
  FROM JOBS
 WHERE MIN_SALARY = 4000;
 
--3번
SELECT *
  FROM JOBS
 WHERE MIN_SALARY>8000;
 
--4번
SELECT *
  FROM JOBS
 WHERE MAX_SALARY<=10000;
 
--5번
SELECT *
  FROM JOBS
 WHERE MIN_SALARY >= 4000 
   AND MAX_SALARY <= 10000;
 
--6번
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID LIKE 'IT@_PROG' ESCAPE'@'
   AND SALARY>5000;
   
-- 5-24
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL, COMM
  FROM EMP;
 
--5-25
SELECT *
  FROM EMP
 WHERE COMM = NULL;
 
 -- 5-26
SELECT *
  FROM EMP
 WHERE COMM IS NULL; -- IS NOT NULL o / NOT IS NULL X
 
-- 5-27 직속상관이 있는 사원 데이터만 출력
SELECT *
  FROM EMP
 WHERE MGR IS NOT  NULL; -- NULL이 아니다 = 존재한다.
 
--5-28 AND 연산자와 IS NULL
SELECT *
  FROM EMP
 WHERE SAL < NULL  -- FALSE
   AND COMM IS NULL;
   
-- 5-28 OR 연산자와 IS NULL
SELECT *
  FROM EMP
 WHERE SAL < NULL
    OR COMM IS NULL;
    
-- 집합 연산자 : UNION, UNION ALL, MINUS, INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10
 UNION -- 중복된게 한번만
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10
 ;
 
 -- 5-35
 SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10
 UNION ALL -- 중복되더라도 모두 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10
 ;

-- 5-36
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 MINUS  
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10;
 
-- INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
INTERSECT  
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10; 
 
-- 연산자 우선순위
-- 높은순 : 산술 -> 대소비교 -> 그외 비교(IS NULL, LIKE, IN)-> BETWEEN -> 논리

-- 연습문제
--잊기 전에 한 번 더!
-- 1번 
SELECT *
  FROM EMP
 WHERE ENAME LIKE '%S';
 
-- 2번
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
 WHERE JOB='SALESMAN' AND DEPTNO=30;

--3번
-- 집합연산자 미사용
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO IN (20,30) --DEPTNO =20 OR DEPTNO =30
   AND SAL>2000;
 
 --집합연산자 사용  
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO =20 
   AND SAL>2000   
  UNION
  SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO =30
   AND SAL>2000
   ;   
   
--4번
SELECT *
  FROM EMP
 WHERE SAL< 2000 
   OR  SAL> 3000;

-- 5번
SELECT ENAME, EMPNO,SAL,DEPTNO
  FROM EMP
 WHERE ENAME LIKE '%E%'
   AND DEPTNO = 30
   AND SAL NOT BETWEEN 1000 AND 2000;
 
-- 6번
SELECT *
  FROM EMP
 WHERE COMM IS NULL -- 수당이 없음
   AND MGR IS NOT NULL -- 상급자 존재
   AND JOB IN ('MANAGER', 'CLERK')
   AND ENAME NOT LIKE '_L%';
   
-- 연습문제
-- 1번
SELECT *
  FROM JOBS
 ORDER BY job_title;

-- 2번
SELECT *
  FROM COUNTRIES 
ORDER BY country_name DESC;

-- 3번
SELECT *
 FROM employees
WHERE salary BETWEEN 10000 AND 12000;

--4번
SELECT *
  FROM employees
WHERE job_id IN('IT_PROG', 'ST_MAN');

--5번
SELECT *
  FROM employees
 WHERE manager_id IS NULL;
 
--6번
SELECT *
  FROM DEPARTMENTS
 WHERE MANAGER_ID IS NOT NULL ;
 
--
SELECT *
  FROM employees
 WHERE job_id LIKE 'AD%';
 
SELECT *
  FROM employees
  WHERE first_name LIKE '%ni%';
  
SELECT LOCATION_ID , STREET_ADDRESS, CITY
FROM LOCATIONS
WHERE LOCATION_ID <= 3000
UNION ALL
SELECT LOCATION_ID , STREET_ADDRESS, CITY
FROM LOCATIONS
WHERE LOCATION_ID  >=2000;

SELECT LOCATION_ID , STREET_ADDRESS, CITY
FROM LOCATIONS
WHERE LOCATION_ID <= 3000
 MINUS
SELECT LOCATION_ID , STREET_ADDRESS, CITY
FROM LOCATIONS
WHERE LOCATION_ID >=2000;

SELECT LOCATION_ID , STREET_ADDRESS, CITY
FROM LOCATIONS
WHERE LOCATION_ID <= 3000
INTERSECT
SELECT LOCATION_ID , STREET_ADDRESS, CITY
FROM LOCATIONS
WHERE LOCATION_ID  >=2000;