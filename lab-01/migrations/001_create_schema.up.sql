-- 001_create_schema.up.sql
-- Створення схеми графіті-магазину: бренди, категорії, товари, постачальники, поставки, клієнти, замовлення.


CREATE TABLE brands (
    brand_id   integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    brand_name text NOT NULL
);


CREATE TABLE categories (
    category_id   integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name text NOT NULL
);


CREATE TABLE suppliers (
    supplier_id   integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_name text NOT NULL,
    contact_phone text NOT NULL
);


CREATE TABLE customers (
    customer_id   integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_name text NOT NULL,
    email         text NOT NULL UNIQUE
);


CREATE TABLE products (
    product_id     integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    article        text NOT NULL UNIQUE,
    product_name   text NOT NULL,
    price          numeric NOT NULL CHECK (price > 0),
    stock_quantity integer NOT NULL CHECK (stock_quantity >= 0),
    brand_id       integer NOT NULL REFERENCES brands (brand_id) ON DELETE RESTRICT,
    category_id    integer NOT NULL REFERENCES categories (category_id) ON DELETE RESTRICT
);


CREATE TABLE supplies (
    supply_id   integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supply_date date NOT NULL,
    supplier_id integer NOT NULL REFERENCES suppliers (supplier_id) ON DELETE RESTRICT
);


CREATE TABLE orders (
    order_id    integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ordered_at  timestamp NOT NULL,
    status      text NOT NULL CHECK (status IN ('нове', 'оплачене', 'відправлене', 'скасоване')),
    customer_id integer NOT NULL REFERENCES customers (customer_id) ON DELETE RESTRICT
);


CREATE TABLE supply_items (
    supply_item_id  integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantity        integer NOT NULL CHECK (quantity > 0),
    purchase_price  numeric NOT NULL CHECK (purchase_price > 0),
    supply_id       integer NOT NULL REFERENCES supplies (supply_id) ON DELETE CASCADE,
    product_id      integer NOT NULL REFERENCES products (product_id) ON DELETE RESTRICT
);


CREATE TABLE order_items (
    order_item_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantity      integer NOT NULL CHECK (quantity > 0),
    sale_price    numeric NOT NULL CHECK (sale_price > 0),
    order_id      integer NOT NULL REFERENCES orders (order_id) ON DELETE CASCADE,
    product_id    integer NOT NULL REFERENCES products (product_id) ON DELETE RESTRICT
);
