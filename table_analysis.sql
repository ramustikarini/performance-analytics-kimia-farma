SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  c.branch_name,
  c.kota,
  c.provinsi,
  c.rating AS rating_cabang,
  t.customer_name,
  p.product_id,
  p.product_name,
  p.price AS actual_price,
  t.discount_percentage,

  CASE
  WHEN p.price <= 50000 THEN 0.1
  WHEN p.price BETWEEN 50000 AND 100000 THEN 0.15
  WHEN p.price BETWEEN 100000 AND 300000 THEN 0.2
  WHEN p.price BETWEEN 300000 AND 500000 THEN 0.25
  WHEN p.price > 500000 THEN 0.3
  END AS persentase_gross_laba,

  t.price * (1 - t.discount_percentage) AS nett_sales,

  (t.price * (1 - t.discount_percentage))*
  CASE
  WHEN p.price <= 50000 THEN 0.1
  WHEN p.price BETWEEN 50000 AND 100000 THEN 0.15
  WHEN p.price BETWEEN 100000 AND 300000 THEN 0.2
  WHEN p.price BETWEEN 300000 AND 500000 THEN 0.25
  WHEN p.price > 500000 THEN 0.3
  END AS nett_profit,

  t.rating AS rating_transaksi

FROM
  `kimia_farma.kf_final_transaction` AS t
  JOIN `kimia_farma.kf_kantor_cabang` AS c ON t.branch_id = c.branch_id
  JOIN `kimia_farma.kf_product` AS p ON t.product_id = p.product_id