CASE 표현식 복잡한 조건 논리 처리

조건식을 여러개 적용할 때는 DECODE  보다 CASE를 사용하는 것이 편하다. DECODE 정확히 맞거나 틀린경우 조건을 처리하기 위운 반면 CASE는 조건의 범위가 다양한 경우 쉽게 처리.


SELECT employee_id, first_name, last_name, salary,
    CASE
        WHEN salary >= 9000 then '상위급여'
        WHEN salary BETWEEN 6000 AND 8999 THEN '중위급여'
        ELSE '하위급여'
    END AS 급여등급
FROM employees
WHERE job_id='IT_PROG';


#순위 정하기

RANK 공통 순위를 출력하되 공통 순위만큼 건너뛰고 출력한다.
- 공동 2위가 2개있다면 3위를 건너뛰고 4위가 출력

DENSE-RANK 공통순위를 출력하되 건너뛰지 않고 출력한다.
- 공통 2위가 2개있어도 그다음 3위가 출력

ROW_NUMBER 공통 순위없이 출력


SELECT employee_id,
        salary,
        RANK() OVER(ORDER BY salary DESC) RANK등수
FROM employees;



SELECT employee_id,
        salary,
        RANK() OVER(ORDER BY salary DESC) RANK_급여,
        DENSE_RANK() OVER(ORDER BY salary DESC) DENSE_급여,
        ROW_NUMBEROVER(ORDER BY salary DESC) ROW_NUMBER_급여
FROM employees;



그룹함수 -집계함수, 기준열의 값에 대한 데이터 끼리 그룹으로 묶고 묶은 행에 대해 연산을 수행한다.


SELECT COUNT(salary)
FROM employees;

#COUNT함수는 null 값도 행으로 계산한다. (대부분의 함수들은 null 을 제외하고 연산)

SELECT SUM(salary), AVG(salary), SUM(salary)/COUNT(salary)
FROM employees;

#AVG 함수는 null값을 제외하고 연산, null 값을 포함하여 평균을 계산하려면 NVL함수를 사용하여 AVG(NVL(salary,0))해야 계산이 된다.
(문자도 가능)

SELECT MAX(salary), MIN(salary), MAX(first_name)
FROM employees;


# GROUP BY 

SELECT job_id, SUM(salary), AVG(salary)
FROM employees
GROUP BY job_id

SELECT job_id, SUM(salary) 직무별 총 급여, AVG(salary) 직무별평균급여
FROM employees
GROUP BY job_id, manager_id
ORDER BY 직무별총급여 DESC;


HAVING 연산된 그룹 함수 결과에 조건 적용

SELECT job_id, SUM(salary) 직무별 총 급여, AVG(salary) 직무별평균급여
FROM employees
GROUP BY job_id, manager_id
HAVING sum(salary) > 30000


# UNION

SQL을 이용해서 select 문의 실행 결과를 하나로 합친다. 즉, 각기 다른 두개이상의 SELECT문을 실행항 결과를 하나로 묶어서 출력할수 있다.
집합을 하나로 묶을 떄 사용. 중복 행은 한번 출력한다.

SELECT department_id
FROM employees
UNION
SELECT department_id
FROM



DML data maniupulation language

SELECT문의 경우는 단지 조회하여 출력만 한다. 
DML : INSERT(새로운 행삽입), UPDATE(갱신), DELETE(삭제);


INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES(271,'sample_Dept', 200, 1700);

열 순서에 따라 차례로 데이터 값을 기술해서 새로운 행을 삽입. values 절에는 삽입될 값을 기술한다. 


INSERT INTO departments VALUES(272,'sample_Dept2', 300, 3700);


UPDATE departments
SET    manager_id = 201,
       location_id=1800
WHERE department_name = 'sample_Dept';

# 다중 열 서브쿼리
UPDATE departments
SET (manager_id, location_id) = (SELECT manager_id, location_id
                                 FROM departments
                                 WHERE department_id=40)
WHERE department_name = 'sample_Dept';
# departments 테이블에서 department_id 가 40인 manager_id, location_id의 데이터 값을 찾아서 department_name = 'sample_Dept'인 행의 manager_id, location_id 를 찾아낸 데이터 값과 동일하게 변경.



UPDATE departments
SET    manager_id = null
WHERE department_name = 'sample_Dept';



UPDATE departments
SET    department_id = null
WHERE department_name = 'sample_Dept';

departments 데이터의 department_id는 기본키이므로 null값을 가질 수 없다. null로 갱신을 시도하면 오류가 발생한다. 




delete 삭제...

DELETE FROM departments
WHERE department_name = 'sample_Dept';