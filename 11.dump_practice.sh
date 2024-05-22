# 0522 db migration - 실무에서 많이 사용

# local 컴퓨터의 board DB -> migration -> linux server
# 스키마 + 데이터 전체를 쿼리 형태로 뽑아냄
# create database ...
# create table author ...
# insert into .... X n번
# 위의 형식처럼 query문이 나옴. -> linux가서 적용만 하면 됨.

# 리눅스에 db 설치 -> local의 dump 작업 후 sql query 생성 -> github에 upload -> git clone -> 리눅스에서 내려받아서 해당 query 실행
# 0522 db migration - 실무에서 많이 사용











# local에서 sql 덤프파일(복사) 생성
mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql    #vscode에서 터미널에
# 위의 결과 -> dumpfile.sql 파일 생성됨. but 한글 깨짐.
# 한글 깨질 때는 아래 코드로 sql query 생성
mysqldump -uroot -p board -r dumpfile.sql

# dump file을 github에 올리기
git add .
git commit -m 'input your message'
git push origin main

# virtual box로 리눅스 접속. shinseunghyun으로 접속함.
# linux에서 mariadb download
sudo apt-get install mariadb-server
# mariadb 시작 명령어
sudo systemctl start mariadb

# mariadb 접속 명령어
sudo mariadb -u root -p
비번 입력

# 데이터베이스는 만드는 sql이 없으므로
create database board;

# exit해서 나와서 git 연동
# git download
git --version
sudo apt-get install git
# git을 통해 repository clone
git clone https://github.com/hyun331/mariadb_syntax.git
ls  #mariadb_syntax가 존재하게 됨.

# 이 파일을 board에 집에 넣는다.
cd mariadb_syntax
sudo mysql -u root -p board < dumpfile.sql

# mariadb 접속해서 확인해보기
select * from author;

## dump 완료! ##