# 중복제거..distinct

SQL연산이나 보고서를 작성할 떄 데이터 값의 행이 중복되었다면 중복을 제거하고 계산하거나 출력한다.


SELECT job_id
FROM employees;

job_id를 출력했는데 중복값이 그대로 다 출력된다.
이출력 결과만으로는 job_id에 전 종류를 한눈에 보기 어렵다.
이럴때 중복을 제거하여 데이터의 값을 종류별로 하나만 출력해보자.


SELECT DISTINCT job_id
FROM employees;

데이터 값이 종류별로 하나씩만 출력되었다.
열 이름 뒤에 다른 열이름도 나열하면 모두 적용된다.

# 별명 사용하기

SELECT문의 결과를 출력할때 열 이름이 제목으로 출력된다.
원래 이름 대신에 임의로 다른이름을 표시할 수 있다.alias

- 별명은 열 이름을 임시로 변경하는데 사용된다. 원래이름을 바꾸는 것은 아니다.
- 별명은  열 이름 바로 뒤에 as 를 붙여서 만든다.
- as 는 생략도 가능하다.
- 별명에 공백, 특수문자, 대소문자를 사용하려면 "" 로 묶어서 사용한다.

SELECT employees_id, first_name, last_name
FROM employees;

SELECT employee_id AS 사원번호,
        first_name AS 이름,
        last_name AS 성
FROM employees;


#연결해서 출력해보자
SELECT employee_id AS 사원번호,
        first_name||last_name AS 이름
FROM employees;

#이렇게 연결될 경우 구분이 되지 않는다.


#연결자를 살짝 변형해보자
SELECT employee_id AS 사원번호,
        first_name||' '||last_name AS 이름       
FROM employees;


#이메일주소까지  문자를 집어넣어 출력해보자
SELECT employee_id AS 사원번호,
        first_name||' '||last_name AS 이름,
        email||'@yahoo.com' AS 이메일주소        
FROM employees;



# 산술처리 직원들의 세금과 실수령액을 나타내보자.
SELECT employee_id, salary, salary*0.4, salary*0.6
FROM employees;

SELECT employee_id 사원번호, 
    salary 월급,
    salary*0.4 세금,
    salary*0.6 실수령액
FROM employees;



#산술연산은 실무에서 매우 많이 쓰인다. 특히 비즈니스를 위한 다양한 보고서 작성시 필수적이다.

#WHERE 구문을 활용한 데이터 검색
행에서 특정 데이터 값을 조회하거나 비교 연산 처리하는 방법
사용자가 원하는 데이터를 조회할때 사용하는 WHERE문은
FROM 다음에 기술한다.


#사원이름중 David 만 찾기
SELECT*
FROM employees
WHERE first_name = 'David';


SELECT*
FROM employees
WHERE first_name = 'david'; 
#찾는 문자열에서는 당연히 대소문자를 구분한다.


SELECT*
FROM employees
WHERE salary BETWEEN 10000 AND 20000;

####

IN 연산자. 조회하고자 하는 데이터가 여러개일때 사용한다.
위의 WHERE에 쓰인 = 유사하지만 =은 조회 조건으로 데이터 값을 하나만 지정할 수 있는데 반해 IN연산자는 데이터 값을 여러개. 즉, 목록으로 지정할 수 있다. 여러개의 값 목록 중에서 하나의 값이라도 만족하면 조건에 해당하는 결과를 출력한다.
IN(조건1,조건2,...);

employees 테이블에서 salary가 10000, 17000, 24000 인 직원만 정보들을 출력하라.

SELECT*
FROM employees
WHERE salary IN(10000,17000,24000)


####

LIKE 연산자 조회- 조건의 값이 명확하지 않을때 사용한다.
%'모든 문자' _ '한글자'

employees 테이블에서 job_id에 AD포함하는 모든 데이터를 조회하라
LIKE '조건'

SELECT *
FROM employees
WHERE job_id LIKE 'AD%';

##응용

last_name LIKE '김%'   #김으로 시작하는 값 모두 출력
first_name LIKE '%나%' #이름에 나가 있으면 모두 출력
first_name LIKE '%자'  #이름에 자로 끝나면 모두 출력

이처럼 %의 위치에 따라 출력값이 다르다.


employees테이블에서 job_id에 AD를 포함하면서 뒤에 글자가 3개인 데이터를 조회하라.

