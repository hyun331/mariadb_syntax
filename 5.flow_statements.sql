-- 0520

-- 흐름제어 : case문
select column1, column2, ....
case column4    --column4가
    when [비교값1] then 결과값 1    -- 비교값 1이라면 결과값 1을 출력
    when [비교값2] then 결과값 2
    else 결과값 3
end
from table_name;

-- post table에서 1번 user는 first author, 2번 user는 second author로 출력한다면?
select id, title, contents,
case author_id
    when 1 then 'first author'
    when 2 then 'second author'
    else 'others'
end
from post;

-- author_id가 있으면 그대로 출력. 없으면 '익명 사용자'로 출력되도록
select id, title, contents,
case
	when author_id is NULL then '익명사용자'
    else author_id
end as author_id
from post;

-- 위의 문제를 IFNULL로 변환해보기
select id, title, contents, IFNULL(author_id, '익명사용자') as author_id
from post;

-- IF로 변환해보기
select id, title, contents, if(author_id is null, '익명사용자', author_id) as author_id
from post;

-- 조건에 부합하는 중고거래 상태 조회하기
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE, 
CASE STATUS
    WHEN 'SALE' THEN '판매중'
    WHEN 'RESERVED' THEN '예약중'
    WHEN 'DONE' THEN '거래완료'
END
FROM USED_GOODS_BOARD 
WHERE DATE_FORMAT(CREATED_DATE, '%Y-%m-%d') = '2022-10-05'
ORDER BY BOARD_ID DESC;

-- 조건에 부합하는 중고거래 댓글 조회하기
SELECT B.TITLE, B.BOARD_ID, R.REPLY_ID, R.WRITER_ID, R.CONTENTS, DATE_FORMAT(R.CREATED_DATE, '%Y-%m-%d') AS CREATED_DATE
from USED_GOODS_BOARD AS B, USED_GOODS_REPLY AS R
where date_format(B.CREATED_DATE, '%Y-%m') = '2022-10' AND B.BOARD_ID = R.BOARD_ID
order by R.CREATED_DATE, B.TITLE;


-- 12세 이하인 여자 환자 목록 출력하기
SELECT PT_NAME, PT_NO, GEND_CD, AGE, 
CASE 
    WHEN TLNO IS NULL THEN 'NONE'
    ELSE TLNO
END AS TLNO
FROM PATIENT 
WHERE AGE <= 12 AND GEND_CD = 'W'
ORDER BY AGE DESC, PT_NAME;
-- IF문 사용
SELECT PT_NAME, PT_NO, GEND_CD, AGE, IF(TLNO IS NULL, 'NONE', TLNO) AS TLNO