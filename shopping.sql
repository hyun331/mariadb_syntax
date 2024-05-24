CREATE DEFINER=`root`@`localhost` PROCEDURE `회원가입`(in email varchar(255), in name varchar(255), in pwd varchar(255), in address varchar(255), in phone varchar(255), in is_seller char(1))
BEGIN
	insert into user (email, name, pwd, address, phone, is_seller) values(email, name, pwd, address, phone, is_seller);
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `회원탈퇴`(in del_email varchar(255))
BEGIN
	update user set del_yn='Y' where email = del_email;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `회원탈퇴`(in del_email varchar(255))
BEGIN
	update user set del_yn='Y' where email = del_email;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `상품주문`(in userEmail varchar(255))
BEGIN
    declare userId int;
    select id into userId from user where email = userEmail;
    
    insert into order_total(user_id) values (userId);

END

CREATE DEFINER=`root`@`localhost` PROCEDURE `상품상세구매`(in orderId int, in productName varchar(255), in amount int)
BEGIN
	declare productId int;
	declare productStock int;
    
    select id, stock into productId, productStock from product where name = productName;
    if productStock >= amount then
		select('상품구매 성공');
		insert into order_details(order_id, product_id, product_amount) values(orderId, productId, amount);
        update product set stock = stock - amount where id = productId;
        update product set sales_volume = sales_volume + amount;
	else
		select('재고부족. 구매 실패');
	end if;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `상품전체조회`()
BEGIN
    select p.name as 상품명, p.contents as 설명, p.price as 가격, if(p.stock = 0, '매진', p.stock) as 재고, p.sales_volume as 판매량, u.name as 판매자 
    from product p inner join user u on u.id = p.seller_id
    order by p.sales_volume desc;

END

CREATE DEFINER=`root`@`localhost` PROCEDURE `주문전체조회`()
BEGIN
	select ot.id as 주문번호, u.name as 구매자, ot.order_time as 주문시각, sum(p.price*od.product_amount) as 총금액
    from order_details od inner join order_total ot on od.order_id = ot.id inner join user u on u.id = ot.user_id inner join product p on p.id = od.product_id
    group by od.order_id;

END