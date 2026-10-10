# Data Dictionary

## Project: E-Commerce Business Intelligence & Customer Analytics

This document describes the principal tables and fields used in the project. Data types are indicative and should be confirmed against the final PostgreSQL schema.

## 1. `orders_clean`

**Grain:** One record per order.

| Column | Description |
|---|---|
| `order_id` | Unique order identifier |
| `order_date` | Date the order was placed |
| `order_time` | Time the order was placed |
| `order_status` | Current order status |
| `sales_channel` | Channel through which the order was placed |
| `customer_id` | Customer identifier |
| `customer_name` | Customer name |
| `customer_age` | Customer age |
| `gender` | Customer gender category |
| `customer_segment` | Business-defined customer segment |
| `customer_type` | Customer classification, such as New, Returning, or Loyal |
| `customer_city` | Customer city |
| `customer_state` | Customer state |
| `customer_country` | Customer country |
| `region` | Geographic region |
| `customer_postal_code` | Customer postal code |
| `payment_method` | Payment method |
| `payment_status` | Payment status |
| `currency` | Currency associated with the transaction |
| `shipping_method` | Shipping method |
| `warehouse` | Warehouse associated with the order |
| `delivery_days` | Actual delivery duration, where available |
| `estimated_delivery_days` | Estimated delivery duration |
| `delivery_status` | Delivery status |
| `return_status` | Return status |
| `return_reason` | Recorded return reason |
| `customer_rating` | Customer rating, where available |
| `review_sentiment` | Review sentiment category |
| `customer_review` | Customer review text |
| `marketing_channel` | Marketing channel attributed to the order |
| `loyalty_points_earned` | Loyalty points earned |
| `loyalty_points_redeemed` | Loyalty points redeemed |
| `quantity` | Order-level quantity field |
| `gross_sales` | Gross sales amount |
| `discount_amount` | Discount amount |
| `tax_amount` | Tax amount |
| `shipping_cost` | Shipping cost |
| `net_sales` | Order-level net sales amount |
| `product_cost` | Order-level product cost |
| `profit` | Order-level profit |
| `profit_margin_percentage` | Recorded profit-margin percentage |
| `customer_lifetime_value` | Customer lifetime value field provided in the dataset |
| `is_repeat_customer` | Boolean indicator for repeat-customer status |
| `customer_order_count` | Customer order-count field |
| `order_year` | Order year |
| `order_month` | Order month number |
| `order_month_name` | Order month name |
| `order_quarter` | Order quarter |
| `order_day` | Day of the month |
| `order_day_name` | Day of the week |
| `delivery_variance` | Difference between actual and estimated delivery duration |
| `delivery_performance` | Early, On Time, or Late classification |
| `calculated_profit_margin` | Calculated profit-margin field |
| `margin_difference` | Difference between recorded and calculated margin fields |

## 2. `order_items_clean`

**Grain:** One record per order line item.

| Column | Description |
|---|---|
| `order_id` | Associated order identifier |
| `product_id` | Associated product identifier |
| `quantity` | Units purchased on the line item |
| `unit_price` | Price per unit |
| `discount_percentage` | Discount percentage |
| `discount_amount` | Discount amount |
| `gross_sales` | Gross line-item sales |
| `tax_amount` | Tax amount |
| `shipping_cost` | Allocated shipping cost |
| `net_sales` | Net line-item sales |
| `product_cost` | Product cost for the line item |
| `profit` | Line-item profit |

## 3. `customer_master_clean`

**Grain:** Intended to be one record per customer after duplicate handling.

| Column | Description |
|---|---|
| `customer_id` | Customer identifier |
| `customer_name` | Customer name |
| `customer_age` | Customer age |
| `gender` | Customer gender category |
| `customer_segment` | Customer segment |
| `customer_city` | Customer city |
| `customer_state` | Customer state |
| `customer_country` | Customer country |
| `region` | Geographic region |
| `customer_postal_code` | Customer postal code |
| `customer_acquisition_cost` | Customer acquisition cost field |

## 4. `product_catalog_clean`

**Grain:** Intended to be one record per product.

| Column | Description |
|---|---|
| `product_id` | Product identifier |
| `product_name` | Product name |
| `product_category` | Product category |
| `product_subcategory` | Product subcategory |
| `brand` | Product brand |
| `supplier` | Product supplier |
| `unit_price` | Catalog unit price |
| `product_cost` | Catalog product cost |
| `product_rating` | Product rating |

## 5. Date Table

The Power BI date table contains a continuous date range based on the order dates.

| Column | Description |
|---|---|
| `Date` | Calendar date |
| `Year` | Calendar year |
| `Month Number` | Numeric month |
| `Month Name` | Month name |
| `Quarter` | Calendar quarter |
| `Year Month` | Year-month label |
| `Year Month Sort` | Numeric year-month sort key |
| `Day` | Day of the month |
| `Day Name` | Day of the week |

## 6. Key Measures

| Measure | Purpose |
|---|---|
| Total Revenue | Sum of order-level net sales |
| Total Profit | Sum of order-level profit |
| Total Orders | Distinct count of orders |
| Total Customers | Distinct count of customers |
| Total Units | Sum of order-level quantity |
| Average Order Value | Total Revenue divided by Total Orders |
| Profit Margin | Total Profit divided by Total Revenue |
| Cancellation Rate | Cancelled Orders divided by Total Orders |
| Return Rate | Returned Orders divided by Total Orders |
| On-Time Delivery Rate | On-time orders divided by orders classified as Early, On Time, or Late |

## 7. Data Notes

- The dataset is synthetic and intended for educational and analytical use.
- Some delivery and customer-rating fields may be missing when the information is unavailable.
- Field meanings and calculation logic should be confirmed against the source data and SQL/DAX implementation before reuse.
- Order-level and item-level measures have different grains and should be selected appropriately to avoid mixing metrics.
