-- procedure
-- 쿼리를 나열한 절차를 저장해서 쓰는 것
-- 기능을 정의한 것 

delimiter //                -- 문장의 끝(한 프로시저의 끝)을 지금부터 //로 하겠다.
create or replace procedure getAllEmployees()
begin
	select emp_id, emp_name, salary
	  from employee;
end // 

delimiter ;                 -- 다시 문장의 끝을 지금부터 ;로 돌려 놓겠다. 

call getAllEmployees();

-- ------------------------------------------------------------
-- in 매개변수
delimiter //

create or replace procedure getEmployessByDepartment (
    in dept char(2)
)
begin
	select emp_id, emp_name, salary, dept_code
	  from employee
	 where dept_code = dept;
end //

delimiter ;

-- 편리함 + 재사용성 측면
call getEmployessByDepartment('D5');
call getEmployessByDepartment('D6');
call getEmployessByDepartment('D2');

-- ------------------------------------------------------------
-- out 매개변수
delimiter //
create or replace procedure getEmployeeSalary(
    in id varchar(3),
   out sal integer
)
begin
	select salary into sal
	  from employee
	 where emp_id = id;
end //

delimiter ;

set @sal = 0;
call getEmployeeSalary('210',@sal);
select @sal;

-- ------------------------------------------------------------
-- inout 매개변수
delimiter //
create or replace procedure updateAndReturnSalary
    in id varchar(3),
 inout sal integer
 )
 begin
 	update employee
 	   set salary = sal
 	 where emp_id = id;

    select salary + ( salary * ifnull(bonus, 0)) into sal
      from employee
     where emp_id = id;
end //

delimiter ;

set @new_sal = 9000000
call updateAndReturnSalary('200',@new_sal);
select @new_sal;
 end
 

delimiter ;

-- @변수의 의미
-- '사용자 정의형 변수'

-- ------------------------------------------------------------
-- if-else 활용 
delimiter //

create or replace procedure checkEmployeeSalary (
    in id varchar(3),
    in threshold integer,
   out result varchar(50)
)
begin
	declare sal integer;

    select salary into sal
      from employee
     where emp_id = id;ALTER 
     
    if sal > threshold then
        set result = '기준치를 넘는 금여입니다.'
   else 
        set result = '기준치와 같거나 기준치 미만의 급여입니다.'
    end if;
end //

delimiter ;

set @result = '';
call checkEmployeeSalary('200', 10000000, @result);
select @result;

-- ------------------------------------------------------------
-- case
delimier //
create or replace procedure getDepartmentMessage(
    in id varchar(3),
   out message varchar(100)
)
begin
	declare dept varchar(50)
	   from employee
	  where emp_id = id;

    case
	    when dept = 'D1' then 
            set message = '인사관리부 직원이시군요!';
	    when dept = 'D2' then 
	        set message = '회계관리부 직원이시군요!';
        when dept = 'D3' then 
            set message = '마케팅부부 직원이시군요!';
        else
            set message = '어떤 부서 직원이신지 모르겠어요!';

    end case;
end //
delimiter;

set @message = '';
call getDepartmentMessage('211',@message);
select @message;

-- ------------------------------------------------------------
-- while 활용
delimiter //

create or replace procedure calculateSumUpTo (
    in max_sum int,
   out sum_result int
)

begin
	declare current_num int default 1;
    declare total_sum int default 0;
	
	
    while current_num <= max_num D0
        set current_num = total_sum + current_num;
        set current_num = current_num + 1;
    end while;
    
    set sum_result = total_sum;
end //

delimiter ;

set @result = 0;
call calculateSumUpTO(10,@result);
select @result;

-- ------------------------------------------------------------
-- 예외처리 
delimiter //

create or replace PROCEDURE divideNumber(
    IN numerator double,
    IN denominator double,
   OUT RESULT double
)
BEGIN 
	DECLARE division_by_zero CONDITION FOR SQLSTATE = '45000';
    DECLARE exit handler FOR divison_by_zero
    BEGIN
    	signal SQLSTATE '45000' SET message_test='0으로 나눌 수 없습니다.'
    END;
    
     IF denominator = 0 THEN
         signal division_by_zero;
     ELSE 
         SET RESULT = numerator / denominator;
     END IF;    
END //
delimiter;

-- ------------------------------------------------------------
-- stored function
delimiter //

CREATE OR replace FUNCTION getAnnualSalary(
    id varchar(3)
)
RETURNS integer
DETERMINISTIC
BEGIN
	DECLARE monthly_salary integer;
    DECLARE anuual_salary integer;

    SELECT salary INTO monthly_salary
      FROM employee
     WHERE emp_id = id;
    
    SET annual_salary = monthly_salary * 12;
    
    RETURN anuual_salary;
	
END //

delimiter ;



