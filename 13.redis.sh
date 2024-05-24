#0524
# Redis 
# https://redis.io/docs/latest/
# 키-값으로 이뤄짐 (자료구조 자체가 빠르고 인메모리이므로 빠르다)
# 인메모리(메모리에 저장함.(빠름) RDB는 디스크에 저장.(느림))
# 인증, 캐싱에서 많이 사용됨
# 동시성제어. -> 싱글 스레드

# redis 설치
sudo apt-get update
sudo apt-get install redis-server
redis-server --version

# redis접속. 
# cli : command line interface
# redis는 계정이 있을 수도 있고 없을 수도 있음
redis-cli

# redis는 0~15번까지의 database로 구성
# database 선택
# 0번이 default.
# 모든게 key와 value로 이뤄짐. table없음
select 번호

# 모든 데이터베이스 내 키를 조회
keys *

# 일반 String 자료구조
# key:value 값 세팅
# key값은 중복되면 안됨
SET key(키) value(값)
set test_key1 test_value1

# 1번 유저의 이메일은 "hongildong@naver.com"이다.
# "안붙여도 문자열
# : 는 의미를 주기 위해 사용
set user:email:1 hongildong@naver.com

# set할 때 키값이 이미 존재하면 덮어쓰기 된다.
#이러면 1의 이메일이 hongildong2@naver.com로 변경
set user:email:1 hongildong2@naver.com   

# nx 옵션 : not exist
# key가 exist하지 않은 경우에만 set
set user:email:1 hongildong3@naver.com nx

# ex (만료시간(time to live : ttl)-초단위)
# 많이 활용됨! - 임시로 잠만 값을 가지고 있을 때 사용 ex)세션
set user:email:2 hong2@naver.com ex 20

# get을 통해 value 값 얻기
get teset_key1
# 위의 결과  : "teset_value1"

# 특정키 삭제
del user:email:1

# 현재 데이터베이스 모든 key 값 삭제
flushdb

# redis 예시
# 인스타 좋아요 기능. 수많은 사람이 동시에 좋아요 눌렀는데 lock을 걸어버리면 성능저하
# 그렇다고 lock을 안걸면 동시성 문제 발생
# redis 쓰면 싱글쓰레드 + 인메모리 기반 성능 -> 동시성 이슈 피할  수 있음.

# 좋아요 기능 구현
set likes:posting:1 0   #post id 1번의 좋아요가 0개
get likes:posting:1     #"0" 문자로 나옴. but 알아서 처리해줌
# 특정 key값의 value를 1만큼 증가. incr = increment
# incr만 해도 충분함. 다들 그렇게 사용함.
incr likes:posting:1    
# decr : incr의 반대. 감소


#재고 기능 구현
set product:stock:1 100
decr product:stock:1
get product:stock:1

# incr product:stock:1 5

# bash shell을 활용하여 재고 감소 프로그램 작성