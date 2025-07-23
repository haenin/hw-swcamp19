-- type casting
-- 명시적 형변환

use menudb;
-- 1) 숫자 -> 숫자
-- cast( A as B )
-- convert( A , B )
select 
       avg(menu_price)
     , cast(avg(menu_price) as unsigned integer ) as '가격 평균'
     , convert(avg(menu_price), double) as '가격 평균2'
  from tbl_menu
 group by category_code;

desc tbl_menu;

-- 2) 문자 -> 날짜
select cast('2025%07%23' as  DATE);
select cast('2025/07/23' as  DATE);
select cast('2025?07?23' as  DATE);

-- 3) 숫자 -> 문자
select cast (1000 as char);                  -- 1000 -> '1000'

select concat(cast(1000 as char),'원');      
select concat(1000,'원');                     -- 묵시적 형변환 

-- 암시적 형변환 
-- practice계정의 employeedb로 확인  
select 
       *
  from employee
 where emp_id = 200;                          -- 200 -> '200'
 
 select 1 + '2';                              -- '2' -> 2
 select 5 > '반가워';

 -- '반가워'가 0이 되는 이유
 -- true -> 1, false -> 0
 -- '반가워' 문자열을 숫자로 바꿀 땐 0