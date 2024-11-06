# SQL_PROJECT_BEGINNER
A beginner-level SQL project repository focused on querying data using the Maven database.
# SQL Projects Using Maven Database

Welcome to my SQL projects repository focused on querying and analyzing data using the Maven database. This repository contains a series of SQL scripts designed to demonstrate essential SQL skills in real-world applications, perfect for beginners and those interested in seeing practical SQL use cases.

## Repository Overview

This repository showcases various SQL queries that perform data extraction, analysis, and reporting tasks on a fictional Maven database commonly used for teaching database concepts. Each script is documented to explain its purpose and the kind of information it retrieves or analyses.

### Projects Included

- **Customer Information Query**
  - **Script**: `customer_info.sql`
  - **Description**: Retrieves all customer information including first name, last name, email, and store ID.
  - **SQL**:
    ```sql
    SELECT first_name, last_name, email, store_id FROM customer;
    ```

- **Inventory Analysis by Store**
  - **Script**: `inventory_analysis_store1.sql` and `inventory_analysis_store2.sql`
  - **Description**: Analyzes inventory items available in each of the two stores.
  - **SQL**:
    ```sql
    -- Store 1
    SELECT store_id, COUNT(inventory_id) AS inventory_items_at_Store1 FROM inventory WHERE store_id=1 GROUP BY store_id;
    -- Store 2
    SELECT store_id, COUNT(inventory_id) AS inventory_items_at_Store2 FROM inventory WHERE store_id=2 GROUP BY store_id;
    ```

- **Active Customers Per Store**
  - **Script**: `active_customers_per_store.sql`
  - **Description**: Counts active customers for each store.
  - **SQL**:
    ```sql
    SELECT store_id, COUNT(CASE WHEN active=1 THEN customer_id ELSE NULL END) AS 'ACTIVE' FROM customer GROUP BY store_id ORDER BY store_id;
    ```

- **Total Customers**
  - **Script**: `total_customers.sql`
  - **Description**: Counts the total number of customers.
  - **SQL**:
    ```sql
    SELECT COUNT(email) FROM customer;
    ```

- **Film Inventory Analysis**
  - **Script**: `film_inventory_analysis.sql`
  - **Description**: Counts distinct films under each store's inventory.
  - **SQL**:
    ```sql
    SELECT store_id, COUNT(DISTINCT film_id) AS distinct_films_under_each_store FROM inventory GROUP BY store_id;
    ```

- **Payment Analysis**
  - **Script**: `payment_analysis.sql`
  - **Description**: Analyzes the maximum and average payment amounts.
  - **SQL**:
    ```sql
    SELECT MAX(payment) AS max_payment, AVG(payment) AS avg_payment FROM payment;
    ```

- **Rental Activity**
  - **Script**: `rental_activity.sql`
  - **Description**: Analyzes rental activity to identify frequent customers.
  - **SQL**:
    ```sql
    SELECT customer_id, COUNT(rental_id) AS rental_count FROM payment GROUP BY customer_id ORDER BY rental_count DESC;
    ```

## Getting Started

To run these scripts, you will need access to a SQL server that hosts the Maven database. Instructions for setting up the database and running each script are included within each script file as comments.

## Usage

Navigate to each script file to view detailed instructions and SQL queries. You can execute these scripts in any SQL client that connects to your Maven database setup.

## Contributing

Feedback and contributions to this repository are welcome. If you have any improvements or additional scripts that you think would benefit this project, please fork the repository, make your changes, and submit a pull request.

## License

This project is freely available for use under the MIT License. For more details, see the LICENSE file in this repository.

## Contact

If you have any inquiries or would like to connect regarding job opportunities, please reach out via:

- **Email**: mohana.gomatham@edhec.com

