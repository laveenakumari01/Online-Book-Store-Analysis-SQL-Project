# Online-Book-Store-Analysis-SQL-Project
## Project Overview
**Project Title**: Online Book Store Analysis
**Database**: Online_Book_Store
This project is a SQL-based database system designed for an online book store. It includes essential tables and queries to manage books, customers, orders, and transactions efficiently. The database is structured to support basic e-commerce functionalities such as inventory management, customer data storage, and purchase tracking.

## Objectives

To design a structured database for an online book store.
To efficiently manage book inventory, customer details, and transactions.
To enable seamless order processing and tracking.
To generate meaningful insights through SQL queries for sales analysis.

## Features

**Books Table**: Stores book details such as title, author, genre, published year, price, and stock.

**Customers Table**: Maintains customer information including name, email, phone, city, and country.
**Orders Table**: Records customer orders with order details, book purchases, and order date.
**Transactions Table**: Tracks payments made by customers.
**Queries**: Includes SQL queries for retrieving insights such as best-selling books, customer purchase history, and revenue reports.

## Project Structure
**1: Database Setup**:  The project starts by creating a database named `online_book_store`.
**Table Creation:**
- **Books**: Stores book details including `Book_ID`, `Title`, `Author`, `Genre`, `Published_Year`, `Price`, and `Stock`.
- **Customers**: Holds customer information such as `Customer_ID`, `Name`, `Email`, `Phone`, `City`, and `Country`.
- **Orders**: Records order transactions with `Order_ID`, `Customer_ID`, `Order_Date`, and `Total_Amount`.
- **Order_Details**: Contains details of each order, including `OrderDetail_ID`, `Order_ID`, `Book_ID`, `Quantity`, and `Subtotal`. 

Each table is structured with primary and foreign keys to ensure data integrity and relational consistency.
```sql
CREATE TABLE Books (
    Book_ID int PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID int PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
```
### 2. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:
1: **Q1 Retrive all books in the "fiction" genre**
```sql
select * 
from Books 
where Genre = "Fiction";
```
2: **find the books published after the year 1950**
```sql
select * 
from Books 
where Published_Year > 1950;
```
3: **Q3 list all the customers from the canada**
```sql
select * from Customers
where Country = "Canada";
```
4: **show orders placed in november 2023**
```sql
select * from Orders
where Order_Date between '2023-11-1' and '2023-11-30';
```
5: **retrive the total stock of books available**
```sql
select sum(Stock) as Total_Stock from Books;
```

 6 **find the detail of the most expensive book**
 ```sql
select * from Books 
order by price DESC
limit 1;
```
7: **Show all customers who ordered more than 1 quantity of a book**
```sql
select * from Orders 
where quantity > 1;
```

8: **Retrieve all orders where the total amount exceeds $20**
```sql
select * from Orders
where Total_Amount > 20;
```

9: **List all genres available in the Books table**
```sql
select distinct Genre from Books;
```
10: **Q10 Find the book with the lowest stock**
```sql
select * from Books
order by stock ASC
limit 1;
```

11 **Calculate the total revenue generated from all order**
```sql
select sum(Total_Amount) as total_revenue from Orders;
```
**Advnace Queries**
1: **Retrieve the total number of books sold for each genre**
```sql
select b.Genre, sum(o.quantity) as total_books_sold
from Books as b
join orders as o
on b.Book_ID = o.Book_ID
group by b.Genre;
```

2: **Find the average price of books in the "Fantasy" genre**
```sql
select avg(price)
from Books 
where Genre = "Fantasy";
```

3: **List customers who have placed at least 2 orders**
```sql
select Customer_ID, count(Order_ID) as Total_Count
from Orders
group by Customer_ID
Having count(Order_ID) >= 2;
```
4: **Find the most frequently ordered book**
```sql
select Book_ID, count(Order_ID) as Order_Count
from orders
group by Book_ID
Order by Order_Count DESC
limit 1;
```

5: **Show the top 3 most expensive books of 'Fantasy' Genre**
```sql
select * from Books
where Genre = "Fantasy"
Order by Price DESC
limit 3;
```

6: **Retrieve the total quantity of books sold by each author**
```sql
select b.author, sum(o.quantity) as total_quantity_sold
from Books as b
join Orders as o
on b.Book_ID= o.Book_ID
group by b.author;
```

7: **List the cities where customers who spent over $300 are located**
```sql
select distinct c.City, o.Total_Amount
from Orders as o
join Customers as c
on o.Customer_ID = c.Customer_ID
where o.Total_Amount > 300;
```

8: **Find the customer who spent the most on orders**
```sql
select c.Customer_ID, c.name, sum(o.Total_Amount) as Total_Spent
from Orders as o
join Customers as c
on o.Customer_ID = c.Customer_ID
group by c.Customer_ID, c.name
order by Total_Spent DESC
limit 1;
```

## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


