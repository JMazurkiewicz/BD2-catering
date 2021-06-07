-- Generated by Oracle SQL Developer Data Modeler 21.1.0.092.1221
--   at:        2021-06-05 15:53:24 CEST

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

-- @TODO Indeksy, constrainty i partycje, i descriminator

CREATE TABLE additional_costs (
    additional_cost_id  NUMERIC(7) IDENTITY(1,1) NOT NULL,
    value               NUMERIC(8, 2) NOT NULL,
    cause               VARCHAR(40) NOT NULL,
    order_id			NUMERIC(32) NOT NULL
);

--COMMENT ON COLUMN additional_costs.value IS
--    '> 0';
ALTER TABLE additional_costs ADD CONSTRAINT value_is_not_zezro CHECK (value > 0);
ALTER TABLE additional_costs ADD CONSTRAINT additional_costs_pk PRIMARY KEY ( additional_cost_id );

CREATE TABLE additional_information (
    info_id      NUMERIC(3) IDENTITY(1,1) NOT NULL,
    information  VARCHAR(30) NOT NULL
);

ALTER TABLE additional_information ADD CONSTRAINT additional_information_pk PRIMARY KEY ( info_id );


ALTER TABLE additional_information ADD CONSTRAINT additional_information_information_un UNIQUE ( information );

CREATE TABLE address (
    address_id            NUMERIC(5) IDENTITY(1,1) NOT NULL,
    postal_code           VARCHAR(6 ) NOT NULL,
    street_name           VARCHAR(16) NOT NULL,
    building_number       VARCHAR(5)  NOT NULL,
    apartment_number      VARCHAR(5),
    client_id			NUMERIC(5) NOT NULL,
    city_id				NUMERIC(5) NOT NULL,
    delivery_id			NUMERIC(7) NOT NULL
);

--ALTER TABLE address ADD CONSTRAINT postal_code weryfikacja regexem;

ALTER TABLE address ADD CONSTRAINT correct_build_num CHECK( building_number > 0);

ALTER TABLE address ADD CONSTRAINT correct_apart_num CHECK( apartment_number > 0);



ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( address_id );

CREATE TABLE allergen (
    allergen_id  NUMERIC(3) IDENTITY(1,1) NOT NULL,
    name         VARCHAR(20) NOT NULL
);

ALTER TABLE allergen ADD CONSTRAINT allergen_pk PRIMARY KEY ( allergen_id );

CREATE TABLE business (
    client_id  NUMERIC(5)  NOT NULL,
    nip        VARCHAR(15) NOT NULL
);

--COMMENT ON COLUMN business.nip IS
--    'Algorytm na wiki.';

ALTER TABLE business ADD CONSTRAINT business_pk PRIMARY KEY ( client_id );

ALTER TABLE business ADD CONSTRAINT business_nip_un UNIQUE ( nip );

CREATE TABLE city (
    city_id   NUMERIC(5) IDENTITY(1,1) NOT NULL,
    name      VARCHAR(20) NOT NULL,
    district  NUMERIC(20)
);

--COMMENT ON COLUMN city.name IS
--    'Zaczyna sie wielk� liter�.';
ALTER TABLE city ADD CONSTRAINT name_start_capital CHECK(ASCII(LEFT(name, 1)) BETWEEN ASCII('A') and ASCII('Z') );

ALTER TABLE city ADD CONSTRAINT city_pk PRIMARY KEY ( city_id );

CREATE TABLE client (
    client_id NUMERIC(5) IDENTITY(1,1) NOT NULL,
	type VARCHAR(1) NOT NULL
);

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( client_id );
ALTER TABLE client ADD CONSTRAINT correct_type CHECK (type = 'P' OR type = 'B');

CREATE TABLE delivery (
    delivery_id     NUMERIC(7) IDENTITY(1,1) NOT NULL,
    cost            NUMERIC(16, 2) NOT NULL,
    delivery_hints  VARCHAR(40),
    order_id  NUMERIC(32) NOT NULL
);

