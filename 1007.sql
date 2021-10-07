DML: 데이터 삽입 / 갱신 / 삭제
INSERT, UPDATE, DELETE

data maninpulation language 데이터 조작 명령어

select도 DML에 속하지만 단지 조회하여 출력만 한다.
INSERT, UPDATE, DELETE 는 직접 데이터를 삽입, 갱신, 삭제
트랜잭션 transaction 데이터를 조작하여 저장하는 과정
DML은 트랜잭션을 다루는 명령어...
테이블의 행을 기준으로 삽입 갱신 삭제 한다.

INSERT 행 삽입하기... 새로운 데이터를 행 단위로 입력한다.

INSERT INTO departments (department_id, department_name, manager_id,
location_id)
VALUES (271, 'Sample_Dept', 200, 1700);



INSERT INTO departments
VALUES (271, 'Sample_Dept', 200, 1700);


UPDATE 기존의 값을 변경할 때 사용

UPDATE departments
SET manager_id=201, location_id=1800
WHERE department_name='IT';


#DELETE 행 삭제, where 생략하면 조건식이 없으므로 모두 삭제

DELETE FROM departments
WHERE department_name='Sample_Dept';


#########################################################
#DDL - date definition language 데이터 정의어
따로 커밋하지 않아도 데이터 베이스에 즉각 반영된다.

CREATE 테이블 생성

CREATE TABLE product(
    productid number,
    productname varchar2(30),
    manudate date
);

#값을 몇개 넣어주자
INSERT INTO PRODUCT VALUES(1,'tv',to_date('211007','YYMMDD'));
INSERT INTO PRODUCT VALUES(2,'washer',to_date('211007','YYMMDD'));
INSERT INTO PRODUCT VALUES(3,'cleaner',to_date('211007','YYMMDD'));



테이블과 열의 이름을 정할 때는..
1. 동일한 테이블의 이름을 중복하여 생성할수없다. 테이블 안의 열 이름도 동일한 이름으로 생성할 수 없다.
2.SELECT , INSERT , FROM 같은 예약어는 사용할 수 없다.
3.문자로 시작한다. 한글과 특수문자도 사용할 수는 있지만 권장하지 않는다.
4.너무 긴 이름으로 사용은 권장하지 않는다.


ALTER 테이블 수정

이미 생성한 테이블에 열을 추가, 변경, 삭제 할 수 있다. ALTER TABLE을 사용하여 구조를 변경할 수 있다.

ALTER TABLE product
ADD (factory varchar(10));

새로 생성되는 열은 위치를 지정할 수 없다.
테이블의 마지막에 위치한다.
이미 행이 있다면 열을 추가 했을떄 새로운 열의 데이터 값은 null로 초기화된다.

ALTER TABLE product
MODIFY (factory char(10));


ALTER TABLE product
MODIFY (productname varchar(5));
기존보다 더 작은 형으로는 변환할 수 없다.


#열 이름 변경

ALTER TABLE product
RENAME column factory to factoryname;



#열 삭제
ALTER TABLE product
DROP column factoryname;


#테이블 내용만 삭제
TRUNCATE TABLE product;



#테이블 내용과 구조 모두 삭제
DROP TABLE product;

트랜잭션 내의 DML 명령문은 실행되어 결과 반영되더라도 COMMIT 전까지는 임시적인 상태이다. 이상태에서 ROLLBACK 을 할 경우 트랜잭션이 취소되고 커밋직후로 돌아간다.

# DML의 DELETE는 돌이킬수 있다. 데이터만 삭제
# delete<truncate<drop
