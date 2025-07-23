-- order by (정렬)

-- 오름차순(Ascending,ASC): 1 -> 2 -> 3 -> ..., a -> b -> c
-- 내림차순(Descending,DESC)

use menudb;
select 
       menu_code
     , menu_name
     , menu_price
  from tbl_menu
--  order by menu_code desc; -- order by 절은 가장 마지막에 해석 
--  order by menu_name asc;
--  order by menu_name;		 -- asc는 생략 가능(기본이 오름차순) 
--  order by 2 desc; 		 -- 내가 작성한 쿼리 셀렉절의 두번째를 말함 (테이블 column순서가 아님)
  order by 3, 2 desc;    	 -- 1차 정렬 기준 , 2차 정렬 기준, 3차 정렬 기준 ... 
  							 -- 앞의 기준에 해당하는 컬럼 값이 같을 경우 다음 기준을 정할 수 있음 
  
-- ------------------------------------------------------------
-- 1. 빈드시 코드는 아끼지말고 변형해보자! 
-- 2. 에러를 되러 띄워보자! 
-- 3. 트러블 슈팅 -> 에러 정리 문서 
  
-- ------------------------------------------------------------

desc tbl_menu; 				 -- desc 명령어로 스키마 보기  

-- 주문 불가능한 메뉴부터 보기 
select 
       menu_name as '메뉴'  
     , orderable_status as '주문가능상태'  
  from tbl_menu
  order by 2 desc; 		     -- 별칭이 인지되고 나서 order by
  
 -- null값(비어있는 컬럼값)에 대한 정렬
 select * from tbl_category;
 
 -- 1) 오름차순 시: null이 먼저 나옴 
 select 
        *
   from tbl_category
  order by ref_category_code;
  -- 2) 내림차순 시: null이 나중에 나옴 
 select 
        *
   from tbl_category
  order by ref_category_code desc;
  -- 3) 오름차순 시: null이 나중에 나옴 
 select 
        *
   from tbl_category
  order by -ref_category_code desc; -- '-'는 반대의 의미이고 desc를 썼지만
  									-- null이 뒤에 나오는 오름차순이 된다.