--COMMENT ON COLUMN delivery.cost IS
--    '>= 0';
ALTER TABLE delivery ADD CONSTRAINT corect_cost_value CHECK( cost > 0);

ALTER TABLE delivery ADD CONSTRAINT delivery_pk PRIMARY KEY ( delivery_id );


CREATE TABLE drink_sizes (
    size_id  NUMERIC(3) IDENTITY(1,1) NOT NULL,
    size_ml  NUMERIC(5) NOT NULL
);

--COMMENT ON COLUMN drink_sizes.size_ml IS
--    '> 0';
ALTER TABLE drink_sizes ADD CONSTRAINT drink_size_is_positive CHECK ( size_ml > 0 );

ALTER TABLE drink_sizes ADD CONSTRAINT drink_sizes_pk PRIMARY KEY ( size_id );

CREATE TABLE drinks (
    item_id          NUMERIC(5) IDENTITY(1,1) NOT NULL,
    alcohol_content  NUMERIC(2)
);

--COMMENT ON COLUMN drinks.alcohol_content IS
--    '>= 0';

ALTER TABLE drinks ADD CONSTRAINT alc_cont_is_not_neg CHECK (alcohol_content >= 0)

ALTER TABLE drinks ADD CONSTRAINT drinks_pk PRIMARY KEY ( item_id );

CREATE TABLE employee (
    employee_id                     NUMERIC(8) IDENTITY(1,1) NOT NULL,
    name                            VARCHAR(32) NOT NULL,
    surname                         VARCHAR(32) NOT NULL,
    pesel                           NUMERIC(32),
    phone_number                    NUMERIC(12) NOT NULL,
    bank_account_number             NUMERIC(32, 4) NOT NULL,
    order_order_id                  NUMERIC(32, 4),
    address_id						NUMERIC(5),
    delivery_id						NUMERIC(7),
    employee_type_id				NUMERIC(4) NOT NULL
);



--COMMENT ON COLUMN employee.name IS
  --  'Zaczyna si� wielk� liter�.';


  ALTER TABLE employee ADD CONSTRAINT name_starts_capital CHECK (ASCII(LEFT(name, 1)) BETWEEN ASCII('A') and ASCII('Z'));

--COMMENT ON COLUMN employee.surname IS
  --  'Zaczyna si� wielk� liter�.';

  ALTER TABLE employee ADD CONSTRAINT surname_starts_capital CHECK (ASCII(LEFT(surname, 1)) BETWEEN ASCII('A') and ASCII('Z'));

--COMMENT ON COLUMN employee.pesel IS
--    'Weryfikacja numeru PESEL (algorytm na wikipedii).';

--COMMENT ON COLUMN employee.phone_number IS
--    'Weryfikacja regexem.';

--COMMENT ON COLUMN employee.bank_account_number IS
--    'Weryfikacja numeru konta (na wiki).';

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id );

ALTER TABLE employee ADD CONSTRAINT employee_pesel_un UNIQUE ( pesel );


ALTER TABLE employee ADD CONSTRAINT employee_bank_account_number_un UNIQUE ( bank_account_number );

ALTER TABLE employee ADD CONSTRAINT employee_phone_number_un UNIQUE ( phone_number );

CREATE TABLE employee_schedule (
    employee_schedule_id  NUMERIC(7) IDENTITY(1,1) NOT NULL,
    start_date            DATE NOT NULL,
    end_date              DATE NOT NULL,
    accepted              BIT NOT NULL,
    employee_id			  NUMERIC(8)
);

--COMMENT ON COLUMN employee_schedule.start_date IS
--    'Start_date < End_date';
ALTER TABLE employee_schedule ADD CONSTRAINT start_date_correct CHECK(start_date < end_date);
--COMMENT ON COLUMN employee_schedule.end_date IS
--    'Start_date < End_date';
ALTER TABLE employee_schedule ADD CONSTRAINT end_date_correct CHECK(start_date < end_date);

