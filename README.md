# E-Commerce Web Application

## Project Overview

The **E-Commerce Web Application** is a Full Stack Java web application developed using Java, JSP, Servlets, JDBC, MySQL, HTML, CSS, JavaScript, Maven, and Apache Tomcat.

The application provides an online shopping platform where users can register, log in, browse products, view product details, add products to a shopping cart, checkout, select a payment method, place orders, view order history, cancel orders, manage their profile, and submit product reviews.

The application also includes an **Admin Dashboard** for managing products and orders.

---

## Project Objectives

The main objectives of this project are:

* To develop a complete web-based E-Commerce application.
* To implement frontend and backend integration using Java technologies.
* To connect a Java web application with a MySQL database.
* To implement user registration and authentication.
* To implement product management.
* To implement shopping cart functionality.
* To implement checkout and order processing.
* To provide administrative product and order management.
* To demonstrate JDBC database connectivity.
* To build and deploy the application using Maven and Apache Tomcat.

---

## Technologies Used

### Frontend

* HTML5
* CSS3
* JavaScript
* JSP (JavaServer Pages)

### Backend

* Java
* Java Servlets
* JDBC

### Database

* MySQL 8.0

### Build and Deployment

* Apache Maven
* Apache Tomcat 10.1

### Development and Version Control

* Visual Studio Code
* MySQL Workbench
* Git
* GitHub

---

## Main Features

### Customer Features

* User Registration
* User Login
* User Logout
* Product Listing
* Product Details
* Buy Now
* Add Products to Cart
* Update Cart
* Remove Products from Cart
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
* View Products
* Add Products
* Edit Products
* Delete Products
* Manage Products
* View Orders
* View Order Details
* Update Order Status

---

## Application Flow

```text
Home
  |
  v
Products
  |
  v
Product Details
  |
  +-------------------> Buy Now
  |
  v
Add to Cart
  |
  v
Shopping Cart
  |
  v
Checkout
  |
  v
Payment
  |
  v
Order Confirmation
  |
  v
My Orders
```

---

## Admin Flow

```text
Admin Login
     |
     v
Admin Dashboard
     |
     +----------------------+
     |                      |
     v                      v
Manage Products        Manage Orders
     |                      |
     +----+----+             +---------+
     |    |    |             |         |
     v    v    v             v         v
   Add  Edit Delete       View       Update
                          Orders      Status
```

---

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

---

## Backend Components

### User Management

* `RegisterServlet.java`
* `LoginServlet.java`
* `LogoutServlet.java`
* `UserProfileServlet.java`

### Product Management

* `AddProductServlet.java`
* `AdminProductServlet.java`
* `DeleteProductServlet.java`
* `EditProductServlet.java`
* `ProductServlet.java`
* `ProductDetailsServlet.java`
* `Product.java`

### Shopping Cart and Orders

* `CartServlet.java`
* `BuyNowServlet.java`
* `PlaceOrderServlet.java`
* `MyOrdersServlet.java`
* `OrderDetailsServlet.java`
* `CancelOrderServlet.java`
* `Order.java`

### Admin Order Management

* `AdminDashboardServlet.java`
* `AdminOrdersServlet.java`
* `AdminOrderDetailsServlet.java`
* `AdminUpdateOrderStatusServlet.java`

### Review Management

* `Review.java`
* `ReviewServlet.java`

### Database Connectivity

* `DBConnection.java`

---

## JSP Pages

### Customer Pages

* `index.jsp`
* `products.jsp`
* `productDetails.jsp`
* `login.jsp`
* `register.jsp`
* `cart.jsp`
* `checkout.jsp`
* `payment.jsp`
* `orderConfirmation.jsp`
* `myOrders.jsp`
* `orderDetails.jsp`
* `profile.jsp`
* `reviews.jsp`

### Admin Pages

* `adminDashboard.jsp`
* `adminProducts.jsp`
* `addProduct.jsp`
* `editProduct.jsp`
* `adminOrders.jsp`
* `adminOrderDetails.jsp`

---

## Database

The application uses **MySQL 8.0** as its relational database.

