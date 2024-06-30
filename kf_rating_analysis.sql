CREATE TABLE kimia_farma.kf_rating_analysis AS
SELECT
  branch_id,
  kota,
  AVG(rating_cabang) AS avg_rating_cabang,
  AVG(rating_transaksi) AS avg_rating_transaksi,
FROM
  `kimia_farma.kf_sales_analysis`
GROUP BY branch_id, kota
ORDER BY 
  avg_rating_cabang DESC,
  avg_rating_transaksi ASC
LIMIT 5