ALTER TABLE employee_schedule ADD CONSTRAINT employee_schedule_pk PRIMARY KEY ( employee_schedule_id );

CREATE TABLE employee_type (
    employee_type_id  NUMERIC(4) IDENTITY(1,1) NOT NULL,
    type_name         VARCHAR(16) NOT NULL
);

ALTER TABLE employee_type ADD CONSTRAINT employee_type_pk PRIMARY KEY ( employee_type_id );

CREATE TABLE event_type (
    event_type_id  NUMERIC(3) IDENTITY(1,1) NOT NULL,
    event_name     VARCHAR(20) NOT NULL
);

ALTER TABLE event_type ADD CONSTRAINT event_type_pk PRIMARY KEY ( event_type_id );

ALTER TABLE event_type ADD CONSTRAINT event_type_event_name_un UNIQUE ( event_name );

CREATE TABLE item_on_the_menu (
    item_id  NUMERIC(5) IDENTITY(1,1) NOT NULL,
    name     VARCHAR(20) NOT NULL,
    cost     NUMERIC(5, 2) NOT NULL,
	type	VARCHAR(1) NOT NULL
);

--COMMENT ON COLUMN item_on_the_menu.cost IS
--    '> 0';

ALTER TABLE item_on_the_menu ADD CONSTRAINT correct_type CHECK (type = 'D' OR type = 'M');

ALTER TABLE item_on_the_menu ADD CONSTRAINT cost_is_correct CHECK (cost > 0);

ALTER TABLE item_on_the_menu ADD CONSTRAINT item_on_the_menu_pk PRIMARY KEY ( item_id );

CREATE TABLE meals (
    item_id     NUMERIC(5) IDENTITY(1,1) NOT NULL,
    size_grams  NUMERIC(4) NOT NULL
);

--COMMENT ON COLUMN meals.size_grams IS
--    '> 0';
ALTER TABLE meals ADD CONSTRAINT size_is_not_negative CHECK (size_grams > 0);

ALTER TABLE meals ADD CONSTRAINT meals_pk PRIMARY KEY ( item_id );

CREATE TABLE "Order" (
    order_id                  NUMERIC(32) IDENTITY(1,1) NOT NULL,
    start_date                DATE NOT NULL,
    end_date                  DATE NOT NULL,
    number_of_people          NUMERIC(8, 2) NOT NULL,
    base_price                NUMERIC(8, 2) NOT NULL,
    waiters_needed            BIT NOT NULL,
    client_id          NUMERIC(5) NOT NULL,
    delivery_id      NUMERIC(7) NOT NULL,
    event_type_id  NUMERIC(3) NOT NULL
);

--COMMENT ON COLUMN "Order".start_date IS
--    'Start_date < End_date';
ALTER TABLE "Order" ADD CONSTRAINT  start_date_is_correct CHECK (start_date < end_date);

--COMMENT ON COLUMN "Order".end_date IS
--    'Start_date < End_date';

--COMMENT ON COLUMN "Order".number_of_people IS
--    '> 0 && < 400';
ALTER TABLE "Order" ADD CONSTRAINT num_od_ppl_is_corr CHECK ( 0 < number_of_people AND number_of_people < 400); 

--COMMENT ON COLUMN "Order".base_price IS
 --   '> 0';
 ALTER TABLE "Order" ADD CONSTRAINT base_price_is_not_negative CHECK ( base_price > 0);

ALTER TABLE "Order" ADD CONSTRAINT order_pk PRIMARY KEY ( order_id );

CREATE TABLE ordered_meals (
    ordered_meal_id           NUMERIC(7) IDENTITY(1,1) NOT NULL,
    number_of_ordered_meals   NUMERIC(8) NOT NULL,
    additional_instructions   VARCHAR(32),
    order_id            NUMERIC(32, 4) NOT NULL,
    item_id  NUMERIC(5) NOT NULL
);

--COMMENT ON COLUMN ordered_meals.number_of_ordered_meals IS
--    '> 0';

