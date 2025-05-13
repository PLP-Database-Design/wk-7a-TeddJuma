-- ✅ Question 1: Achieving 1NF (First Normal Form)
-- Problem: The Products column contains multiple values (comma-separated), which violates 1NF.

-- Goal: Split the Products column into separate rows so that each row contains only one product per order.

-- Step 1: Create the normalized ProductDetail_1NF table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Step 2: Insert normalized rows (manually split the products)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');



-- ✅ Question 2: Achieving 2NF (Second Normal Form)
-- Problem: The table is in 1NF but contains partial dependencies — CustomerName depends only on OrderID, not on the full composite key (OrderID, Product).

-- Goal: Separate the table into two tables:

-- One for orders (OrderID, CustomerName)

-- One for order details (OrderID, Product, Quantity)

-- Step 1: Create Orders table (removes partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Insert data into Orders table (distinct order-customer pairs)
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 3: Create OrderDetails_2NF table
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 4: Insert data into OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
