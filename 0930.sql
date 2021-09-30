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
