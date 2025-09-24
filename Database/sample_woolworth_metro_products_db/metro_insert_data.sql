-- Disable foreign key checks to prevent issues during deletion
SET session_replication_role = 'replica';

-- Delete data from child tables first to maintain referential integrity
DELETE FROM store_products;
DELETE FROM store_categories;
DELETE FROM products;
DELETE FROM product_sub_categories;
DELETE FROM product_categories;
DELETE FROM stores;
DELETE FROM suppliers;
DELETE FROM package_types;
DELETE FROM unit_details;

-- Enable foreign key checks again
SET session_replication_role = 'origin';

-- Insert data into stores
INSERT INTO stores (store_name, store_location) VALUES
('Woolworths Metro', 'Sydney'),
;

-- Insert data into product_categories
INSERT INTO product_categories (category_name) VALUES
('Fruit & Veg'),
('Bakery'),
('Poultry, Meat & Seafood'),
('Deli & Chilled Meals'),
('Dairy, Eggs & Fridge'),
('Lunch Box'),
('Pantry'),
('International Foods'),
('Snacks & Confectionery'),
('Freezer'),
('Drinks'),
('Beer, Wine & Spirits'),
('Health & Wellness'),
('Beauty & Personal Care'),
('Baby'),
('Electronics'),
('Home & Lifestyle'),
('Pet'), 
('Cleaning & Maintenance'),
('Sports, Fitness & Outdoor Activities');

-- Insert data into product_sub_categories
INSERT INTO product_sub_categories (sub_category_name, category_id) VALUES
('Fruit', 1),  
('Vegetables', 1),  
('Salad', 1), 
('Prepared Vegetables', 1), 
('Organic', 1), 
('Fresh Herbs, Garlic & Chillies', 1), 
('Snacking', 1),
('In-Store Bakery', 2),
('Packaged Bread & Bakery', 2),
('Poultry', 3),
('Meat', 3),
('Seafood', 3), 
('BBQ Meat & Seafood', 3), 
('Deli Meats', 4),
('Ready to Eat Meals',4),
('Vegetarian & Vegan',4),
('Cheese', 5),
('Milk', 5),
('Yoghurt', 5),
('Cream, Custard & Desserts', 5),
('Eggs, Butter & Margarine', 5), 
('Dips & Pate' 5),
('Ready to Eat Meals', 5), 
('Fresh Pasta & Sauces', 5),
('Vegetarian & Vegan', 5),
('International Foods',5),
('Snacks', 6),
('Healthier Lunch Box', 6),
('Fruit & Veg', 6), 
('Drinks', 6),
('Sandwich Ingredients & Meals', 6),
('Dietary Needs', 6),
('Accessories', 6),
('Breakfast  Spreads', 7),
('Tea & Coffee', 7),
('Long Life Milk', 7), 
('Baking',7),
('Herbs & Spices', 7),
('Condiments', 7),
('Canned Food & Instant Meals', 7), 
('Pasta, Rice & Grains', 7),
('Cooking Sauces & Recipe Bases', 7),
('Oil & Vinegar', 7),
('International Foods', 7), 
('Desserts', 7),
('Hampers & Gifting',7),
('Everyday Market', 7),
('Meican', 8),
('Asian', 8),
('Indian & South Asian', 8),
('European, UK & Irish', 8),
('Kosher', 8),
('Middle Eastern', 8),
('New Zealand & South African', 8),
('Confectionery', 9),
('Gum, Mints & Lozenges', 9),
('Chips', 9),
('Snacks', 9), 
('Biscuits & Crackers', 9),
('Frozen Meals', 9),
('Frozen Gluten Free', 9),
('Chips & Wedges', 9),
('Frozen SeaFood', 9), 
('Frozen Meat', 9),
('Frozen Pizzas', 9),
('Frozen Vegetables', 9),
('Frozen Fruit', 9),
('Ice Cream', 9),
('Frozen Desserts', 9),
('Frozen Party Food', 9),
('Frozen Pies & Sausage Rolls', 9),
('Chilled Drinks', 10),
('Soft Drinks', 10),
('Cordials, Juices & Iced Teas', 10),
('Water', 10),
('Sports & Energy Drinks', 10),
('Tea', 10),
('Coffee' 10),
('Flavoured Milk', 10),
('Long Life Milk', 10),
('Home Brew', 10),
('Low & Non Alcoholic Drink' 10),
('Hampers & Gifting', 10),
('Everyday Market', 10), 
('Health Foods', 12), 
('Vitamins', 12),
('Diet & Sports Nutrition', 12),
('First Aid & Medicinal', 12),
('Everyday Market', 12),
('Shower, Bath & Body', 12), 
('Hair Care', 13), 
('Oral Care', 13), 
('Mens Care', 13), 
('Period & Continence Care', 13), 
('Skin Care', 13),
('Womens Hair Removal', 13),
('Cosmetics', 13),
('Sun Protection', 13),
('Travel Toiletries & Minis', 13),
('Health & Safety', 14),
('Nursery & Sleeping', 14),
('Baby & Toddler Clothing', 14),
('Pregnancy Care & Family Planning', 14),
('Baby Furniture', 14),
('Toys & Playtime', 14),
('Baby Travel & Accessories', 14),
('Hampers & Gifting', 14),
('Everyday Market', 14),
('Batteries & Power', 15),
('Headphones', 15),
('Computers & Tablets', 15), 
('Smart Watches & Activity Trackers', 15), 
('Gaming', 15), 
('Cameras & Drones', 15),
('Home Theatre & Entertainment', 15),
('Security & Smart Home', 15), 
('Automotive Electronics', 15), 
('Dining & Entertaining', 16), 
('Party Supplies', 16),
('Kitchenware & Storage', 16), 
('Kitchen Appliances', 16),
('Home Appliances', 16),
('Home Decor & Furniture', 16),
('Manchester & Bedding', 16),
('Bathroom Towels & Accessories', 16),
('Clothing & Accessories', 16), 
('Electronics', 16),
('Stationery & Office Supplies', 16), 
('Toys & Games', 16), 
('Books & Magazines', 16), 
('Luggage & Travel', 16), 
('Reusable Shopping Bags', 16),
('Outdoor Living', 16),
('Sport, Fitness & Outdoor Activities', 16), 
('Everyday Market', 16), 
('Cat  Kitten', 17), 
('Dog & Puppy', 17), 
('Birds, Fish & Small Pets', 17), 
('Everyday Market', 17), 
('Laundry', 18), 
('Kitchen', 18), 
('Toilet Paper, Tissues & Paper Towels', 18),
('Cleaning Goods', 18), 
('Pest Control', 18), 
('Garden & Outdoors', 18), 
('Hardware', 18),
('Cardio Machines', 19), 
('Strength Tranining & Accessories', 19), 
('Fitness Accessories', 19),
('Bat & Ball Sport', 19), 
('Cycling & Bike Accessories', 19), 
('Racquet Sports', 19),
('Water & Outdoor Sports', 19), 
('Camping', 19),
('Fishing', 19),
('Games Room', 19);  

