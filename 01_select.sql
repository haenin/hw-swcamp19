use menudb;

select * from tbl_menu; -- 메뉴 조회 
select * from tbl_category;

select category_code, category_name from tbl_category;
select 
       category_code
     , category_name  -- 코딩컨벤션에 따라 콤마는 다음줄에 ...
     , ref_category_code
  from tbl_category;

-- ------------------------------------------------------------
-- from절 없는 select 해보기
select 7 + 3;
select 10 * 2;
select 6%3, 6%4; -- mod,modulus: 나누고 나머지 
select now(); -- 컴퓨터의 시스템 시간 ( 데이터베이스 서버 시스템 시간 )  
select concat('유',' ','관순'); -- concat은 하나의 문자열로 변환 

-- 문자 -> 아스키 코드(영어, 숫자, 특수기호), 유니코드(영어, 숫자, 특수기호, 그 외) 
-- 문자열('): 문자 0개 이상 

select * from tbl_menu;
select 
       concat(menu_price,'원')
  from tbl_menu;

-- 별칭(alias)
select 7+3 as '합'; -- 가독성이 좋게 하기위해 as 및 '를 붙인다. -- 10은 컬럼 값 
select 7+3 '합';
select 7+3 합;

-- 별칭에 띄어쓰기를 포함한 특수기호가 있다면 ' 생략X
select 7+1 '합  계'; 
select 7+1 '합계'; 

select
       menu_name as '메뉴명'
     , menu_price as '메뉴가격'
  from tbl_menu;

