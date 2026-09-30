# E-Commerce Web Application

## Project Overview

This is a Full Stack Java E-Commerce Web Application developed using Java, JSP, Servlets, JDBC, MySQL, HTML, CSS, JavaScript, Maven, and Apache Tomcat.

The application provides functionality for customers to browse products, manage their shopping cart, place orders, make payment selections, view order history, and manage their profile. It also provides an admin section for managing products and orders.

## Technologies Used

* Java
* JSP (JavaServer Pages)
* Java Servlets
* JDBC
* MySQL 8.0
* HTML5
* CSS3
* JavaScript
* Apache Maven
* Apache Tomcat 10.1
* Git
* GitHub
* Visual Studio Code

## Project Structure

```text
E commerce/
│
├── .vscode/
│   └── java/
│       └── settings.json
│
├── ecommerce/
│   │
│   ├── .mvn/
│   │
│   ├── src/
│   │   └── main/
│   │       │
│   │       ├── java/
│   │       │   └── com/
│   │       │       └── ecommerce/
│   │       │           │
│   │       │           ├── AddProductServlet.java
│   │       │           ├── AdminDashboardServlet.java
│   │       │           ├── AdminOrderDetailsServlet.java
│   │       │           ├── AdminOrdersServlet.java
│   │       │           ├── AdminProductServlet.java
│   │       │           ├── AdminUpdateOrderStatusServlet.java
│   │       │           ├── BuyNowServlet.java
│   │       │           ├── CancelOrderServlet.java
│   │       │           ├── CartServlet.java
│   │       │           ├── DBConnection.java
│   │       │           ├── DeleteProductServlet.java
│   │       │           ├── EditProductServlet.java
│   │       │           ├── LoginServlet.java
│   │       │           ├── LogoutServlet.java
│   │       │           ├── MyOrdersServlet.java
│   │       │           ├── Order.java
│   │       │           ├── OrderDetailsServlet.java
│   │       │           ├── PlaceOrderServlet.java
│   │       │           ├── Product.java
│   │       │           ├── ProductDetailsServlet.java
│   │       │           ├── ProductServlet.java
│   │       │           ├── RegisterServlet.java
│   │       │           ├── Review.java
│   │       │           ├── ReviewServlet.java
│   │       │           └── UserProfileServlet.java
│   │       │
│   │       └── webapp/
│   │           │
│   │           ├── images/
│   │           ├── WEB-INF/
│   │           ├── addProduct.jsp
│   │           ├── adminDashboard.jsp
│   │           ├── adminOrderDetails.jsp
│   │           ├── adminOrders.jsp
│   │           ├── adminProducts.jsp
│   │           ├── cart.jsp
│   │           ├── checkout.jsp
│   │           ├── editProduct.jsp
│   │           ├── index.jsp
│   │           ├── login.jsp
│   │           ├── myOrders.jsp
│   │           ├── orderConfirmation.jsp
│   │           ├── orderDetails.jsp
│   │           ├── payment.jsp
│   │           ├── productDetails.jsp
│   │           ├── products.jsp
│   │           ├── profile.jsp
│   │           ├── register.jsp
│   │           └── reviews.jsp
│   │
│   ├── target/
│   │
│   ├── .gitignore
│   ├── pom.xml
│   └── README.md
│
└── ecommerce_backup/
```

> Note: The `target/` directory contains generated Maven build files and is excluded from GitHub using `.gitignore`.

## Main Features

### Customer Features

* User Registration
* User Login
* User Logout
* Product Listing
* Product Details
* Add to Cart
* Update Cart
* Remove Products from Cart
* Buy Now
* Checkout
* Payment Method Selection
* Cash on Delivery
* Order Confirmation
* View My Orders
* View Order Details
* Cancel Orders
* User Profile
* Product Reviews

### Admin Features

* Admin Login
* Admin Dashboard
* Add Products
* Edit Products
* Delete Products
* Manage Products
* View Orders
* View Order Details
* Update Order Status

## Application Flow

```text
Home
  │
  ▼
Products
  │
  ▼
Product Details
  │
  ├──────────────► Buy Now
  │
  ▼
Add to Cart
  │
  ▼
Shopping Cart
  │
  ▼
Checkout
  │
  ▼
Payment
  │
  ▼
Order Confirmation
  │
  ▼
My Orders
```

## Admin Flow

```text
Admin Login
     │
     ▼
Admin Dashboard
     │
     ├──► Manage Products
     │       ├── Add Product
     │       ├── Edit Product
     │       └── Delete Product
     │
     └──► Manage Orders
             ├── View Orders
             ├── View Order Details
             └── Update Order Status
```

## Database

The application uses MySQL for database management.

### Database Name

```text
ecommerce
```

### Main Tables

* `users`
* `products`
* `orders`
* `order_items`
* `reviews`

The database stores user information, product information, orders, order items, and product reviews.

## Database Connection

Database connection is handled through:

```text
src/main/java/com/ecommerce/DBConnection.java
```

Before running the project, configure the MySQL username, password, and database connection according to the local environment.

**Important:** Do not upload real database passwords or other sensitive credentials to a public GitHub repository.

## Requirements

To run this project locally, install:

* JDK 17 or later
* Apache Maven
* MySQL 8.0
* Apache Tomcat 10.1
* Visual Studio Code or another Java IDE

## Database Setup

Create the database in MySQL:

```sql
CREATE DATABASE ecommerce;
```

Then create the required tables using the SQL commands used for the project.

## Build the Project

Open PowerShell or a terminal inside the project folder:

```text
D:\E commerce\ecommerce
```

Run:

```bash
mvn clean package
```

After a successful build, Maven generates the WAR file inside:

```text
target/
```

The generated file is:

```text
target/ecommerce.war
```

## Deploy on Apache Tomcat

Copy the generated:

```text
ecommerce.war
```

into the Tomcat `webapps` folder.

Start Apache Tomcat and open:

```text
http://localhost:8080/ecommerce/
```

## Project Backup

A backup copy of the project is maintained separately:

```text
ecommerce_backup/
```

The backup folder is kept outside the main project files and is not required for running the application.

## Project Purpose

The purpose of this project is to demonstrate the development of a complete Full Stack Java web application with:

* Frontend development
* Java Servlet-based backend
* JSP pages
* JDBC database connectivity
* MySQL database
* User authentication
* Product management
* Shopping cart functionality
* Checkout and order processing
* Admin management
* Maven project management

## Version Control

The project is maintained using Git and hosted on GitHub.

GitHub Repository:

`https://github.com/bhavanam8277-lang/ecommer
