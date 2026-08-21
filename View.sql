


--1
-- View: Daily Profits
CREATE VIEW DailyProfits AS
SELECT 
    CAST(OrderDate AS DATE) AS Day,
    SUM((Quantity * Price) - (Quantity * CostPrice)) AS Profit
FROM Orders
GROUP BY CAST(OrderDate AS DATE);


--2

-- View: Taxes Applied
CREATE VIEW TaxesApplied AS
SELECT 
    o.OrderID,
    o.UserID,
    o.ProductID,
    o.Quantity,
    (o.Quantity * o.Price * 0.14) AS VAT -- مثال ضريبة 14%
FROM Orders o;

--3

-- View: Pending Orders
CREATE VIEW PendingOrders AS
SELECT 
    so.system_order_id,
    o.OrderID,
    u.UserName AS SmallMerchant,
    so.approval_status,
    so.release_time
FROM SystemOrders so
JOIN Orders o ON so.order_id = o.OrderID
JOIN Users u ON so.small_merchant_id = u.UserID
WHERE so.approval_status = 'Pending';

--005 📂 Finance & Payments

--4
-- View: ملخص المحافظ الإلكترونية
CREATE VIEW WalletSummary AS
SELECT 
    wallet_type,
    COUNT(wallet_id) AS TotalWallets,
    SUM(balance) AS TotalBalance,
    AVG(balance) AS AvgBalance
FROM DigitalWallets
GROUP BY wallet_type;


--5
-- View: ملخص الأرصدة حسب نوع المحفظة
CREATE VIEW WalletBalanceSummary AS
SELECT 
    w.wallet_type,
    COUNT(b.balance_id) AS TotalWallets,
    SUM(b.current_balance) AS TotalBalance,
    AVG(b.current_balance) AS AvgBalance
FROM WalletBalance b
JOIN DigitalWallets w ON b.wallet_id = w.wallet_id
GROUP BY w.wallet_type;

--6
-- View: ملخص العمليات حسب النوع
CREATE VIEW WalletTransactionSummary AS
SELECT 
    transaction_type,
    COUNT(transaction_id) AS TotalTransactions,
    SUM(amount) AS TotalAmount,
    AVG(amount) AS AvgAmount
FROM WalletTransactions
GROUP BY transaction_type;


--1- 009 📂 Analytics & Reports
--7

-- View: KPI Summary
CREATE VIEW KPISummary AS
SELECT 
    k.kpi_name,
    h.recorded_value,
    k.target_value,
    t.min_value,
    t.max_value,
    t.alert_level,
    h.recorded_at
FROM KPIIndicators k
JOIN KPIHistory h ON k.kpi_id = h.kpi_id
JOIN KPIThresholds t ON k.kpi_id = t.kpi_id;

--011.1📂KPIReports

-- 8
-- View: Daily KPIs
CREATE VIEW DailyKPIs AS
SELECT 
    k.kpi_name,
    h.recorded_value,
    k.target_value,
    h.recorded_at
FROM KPIIndicators k
JOIN KPIHistory h ON k.kpi_id = h.kpi_id
WHERE CAST(h.recorded_at AS DATE) = CAST(GETDATE() AS DATE);
GO

--9

-- View: Monthly KPIs
CREATE VIEW MonthlyKPIs AS
SELECT 
    k.kpi_name,
    AVG(h.recorded_value) AS AvgValue,
    k.target_value,
    MONTH(h.recorded_at) AS ReportMonth,
    YEAR(h.recorded_at) AS ReportYear
FROM KPIIndicators k
JOIN KPIHistory h ON k.kpi_id = h.kpi_id
WHERE MONTH(h.recorded_at) = MONTH(CURDATE())
  AND YEAR(h.recorded_at) = YEAR(CURDATE())
GROUP BY k.kpi_name, k.target_value, MONTH(h.recorded_at), YEAR(h.recorded_at);

--10
-- View: Weekly KPIs
CREATE VIEW WeeklyKPIs AS
SELECT 
    k.kpi_name,
    AVG(h.recorded_value) AS AvgValue,
    k.target_value,
    YEARWEEK(h.recorded_at) AS ReportWeek
FROM KPIIndicators k
JOIN KPIHistory h ON k.kpi_id = h.kpi_id
WHERE YEARWEEK(h.recorded_at) = YEARWEEK(CURDATE())
GROUP BY k.kpi_name, k.target_value, YEARWEEK(h.recorded_at);

--011.2📂SalesReports
--11
-- View: Daily Sales
CREATE VIEW DailySales AS
SELECT 
    DATE(order_date) AS ReportDate,
    SUM(total_amount) AS TotalSales,
    COUNT(order_id) AS TotalOrders,
    COUNT(DISTINCT customer_id) AS TotalCustomers,
    AVG(total_amount) AS AvgOrderValue
FROM Orders
WHERE DATE(order_date) = CURDATE()
GROUP BY DATE(order_date);

--12
-- View: Monthly Sales
CREATE VIEW MonthlySales AS
SELECT 
    YEAR(order_date) AS ReportYear,
    MONTH(order_date) AS ReportMonth,
    SUM(total_amount) AS TotalSales,
    COUNT(order_id) AS TotalOrders,
    COUNT(DISTINCT customer_id) AS TotalCustomers,
    AVG(total_amount) AS AvgOrderValue
FROM Orders
WHERE MONTH(order_date) = MONTH(CURDATE())
  AND YEAR(order_date) = YEAR(CURDATE())
GROUP BY YEAR(order_date), MONTH(order_date);

--💻 الكود (SQL Views 
--13
-- View: Daily Sales Report
CREATE VIEW DailySalesReport AS
SELECT 
    DATE(order_date) AS ReportDate,
    SUM(total_amount) AS TotalSales,
    COUNT(order_id) AS TotalOrders
FROM Orders
GROUP BY DATE(order_date);

--14
-- View: Weekly Sales Report
CREATE VIEW WeeklySalesReport AS
SELECT 
    YEARWEEK(order_date) AS ReportWeek,
    SUM(total_amount) AS TotalSales,
    COUNT(order_id) AS TotalOrders
FROM Orders
GROUP BY YEARWEEK(order_date);

--15
-- View: Monthly Sales Report
CREATE VIEW MonthlySalesReport AS
SELECT 
    YEAR(order_date) AS ReportYear,
    MONTH(order_date) AS ReportMonth,
    SUM(total_amount) AS TotalSales,
    COUNT(order_id) AS TotalOrders
FROM Orders
GROUP BY YEAR(order_date), MONTH(order_date);

--16
-- View: Sales Trends
CREATE VIEW SalesTrendReport AS
SELECT 
    product_id,
    trend_type,
    percentage_change,
    period_start,
    period_end
FROM SalesTrends;

--17
-- View: Sales Trends
CREATE VIEW SalesTrendsView AS
SELECT 
    product_id,
    trend_type,
    percentage_change,
    period_start,
    period_end
FROM SalesTrends;

--18
-- View: Weekly Sales
CREATE VIEW WeeklySales AS
SELECT 
    YEARWEEK(order_date) AS ReportWeek,
    SUM(total_amount) AS TotalSales,
    COUNT(order_id) AS TotalOrders,
    COUNT(DISTINCT customer_id) AS TotalCustomers,
    AVG(total_amount) AS AvgOrderValue
FROM Orders
WHERE YEARWEEK(order_date) = YEARWEEK(CURDATE())
GROUP BY YEARWEEK(order_date);

-----------------------------END--------------------------------------------