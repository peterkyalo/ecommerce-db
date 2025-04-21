E-Commerce Database Documentation
Overview
This database schema powers a complete e-commerce platform, supporting product catalogs, inventory management, product variations, and detailed attributes. The design follows relational database best practices with proper normalization and relationship management.


Table Reference
1. Core Product Tables
product
Stores core product information.

Fields:

product_id (PK): Unique identifier

product_name: Product display name

description: Detailed description

base_price: Base product price

brand_id (FK): Reference to brand

category_id (FK): Reference to category

created_at: Timestamp of creation

updated_at: Timestamp of last update

product_category
Product classification system supporting hierarchies.

Fields:

category_id (PK): Unique identifier

category_name: Display name

parent_category_id (FK): Self-reference for hierarchy

description: Category description

brand
Brand information for products.

Fields:

brand_id (PK): Unique identifier

brand_name: Brand display name

description: Brand description

logo_url: Path to brand logo

2. Product Media
product_image
Stores product images with display order.

Fields:

image_id (PK): Unique identifier

product_id (FK): Reference to product

image_url: Path to image

alt_text: Accessibility text

is_primary: Flag for primary image

display_order: Sorting order

3. Variation System
product_variation
Links products to their variations (color/size combinations).

Fields:

variation_id (PK): Unique identifier

product_id (FK): Reference to product

color_id (FK): Color variation

size_id (FK): Size variation

sku: Stock keeping unit

additional_price: Price modifier

color
Available color options.

Fields:

color_id (PK): Unique identifier

color_name: Display name

hex_code: Color hex value

size_option
Available size options.

Fields:

size_id (PK): Unique identifier

size_category_id (FK): Size classification

size_value: Size value (e.g., "M", "10")

description: Size description

size_category
Groups sizes into categories.

Fields:

size_category_id (PK): Unique identifier

category_name: Category name

description: Category description

4. Inventory Management
product_item
Tracks inventory for specific variations.

Fields:

item_id (PK): Unique identifier

variation_id (FK): Reference to variation

quantity_in_stock: Available quantity

barcode: Inventory barcode

5. Attribute System
product_attribute
Extended product specifications.

Fields:

attribute_id (PK): Unique identifier

product_id (FK): Reference to product

attr_category_id (FK): Attribute classification

attr_type_id (FK): Data type

attribute_name: Attribute name

attribute_value: Attribute value

display_order: Sorting order

attribute_category
Groups attributes logically.

Fields:

attr_category_id (PK): Unique identifier

category_name: Category name

description: Category description

attribute_type
Defines attribute data types.

Fields:

attr_type_id (PK): Unique identifier

type_name: Type name

description: Type description

Business Logic
Product Management Flow
Create base product record

Add product images

Define available variations (color/size)

Set inventory levels for each variation

Add technical/specification attributes

Inventory Tracking
Stock levels are maintained at the product_item level

Each variation has its own inventory count

The system prevents orders when quantity_in_stock = 0

Pricing Strategy
Base price set at product level

Variations can have price adjustments

Final price = base_price + additional_price

Sample Queries
Get all products with brand and category info

sql
SELECT 
    p.product_id,
    p.product_name,
    b.brand_name,
    pc.category_name,
    p.base_price
FROM 
    product p
JOIN 
    brand b ON p.brand_id = b.brand_id
JOIN 
    product_category pc ON p.category_id = pc.category_id;


sql
CREATE DATABASE ecommerce;
USE ecommerce;
Execute the schema creation script:

bash
mysql -u username -p ecommerce < schema.sql
Load sample data:

bash
mysql -u username -p ecommerce < sample_data.sql
Migration Guide
When making changes to the schema:

Create migration scripts:

sql
-- Example: Adding a new column
ALTER TABLE product ADD COLUMN is_featured BOOLEAN DEFAULT FALSE;
Version your schema changes

Test migrations in staging before production

API Endpoints (Example)
Endpoint	Method	Description
/products	GET	List all products
/products/{id}	GET	Get product details
/products/{id}/variations	GET	Get product variations
/inventory	GET	View inventory levels
/inventory/{id}	PUT	Update inventory
Contributing
Fork the repository

Create a feature branch

Submit a pull request

License
MIT License