ALTER TABLE ordered_meals ADD CONSTRAINT num_of_meals_not_zero CHECK (number_of_ordered_meals > 0);

ALTER TABLE ordered_meals ADD CONSTRAINT ordered_meals_pk PRIMARY KEY ( ordered_meal_id );

CREATE TABLE person (
    client_id     NUMERIC(5)  NOT NULL,
    name          VARCHAR(25) NOT NULL,
    surname       VARCHAR(25) NOT NULL,
    phone_number  VARCHAR(15) NOT NULL,
    email         VARCHAR(40)
);
--COMMENT ON COLUMN person.name IS 
--    'Czy zaczyna si� wielk� liter�?';
ALTER TABLE person ADD CONSTRAINT name_start_with_capital CHECK(ASCII(LEFT(sname, 1)) BETWEEN ASCII('A') and ASCII('Z'))

--COMMENT ON COLUMN person.surname IS
--    'Czy zaczyna si� wielk� liter�?';
ALTER TABLE person ADD CONSTRAINT surname_start_with_capital CHECK(ASCII(LEFT(surname, 1)) BETWEEN ASCII('A') and ASCII('Z'))
--COMMENT ON COLUMN person.phone_number IS
--    'Weryfikacja regexem';

--COMMENT ON COLUMN person.email IS
--    'Weryfikacja regexem';

ALTER TABLE person ADD CONSTRAINT person_pk PRIMARY KEY ( client_id );

CREATE TABLE product (
    catalog_number                VARCHAR(20) NOT NULL,
    name                          VARCHAR(32) NOT NULL,
    wholesale_price               NUMERIC(5, 2) NOT NULL,
    batch_number  VARCHAR(15),
	type VARCHAR(1) NOT NULL
);

--COMMENT ON COLUMN product.wholesale_price IS
 --   '> 0';
ALTER TABLE product ADD CONSTRAINT price_not_zero CHECK (wholesale_price > 0);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( catalog_number );

CREATE TABLE info_about_item (
    info_id  NUMERIC(3) NOT NULL,
    item_id  NUMERIC(5) NOT NULL
);

ALTER TABLE info_about_item ADD CONSTRAINT info_about_itempk PRIMARY KEY ( info_id,
                                                                    item_id );

CREATE TABLE ingredients (
    item_id  NUMERIC(5) NOT NULL,
    product_catalog_number    VARCHAR(20) NOT NULL
);

ALTER TABLE ingredients ADD CONSTRAINT ingredients_pk PRIMARY KEY ( item_id,
                                                                    product_catalog_number );

CREATE TABLE allergens_in_product (
    allergen_id    NUMERIC(3) NOT NULL,
    product_catalog_number  VARCHAR(20) NOT NULL
);

ALTER TABLE allergens_in_product ADD CONSTRAINT allergens_in_product_pk PRIMARY KEY ( allergen_allergen_id,
                                                                    product_catalog_number );

CREATE TABLE size_of_drink (
    drink_sizes_id  NUMERIC(3) NOT NULL,
    drinks_item_id       NUMERIC(5) NOT NULL
);

ALTER TABLE size_of_drink ADD CONSTRAINT size_of_drink_pk PRIMARY KEY ( drink_sizes_id,
                                                                    drinks_item_id );

CREATE TABLE cars_for_delivery (
    delivery_id  NUMERIC(7) NOT NULL,
    vehicle_id   NUMERIC(8, 4) NOT NULL
);

ALTER TABLE cars_for_delivery ADD CONSTRAINT cars_for_delivery_pk PRIMARY KEY ( delivery_delivery_id,
                                                                  vehicles_vehicle_id );

CREATE TABLE storage (
    storage_id                    NUMERIC(2) NOT NULL,
    name                          VARCHAR(20) NOT NULL,
    stored_products_batch_number  VARCHAR(15)
);

ALTER TABLE storage ADD CONSTRAINT storage_pk PRIMARY KEY ( storage_id );

ALTER TABLE storage ADD CONSTRAINT storage_name_un UNIQUE ( name );

