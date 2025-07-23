use menudb;
select * from tbl_menu;
-- distinct
-- 중복을 제거해 종류를 알고자 할 때(그룹핑)
-- distinct를 쓸 때는 추출할 칼럼을 잘 고려해야 한다. 
-- (일반적으로 하나의 컬럼을 쓸 것)

-- 메뉴가 할당된 카테고리를 조회
select
       distinct category_code
  from tbl_menu;

-- 해당 카테고리들의 이름을 조회(in 연산자를 활용)
select 
       category_name, category_code
  from tbl_category
 where category_code in ( 
 						  select distinct category_code 
                            from tbl_menu
						 );

-- ------------------------------------------------------------
-- 다중열 distinct 
-- 컬럼이 두개 이상일 경우 한데 묶어 하나의 개념으로 보고 중복체크 함 

-- 같은 카테고리와 주문가능 상태를 가지는 메뉴들의 종류(그룹)
select
       distinct
       category_code
     , orderable_status
   from tbl_menu;
