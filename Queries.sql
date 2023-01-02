ALTER TABLE orders
MODIFY COLUMN delivery VARCHAR(20);

USE Pizza;

SELECT * FROM orders;

-- Data needed to get a dashboard activity
SELECT 
	o.order_id,
    i.item_price,
    o.quantity,
    i.item_cat,
    i.item_name,
    o.created_at,
    a.delivery_address,
    o.delivery
From 
	ordersx o
	LEFT JOIN item i ON o.item_id = i.item_id
    LEFT JOIN address a ON o.add_id = a.add_id;
    
    
-- Inventory Management Data
-- Calculating total quantit by ingredient ( No of orders * ingreient quantity in recipe)
-- Creating data for order quantity per pizza

SELECT 
	s1.item_name,
    s1.ing_id,
    s1.ing_name,
    s1.ing_weight,
    s1.ing_price,
    s1.order_quantity,
    s1.recipe_quantity,
    s1.order_quantity * s1.recipe_quantity as ordered_quantity,
    s1.ing_price/s1.ing_weight as unit_cost,
    (s1.order_quantity*s1.recipe_quantity) * (s1.ing_price/s1.ing_weight) as ingredient_cost
 FROM  ( SELECT
	 o.item_id,
	 i.sku,
	 i.item_name,
     r.ing_id,
     ing.ing_name,
     r.quantity AS recipe_quantity,
	SUM(o.quantity) AS order_quantity,
    ing.ing_weight,
    ing.ing_price
 FROM 
	orders o 
    LEFT JOIN item i ON o.item_id = o.item_id
    LEFT JOIN receipe r ON i.sku = r.recipe_id
    LEFT JOIN ingredient ing ON ing.ing_id = r.ing_id
GROUP BY
	o.item_id,
    i.sku,
    i.item_name,
    r.ing_id,
    r.quantity,
    ing.ing_id,
    ing.ing_weight,
    ing.ing_price ) s1
 
