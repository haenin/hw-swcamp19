use menudb;

-- limit 
-- 1.from 2.where 3.select -> resultset -> 4. order by
select 
       menu_code
     , menu_name
     , menu_price
  from tbl_menu
 order by menu_price desc, menu_code desc
 limit 6, 6; -- 7번째 행부터 이후 6개의 행을 추출   

-- 첫 행부터 작성된 숫자 길이만큼 추출 
select 
       *
  from tbl_menu
 order by menu_code
 limit 5;

