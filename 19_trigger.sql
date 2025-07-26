-- trigger
-- 특정 테이블 또는 데이터에 변화가 생기면 실행할 내용을 저장하는 DB의 오브젝트

use menudb;

delimiter //

create or replace trigger after_oreder_menu_insert
    after insert
    on tbl_order_menu
    for each row
begin
	update tbl_order
	   set total_order_prcie = total_order_price + new.order_amnout *
   (select menu_price from tbl_menu where menu_code = new.menu_code)
     where order_code = new.order.code; 

end //

delimiter;

-- 주문 테이블(tbl_order)에 insert 후 주문 메뉴 테이블(tbl_order_menu)에
-- 주문한 메뉴마다 insert 후 주문 테이블의 총 금액(total_order_price)을 업데이트
-- 되는지 확인하자.

-- 1. 부모테이블인 tbl_order부터 insert
insert 
  into tbl_order
(
  order_code, order_date
, order_time, total_order_price
)
VALUES (
    NULL,
    CONCAT(
        CAST(YEAR(NOW()) AS VARCHAR(4)),
        CAST(LPAD(MONTH(NOW()), 2, 0) AS VARCHAR(2)),
        CAST(LPAD(DAYOFMONTH(NOW()), 2, 0) AS VARCHAR(2))
    ),
    CONCAT(
        CAST(LPAD(HOUR(NOW()), 2, 0) AS VARCHAR(2)),'',
        CAST(LPAD(MINUTE(NOW()), 2, 0) AS VARCHAR(2)),'',
        CAST(LPAD(SECOND(NOW()), 2, 0) AS VARCHAR(2))
    ),
    0
);
desc tbl_order;

select * from tbl_order;
select * from tbl_order_menu;

-- 2. 자식테이블인 tbl_order_menu에 메뉴추가
select * from tbl_menu;
insert
  into  tbl_order_menu 
(order_code, menu_code, order_amount)
values
(1, 4, 3);

select * from tbl_menu;
insert
  into  tbl_order_menu 
(order_code, menu_code, order_amount)
values
(4, 1, 3);

-- insert만 해도 자동으로 문제없이 유도속어이 update됨 (업무 무결성 만족)
-- 입출고용 트리거 생성

-- 1. 이력 테이블(update)
create table if not exists product(
	pcode int primary key auto_increment,
	pname varchar(30),
	brand varchar(30),
	price int,
	stock int default 0,
	check(stock >= 0)
);
-- 2) 내역 테이블 (insert)
CREATE TABLE IF NOT EXISTS pro_detail (
    dcode INT PRIMARY KEY AUTO_INCREMENT,
    pcode INT,
    pdate DATE,
    amount INT,
    STATUS VARCHAR(10) CHECK(STATUS IN ('입고', '출고')),
    FOREIGN KEY (pcode) REFERENCES product
);
delimiter //

create or replace trigger trg_product_after
     after insert
     on pro_detail
     for each row
begin
	if new.status = '입고' then 
	    update product
	       set stock = stock + new.amount
	     where pcode = new.pocde;
    elseif new.status ='출고' then 
        update product
           set stock = stock = new.amount
         where pcode = new.pcode;
    end if;
end //

delimiter;

-- 1. 상품 등록(초기 수량 부여)
insert
  into product
( 
  pcode, pname, brand
, price, stock
)
values
(
  null, '갤럭시풀립', '삼송'
, 900000, 5
),
(
  null, '아이펀17', '사과'
, 1100000, 3
),
(
  null,'투명폰', '삼송'
, 2100000, 4
);

select * from product;
select * from pro_detail;

-- 2) 입고 및 출고 진행
INSERT INTO pro_detail (
    dcode, pcode, pdate,
    amount, status
)
VALUES (
    NULL, 3, CURDATE(),
    3, '출고'
);


INSERT INTO pro_detail (
    dcode, pcode, pdate,
    amount, status
)
VALUES (
    NULL, 3, CURDATE(),
    1, '입고'
);

-- insert 시 동작할 trigger -> new.컬럼명 
-- update 시 동작할 trigger -> new.컬럼명, old.컬럼명 
-- delete 시 동작할 trigger -> old.컬럼명

