---
title: "Laravel 11 Coding Standards"
description: "Laravel 11のコーディング規約のベストプラクティスをまとめたよ！PSR-12準拠の規約から、MVCの各コンポーネント、テストまで、Laravel開発の品質を高めるためのヒントが満載だよ！"
author: "Reco"
date: "2025-06-03"
tag: ["Laravel", "Laravel11", "コーディング規約", "ベストプラクティス", "PHP", "PSR-12"]
globs: *
---
# Laravel 11 Coding Standards

## 1. General Standards

*   **PSR-12 Compliance**: Primarily adhere to [PSR-12](https://www.php-fig.org/psr/psr-12/).
*   **Naming Conventions**:
    *   Class names: `PascalCase` (e.g., `UserController`)
    *   Method names: `camelCase` (e.g., `getUserProfile`)
    *   Variable names: `camelCase` (e.g., `$userName`)
    *   Constants: `UPPER_SNAKE_CASE` (e.g., `MAX_USERS`)
    *   Table names: `snake_case` (plural, e.g., `users`)
    *   Column names: `snake_case` (e.g., `user_id`)
    *   Configuration file keys: `snake_case` (e.g., `database.default`)
*   **Indentation**: Use 4 spaces. Do not use tabs.
*   **Line Length**: Keep lines within 120 characters in principle.
*   **PHPDoc**: Write appropriate PHPDoc for classes, methods, and properties.
    *   Clearly describe `@param`, `@return`, `@throws`, etc.
*   **Type Declarations**: Actively use PHP 7.4+ type declarations (arguments, return values, properties). Use nullable types (`?Type`) appropriately.
*   **Strict Types**: Declaring `declare(strict_types=1);` at the beginning of files is recommended.

## 2. Controllers

*   **Single Responsibility Principle**: Ensure each controller method is responsible for a single action.
*   **Resource Controllers**: Actively use resource controllers for CRUD operations.
*   **Form Request**: Separate validation logic into dedicated Form Request classes (`app/Http/Requests`) instead of within controllers.
*   **Business Logic Separation**: Do not write complex business logic directly in controllers; separate it into Service classes, Action classes, etc.
*   **DI (Dependency Injection)**: Inject dependencies via constructor injection or method injection. Avoid direct use of the `app()` helper as much as possible.

## 3. Models

*   **Mass Assignment**: Properly set `$fillable` or `$guarded` properties to prevent Mass Assignment vulnerabilities. Use `$fillable` in principle.
*   **Relationships**: Actively utilize Eloquent relationships. Method names should represent the related model name in plural or singular form (e.g., `posts()`, `user()`).
*   **Scopes**: Utilize local scopes (`scopeMethodName`) and global scopes to reuse query conditions.
*   **Accessors and Mutators**: Use accessors (`getAttribute`) / mutators (`setAttribute`) for specific processing when getting/setting data. Recommend the new syntax from Laravel 9+.
*   **Date Mutators**: Cast date/time columns to `datetime`, `date`, `immutable_datetime`, etc., using the `$casts` property.

## 4. Views

*   **Blade Templates**: Maximize the use of the Blade template engine. Minimize direct embedding of PHP code (`<?php ... ?>`).
*   **Components**: Create reusable UI parts as Blade components (`app/View/Components`).
*   **Logic Separation**: Avoid complex logic within views; handle it in controllers, View Composers/View Creators, Service classes, etc.
*   **XSS Prevention**: Use Blade's double curly braces `{{ }}` to escape output. If intentionally not escaping, use `{!! !!}`, but carefully consider the necessity.
*   **Translation**: Make display strings translatable using the `__()` helper or `@lang` directive.

## 5. Routing

*   **Route Definitions**: Use separate files for different purposes, such as `routes/web.php`, `routes/api.php`.
*   **Route Names**: Assign names to routes (`->name('route.name')`) and generate URLs using the `route()` helper. Avoid hardcoding URLs.
*   **Route Groups**: Utilize route groups to share middleware, prefixes, etc.
*   **API Routes**: Define API endpoints in `routes/api.php` and apply appropriate middleware (e.g., `auth:sanctum`).

## 6. Migrations

*   **Reversibility**: Implement both `up()` and `down()` methods in migrations to maintain reversibility.
*   **Foreign Key Constraints**: Set foreign key constraints whenever possible.
*   **Column Modifications**: The `doctrine/dbal` package is required for modifying columns in existing tables.

## 7. Configuration

*   **Environment Variables**: Manage environment-dependent settings (API keys, DB connection info, etc.) in the `.env` file and load them using the `env()` helper within `config/*.php`.
*   **Default Values**: Always specify a default value for the `env()` helper (`env('KEY', 'default_value')`).
*   **Configuration Caching**: Run `php artisan config:cache` in production environments to cache configuration files.

## 8. Testing

*   **Test-Driven Development (TDD)**: Recommend TDD whenever possible.
*   **Test Types**: Appropriately use Feature Tests and Unit Tests.
*   **Database**: Use the `RefreshDatabase` trait during test execution to refresh the database after each test.
*   **Factories**: Utilize model factories for generating test data.
*   **Assertions**: Leverage the rich assertion methods provided by Laravel.

## 9. Others

*   **Helper Functions**: Global helper functions are convenient but use them sparingly as they can obscure dependencies. Consider class-based approaches where possible.
*   **Collections**: Actively utilize Laravel Collections for array manipulation.
*   **Queues**: Use Queues (`Queue`) to handle time-consuming processes or external API interactions asynchronously.
*   **Events and Listeners**: Utilize events and listeners to decouple concerns within the application.
