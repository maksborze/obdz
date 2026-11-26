-- Перевірки обмежень схеми графіті-магазину.
-- Кожну команду виконують окремо: виділити команду разом із коментарем і виконати.
-- Кожна команда має бути відхилена СУБД, база лишається порожньою.


-- Правило 5: замовлення без клієнта не створюється (NOT NULL).
-- Очікувано: null value in column "customer_id" of relation "orders" violates not-null constraint
INSERT INTO orders (ordered_at, status, customer_id)
VALUES ('2026-11-01 12:00', 'нове', NULL);


-- Правило 7: email клієнта не повторюється (UNIQUE).
-- Очікувано: duplicate key value violates unique constraint "customers_email_key"
INSERT INTO customers (customer_name, email)
VALUES ('Олег', 'oleg@mail.com'),
       ('Іра', 'oleg@mail.com');


-- Правило 1: ціна товару більша за нуль (CHECK).
-- Очікувано: new row for relation "products" violates check constraint "products_price_check"
INSERT INTO products (article, product_name, price, stock_quantity, brand_id, category_id)
VALUES ('MTN-001', 'Montana Black', 0, 10, 1, 1);


-- Правило 8: статус замовлення з дозволеного переліку (CHECK).
-- Очікувано: new row for relation "orders" violates check constraint "orders_status_check"
INSERT INTO orders (ordered_at, status, customer_id)
VALUES ('2026-11-01 12:00', 'невідомий', 1);


-- Правило 5: замовлення посилається на існуючого клієнта (REFERENCES).
-- Очікувано: insert or update on table "orders" violates foreign key constraint "orders_customer_id_fkey"
INSERT INTO orders (ordered_at, status, customer_id)
VALUES ('2026-11-01 12:00', 'нове', 999);


-- Первинний ключ бренду не повторюється (PRIMARY KEY).
-- Очікувано: duplicate key value violates unique constraint "brands_pkey"
INSERT INTO brands (brand_id, brand_name)
OVERRIDING SYSTEM VALUE
VALUES (1, 'Montana'),
       (1, 'Molotow');
