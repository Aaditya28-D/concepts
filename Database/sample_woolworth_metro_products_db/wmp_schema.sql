-- Drop existing tables if they exist to reset the schema
DROP TABLE IF EXISTS store_products CASCADE;
DROP TABLE IF EXISTS store_categories CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS product_sub_categories CASCADE;
DROP TABLE IF EXISTS product_categories CASCADE;
DROP TABLE IF EXISTS stores CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;
DROP TABLE IF EXISTS package_types CASCADE;
DROP TABLE IF EXISTS unit_details CASCADE;

-- Create stores table
CREATE TABLE IF NOT EXISTS stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    store_location VARCHAR(255)
);

-- Create product_categories table
CREATE TABLE IF NOT EXISTS product_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

-- Create product_sub_categories table
CREATE TABLE IF NOT EXISTS product_sub_categories (
    sub_category_id SERIAL PRIMARY KEY,
    sub_category_name VARCHAR(255) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

-- Create suppliers table
CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL
);

-- Create package_types table
CREATE TABLE IF NOT EXISTS package_types (
    package_type_id SERIAL PRIMARY KEY,
    package_type_name VARCHAR(255) NOT NULL
);

-- Create unit_details table
CREATE TABLE IF NOT EXISTS unit_details (
    unit_detail_id SERIAL PRIMARY KEY,
    unit_size DECIMAL(10, 2) NOT NULL,
    unit_type_name VARCHAR(50) NOT NULL
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    sub_category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    unit_detail_id INT NOT NULL,
    package_type_id INT NOT NULL,
    FOREIGN KEY (sub_category_id) REFERENCES product_sub_categories(sub_category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (unit_detail_id) REFERENCES unit_details(unit_detail_id),
    FOREIGN KEY (package_type_id) REFERENCES package_types(package_type_id)
);

-- Create store_products table (Many-to-Many between stores and products)
CREATE TABLE IF NOT EXISTS store_products (
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create store_categories table (Many-to-Many between stores and categories)
CREATE TABLE IF NOT EXISTS store_categories (
    store_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (store_id, category_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);
