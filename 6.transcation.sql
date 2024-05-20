-- author table에 post_count컬럼 추가
alter table author add column post_count int default 0;
alter table author modify column post_count int default 0;

-- post에 글 쓴 후에, author 테이블에 post_count 값에 +1 => 트랜잭션
start transaction;  -- 지금부터 트랜잭션 시작
update author set post_count = post_count+1 where id = 4;
insert into post(title, author_id) values('hello world', 544);
commit; 
--또는
rollback;
--# 여기서 1 나오는건 임시저장임. powershell에서 하면 0으로 나옴
-- insert에서 오류 발생
-- 위 쿼리들이 정상실행됐으면 x, 실패했으면 y. -> 분기처리 procedure사용!
-- 한번 commit되면 rollback할 수 없음. commit하기 전까지만 rollback 가능함

-- stored 프로시저를 활용한 트랜잭션 테스트
-- 프로시저 저장하기 --
DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_count = post_count + 1 WHERE id = 4;
    -- UPDATE가 실패했는지 확인하고 실패 시 ROLLBACK 및 오류 메시지 반환
    IF (ROW_COUNT() = 0) THEN   -- 정상이면 1. ROW_COUNT : 영향받은 row 개수
        ROLLBACK;
    END IF;
    -- INSERT 구문
    insert into post(title, author_id) values('hello world', 544);
    -- INSERT가 실패했는지 확인하고 실패 시 ROLLBACK 및 오류 메시지 반환
    IF (ROW_COUNT() = 0) THEN
        ROLLBACK;
    END IF;
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;
------
-- 프로시저 호출
CALL InsertPostAndUpdateAuthor();

DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    DECLARE exit handler for SQLEXCEPTION   -- 자바의 예외처리처럼. 오류가 발생하면 여기서 처리하겠다
    BEGIN
        ROLLBACK;
    END;
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_count = post_count + 1 WHERE id = 4;
    -- INSERT 구문
    insert into post(title, author_id) values('hello world', 544);
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;