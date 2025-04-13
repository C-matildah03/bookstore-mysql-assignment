
-- Create database
CREATE DATABASE IF NOT EXISTS bookstore;
USE bookstore;

-- Table: country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- Table: address_status
CREATE TABLE address_status (
    address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_description VARCHAR(100) NOT NULL
);

-- Table: address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Table: customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- Table: customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    address_status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);

-- Table: book_language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

-- Table: publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL
);

-- Table: author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- Table: book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_year YEAR,
    language_id INT,
    publisher_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Table: book_author (Many-to-Many relationship between books and authors)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Table: shipping_method
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL
);

-- Table: order_status
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_description VARCHAR(100) NOT NULL
);

-- Table: cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

-- Table: order_line
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Table: order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);



-- Insert into country
INSERT INTO country (country_name) VALUES 
('Kenya'),
('USA'),
('UK');

-- Insert into book_language
INSERT INTO book_language (language_name) VALUES 
('English'),
('Swahili'),
('French');

-- Insert into publisher
INSERT INTO publisher (publisher_name, publisher_address, publisher_contact) VALUES 
('East African Publishers', 'Nairobi, Kenya', 'info@eapub.co.ke'),
('Penguin Books', 'London, UK', 'contact@penguin.co.uk');

-- Insert into author
INSERT INTO author (first_name, last_name, biography) VALUES 
('Chinua', 'Achebe', 'Author of Things Fall Apart.'),
('Ngugi', 'wa Thiong'o', 'Kenyan writer and activist.');

-- Insert into book
INSERT INTO book (title, isbn, price, publication_year, book_language_id, publisher_id) VALUES 
('Things Fall Apart', '9780385474542', 12.99, 1958, 1, 2),
('The River Between', '9780435905484', 10.50, 1965, 1, 1);

-- Insert into book_author
INSERT INTO book_author (book_id, author_id) VALUES 
(1, 1),
(2, 2);

-- Insert into address_status
INSERT INTO address_status (status_name) VALUES 
('Current'),
('Old');

-- Insert into address
INSERT INTO address (street, city, zip_code, country_id) VALUES 
('Moi Avenue', 'Nairobi', '00100', 1),
('Baker Street', 'London', 'NW1', 3);

-- Insert into customer
INSERT INTO customer (first_name, last_name, email, phone) VALUES 
('Alice', 'Wanjiku', 'alice@example.com', '0712345678'),
('Bob', 'Smith', 'bob@example.com', '+442012345678');

-- Insert into customer_address
INSERT INTO customer_address (customer_id, address_id, address_status_id) VALUES 
(1, 1, 1),
(2, 2, 1);

-- Insert into shipping_method
INSERT INTO shipping_method (method_name) VALUES 
('Courier'),
('Postal Service');

-- Insert into order_status
INSERT INTO order_status (status_name) VALUES 
('Pending'),
('Shipped'),
('Delivered');

-- Insert into cust_order
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, order_status_id) VALUES 
(1, '2025-04-10', 1, 1),
(2, '2025-04-11', 2, 2);

-- Insert into order_line
INSERT INTO order_line (order_id, book_id, quantity, price_each) VALUES 
(1, 1, 2, 12.99),
(2, 2, 1, 10.50);

-- Insert into order_history
INSERT INTO order_history (order_id, status_id, change_date) VALUES 
(1, 1, '2025-04-10'),
(1, 2, '2025-04-11'),
(2, 2, '2025-04-11'),
(2, 3, '2025-04-12');