-- Insert data into suppliers
INSERT INTO suppliers (supplier_name) VALUES
('SupplierX'),
('SupplierY'),
('SupplierZ');

-- Insert data into package_types
INSERT INTO package_types (package_type_name) VALUES
('Loose'),
('Prepack');

-- Insert data into unit_details
INSERT INTO unit_details (unit_size, unit_type_name) VALUES
(1, 'Kilograms'),  -- For loose products sold by weight
(500, 'Grams'),  -- For packaged products
(1, 'Pack');  -- For prepacked products

-- Insert data into products
INSERT INTO products (product_name, sub_category_id, supplier_id, unit_detail_id, package_type_id) VALUES
('Green Tea', 1, 1, 3, 2),  -- sub_category_id 1 = 'Tea & Coffee', supplier_id 1 = 'SupplierX', unit_detail_id 3 = '1 Pack', package_type_id 2 = 'Prepack'
('Bananas', 2, 2, 1, 1),  -- sub_category_id 2 = 'Breakfast & Spread', supplier_id 2 = 'SupplierY', unit_detail_id 1 = '1 Kilogram', package_type_id 1 = 'Loose'
('Potato Chips', 3, 3, 2, 2);  -- sub_category_id 3 = 'Chips', supplier_id 3 = 'SupplierZ', unit_detail_id 2 = '500 Grams', package_type_id 2 = 'Prepack'

-- Insert data into store_products (stores selling specific products)
INSERT INTO store_products (store_id, product_id) VALUES
(1, 1),  -- SuperMart Downtown sells Green Tea
(1, 2),  -- SuperMart Downtown sells Bananas
(2, 1),  -- SuperMart Suburbs sells Green Tea
(2, 3);  -- SuperMart Suburbs sells Potato Chips

-- Insert data into store_categories (stores with specific product categories)
INSERT INTO store_categories (store_id, category_id) VALUES
(1, 1),  -- SuperMart Downtown has Pantry
(1, 2),  -- SuperMart Downtown has Beverages
(2, 2),  -- SuperMart Suburbs has Beverages
(2, 3);  -- SuperMart Suburbs has Snacks
