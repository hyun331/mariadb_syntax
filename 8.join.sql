-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 체코드만 반환. on 조건을 통해 교집합 찾기
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

select a.email
from post p inner join author a on p.author_id=a.id
where date_format(p.CREATED_DATE, '%Y-%m-%d') > '2024-05-01';