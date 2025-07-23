-- 계정 생성 후 데이터베이스 활용

	-- 1) 새로운 swcamp 계정 만들기
CREATE USER 'swcamp'@'%' IDENTIFIED BY 'swcamp'; -- 'localhost' 대신 '%'를 쓰면 외부 ip로 접속 가능하다.

-- 현재 존재하는 데이터베이스 확인
SHOW databases;

-- mysql 데이터베이스로 계정 정보 확인하기
USE mysql;	-- 기본적으로 제공되는 mysql database

SELECT * FROM user;	-- mysql database에서 user를 확인해 계정이 추가된 것을 확인한다.

-- 2) 데이터베이스 생성 후 계정에 권한 부여
-- 데이터베이스(스키마) 생성' 
CREATE DATABASE menudb;
-- CREATE SCHEMA menudb;

-- swcamp 계정의 권한 확인하기 
SHOW GRANTS FOR 'swcamp'@'%';

-- 왼쪽 Navigator를 새로고침해서 menudb da tabase(schema)가 추가된 것을 확인한다.
-- MySQL 또는 MariaDB는 개념적으로 database와 schema를 구분하지 않는다.
-- (CREATE DATABASE와 CREATE SCHEMA가 같은 개념이다.)

GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';	-- menudb에 대한 모든 권한 부여

-- swcamp 계정의 바뀐 권한 확인하기
SHOW GRANTS FOR 'swcamp'@'%';

use mysql;
CREATE USER 'swcamp'@'%' IDENTIFIED BY 'swcamp';

-- % -> 외부컴퓨터에서도 접속가능하게 
-- 'localhost' 대신 '%'를 쓰면 외부 ip로 접속 가능하다.
SELECT * FROM user;
CREATE DATABASE menudb;

SHOW GRANTS FOR 'swcamp'@'%';
-- menudb 데이터베이스의 모든 테이블에 대해 모든 권한을 swcamp에 부여 
GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';
SHOW GRANTS FOR 'swcamp'@'%';