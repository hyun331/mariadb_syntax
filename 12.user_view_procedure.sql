-- 0523
-- 사용자 관리 (계정 생성, 관리)

-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성. 사용자명 test1, 비번 4321
-- localhost(127.0.0.1) : 내 pc
-- % : 원격 접속. ssh를 이용하여 리눅스에 멀티 접속자. 'test1'@'%'
create user 'test1'@'localhost' identified by '4321';

-- 사용자 삭제
drop user 'test1'@'localhost';

-- 사용자에게 권한 부여 - 하나의 테이블 단위로 부여
grant select on board.author to 'test1'@'localhost';

-- test1으로 로그인 후에 검색해보기
select * from board.author;

-- 사용자 권한 회수
revoke select on board.author to 'test1'@'localhost';

-- 환경 섥정을 변경 후 확정 (일종의 commit 같은..)
flush privileges;

-- 권한 조회 
show grants for 'test1'@'localhost';

---------------------------- view -----------------------------
-- view : 별도의 테이블과 유사. 가상의 테이블. 물리적으로 저장되지 않음
-- view 생성
create view author_for_marketing_team as
select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- 사용자에게 위의 view 권한 부여
create user 'test1'@'localhost' identified by '4321'; -- 다시 생성

-- view 권한 부여
grant select on board.author_for_marketing_team to 'test1'@'localhost';
-
- 해당 사용자의 view 조회
select * from board.author_for_marketing_team;

-- view 변경(원본 대체) -> 이전 view를 고침 
create  or replace view author_for_marketing_team as 
select name, email, age , role from author;
 
-- view 삭제
drop view author_for_marketing_team;



---------------------- procedure --------------------------
-- procedure 생성 형식
DELIMITER //    -- 프로시저 시작
CREATE PROCEDURE 프로시저명()
BEGIN 
    -- 여기에 쿼리가 존재
END
// DELIMITER ; -- 프로시저 끝. 반드시 띄어쓰기 후 세미콜론

-- 생성할 땐 반드시 위의 주석 내용 빼고 작성하기
DELIMITER //   
CREATE PROCEDURE test_procedure()
BEGIN 
    SELECT 'HELLO';
END
// DELIMITER ;

-- 프로시저 호출
CALL test_procedure();

-- 프로시저 삭제
drop procedure 프로시저명;

-- 게시물 목록 조회 프로시저
DELIMITER //   
CREATE PROCEDURE 게시글목록조회()
BEGIN 
   select * from post;
END
// DELIMITER ;

 -- 게시글 1건 조회 : 정적 조회
 DELIMITER //   
CREATE PROCEDURE 게시단건조회()
BEGIN 
   select * from post where id = 1;
END
// DELIMITER ;
call 게시단건조회();

 -- 게시글 1건 조회 : 동적 조회
 -- 매개변수 in postId int -> 자료형이 int형인 postId가 in 들어온다.
 DELIMITER //   
CREATE PROCEDURE 게시단건조회(in postId int)
BEGIN 
   select * from post where id = postId;
END
// DELIMITER ;

call 게시단건조회();


-- 매개변수 여러개도 가능하다.
 DELIMITER //   
CREATE PROCEDURE 게시단건조회2(in postId int, in 제목 varchar(255))
BEGIN 
   select * from post where id = postId and title = 제목;
END
// DELIMITER ;

call 게시단건조회2(1, '집');





-- 글쓰기 procedure. title, contents, 저자 id
DELIMITER //
CREATE PROCEDURE 글쓰기(in title varchar(255), in contents varchar(3000), in author_id int)
BEGIN
    insert into post (title, contents, author_id) values(title, contents, author_id);
END
// DELIMITER ;
call board.글쓰기('프로시저', '글쓰기 프로시저입니다', 7);

-- 변수 선언
declare 변수명 자료형
-- 변수 대입
1) select 넣을값(변수명) into 변수명 from ....
2) set 변수명 = 넣을 밧

--> 글쓴이는 자신의 id를 모름. -> email을 입력받기
DELIMITER //
CREATE PROCEDURE 글쓰기2(in title varchar(255), in contents varchar(3000), in emailInput varchar(255))
BEGIN
    declare authorId int;
    select id into authorId from author where email = emailInput;
    insert into post (title, contents, author_id) values(title, contents, author_id);
END
// DELIMITER ;
call board.글쓰기2('프로시저', '글쓰기 프로시저입니다', 7);

-- sql에서 문자열 합치는 concat('hello', 'world');
-- 글 상세 조회 : input값이 postId
-- title, contents, '홍길동'+님 출력
DELIMETER //
CREATE PROCEDURE 글쓴이님출력(in postId int)
BEGIN
    select p.title, p.contents, concat(a.name, '님')
    from post p inner join author a on p.author_id = a.id
    where p.id = postId;

END
// DELIMITER ;
-- subquery
DELIMITER //
CREATE PROCEDURE 글쓴이님2출력(in postId int)
BEGIN
    declare authorName varchar(255);
    select name into authorName from author where id = (select author_id from post where id = postId);
    set authorName = concat(authorName, '님');
    select title, contents, authorNAme from post where id = postId;
END
// DELIMITER ;

-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 글을 10개 이상 100개미만이면 중수입니다.
-- 그 외는 초보입니다.
-- input값 email.
DELIMITER //
CREATE PROCEDURE 등급조회(in emailInput varchar(255))
BEGIN
    declare authorId int;
    declare count int;
    select id into authorId from author where email = emailInput;
    select count(*) into count from post where author_id = authorId;
    if count>=100 then
        select '고수입니다.';
    elseif count>=10 and count <100 then
        select '중숭입니다.';
    else
        select '초보입니다.';
    end if;
END
// DELIMITER ;

-- 반복을 통해 post 대량생성
-- 사용자가 입력한 반복 횟수에 따라 글 도배.
-- title = 안녕하세요. contents는 null
DELIMITER //
CREATE PROCEDURE 글도배(in num int)
BEGIN
    declare i int;  -- default i int default 0;
    set i = 0;
    while i < num do
        insert into post(title) values ('안녕하세요.');
        set i = i+1;
    end while;
END
// DELIMITER ;

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여(실행권한)
-- test1 사용자에게 글도배 프로시저 실행권한을 부여
grant execute on board.글도배 to 'test1'@'localhost';



