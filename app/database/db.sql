-- database creation
CREATE DATABASE inventory_management;

-- tables creation
CREATE TABLE IF NOT EXISTS category(
       id BIGSERIAL,
       name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS product(
       id BIGSERIAL,
       category_id BIGINT,
       name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS provider(
       dui VARCHAR(50),
       first_name VARCHAR(50),
       second_name VARCHAR(50),
       first_lastname VARCHAR(50),
       second_lastname VARCHAR(50),
       email VARCHAR(50),
       contact VARCHAR(50)
);

CREATE TABLE request(
       order_no VARCHAR(50),
       provider_dui VARCHAR(50),
       order_state BOOLEAN,
       order_date DATE
);

CREATE TABLE request_detail(
       id BIGSERIAL,
       product_id BIGINT,
       request_order_no VARCHAR(50),
       amount BIGINT,
       cost FLOAT
);

CREATE TABLE inventory(
       id BIGSERIAL,
       request_detail_id BIGINT,
       amount BIGINT
);

-- constraints creation
ALTER TABLE inventory DROP CONSTRAINT IF EXISTS inventory_pk;
ALTER TABLE inventory ADD CONSTRAINT inventory_pk PRIMARY KEY(id);

ALTER TABLE request_detail DROP CONSTRAINT IF EXISTS request_detail_pk;
ALTER TABLE request_detail ADD CONSTRAINT request_detail_pk PRIMARY KEY(id);

ALTER TABLE request DROP CONSTRAINT IF EXISTS request_pk;
ALTER TABLE request ADD CONSTRAINT request_pk PRIMARY KEY(order_no);

ALTER TABLE provider DROP CONSTRAINT IF EXISTS provider_pk;
ALTER TABLE provider ADD CONSTRAINT provider_pk PRIMARY KEY(dui);

ALTER TABLE product DROP CONSTRAINT IF EXISTS product_pk;
ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY(id);

ALTER TABLE category DROP CONSTRAINT IF EXISTS category_pk;
ALTER TABLE category ADD CONSTRAINT category_pk PRIMARY KEY(id);


ALTER TABLE inventory DROP CONSTRAINT IF EXISTS inventory_request_detail_fk;
ALTER TABLE inventory ADD CONSTRAINT inventory_request_detail_fk FOREIGN KEY(request_detail_id) REFERENCES request_detail(id) ON DELETE CASCADE;

ALTER TABLE request_detail DROP CONSTRAINT IF EXISTS request_detail_product_fk;
ALTER TABLE request_detail ADD CONSTRAINT request_detail_product_fk FOREIGN KEY(product_id) REFERENCES product(id) ON DELETE CASCADE;

ALTER TABLE request_detail DROP CONSTRAINT IF EXISTS request_detail_request_fk;
ALTER TABLE request_detail ADD CONSTRAINT request_detail_request_fk FOREIGN KEY(request_order_no) REFERENCES request(order_no) ON DELETE CASCADE;

ALTER TABLE request DROP CONSTRAINT IF EXISTS request_provider_fk;
ALTER TABLE request ADD CONSTRAINT request_provider_fk FOREIGN KEY(provider_dui) REFERENCES provider(dui) ON DELETE CASCADE;

ALTER TABLE product DROP CONSTRAINT IF EXISTS product_category_fk;
ALTER TABLE product ADD CONSTRAINT product_category_fk FOREIGN KEY(category_id) REFERENCES category(id) ON DELETE CASCADE;
