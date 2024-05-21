-- dirty read 실습
-- 워크벤치(하나의 사용자로 생각하기)에서 auto_commit을 해제 후 update 실행 -> commit이 안된상태
-- 터미널에서 select 했을 때 위 변경사항이 변경됐는지 확인하기 -> 변경 안됨. -> dirty read가 발생하지 않음. 격리성 높음.
-- 자신의 트랜잭션에는 임시저장되지만 다른 트랜잭션에는 없음


-- phantom read 동시성 이슈 실습
-- 워크벤치에서 시간을 두고 두번의 select 실행.
-- 터미널에서 중간에 insert 실행. -> 두번의 select결과가 동일하면 repeatable read 수준
START TRANSACTION
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
-- 터미널에서 insert into author(name, email) values('transaction test','transaction');


-- lost update 이슈를 해겨라기위한 공유락(shared lock)
-- 워크벤치에서 아래 코드 실행
start transaction;
select post_count from author where id = 4 lock in share mode;
do sleep(15);
select post_count from author where id = 4 lock in share mode;
commit;
-- 아래는 터미널
select  post_count from author where id = 4 lock in share mode;
update author set post_count = 0 where id =4;

-- 배타적 잠금(exclusive lock) : select for update
-- select부터 lock
start transaction;
select post_count from author where id = 4 for update;
do sleep(15);
select post_count from author where id = 4 for update;
commit;
-- 아래는 터미널
select  post_count from author where id = 4 for update;
update author set post_count = 0 where id =4;

