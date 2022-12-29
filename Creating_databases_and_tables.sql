-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/uk9uzU
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.






CREATE TABLE Orders (
    row_id INT  NOT NULL ,
    order_id VARCHAR(10)  NOT NULL ,
    created_at datetime  NOT NULL ,
    item_id VARCHAR(10)  NOT NULL ,
    quantity INT  NOT NULL ,
    cust_id int  NOT NULL ,
    delivery boolean  NOT NULL ,
    add_id int  NOT NULL ,
    PRIMARY KEY ( row_id )
);


CREATE TABLE customers (
    cust_id int  NOT NULL ,
    cust_firstname VARCHAR(50)  NOT NULL ,
    cust_lastname VARCHAR(50)  NOT NULL ,
    PRIMARY KEY ( cust_id )
);

CREATE TABLE address (
    add_id int  NOT NULL ,
    delivery_address VARCHAR(200)  NOT NULL ,
    delivery_zipcode VARCHAR(50)  NOT NULL ,
    PRIMARY KEY (  
    add_id )
);


CREATE TABLE item (
    item_id VARCHAR(10)  NOT NULL ,
    SKU VARCHAR(20)  NOT NULL ,
    item_name VARCHAR(100)  NOT NULL ,
    item_cat VARCHAR(100)  NOT NULL ,
    item_size VARCHAR(20)  NOT NULL ,
    item_price DECIMAL(5,2)  NOT NULL ,
    PRIMARY KEY ( item_id )
);


CREATE TABLE ingredient (
    ing_id VARCHAR(10)  NOT NULL ,
    ing_name VARCHAR(100)  NOT NULL ,
    ing_weight int  NOT NULL ,
    ing_meas VARCHAR(20)  NOT NULL ,
    ing_price DECIMAL(5,2)  NOT NULL ,
    PRIMARY KEY ( ing_id )
);

CREATE TABLE receipe(
    row_id int  NOT NULL ,
    recipe_id VARCHAR(20)  NOT NULL ,
    ing_id VARCHAR(10)  NOT NULL ,
    quantity int  NOT NULL ,
    PRIMARY KEY ( row_id)
);

CREATE TABLE inventory (
    inv_id int  NOT NULL ,
    item_id VARCHAR(10)  NOT NULL ,
    quantity int  NOT NULL ,
    PRIMARY KEY (inv_id)
);

CREATE TABLE rota (
    row_id int  NOT NULL ,
    rota_id VARCHAR(20)  NOT NULL ,
    date datetime  NOT NULL ,
    shift_id VARCHAR(20)  NOT NULL ,
    staff_id VARCHAR(20)  NOT NULL ,
    PRIMARY KEY ( row_id )
);

CREATE TABLE staff (
    staff_id VARCHAR(20)  NOT NULL ,
    first_name VARCHAR(20)  NOT NULL ,
    last_name VARCHAR(20)  NOT NULL ,
    position VARCHAR(100)  NOT NULL ,
    hourly_rate DECIMAL(5,2)  NOT NULL ,
    PRIMARY KEY ( staff_id )
);

CREATE TABLE shift (
    shift_id VARCHAR(20)  NOT NULL ,
    ay_of_week VARCHAR(20)  NOT NULL ,
    start_time time  NOT NULL ,
    end_time time  NOT NULL ,
    PRIMARY KEY ( shift_id )
);

ALTER TABLE orders ADD CONSTRAINT  FOREIGN KEY(item_id)
REFERENCES item (item_id);

ALTER TABLE Orders ADD CONSTRAINT FOREIGN KEY(cust_id)
REFERENCES customers (cust_id);

ALTER TABLE Orders ADD CONSTRAINT FOREIGN KEY(add_id)
REFERENCES address (add_id);

ALTER TABLE item ADD CONSTRAINT fk_item_SKU FOREIGN KEY(SKU)
REFERENCES receipe (recipe_id);

ALTER TABLE receipe ADD CONSTRAINT FOREIGN KEY(recipe_id)
REFERENCES ingredient (ing_id);

ALTER TABLE receipe ADD CONSTRAINT FOREIGN KEY(ing_id)
REFERENCES inventory (item_id);

ALTER TABLE rota ADD CONSTRAINT fk_rota_date FOREIGN KEY(date)
REFERENCES Orders (created_at);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `staff` (`staff_id`);

ALTER TABLE `shift` ADD CONSTRAINT `fk_shift_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `rota` (`shift_id`);

