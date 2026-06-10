-- ==========================================
-- RFM CUSTOMER SEGMENTATION ANALYSIS
-- ==========================================

WITH customer_rfm AS (

    SELECT
        c.customer_id,
        c.full_name,

        MAX(o.order_date) AS last_purchase_date,

        COUNT(DISTINCT o.order_id) AS frequency,

        SUM(oi.quantity * oi.unit_price) AS monetary_value

    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        c.customer_id,
        c.full_name
),

rfm_scores AS (

    SELECT
        customer_id,
        full_name,
        last_purchase_date,
        frequency,
        monetary_value,

        NTILE(5) OVER (
            ORDER BY last_purchase_date DESC
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY frequency
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY monetary_value
        ) AS monetary_score

    FROM customer_rfm
)

SELECT
    customer_id,
    full_name,
    last_purchase_date,
    frequency,
    monetary_value,

    recency_score,
    frequency_score,
    monetary_score,

    CASE

        WHEN recency_score >= 4
             AND frequency_score >= 4
             AND monetary_score >= 4
        THEN 'Champion'

        WHEN recency_score >= 3
             AND frequency_score >= 3
        THEN 'Loyal Customer'

        WHEN recency_score >= 4
        THEN 'Potential Loyalist'

        WHEN recency_score <= 2
             AND frequency_score <= 2
        THEN 'At Risk'

        ELSE 'Regular Customer'

    END AS customer_segment

FROM rfm_scores

ORDER BY monetary_value DESC;
