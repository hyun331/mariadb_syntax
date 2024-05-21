-- index 생성문
create index 인덱스명 on 테이블명(컬럼명);

-- index 조회
show index from 테이블명

-- index 삭제문
alter table 테이블명 drop index 인덱스명;

-- board2 schema 생성
-- author table 생성
create table author(
id int primary key auto_increment,
email varchar(255) default null
);
-- 대량 데이터 생성 프로시저
DELIMITER //
CREATE PROCEDURE insert_authors()
BEGIN
    DECLARE i INT DEFAULT 1;    -- 변수 지정
    DECLARE email VARCHAR(100);
    DECLARE batch_size INT DEFAULT 10000; -- 한 번에 삽입할 행 수
    DECLARE max_iterations INT DEFAULT 100; -- 총 반복 횟수 (100000000 / batch_size)
    DECLARE iteration INT DEFAULT 1;
    WHILE iteration <= max_iterations DO
        START TRANSACTION;
        WHILE i <= iteration * batch_size DO
            SET email = CONCAT('seonguk', i, '@naver.com'); -- seonguk1부터 1000000까지
            INSERT INTO author (email) VALUES (email);
            SET i = i + 1;
        END WHILE;
        COMMIT;
        SET iteration = iteration + 1;
        DO SLEEP(0.1); -- 각 트랜잭션 후 0.1초 지연
    END WHILE;
END //
DELIMITER ;

-- 프로시저 호출
CALL insert_authors();

-- 인덱스 없는 email 검색해보기
select * from author where email = 'seonguk99999@naver.com';
-- 0.2초 걸림

-- 인덱스 생성
create index email_index on author(email);

-- 인덱스 생성 후 다시 검색
select * from author where email = 'seonguk99999@naver.com';
-- 0초 걸림. 인덱스를 통해 검색 성능 향상

--데이터를 추가할 때마다 index 페이지에도 데이터를 추가 -> 속도 저하 가능성 존재










