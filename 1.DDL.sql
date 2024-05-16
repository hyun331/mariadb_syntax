

--데이터베이스 접속
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases;

-- 스키마 생성 
--보통 명령어는 대문자. board와 같은 문자열은 소문자로
CREATE DATABASE board;

-- 스키마 삭제
drop database board;


-- 데이터베이스 선택
use board;

-- 테이블 조회
show tables;


-- 테이블 생성
-- author table 생성
CREATE TABLE author(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

-- 테이블 column 조회
describe author;
-- column 상세 조회
show full columns from author;
-- 테이블 생성 query문 조회
show create table author;

-- post table 생성
CREATE TABLE posts(
    id INT PRIMARY KEY,
    title VARCHAR(255),
    content VARCHAR(255),
    author_id INT,
    foreign key (author_id) references author(id)
);
-- 제약조건은 컬럼이 아닌 테이블 차원에서 설정하기! (컬럼 차원에서 해도 되긴 함)


-- insert into 데이터 삽입
-- 문자열은 일반적으로 ' 많이 사용
insert into 테이블명(컬럼1, 컬럼2, 컬럼3, ...) values(데이터1, 데이터2, 데이터3, ...)

-- select 데이터 조회. *은 모든 컬럼 조회
select * from 테이블명

-- posts에 데이터 삽입. id, title, content, author_id
insert into posts(id, title, content, author_id) values (1, '집', ' 집이 그리워..', 1);

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name='posts';


--내가 현재 사용하지 않은 데이터베이스에 접근하려면 ~~.~~이렇게 접근해야함. board.posts


-- 인덱스 조회 (인덱스 : 목차 페이지. 빠른 검색을 위해서)
-- pk, fk는 자동으로 인덱스로 잡힘
show index from author;
show index from posts;


-- ALTER문 : 테이블 구조 변경
-- 테이블 이름 변경
alter table posts rename post;
-- 테이블 컬럼 추가
alter table post add column teset1 varchar(255);
-- 테이블 컬럼 삭제
alter table post drop column test1;
-- 테이블 컬럼명 변경
alter table post change column content contents varchar(255);
-- 테이블 컬럼 타입과 제약조건 변경
alter table author modify column email varchar(255) not null;

-- alter문 실습
-- author 테이블에 address 컬럼 추가. varchar 255
alter table author add address varchar(255)
-- post 테이블에 title not null 제약조건 추가
alter table post modify title varchar(255) not null;
-- contents 255 -> 3000으로 변경
alter table post modify contents varchar(3000);


-- 테이블 삭제
drop table 테이블명;

-- show create table post; 사용해서 post table create문 복사해놓고 테이블 삭제해보기
CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
)


