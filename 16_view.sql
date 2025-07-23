-- view
-- 가상 테이블
-- result set을 활용한 가상의 테이블 
use menudb;
create view v_menu
as
select
       menu_name as '메뉴명'
     , menu_price as '메뉴단가'
  from tbl_menu;

select * from v_menu;

-- view는 or replace라는 옵션 덕에 매번 drop할 필요가 없다. 
-- drop view hansik;
create or replace view hansik
as
select
       menu_code as '메뉴번호'
     , menu_name as '메뉴명'
     , menu_price as '메뉴가격'
     , category_code as '카테고리코드'
     , orderable_status as '주문가능상태'
  from tbl_menu
 where category_code = 4;

select * from hansik;

-- view를 통해 특정 조건을 만족하면 베이스테이블에 영향(DML 작업)을 줄 수 있찌만 지양해야 한다.
insert
  into hansik
values
(null, '커피맛솜사탕',2000,4,'Y');

update hansik
   set 메뉴명 = '딸기맛솜사탕'
     , 메뉴가격 = 4000
 where 메뉴명 = '커피맛솜사탕';

select * from hansik;

create or replace view test_v 
as
select menu_name
     , a.category_code
  from tbl_menu a
  join tbl_category b on a.category_code = b.category_code;

select * from test_v;

-- ------------------------------------------------------------
create or replace view v_test
as
select
       avg(menu_price) + 3
  from tbl_menu;

select * from v_test;

-- view를 사용하는 목적
-- 1) DBA가 일반 백엔드 개발자 각각에게 필요한 만큼의 정보를 제공하기 위헤(접근 제어)
-- 2) 실제 비즈니스에서 사용되는 용어로 별칭을 달아 가독성 및 오해 방지를 위해
-- 3) 복잡한 db관계를 고민하지 않고 사용할 수 있게 하기 위해서
