/* 3)	Display the number of the customer group by their genders who have placed any 
order of amount greater than or equal to Rs.3000. */
select cus_gender, count(cus_gender) Num from `customer` a inner join `order` b on a.cus_id = b.cus_id  
where b.ord_amount >= 3000
group by cus_gender;

/* 4)	Display all the orders along with the product name ordered by a customer having Customer_Id=2.*/
select a.* , b.pro_name from `order` a, `product` b where a.PROD_ID = b.PRO_ID
and cus_id =2;

/* 5)	Display the Supplier details who can supply more than one product.*/
select * from `supplier` a where a.SUPP_ID in (select SUPP_ID from `product_details` b group by b.SUPP_ID
having count(b.SUPP_ID)>1);

/* 6)	Find the category of the product whose order amount is minimum */
select a.* from `category` a inner join `product` b on a.CAT_ID = b.CAT_ID where b.PRO_ID =
(select pro_id from `product_details` where prod_id =
(select o.prod_id from `order` o having min(o.ORD_AMOUNT)));

/* 7)	Display the Id and Name of the Product ordered after “2021-10-05”. */
select a.pro_id , a.pro_name from `product` a inner join `product_details` b on a.PRO_ID = b.PRO_ID
inner join `order` o on  o.PROD_ID = b.PROD_ID where o.ORD_DATE > "2021-10-05" order by a.pro_id;

/* 8)	Display customer name and gender whose names start or end with character 'A'. */
select a.CUS_NAME, a.CUS_GENDER from `customer` a where a.CUS_NAME like 'A%' or a.CUS_NAME like '%A';

/* 9)	Create a stored procedure to display the Rating for a Supplier if any along with the Verdict 
on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average Supplier” else 
“Supplier should not be considered”.*/
DELIMITER $$
USE `ORDER-DIRECTORY` $$
CREATE PROCEDURE PROC_1()
BEGIN
	SELECT SUPPLIER.SUPP_ID, SUPPLIER.SUPP_NAME, RATING.RAT_RATSTARS,
	CASE
		WHEN RATING.RAT_RATSTARS >4 THEN "GENUINE SUPPLIER"
		WHEN RATING.RAT_RATSTARS >2 THEN "AVERAGE SUPPLIER"
		ELSE "SUPPLIER SHOULD NOT BE CONSIDERED"
	END
    AS VERDICT FROM RATING INNER JOIN SUPPLIER ON SUPPLIER.SUPP_ID = RATING.SUPP_ID;
END $$

CALL PROC_1;




