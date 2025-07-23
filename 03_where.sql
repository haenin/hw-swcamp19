use menudb;
select * from tbl_category;
desc tbl_category;
select * from tbl_menu;
-- where 절
-- 테이블에 들어있는 행마다 조건을 확인(필터링)하는 절 

-- 주문 가능한 메뉴만 조회
select 
	   menu_name 
	 , orderable_status 
  from tbl_menu
--  where orderable_status = 'y'				-- 모든 행에 대해 조건 확인 -> true만 통과 
--  where orderable_status != 'n'	
  where orderable_status <> 'n'					-- <> 같지 않다 
 order by 1;
 
-- ------------------------------------------------------------
-- Q) '기타' 카테고리에 해당하지 않는 메뉴를 조회하시오.
-- H1) 카테고리 테이블을 통해 메뉴에도 있는 카테고리 코드 번호 파악 
-- H2) 메뉴조회 

select 
       *
  from tbl_category
 where category_name = '기타' ;

select 
       *
  from tbl_menu
 where category_code =10;

-- 서브 퀴리로 작성 
select 
	    *
   from tbl_menu
  where category_code = (
	  					  select category_code
						    from tbl_category
						   where category_name = '기타'
						 );

-- 5000원 이상이면서 7000원 미만인 메뉴 조회
select 
       menu_name
     , menu_price
  from tbl_menu
 where menu_price >= 5000 
   and menu_price < 7000;

-- 10000원보다 초과하거나 5000원 이하인 메뉴조회 
select 
       menu_name
     , menu_price
  from tbl_menu
 where menu_price > 10000
    or menu_price <= 5000;

-- ------------------------------------------------------------
-- between 연산자 활용하기
-- 가격이 5000원 이상이면서 9000원 이하인 메뉴 전체 컬럼 조회
desc tbl_menu;
select
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  from tbl_menu
-- where menu_price >= 5000
--   and menu_price <= 9000
 where menu_price between 5000 and 9000;    -- and이면서 이상 또는 이하로 구성되면 
                                            -- between연산자로 수정가능 
-- 만약 반대로 하고 싶다면 
 select
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  from tbl_menu
 where menu_price not between 5000 and 9000;  -- 배타적 관계 / mece하게 (중복되지 않개) 
 
-- ------------------------------------------------------------
-- like문
-- 제목, 작성자 등을 검색할 때 주로 사용
select
       *
  from tbl_menu
 where menu_name like '%밥%';                  -- % 와일드카드를 써서 like문 작성가능 

-- ------------------------------------------------------------
-- in연산자
-- 카테고리가 중식, 커피, 기타인 메뉴 조회하기
select 
       *
  from tbl_menu
 where category_code in (
                          select category_code 
                            from tbl_category 
                           where category_name in ('중식','커피', '기타') -- = 와 or이 반복될 경우 
                         );
-- ------------------------------------------------------------
-- is null 연산자 
-- 상위 카테고리를 조회
select
       *
  from tbl_category
 where ref_category_code is null;  -- 상위 카테고리를 조회 (null) 
 								   -- = null은 불가능 
 
-- 하위 카테고리를 조회 
select
       *
  from tbl_category
 where ref_category_code is not null;
 
 
 
 
 
 
 
 
 
 
 
 
 
 