CREATE TABLE stored_products (
    batch_number      VARCHAR(15) NOT NULL,
    available_amount  NUMERIC(10, 2) NOT NULL,
    expiration_date   DATE NOT NULL
);

--COMMENT ON COLUMN stored_products.batch_number IS
--    'Weryfikacja regexem.';

--COMMENT ON COLUMN stored_products.available_amount IS
 --   '> 0';
 ALTER TABLE stored_products ADD CONSTRAINT available_amount_not_negative CHECK (available_amount >= 0);

ALTER TABLE stored_products ADD CONSTRAINT stored_products_pk PRIMARY KEY ( batch_number );

CREATE TABLE vehicles (
    vehicle_id  NUMERIC(8) IDENTITY(1,1) NOT NULL,
    capacity    NUMERIC(32, 4) NOT NULL,
    fuel_usage  NUMERIC(8, 4) NOT NULL
);

--COMMENT ON COLUMN vehicles.capacity IS
--    '> 0';
ALTER TABLE vehicles ADD CONSTRAINT capacity_is_not_zero CHECK (capacity > 0);

--COMMENT ON COLUMN vehicles.fuel_usage IS
--    '> 0';
ALTER TABLE vehicles ADD CONSTRAINT fuel_usage_is_not_zero CHECK (fuel_usage > 0);

ALTER TABLE vehicles ADD CONSTRAINT vehicles_pk PRIMARY KEY ( vehicle_id );

ALTER TABLE additional_costs
    ADD CONSTRAINT additional_costs_order_fk FOREIGN KEY ( order_id )
        REFERENCES "Order" ( order_id );

ALTER TABLE address
    ADD CONSTRAINT address_city_fk FOREIGN KEY ( city_id )
        REFERENCES city ( city_id );

ALTER TABLE address
    ADD CONSTRAINT address_client_fk FOREIGN KEY ( client_id )
        REFERENCES client ( client_id );

ALTER TABLE address
    ADD CONSTRAINT address_delivery_fk FOREIGN KEY ( delivery_id )
        REFERENCES delivery ( delivery_id );

ALTER TABLE business
    ADD CONSTRAINT business_client_fk FOREIGN KEY ( client_id )
        REFERENCES client ( client_id );

ALTER TABLE delivery
    ADD CONSTRAINT delivery_order_fk FOREIGN KEY ( order_id )
        REFERENCES "Order" ( order_id );

