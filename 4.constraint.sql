-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 컬럼타입 not null;
->alter table post modify column title varchar(255) not null;

-- auto_increment
alter table author modify id BIGINT AUTO_INCREMENT;
 alter table post modify id INT AUTO_INCREMENT;

 -- author.id에 제약조건 추가시 fk로 인해 문제 발생
 -- fk먼저 제거 이후에 author.id에 제약조건 추가
 select * from information_schema.key_column_usage where table_name='post';
 -- 삭제
 alter table post drop foreign key post_ibfk_1;

-- post table author_id bigint로 변경
 alter table post modify column author_id bigint;

 -- 제약조건 추가하기 (삭제된 제약조건 추가). 제약조건 이름은 마음대로
 alter table post add constraint post_author_fk foreign key (author_id) references author(id);

-- uuid (실무에서도 실제로 사용)
-- random으로 36자리 user_id 생성. 중복불가
alter table post add column user_id char(36) default (UUID());

-- unique 제약조건
alter table author modify column email varchar(255) unique;

-- foreign key 제약조건
-- on delete cascade -> 부모테이블의 아이디를 수정하면 수정안됨.(update는 따로 설정해줘야 함)
select * from information_schema.key_column_usage where table_name='post';
alter table post drop foreign key post_author_fk;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade on update cascade;
delete from author where id=3;
-- on delete cascade on update set null
alter table post add constraint ... foreign key(author_id) references author(id) on delete set null on update cascade;