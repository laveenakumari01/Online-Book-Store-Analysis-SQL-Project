create database online_book_store;
use online_book_store;
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
select * from Books;
select * from Customers;
select * from Orders;

-- Basic queries
-- Q1 Retrive all books in the "fiction" genre
select * 
from Books 
where Genre = "Fiction";

-- Q2 find the books published after the year 1950
select * 
from Books 
where Published_Year > 1950;

-- Q3 list all the customers from the canada
select * from Customers
where Country = "Canada";

-- Q4 show orders placed in november 2023
select * from Orders
where Order_Date between '2023-11-1' and '2023-11-30';

-- Q5 Retrive the total stock of books available
select sum(Stock) as Total_Stock from Books;

-- Q6 find the detail of the most expensive book
select * from Books 
order by price DESC
limit 1;

-- Q7 Show all customers who ordered more than 1 quantity of a book
select * from Orders 
where quantity > 1;

-- Q8 Retrieve all orders where the total amount exceeds $20
select * from Orders
where Total_Amount > 20;

-- Q9 List all genres available in the Books table
select distinct Genre from Books;

-- Q10 Find the book with the lowest stock
select * from Books
order by stock ASC
limit 1;

-- Q11 Calculate the total revenue generated from all order
select sum(Total_Amount) as total_revenue from Orders;

-- advance queries
select * from Books;
select * from Customers;
select * from Orders;

-- Q1  Retrieve the total number of books sold for each genre
select b.Genre, sum(o.quantity) as total_books_sold
from Books as b
join orders as o
on b.Book_ID = o.Book_ID
group by b.Genre;

-- Q2 Find the average price of books in the "Fantasy" genre
select avg(price)
from Books 
where Genre = "Fantasy";

-- Q3 List customers who have placed at least 2 orders
select Customer_ID, count(Order_ID) as Total_Count
from Orders
group by Customer_ID
Having count(Order_ID) >= 2;

-- Q4  Find the most frequently ordered book
select Book_ID, count(Order_ID) as Order_Count
from orders
group by Book_ID
Order by Order_Count DESC
limit 1;

-- if we want the book title also which is most freQuently order then we will use join 
select o.Book_ID, b.title, count(o.Order_ID) as Order_Count
from Orders as o
join Books as b
on o.Book_ID = b.Book_ID
group by b.Book_ID, b.title
Order by Order_Count DESC
limit 1;

-- Q5 Show the top 3 most expensive books of 'Fantasy' Genre 
select * from Books
where Genre = "Fantasy"
Order by Price DESC
limit 3;

-- Q6 Retrieve the total quantity of books sold by each author
select b.author, sum(o.quantity) as total_quantity_sold
from Books as b
join Orders as o
on b.Book_ID= o.Book_ID
group by b.author;

-- Q7  List the cities where customers who spent over $300 are located
select distinct c.City, o.Total_Amount
from Orders as o
join Customers as c
on o.Customer_ID = c.Customer_ID
where o.Total_Amount > 300;

--  Find the customer who spent the most on orders
select c.Customer_ID, c.name, sum(o.Total_Amount) as Total_Spent
from Orders as o
join Customers as c
on o.Customer_ID = c.Customer_ID
group by c.Customer_ID, c.name
order by Total_Spent DESC
limit 1;

-- end of project
