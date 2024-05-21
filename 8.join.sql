-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 코드만 반환. on 조건을 통해 교집합 찾기
select * from author inner join post on author.id = post.author_id;
select * from author as a inneer join post as ap on a.id=p.author_id;

-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

-- 모든 글목록을 출력하고 만약 글쓴이가 있다면 이메일 출력
select p.jid, p.itle, p.contentes, a.contents from post p
left outer join author a on p.authorid=a.ic;

-- join된 상황에서의 where 조건 : on 뒤에 where 조건 나옴
-- 1)글쓴이가 있는 글 중에 글의 title과 저자의 email을 뽑아라. 저자 나이는 25세 이상인 글만
select p.title, a.email
from post p inner join author a on p.author_id=a.id
where a.age>=25;
-- 2)모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력 2024-05-01 이후에 만들어진 글만 출력하시오.
select p.title, ifnull(a.email, '익명')
from post p left join author a on p.author_id = a.id
where p.title is not null and date_format(p.created_time, '%Y-%m-%d') > '2024-05-01';

-- 조건에 맞는 도서와 저자 리스트 출력하기
SELECT B.BOOK_ID, A.AUTHOR_NAME, DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK B INNER JOIN AUTHOR A ON B.AUTHOR_ID = A.AUTHOR_ID
WHERE B.CATEGORY = '경제'
ORDER BY B.PUBLISHED_DATE;

---------0521---------

-- UNION : 중복 제거
-- UNION ALL : 중복 포함
-- 컬럼의 개수와 타입이 같아야 함.
SELECT 컬럼 1, ... FROM TABLE1 UNION SELECT 컬럼1, ... FROM TABLE2;
-- AUTHOR 의 NAME, EMAIL그리고 POST의 TITLE, CONTENTS UNION 해보기
SELECT NAME, EMAIL FROM AUTHOR UNION SELECT TITLE, CONTENTS FROM POST;

-- SQL 의 간결성 중요 -> 유지보수를 위해

-- 서브쿼리 : SELECT문 안에 또 다른 SELECT문을 서브쿼리라 한다.
-- SELECT절 안에 서브쿼리
-- author email과 해당 author가 쓴 글의 개수 출력
select a.email, (select count(*) from post p where a.id = p.author_id) as count
from author a;
-- FROM절 안에 서브쿼리
select a.name from (select * from author)as a;
-- WHERE절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in (select author_id from post);
-- 서브쿼리보단 join 사용하는 게 좋음

-- 없어진 기록 찾기
-- SUBQUERY
SELECT O.ANIMAL_ID, O.NAME
from ANIMAL_OUTS O
where O.ANIMAL_ID NOT in (select I.ANIMAL_ID FROM ANIMAL_INS I)
ORDER BY O.ANIMAL_ID;
-- JOIN
SELECT O.ANIMAL_ID, O.NAME
FROM ANIMAL_OUTS O LEFT JOIN ANIMAL_INS I ON O.ANIMAL_ID = I.ANIMAL_ID
WHERE I.ANIMAL_ID IS NULL
ORDER BY O.ANIMAL_ID;

-- Group by
-- 집계를 위해 사용
-- select (여기에는 집계함수 or group column만 나올 수 있음) from ... group by 컬럼명
select count(*) from author;
select sum(price) from post;
select round(avg(price), 0) from post;  -- 반올림
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price), round(avg(price), 0), min(price), max(price) from post group by author_id;

-- 저자 email, 해당 저자가 작성한 글 개수
select a.email, if(p.id is null, 0, count(*)) as count  -- left join으로 인해 p.id가 null인 행도 1개 체크됨. -> if문을 통해 0으로
from author a left join post p on a.id = p.author_id
group by a.id;

-- where와 group by
-- 연도별 포스트 글 출력. null 제외
select date_format(created_time, '%Y') as year, count(*) 
from post p 
where p.created_time is not null 
group by year; 

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE, COUNT(*) AS CARS
FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS LIKE '%시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE;

-- 입양 시각 구하기(1)
SELECT CAST(DATE_FORMAT(DATETIME, '%H') AS UNSIGNED) AS HOUR , COUNT(*)
FROM ANIMAL_OUTS
WHERE DATE_FORMAT(DATETIME, '%H') BETWEEN 9 AND 19
GROUP BY HOUR
ORDER BY HOUR;
-- 강사님 코드에서 where 절 : where date_format(datetime, '%H:%i') between '09:00' and '19:59'

--HAVING : group by를 통해 나온 통계에 대한 조건
select author_id, count(*) as count 
from post
group by author_id
having count >= 2;
-- (실습) 포스팅 price가 2000원 이상인 글을 대상으로, 
-- 작성자별로 몇건인지와 평균 price를 구하되 
-- 평균 price가 3000원 이상인 데이터를 대상으로만 통계를 출력
select author_id, count(*) as count, round(avg(price), 0) as avg
from post
where price >= 2000    --2000원 이상인 게시글을 선택한 뒤
group by author_id     --그룹화함
having avg >= 3000;

--동명 동물 수 찾기
SELECT NAME, COUNT(*) AS COUNT
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING COUNT >= 2
ORDER BY NAME;

--(실습)2건 이상의 글을 쓴 사람의 EMAIL, 게시글 수 구할건데
-- 나이는 25세 이상인 사람만 집계에 사용하고
-- 가장 나이 많은 한명의 통계만 출력하시오
SELECT A.EMAIL, COUNT(*) AS COUNT
FROM AUTHOR A INNER JOIN POST P ON A.ID = P.AUTHOR_ID
WHERE A.AGE >=25 
GROUP BY P.AUTHOR_ID
HAVING COUNT >= 2;
----------------SUBQUERY-----------------
-- SELECT A.EMAIL, COUNT(*) AS COUNT
-- FROM (SELECT * FROM AUTHOR A WHERE A.AGE>=25 ORDER BY A.AGE) AS A INNER JOIN POST P ON A.ID = P.AUTHOR_ID
-- GROUP BY P.AUTHOR_ID
-- HAVING COUNT >= 2
-- ORDER BY MAX(A.AGE) DESC LIMIT 1;

-- 다중열 GROUP BY 
SELECT AUTHOR_ID, TITLE, COUNT(TITLE)
FROM POST
GROUP BY AUTHOR_ID, TITLE;