-- 0522 테이블 생성하기
create table author(
    id int auto_increment,
    name varchar(255),
    email varchar(255) not null,
    create_time datetime default current_timestamp,
    primary key(id),
    unique(email)
);

create table post(
    id int auto_increment,
    title varchar(255) not null,
    contents varchar(3000),
    primary key(id)
);

-- author과 author_address는 1:1 관계 -> author_id가 unique가 되야함
create table author_address(
    id int auto_increment,
    city varchar(255),
    street varchar(255),
    author_id int not null unique,
    primary key(id),
    foreign key (author_id) references author(id) on delete cascade
);

create table author_post(
id int auto_increment,
author_id int not null,
post_id int not null,	
primary key (id),
foreign key(author_id) references author(id),
foreign key(post_id) references post(id)
);