-- 9�� ��������
-- 9-1 JONES�� ����� �޿� ���
SELECT SAL
  FROM EMP
 WHERE ENAME = 'JONES';
 
-- 9-2 �޿��� 2975���� ���� ��� ���
SELECT *
  FROM EMP
 WHERE SAL > 2975;
 
-- 9-3 ��������
SELECT *
  FROM EMP
 WHERE SAL > (SELECT SAL
                FROM EMP
               WHERE ENAME = 'JONES'); -- 2975
               
-- �������� Ư¡
-- 1. ��ȣ�� ��� ��� 2. Ư���� ��� ����, ������������ ORDER BY �� ��� �Ұ�
-- 3. �������� �񱳴��� ������ ������ �ڷ��� ���
-- 4. ���������� ���������� ������������ ���� ������ ���

-- 1�� ���� : ������� �߿��� ��� �̸��� ALLEN�� ����� �߰� ���纸�� ���� �߰����� ���� ���
SELECT *
  FROM EMP
 WHERE COMM > (SELECT COMM
                 FROM EMP
                WHERE ENAME = 'ALLEN');
                
-- 9-4 SCOTT���� ���� �Ի��� ����
SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE 
                     FROM EMP 
                    WHERE ENAME = 'SCOTT');

-- �ٸ� ��
SELECT *
  FROM EMPLOYEES
 WHERE SALARY = (SELECT SALARY
                   FROM EMPLOYEES
                  WHERE HIRE_DATE = '2006/01/03');


--������ ���������� �Լ�
-- 9-5 ����������� ��ձ޿����� ���� �޴� ����� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
         D.DEPTNO,D.DNAME,D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL>(SELECT AVG(SAL)
                FROM EMP);

-- 1�� ����
--��ü ����� ��� �޿� ���� �۰ų� ���� �޿��� �ް��ִ�
-- 20�� �μ��� ��� �� �μ������� ���ϵ��� ������ �ۼ��ϼ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
         D.DEPTNO,D.DNAME,D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL <=(SELECT AVG(SAL)
                 FROM EMP);
                 
-- ������ �������� ������: IN, ANY/SOME, ALL, EXISTS
--9-6
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20, 30);
 
 -- 9-7 �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ���
 SELECT *
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
                  FROM EMP
                 GROUP BY DEPTNO);
                 
-- ANY, SOME ������
-- (���ǽ��� ����� ����� �ϳ���  TRUE���
-- �������� ���ǽ��� TRUE�� ��ȯ���ִ� ������)
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
                   