ALTER TABLE drinks
    ADD CONSTRAINT drinks_item_on_the_menu_fk FOREIGN KEY ( item_id )
        REFERENCES item_on_the_menu ( item_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_address_fk FOREIGN KEY ( address_id )
        REFERENCES address ( address_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_delivery_fk FOREIGN KEY ( delivery_id )
        REFERENCES delivery ( delivery_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_employee_type_fk FOREIGN KEY ( employee_type_id )
        REFERENCES employee_type ( employee_type_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_order_fk FOREIGN KEY ( order_id )
        REFERENCES "Order" ( order_id );

ALTER TABLE employee_schedule
    ADD CONSTRAINT employee_schedule_employee_fk FOREIGN KEY ( employee_id )
        REFERENCES employee ( employee_id );

ALTER TABLE meals
    ADD CONSTRAINT meals_item_on_the_menu_fk FOREIGN KEY ( item_id )
        REFERENCES item_on_the_menu ( item_id );

ALTER TABLE "Order"
    ADD CONSTRAINT order_client_fk FOREIGN KEY ( client_id )
        REFERENCES client ( client_id );

ALTER TABLE "Order"
    ADD CONSTRAINT order_delivery_fk FOREIGN KEY ( delivery_id )
        REFERENCES delivery ( delivery_id );

ALTER TABLE "Order"
    ADD CONSTRAINT order_event_type_fk FOREIGN KEY ( event_type_id )
        REFERENCES event_type ( event_type_id );

ALTER TABLE ordered_meals
    ADD CONSTRAINT ordered_meals_item_on_the_menu_fk FOREIGN KEY ( item_id )
        REFERENCES item_on_the_menu ( item_id );

ALTER TABLE ordered_meals
    ADD CONSTRAINT ordered_meals_order_fk FOREIGN KEY ( order_id )
        REFERENCES "Order" ( order_id );

ALTER TABLE person
    ADD CONSTRAINT person_client_fk FOREIGN KEY ( client_id )
        REFERENCES client ( client_id );

ALTER TABLE product
    ADD CONSTRAINT product_stored_products_fk FOREIGN KEY ( batch_number )
        REFERENCES stored_products ( batch_number );

ALTER TABLE info_about_item
    ADD CONSTRAINT info_about_item_additional_information_fk FOREIGN KEY ( info_id )
        REFERENCES additional_information ( info_id );

ALTER TABLE info_about_item
    ADD CONSTRAINT info_about_item_item_on_the_menu_fk FOREIGN KEY ( item_id )
        REFERENCES item_on_the_menu ( item_id );

ALTER TABLE ingredients
    ADD CONSTRAINT ingredients_item_on_the_menu_fk FOREIGN KEY (item_id )
        REFERENCES item_on_the_menu ( item_id );

ALTER TABLE ingredients
    ADD CONSTRAINT ingredients_product_fk FOREIGN KEY ( product_catalog_number )
        REFERENCES product ( catalog_number );

ALTER TABLE allergens_in_product
    ADD CONSTRAINT allergens_in_product_allergen_fk FOREIGN KEY ( allergen_id )
        REFERENCES allergen ( allergen_id );

ALTER TABLE allergens_in_product
    ADD CONSTRAINT allergens_in_product_product_fk FOREIGN KEY ( product_catalog_number )
        REFERENCES product ( catalog_number );

ALTER TABLE size_of_drink
    ADD CONSTRAINT size_of_drink_drink_sizes_fk FOREIGN KEY ( drink_sizes_id )
        REFERENCES drink_sizes ( size_id );

ALTER TABLE size_of_drink
    ADD CONSTRAINT size_of_drink_drinks_fk FOREIGN KEY ( drinks_item_id )
        REFERENCES drinks ( item_id );

ALTER TABLE cars_for_delivery
    ADD CONSTRAINT cars_for_delivery_delivery_fk FOREIGN KEY ( delivery_id )
        REFERENCES delivery ( delivery_id );

ALTER TABLE cars_for_delivery
    ADD CONSTRAINT cars_for_delivery_vehicles_fk FOREIGN KEY ( vehicle_id )
        REFERENCES vehicles ( vehicle_id );

ALTER TABLE storagei
    ADD CONSTRAINT storage_stored_products_fk FOREIGN KEY ( stored_products_batch_number )
        REFERENCES stored_products ( batch_number );


GO


CREATE OR ALTER TRIGGER check_if_drink_trigg ON item_on_the_menu
	FOR INSERT
	AS
	BEGIN
		SET NOCOUNT ON;
		INSERT INTO drinks (item_id)
		SELECT item_id
		FROM INSERTED
		WHERE type = 'D';
END;
GO

CREATE OR ALTER TRIGGER check_if_meal_trigg ON item_on_the_menu
	FOR INSERT
	AS
	BEGIN
		SET NOCOUNT ON;
		INSERT INTO meals (item_id)
		SELECT item_id
		FROM INSERTED
		WHERE type = 'M';
END;

GO

CREATE OR ALTER TRIGGER check_if_person_trigg ON client
	FOR INSERT
	AS
	BEGIN
		SET NOCOUNT ON;
		INSERT INTO person (client_id)
		SELECT client_id
		FROM INSERTED
		WHERE type = 'P';
END;

GO

CREATE OR ALTER TRIGGER check_if_business_trigg ON client
	FOR INSERT
	AS
	BEGIN
		SET NOCOUNT ON;
		INSERT INTO business(client_id)
		SELECT client_id
		FROM INSERTED
		WHERE type = 'B';
END;