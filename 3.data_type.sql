-- tinyint는 -128~127까지 표현
-- author table에 age(tinyint) 추가하기
alter table author add age tinyint;
-- author table에 insert age 200->125
> insert into author values (5, 'ddd', 'd@naver.com', 1234, 'd', 200);
ERROR 1264 (22003): Out of range value for column 'age' at row 1    -- 범위 벗어나서 에러 발생
> insert into author values (5, 'ddd', 'd@naver.com', 1234, 'd', 125);
Query OK, 1 row affected (0.011 sec)
-- unsigned : 부호 없이 0~255
insert into author values (6, 'eee', 'e@naver.com', 1234, 'd', 224);


-- 실수
-- 소수점 : 이진법으로 표현하기 어려움. 근사치 표현만 가능.
-- 정확한 소수점 표현을 위해서 BigDecimal class를 사용함(자바에서)
-- DECIMAL 실습
-- post table에 price 추가
alter table post add price DECIMAL(10, 3);

-- decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(id, title, price) values(7, 'hello', 3.123123123); -- 3.123까지 들어감

-- 정상적인 숫자 넣으면 --> 1234.100으로 저장됨
update post set price=1234.1 where price=3.123;
