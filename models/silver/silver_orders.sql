SELECT
    id,
    to_date(created_at) as order_date,
    user_id,
    product_id,
    quantity,
    unit_price,
    {{ multiply_columns_and_round('quantity', 'unit_price') }} as order_amount
    -- quantity * unit_price as order_amount
FROM
  {{ ref('bronze_orders') }}