-- DML : select, insert, delete, update(가장 많음)
-- update문
update 테이블명
set 컬럼명 = 데이터
where 조건;   -- where절 생략시 모든 데이터가 변경되므로 유의하기!

-- update 실습. author 4개, post 5개 정도 데이터 추가
insert into author values(5, 'ddd', 'd@naver.com', '1234', 'd');
insert into post values(3, 'sksk', 'this is sksk', 2);
insert into post values(4, '4sk', 'this is sksk', 2);
insert into post values(5, '5k', 'this is sksk', 2);
insert into post(id, title, contents) values(6, '6k', 'this is sksk');
-- 이름 이메일 변경해보기
update author
set email = 'abc.test.com', name='abc'
where id=1;
-- 이메일만 변경해보기
update author set email='aaaa@naver.com' where id=2;

-- delete문
delete from 테이블명 where 조건;    -- 조건 생략시 모든 데이터 삭제
delete from author where id=5;
-- 실무에선 delete문을 많이 사용하지 않음. 데이터 영구 삭제시 복구가 불가능하기 때문.
-- DEL_YN이라는 attribute를 추가하여 Y or N 로 표시해준다.

-- select문
select * from author;
select * from author where id=1;
select * from author where id>2;
select * from author where id>2 and name='bbb';

-- 특정 컬럼만을 조회
select name, eamil from author where id=3;

-- 중복 제거하고 조회하기
select distinct name from post;

-- 정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬조건 없이 조회할 경우에는 pk를 기준으로 오름차순
-- desc는 내림차순, asc는 오름차순. 생략 시 오름차순
select * from author order by name asc;

-- 멀티 컬럼 order by : 여러 컬럼으로 정렬
select * from post
order by title, content desc;

-- limit number : 특정 숫자로 결과값 개수 제한
-- limit 많이 사용함!!!! 중요 --
select * from author order by id desc limit 1;

-- 별칭을 이용한 select : as(alias) 키워드 사용
select name as '이름', email  as '이메일' from author;
select a.name, a.email from author as a;    -- 두 개 이상의 테이블이 존재한 경우 사용

-- null을 조회 조건으로 사용
select * from post where author_id is null;
select * from post where author_id is not null;


-- 프로그래머스 : 여러 기준으로 정렬하기
SELECT ANIMAL_ID, NAME, DATETIME
FROM ANIMAL_INS
ORDER BY NAME ASC, DATETIME DESC;

-- 프로그래머스 : 상위 N개 레코드
SELECT NAME
FROM ANIMAL_INS
ORDER BY DATETIME LIMIT 1;