-- 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ������� ����ϱ�
SELECT *
  FROM EMP
 WHERE SAL < ANY ( SELECT SAL 
                     FROM EMP
                    WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;   --2850���� �۰� �޴� ���      
 
 -- < ANY�� ���������� MAX �Լ��� ����� ���
 SELECT *
  FROM EMP
 WHERE SAL < ( SELECT MAX(SAL) 
                 FROM EMP
                WHERE DEPTNO = 30)
 ORDER BY SAL, EMPNO;  
 
-- 30�� �μ� ������� �ּұ޿� ���� ���� �޿��� �޴� �������
-- ������ ������ ���
SELECT *
  FROM EMP
 WHERE SAL > ANY  (SELECT SAL
                     FROM EMP
                    WHERE DEPTNO = 30);
                    
-- ALL ������ : ��� ����
--9-14 �μ���ȣ�� 30���� ������� �ּұ޿����� �� ���� �޿��� ���� ��� ���
SELECT*
  FROM EMP
 WHERE SAL < ALL (SELECT SAL
                    FROM EMP
                  WHERE DEPTNO = 30);
     
 -- 9-15 �μ���ȣ�� 30���� ������� �ִ�޿� ���� �� ���� �޿��� �޴� ��� ���
SELECT *
  FROM EMP
WHERE SAL> ALL ( SELECT SAL
                  FROM EMP
                  WHERE DEPTNO =30);
                
 -- EXISTS������ : �������� ��� ���� �����ϴ� ���
 -- �ǽ� 9-16
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
                  
-- �����࿬���� ���
-- EMP ���̺��� ����߿� 10�� �μ��� ���� ��� ����麸��
-- ���� �Ի��� ��� ������ ���
SELECT *
  FROM EMP
 WHERE HIREDATE < ALL (SELECT HIREDATE
                         FROM EMP
                        WHERE DEPTNO =10);
                        
-- ��� ����
-- : ���������� �������� ���� ���� ��� �����ϴ� ����
-- ����� �Ѹ��̶� �ִ� �μ��� ���
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

-- ���� ���� �������� ���߿� ��������
-- 9-18
SELECT *
  FROM EMP
 WHERE (DEPTNO,SAL) IN (SELECT DEPTNO, MAX(SAL) 
                          FROM EMP
                        GROUP BY DEPTNO);
 
 --SELECT���� �������� : ��Į������ , �������                      
 SELECT E.EMPNO, E.ENAME, E.DEPTNO
       ,(SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
   FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO;
  
 SELECT E.EMPNO, E.ENAME, E.DEPTNO
         ,D.DNAME
   FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO;        
 
-- FROM���� ����ϴ� ���������� WITH��
-- 9-19 / �ζ��� ��
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO
     , D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10
     , (SELECT * FROM DEPT) D
 WHERE E10.DEPTNO = D.DEPTNO;
 
-- 9-20 WITH�� ����ϱ� / FROM���� ���ذ� �̸� �տ��� ������ִ� ��
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
 
-- �� �� �� ������ : ��ȣ ���� �������� =�������
-- �� �μ��� �ּ� �޿����� ���� �޴� ���?
SELECT *
  FROM EMP E1
 WHERE SAL > (SELECT MIN(SAL)
                FROM EMP E2
               WHERE E2.DEPTNO = E1.DEPTNO)
 ORDER BY DEPTNO, SAL;
 
-- 9-21 SELECT���� ��������(��Į������) ����ϱ�
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
  
  --�ر����� �ѹ���!
  -- 1��
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND JOB =(SELECT JOB
               FROM EMP 
              WHERE ENAME='ALLEN');
                
 -- 2��
 SELECT E.EMPNO , E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
   FROM EMP E, DEPT D, SALGRADE S
  WHERE  E.DEPTNO = D.DEPTNO
    AND  SAL BETWEEN S.LOSAL AND S.HISAL
    AND  SAL > (SELECT AVG(SAL)
                   FROM EMP)
  ORDER BY E.SAL DESC, E.EMPNO       
  ;
 
-- 3��
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO =10 
   AND JOB NOT IN (SELECT JOB
                     FROM EMP
                    WHERE DEPTNO=30 );
                
-- 4��
--������
SELECT E.EMPNO, E.ENAME,E.SAL,S.GRADE
  FROM EMP E, SALGRADE S
 WHERE SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > ALL(SELECT SAL  
                   FROM EMP
                  WHERE JOB='SALESMAN')
  ORDER BY E.EMPNO;                 

--������                
SELECT E.EMPNO, E.ENAME,E.SAL,S.GRADE
  FROM EMP E, SALGRADE S
 WHERE SAL BETWEEN S.LOSAL AND S.HISAL
   AND SAL > (SELECT MAX(SAL) 
                FROM EMP
               WHERE JOB='SALESMAN')
  ORDER BY E.EMPNO;      
  
--�߰�����
--1��
SELECT FIRST_NAME, LAST_NAME, JOB_ID, SALARY
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                            FROM DEPARTMENTS
                            WHERE DEPARTMENT_NAME = 'IT');

--2��
 SELECT DEPARTMENT_ID, DEPARTMENT_NAME
   FROM DEPARTMENTS
  WHERE LOCATION_ID =  (SELECT LOCATION_ID
                          FROM LOCATIONS 
                         WHERE STATE_PROVINCE= 'California');
 
 --3��
SELECT CITY, STATE_PROVINCE, STREET_ADDRESS
  FROM LOCATIONS
 WHERE COUNTRY_ID IN (SELECT COUNTRY_ID
                        FROM COUNTRIES
                       WHERE REGION_ID = 3);

--4��
SELECT FIRST_NAME, LAST_NAME, JOB_ID, SALARY
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                           FROM DEPARTMENTS
                          WHERE MANAGER_ID IS NOT NULL);
--5��
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
  FROM DEPARTMENTS 
 WHERE LOCATION_ID NOT IN(SELECT LOCATION_ID
                            FROM LOCATIONS
                           WHERE CITY = 'Seattle');




-- 6��
SELECT CITY, STATE_PROVINCE, STREET_ADDRESS
  FROM LOCATIONS
 WHERE COUNTRY_ID IN (SELECT COUNTRY_ID
  FROM COUNTRIES 
 WHERE REGION_ID = (SELECT REGION_ID 
                     FROM REGIONS
                    WHERE REGION_NAME = 'Europe'));
