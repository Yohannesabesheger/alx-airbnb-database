# Optimization Report

## Objective

Refactor a complex query retrieving booking, user, property, and payment details to improve performance.

## Initial Query Analysis

The initial query joins four tables (`Booking`, `User`, `Property`, and `Payment`). While functionally correct, it:

- Selects unnecessary columns (e.g., `user_id`, `property_id`, `payment_id`)
- Applies `LEFT JOIN` where it could use `INNER JOIN` for non-nullable foreign keys
- Does not prioritize join order based on selectivity

### Performance (Before Optimization)

Example output from `EXPLAIN` shows:

- Sequential scans on large tables
- Join costs accumulating to high total cost

## Refactored Query

- Removed unused columns
- Retained `LEFT JOIN` only for optional `Payment`
- Reordered joins (put most selective joins earlier)
- Ensured relevant indexes exist on `user_id`, `property_id`, `booking_id`

### Performance (After Optimization)

Using `EXPLAIN` and `EXPLAIN ANALYZE`, the refactored query shows:

- Use of `Index Scan` for `user_id` and `property_id`
- Lower startup and total cost
- Reduced rows processed

## Conclusion

The refactored query is cleaner and more efficient. Indexes and join simplification together result in significant performance improvement.
