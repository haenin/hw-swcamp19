-- ------------------------------------------------------------

-- 5. check	제약조건조건식을 활용한 상세한 제약사항)
use menudb;

drop table if exists user_check;
create table if not exists user_check (
	user_no int auto_increment primary key,
	user_name varchar(255) not null,
	gender varchar(3) check(gender in ('남','여')), -- check 제약조건은 컬럼레벨도 컬럼을 작성한다. 
	age int check(age >= 19 and age <=30)
);

insert
   into user_check
values 
(null,'홍길동','남',25),
(null,'신사임당','여',23);

-- check 제약조건 위반 
insert
  into user_check
values 
(null,'김개똥','중',27);

-- ------------------------------------------------------------
-- defalt 제약조건
create table if not exists tbl_country (
    country_code int auto_increment primary key,
    country_name varchar(255) default '한국',
    population varchar(255) default '0명',
    add_day date default (current_date),
    add_time datetime default (current_time) 
 );

insert
  into tbl_country
values
(null, default, default, default, default);

SELECT * from tbl_country;

SELECT 
    TABLE_NAME as '테이블명',
    ENGINE as '엔진',
    TABLE_ROWS as '행수',
    ROUND(DATA_LENGTH/1024/1024, 2) as 'MB'
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_TYPE = 'BASE TABLE';

SELECT 
    tc.CONSTRAINT_NAME as '제약조건명',
    CONSTRAINT_TYPE as '제약조건타입',
    tc.TABLE_NAME as '테이블명',
    COLUMN_NAME as '컬럼명'
FROM information_schema.TABLE_CONSTRAINTS tc
LEFT JOIN information_schema.KEY_COLUMN_USAGE kcu 
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_SCHEMA = DATABASE()
    AND tc.TABLE_NAME = 'tbl_country'
ORDER BY tc.CONSTRAINT_TYPE, tc.CONSTRAINT_NAME;

SELECT
    tc.CONSTRAINT_NAME,
    CONSTRAINT_TYPE,
    COLUMN_NAME
FROM information_schema.TABLE_CONSTRAINTS tc
LEFT JOIN information_schema.KEY_COLUMN_USAGE kcu 
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME 
    AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA 
    AND tc.TABLE_NAME = kcu.TABLE_NAME
WHERE tc.TABLE_SCHEMA = DATABASE() 
    AND tc.TABLE_NAME = 'user_check';