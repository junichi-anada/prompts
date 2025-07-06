---
title: "Laravel Testing Guidelines"
description: "Common issues and solutions when running PHPUnit tests in Laravel projects, especially database-related problems!"
author: "Reco"
version: "1.0"
date: "2025-07-03"
tags: ["Laravel", "Testing", "PHPUnit", "Database", "SQLite", "テスティング", "データベース"]
globs: ["phpunit.xml", "tests/**/*"]
---

# 🧪 Laravel Testing Guidelines Database Edition 🧪

When writing tests in Laravel, database-related issues are quite common! 😭
Here's a guideline compiling frequent errors and their solutions. Use this as a checklist to make your future testing smoother! ✨

### 1. First, Basic Setup! Check `phpunit.xml`

Before starting tests, make sure your `phpunit.xml` settings are properly configured for "testing"!
Especially for databases, it's essential to use test-specific ones to avoid affecting production environment.

**Recommended Setup (SQLite In-Memory)**
SQLite in-memory database is simple to set up and super fast, perfect for feature tests!

```xml
// phpunit.xml

<php>
    <env name="APP_ENV" value="testing"/>
    <env name="BCRYPT_ROUNDS" value="4"/>
    <env name="CACHE_STORE" value="array"/>
    <env name="DB_CONNECTION" value="sqlite"/>
    <env name="DB_DATABASE" value=":memory:"/>
    <env name="MAIL_MAILER" value="array"/>
    <env name="QUEUE_CONNECTION" value="sync"/>
    <env name="SESSION_DRIVER" value="array"/>
</php>
```

- Set `DB_CONNECTION` to `sqlite`!
- Set `DB_DATABASE` to `:memory:`!

With these two settings, a clean database is created in memory for each test run, maintaining test independence and safety.

### 2. Common Database Errors and Solutions 🚑

#### Error 1: `could not find driver`

**Cause**: PHP cannot find the driver to connect to the specified database (e.g., `mysql`).
**Solution**:
1.  Open `phpunit.xml`.
2.  Check if `<env name="DB_CONNECTION" value="sqlite"/>` exists in the `<php>` section! Add it if missing.
3.  If this doesn't solve it, you may need to verify that PHP extensions like `php-sqlite3` or `php-mysql` are installed in your local environment.

#### Error 2: `General error: 1 no such table: ...`

**Cause**: Migrations are not running properly.
**Solution**:
1.  Verify that the `use RefreshDatabase;` trait is properly declared in your test class.
2.  If that doesn't work, check if specific migration files are causing errors by looking at the next error patterns!

#### Error 3: `General error: 1 ... after drop column: no such column: ...` (SQLite)

**Cause**: SQLite isn't as flexible as MySQL when dropping columns... Especially when trying to drop columns with unique indexes, this error occurs frequently.
**Solution**:
1.  Open the migration file causing the error.
2.  Add processing to drop related indexes **before** executing `dropColumn('column_name')`.
    ```php
    // Example: Drop unique index before deleting email column
    $table->dropUnique('users_email_unique'); // Check index name!
    $table->dropColumn('email');
    ```

#### Error 4: `General error: 1 no such function: ...` (SQLite)

**Cause**: Using MySQL-specific functions or syntax (e.g., index length specification `description(255)`) with SQLite.
**Solution**:
1.  Open the migration file causing the error.
2.  Use `DB::connection()->getDriverName()` to detect database type and branch processing.
    ```php
    if (DB::connection()->getDriverName() === 'mysql') {
        // MySQL-only processing goes here
        DB::statement('CREATE INDEX ...');
    }
    ```

#### Error 5: `General error: 1 table ... has no column named ...` (During Factory execution)

**Cause**: The data that Factory is trying to create doesn't match the actual table column structure.
**Solution**:
1.  **Check Factory definition**: Open the corresponding Factory file in `database/factories/` and verify that the `definition()` method contents match the latest table structure!
2.  **Check model's `$fillable`**: Open the corresponding model file and verify that the `$fillable` array includes the column names that Factory is trying to set.
3.  **Check authentication and relations**: When authentication information is in separate tables like `users` and `authenticates`, verify that the user creation method in test code is correct. The correct flow might be to create an `Operator` first, then create the associated `Authenticate` and pass it to `actingAs()`!

---

#### Error 6: `Permission denied` (Docker/Sail environment)

**Cause**: PHP processes in Docker containers don't have write permissions to `storage` or `bootstrap/cache` directories. This commonly occurs due to user ID mismatches between Docker host OS and containers.

**Solution**:
1.  **Identify execution user**: First, identify which user is running PHP in the container. Don't assume it's `www-data` - check with this command!
    ```bash
    docker-compose exec [service-name] ps aux
    ```
    (Laravel Sail's default service name is `laravel.test`)
    Look at the output and check the username (e.g., `sail`) running `php artisan serve`!

2.  **Change ownership**: Give the identified user ownership of the directories.
    ```bash
    docker-compose exec [service-name] chown -R [username]:[username] /var/www/html/storage /var/www/html/bootstrap/cache
    ```
    **Command example (if user is `sail`):**
    ```bash
    docker-compose exec laravel.test chown -R sail:sail /var/www/html/storage /var/www/html/bootstrap/cache
    ```
    This should enable proper file writing from within the container! ✨

---

I hope this guideline makes your testing life a little easier! 💖
Whenever new errors appear, let's keep updating these rules!