### Database Name

```text
ecommerce
```

### Main Tables

```text
users
products
orders
order_items
reviews
```

### Users Table

Stores customer and administrator account information.

```text
id
name
email
password
role
```

### Products Table

Stores product information.

```text
id
name
description
price
stock
image_url
active
```

### Orders Table

Stores customer order information.

```text
id
user_id
total_amount
status
order_date
```

### Order Items Table

Stores the products included in each order.

```text
id
order_id
product_id
quantity
price
```

### Reviews Table

Stores product reviews submitted by users.

---

## Database Setup

Create the database in MySQL:

```sql
CREATE DATABASE ecommerce;
```

Select the database:

```sql
USE ecommerce;
```

Create the required tables using the SQL table definitions used by the project.

---

## Database Connection

Database connectivity is handled through:

```text
src/main/java/com/ecommerce/DBConnection.java
```

The application uses JDBC to connect to the MySQL `ecommerce` database.

Before running the application on another computer, configure the database connection according to the local MySQL installation.

### Security

The GitHub repository is public, so sensitive database credentials must not be stored in the repository.

The submitted source code uses a password placeholder rather than exposing the actual MySQL password.

---

## Software Requirements

To run the project locally, install:

* JDK 17 or later
* Apache Maven
* MySQL 8.0
* MySQL Workbench
* Apache Tomcat 10.1
* Visual Studio Code
* Git

---

## Build the Project

Open PowerShell or the VS Code terminal.

Navigate to:

```text
D:\E commerce\ecommerce
```

Run:

```bash
mvn clean package
```

After a successful Maven build, the generated WAR file will be available at:

```text
target/ecommerce.war
```

---

## Deploy Using Apache Tomcat

Copy:

```text
target/ecommerce.war
```

to the Apache Tomcat `webapps` directory.

Start Apache Tomcat.

The application can then be accessed at:

```text
http://localhost:8080/ecommerce/
```

---

## Project Testing

The main customer shopping workflow has been tested:

```text
Products
   |
   v
Product Details
   |
   v
Add to Cart
   |
   v
Cart
   |
   v
Proceed to Checkout
   |
   v
Checkout
   |
   v
Proceed to Payment
   |
   v
Select Payment Method
   |
   v
Place Order
   |
   v
Order Confirmation
```

The application also supports viewing orders through the **My Orders** section.

---

## Maven Configuration

The project uses Apache Maven for project management and building.

The Maven configuration file is:

```text
pom.xml
```

The project is packaged as a:

```text
WAR
```

The generated WAR file can be deployed to Apache Tomcat.

---

## Git and GitHub

Git is used for version control and GitHub is used to host the project source code.

### GitHub Repository

**E-Commerce Full Stack Java Project**

https://github.com/bhavanam8277-lang/ecommerce-full-stack-java

The repository is public and contains the submitted project source code and project documentation.

---

## .gitignore

The project uses `.gitignore` to prevent generated and development-specific files from being committed.

The following types of files/directories are ignored:

```text
target/
*.class
.idea/
.vscode/
*.iml
```

The `target/` directory contains generated Maven build files and does not need to be stored in the source repository.

---

## Project Backup

A separate local backup is maintained in:

```text
ecommerce_backup/
```

The backup is intended for local recovery and is not required to build or run the application.

---

## Future Enhancements

Possible future enhancements include:

* Online payment gateway integration
* Product search
* Product filtering
* Product categories
* Wishlist functionality
* Password encryption improvements
* Email order notifications
* Product stock alerts
* Pagination
* Improved responsive design
* Customer support functionality
* Cloud deployment

---

## Conclusion

The E-Commerce Web Application demonstrates the development of a complete Full Stack Java web application using JSP, Servlets, JDBC, MySQL, Maven, and Apache Tomcat.

The project integrates frontend pages, Java backend processing, database connectivity, authentication, product management, shopping cart functionality, checkout, order processing, reviews, and administrative management into a single web application.

---

## GitHub Repository Link

**https://github.com/bhavanam8277-lang/ecommerce-full-stack-java**
