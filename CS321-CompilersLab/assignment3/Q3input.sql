CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO customers (id, name) VALUES (1, 'John Doe');

SELECT * FROM customers;

UPDATE customers SET name = 'Jane Doe' WHERE id = 1;

DROP TABLE customers;