SELECT *
FROM employees
WHERE job_id LIKE '%AD___'; 

IS NULL 은 값이 없는 것을 뜻한다. 0이나 공백과는 다르다.

SELECT *
FROM employees
WHERE manager_id IS NULL;


#여러개의 조건을 걸어보자
employees테이블에서 salary가 4000을 초과 job_id 가 IT_PROG인 데이터조회

SELECT *
FROM employees
WHERE salary > 4000 
AND job_id = 'IT_PROG';

employees테이블에서 salary가 4000을 초과 job_id 가 IT_PROG 이거나
FI_ACCOUNT인값을 조회하세요

SELECT *
FROM employees
WHERE salary > 4000 
AND job_id = 'IT_PROG'
or job_id = 'FI_ACCOUNT';


employees테이블에서 salary가 4000을 초과 job_id 가 IT_PROG 아닌 데이터를 출력하라. 
SELECT *
FROM employees
WHERE salary > 4000 
AND job_id <> 'IT_PROG';
많은 프로그래밍 언어에서 쓰이는 != 도 가능하지만 SQL에선 보통 <>을 쓴다


#############################################
함수
#############################################


오라클 데이터 베이스에서의 함수는 문자, 숫자, 날짜값등을 조작할 수 있고 데이터 타입 끼리 변환 할 수 있다. 복수의 행을 조합하여 그룹당 하나의 결과로 출력할 수 있다.

- 데이터 값을 계산하거나 조작한다.
- 행을 그룹으로 계산하거나 요약한다.
- 열의 데이터 타입을 변환.

문자 CHAR       - 고정 길이의 문자 타입
문자 VARCHAR2   - 가변 길이의 문자 타입
숫자 NUMBER (INT)   - 숫자 타입을 저장.
날짜 DATE

#실무에서는 VARCHAR2 를 많이 사용한다.

단일행 함수 : 한번에 하나의 데이터를 처리하는 함수.
그룹 함수 : 여러 데이터를 동시에 처리하여 그 결과를 반환
GROUP BY와 함께 많이 사용되며 요약 정보를 출력할 때 유용하다.

단일행 함수 : 테이블의 열은 한가지 데이터 타입으로 지정되어있다. 지정된 데이터 타입과 일치하는 데이터 값만 저장할 수 있다.
1. 각 행에 대해 수행
2. 데이터 타입에 맞는 함수를 사용해야 한다.
3. 행별로 하나의 결과를 반환한다.
4. SELECT, WHERE, ORDER BY 절에서 사용된다.
5. 함수 안의 함수 처럼 중복해서 사용할 수 있다.
6. 중첩할 경우 안쪽에서 바깥쪽 순서로 진행된다.


LOWER/UPPER/INITCAP 소문자로/대문자로/첫글자만 대문자로
SUBSTR 문자열 중 일부분만 선택
REPLACE 특정 문자열을 찾아서 바꾼다
CONCAT 문자열을 연결한다.
LENGTH 문자열의 길이를 구한다.
INSTR 문자의 위치를 구한다.
LTRIM / RTRIM  좌/우 여백제거
LPAD / RPAD  좌/우 특정문자로 자리수 만들어 채우기

###
LOWER UPPER INITCAP 두개씩 출력하여 비교해보자
SELECT last_name,
        LOWER(last_name),
        UPPER(last_name),
        email,
        INITCAP(email)
FROM employees;

###
SUBSTR 지정한 길이만큼 문자열 추출. 데이터값이 이미가공되어 저장되있어도 일부 문자열을 잘라내 가공해야 할 때가 많다. 예를 들면 employees테이블에서 JOB_ID열의 앞 두자리는 부서를 나타낸다. 앞의 두자리데이터를 잘라내면 부서를 표시할 수 있다. 두개를 출력비교해보자.
SELECT job_id,
SUBSTR(job_id, 1, 2)
FROM employees;

추출된 데이터는 기초 통계 처리나 다른 테이블과 붙일때 등 상황에 맞게 유용하게 응용할 수 있다.


###
REPLACE 특정 문자를  찾아서 바꾼다
SELECT job_id,
REPLACE(job_id, 'ACCOUNT', 'ACCNT')
FROM employees;


###
LPAD/RPAD 좌/우에 특정 문자를
SELECT first_name,
LPAD(first_name,12,' ') AS LPAD
RPAD(first_name,12,' ') AS RPAD
FROM employees;