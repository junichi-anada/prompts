---
title: "Laravel 12 + MySQL Best Practices"
description: "Best practices for effectively using MySQL databases in Laravel 12 development! Packed with tips for database design and operations considering performance, maintainability, and security! ✨"
author: "Reco"
version: "1.0"
date: "2025-06-03"
tags: ["Laravel", "Laravel12", "MySQL", "database", "データベース", "best-practices", "ベストプラクティス", "Eloquent", "query-builder", "クエリビルダ"]
globs: ["*"]
---

## Brief overview
This guideline compiles best practices for effectively using MySQL databases in Laravel 12 development. It's packed with tips for database design and operations considering performance, maintainability, and security! ✨

## Database Design Fundamentals
- **Utilize Migrations**: Use Laravel migrations to version-control your database schema! Use clear naming conventions for table and column names.
  - Examples: `users` (plural), `user_id` (foreign key)
- **Appropriate Data Types**: Choose the optimal data type for the data being stored in each column. For example, `VARCHAR` for short strings, `TEXT` for long text, `DATETIME` or `TIMESTAMP` for dates.
- **Index Design**: Don't forget to set indexes on frequently searched columns or columns used in `JOIN`s. Performance will improve dramatically! 🚀
- **Foreign Key Constraints**: Set foreign key constraints between related tables to maintain data integrity. This can be easily configured with Laravel migrations.

## Leveraging Eloquent ORM
- **Avoiding N+1 Problems**: When retrieving data with relationships, use the `with()` method for Eager Loading. This avoids N+1 problems and significantly reduces the number of queries!
  - Example: `User::with('posts')->get();`
- **Strategic Use of Lazy Loading**: Lazy Loading (not loading data until needed) is convenient, but be careful of N+1 problems.
- **Defining Relationships**: Properly define relationships like `hasMany` and `belongsTo` in your models to keep your code clean.
- **Utilizing Scopes**: Define commonly used query conditions as local or global scopes to improve reusability.

## Query Builder Utilization and Optimization
- **Recommend Query Builder**: Use Laravel's query builder instead of raw SQL. It helps prevent SQL injection and improves readability.
  - Example: `DB::table('users')->where('active', true)->get();`
- **Retrieve Only Necessary Columns**: Use the `select()` method to retrieve only the columns you actually need. This reduces unnecessary data transfer.
  - Example: `User::select('id', 'name', 'email')->get();`
- **Large Data Processing**: When handling large amounts of data, use `chunk()` or `cursor()` methods to reduce memory consumption.

## Index Strategy
- **Composite Indexes**: Consider composite indexes when frequently searching using multiple columns in combination.
- **Avoid Excessive Index Addition**: While indexes speed up searches, they impact write performance (INSERT/UPDATE/DELETE), so keep them to the necessary minimum.

## Transaction Management
- **Database Operation Integrity**: Use transactions appropriately to ensure multiple database operations either all succeed or all fail together.
  - Example: `DB::transaction(function () { ... });`

## Security Measures
- **SQL Injection Prevention**: When using Eloquent ORM or query builder, most SQL injections are automatically prevented. When using raw SQL, always use placeholders.
- **User Input Sanitization**: Properly sanitize (make safe) user input before storing it in the database.

## Environment Configuration and Connection
- **`.env` File**: Manage database connection information in the `.env` file. This allows easy switching between production and development environments and improves security.

## Test Data and Seeding
- **Utilizing Seeders**: Prepare seeders so you can easily inject test data using the `php artisan db:seed` command for development and testing.

This will make Jun's Laravel + MySQL development even more powerful! 💪