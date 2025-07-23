-- functions
-- 1. 문자열 관련 함수

select ascii('a'), char(97);

select bit_length('한글'), char_length('한글'), length('한글');

select concat('nice','to','meet','you');

select concat_ws('-','nice','to','meet','you');

select concat(cast(menu_price as char),'원')from tbl_menu;  -- 단일행 함수 

select
       elt(2, '축구', '야구', '농구')
     , field('축구', '야구', '농구', '축구')
     , FIND_IN_SET('축구', '야구,농구,축구')
     , instr('축구농구야구', '농구')
     , locate('야구', '축구농구야구');

-- field 함수를 활용한 order by
select 
       orderable_status
     , field(orderable_status,'Y', 'N') as '가능여부'
     , menu_name
  from tbl_menu 
 order by field(orderable_status, 'Y', 'N') desc;

select insert('나와라 피카츄!', 5, 3, '꼬부기');

select left('hello wordl!', 5), right('nice shot!', 5);

select lower('hello WORLD!'), upper('hello world!');

select lpad('왼쪽', 10, '#'), rpad('오른쪽', 10, '#');

select ltrim('          왼쪽'), rtrim('오른쪽            '),'오른쪽        ';

select trim('             MariaDB             ')
     , trim(both '@' from '@@@@MariaDB@@@@')
     , trim(leading '@' from '@@@@MariaDB@@@@')          -- ltrim과 동일 
     , trim(trailing '@' from '@@@@MariaDB@@@@');        -- rtrim과 동일
     
select concat('현재 잔액은 ',format(1234561234, 3),'원 입니다.');

select bin(65), oct(65), hex(59);

select repeat('재미',5);

select reverse('happy');

select replace('마리아db', '마리아', 'Maria');

select substring('열심히 db공부를 해 봅시다!',5,4)
     , substring('열심히 db공부를 해 봅시다!',11);

-- 2. 숫자 관련 함수

select abs(-123);

select ceiling(1234.56), floor(1234.56), round(1234.56);

select conv('a',16,10), conv('a',16,2);

select mod(10,3), 10%3;

select pow(3,2), sqrt(81)

select floor(rand() * 4 + 5 ), FLOOR((rand() * 4 ) + 5); 

select sign(10.1), sign(0), sign(-1.1);

select truncate(12345.12345,2), truncate(12345.12345, -2);

-- 3. 날짜 및 시간 관련 함수

select adddate('2020-02-01',interval 28 day), adddate('2020-02-01',28);
select subdate('2020-02-01',interval 1 day), subdate('2020-02-01',1);

select addtime('2020-02-21 12:02:00', '1:0:10')
     , subtime('2020-02-21 12:02:00', '1:0:10');

select curdate(), curtime(), now(), sysdate();

select year(curdate()),month(curdate()), day(curdate());
select hour(curtime()),minute(curtime()), second(curtime()), microsecond(curtime(6));