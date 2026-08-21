
--001📂 Users
--1.
CREATE PROCEDURE AddNewUser
    @UserName NVARCHAR(100),
    @Email NVARCHAR(100),
    @RoleID INT
AS
BEGIN
    INSERT INTO Users (UserName, Email, RoleID, CreatedAt)
    VALUES (@UserName, @Email, @RoleID, GETDATE());
END;

--2.
CREATE PROCEDURE AssignRoleToUser
    @UserID INT,
    @RoleID INT
AS
BEGIN
    UPDATE Users 
    SET RoleID = @RoleID 
    WHERE UserID = @UserID;
END;

--3.
CREATE PROCEDURE LogUserActivity
    @UserID INT,
    @Action NVARCHAR(200)
AS
BEGIN
    INSERT INTO UserActivity (UserID, Action, ActionDate)
    VALUES (@UserID, @Action, GETDATE());
END;

--4.
CREATE PROCEDURE UserProfileUpdate
    @UserID INT,
    @Name NVARCHAR(100),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @ProfilePicture NVARCHAR(255),
    @Bio NVARCHAR(500)
AS
BEGIN
    UPDATE Users
    SET Name = @Name,
        Email = @Email,
        PhoneNumber1 = @Phone,
        PhoneNumber2 = @Phone,
        ProfilePicture = @ProfilePicture,
        Bio = @Bio,
        UpdatedAt = GETDATE()
    WHERE UserID = @UserID;
END;
----------------------
--002 📂 Roles
--5.
CREATE PROCEDURE CreateRole
    @RoleName NVARCHAR(100),
    @Permissions NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO Roles (RoleName, Permissions, CreatedAt)
    VALUES (@RoleName, @Permissions, GETDATE());
END;


--6
CREATE PROCEDURE AddPermissionToRole
    @RoleID INT,
    @PermissionID INT
AS
BEGIN
    INSERT INTO RolePermissions (RoleID, PermissionID)
    VALUES (@RoleID, @PermissionID);
END;

--7
CREATE PROCEDURE UpdateRole
    @RoleID INT,
    @RoleName NVARCHAR(100),
    @Permissions NVARCHAR(MAX)
AS
BEGIN
    UPDATE Roles
    SET RoleName = @RoleName,
        Permissions = @Permissions,
        UpdatedAt = GETDATE()
    WHERE RoleID = @RoleID;
END;

--8
CREATE PROCEDURE AddDefaultPermissions
AS
BEGIN

    INSERT INTO Permissions (permission_name)
    VALUES
        ('can_sell_wholesale'),
        ('can_sell_retail');

END;
GO

--9
-- BigMerchant
INSERT INTO RolePermissions (role_id, permission_id) 
SELECT bm.id, p.id 
FROM Roles bm, Permissions p 
WHERE bm.role_name='BigMerchant' 
AND p.permission_name IN ('can_sell_wholesale','can_sell_retail');

--10
-- SmallMerchant
INSERT INTO RolePermissions (role_id, permission_id) 
SELECT sm.id, p.id 
FROM Roles sm, Permissions p 
WHERE sm.role_name='SmallMerchant' 
AND p.permission_name IN ('can_sell_wholesale','can_sell_retail');


--003 📂 Products
--11
CREATE PROCEDURE AddProduct
    @ProductName NVARCHAR(200),
    @SKU NVARCHAR(50),
    @Price FLOAT,
    @CostPrice FLOAT,
    @Quantity INT,
    @CategoryID INT,
    @Brand NVARCHAR(100),
    @Description NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO Products (
        ProductName, SKU, Price, CostPrice, Quantity, 
        CategoryID, Brand, Description, CreatedAt
    )
    VALUES (
        @ProductName, @SKU, @Price, @CostPrice, @Quantity, 
        @CategoryID, @Brand, @Description, GETDATE()
    );
END;

--12
-- إجراء لإضافة طلب جديد إلى الطابور
CREATE PROCEDURE AddToBigMerchantQueue
    @SystemOrderID INT,
    @BigMerchantID INT
AS
BEGIN
    INSERT INTO BigMerchantQueue (system_order_id, big_merchant_id, queued_at)
    VALUES (@SystemOrderID, @BigMerchantID, GETDATE());
END;


--13
-- إجراء للإفراج عن الطلب من الطابور
CREATE PROCEDURE ReleaseFromBigMerchantQueue
    @QueueID INT
AS
BEGIN
    UPDATE BigMerchantQueue
    SET released_at = GETDATE()
    WHERE queue_id = @QueueID;
END;

--14.

--15.

--16
-- إجراء لإضافة منتج جديد إلى قائمة الـ Reseller
CREATE PROCEDURE AddResellerProduct
    @ResellerID INT,
    @ProductID INT,
    @SmallMerchantID INT,
    @ResellPrice FLOAT,
    @CommissionRate FLOAT
AS
BEGIN
    INSERT INTO ResellerProducts (
        reseller_id, product_id, small_merchant_id, resell_price, commission_rate
    )
    VALUES (
        @ResellerID, @ProductID, @SmallMerchantID, @ResellPrice, @CommissionRate
    );
END;

--17

CREATE PROCEDURE UpdateProductStock
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    UPDATE Products
    SET Quantity = Quantity - @Quantity,
        UpdatedAt = GETDATE()
    WHERE ProductID = @ProductID;
END;

-- 004 📂 Orders
--18
CREATE PROCEDURE CreateOrder
    @UserID INT,
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    INSERT INTO Orders (
        UserID, ProductID, Quantity, OrderDate, Status
    )
    VALUES (
        @UserID, @ProductID, @Quantity, GETDATE(), 'Pending'
    );
END;

--19
-- إجراء لإضافة طلب داخلي جديد
CREATE PROCEDURE AddSystemOrder
    @OrderID INT,
    @SmallMerchantID INT,
    @PurchasePrice DECIMAL(10,2),
    @ProfitMargin DECIMAL(10,2)
AS
BEGIN
    INSERT INTO SystemOrders (
        order_id, small_merchant_id, purchase_price, profit_margin, created_at
    )
    VALUES (
        @OrderID, @SmallMerchantID, @PurchasePrice, @ProfitMargin, GETDATE()
    );
END;

--20
CREATE PROCEDURE UpdateOrderStatus
    @OrderID INT,
    @Status NVARCHAR(50)
AS
BEGIN
    UPDATE Orders
    SET Status = @Status,
        UpdatedAt = GETDATE()
    WHERE OrderID = @OrderID;
END;

--005 📂 Finance & Payments//Payment System
--21

-- إجراء لإنشاء فاتورة جديدة
CREATE PROCEDURE CreateInvoice
    @OrderID INT,
    @TotalAmount DECIMAL(12,2),
    @DueDate DATE
AS
BEGIN
    INSERT INTO Invoices (order_id, total_amount, due_date, status, invoice_date)
    VALUES (@OrderID, @TotalAmount, @DueDate, 'Unpaid', GETDATE());
END;

--22
-- إجراء لإضافة مزود دفع جديد
CREATE PROCEDURE AddPaymentGateway
    @GatewayName NVARCHAR(100),
    @ApiKey NVARCHAR(255),
    @ApiSecret NVARCHAR(255),
    @EndpointUrl NVARCHAR(255),
    @Environment NVARCHAR(20)
AS
BEGIN
    INSERT INTO PaymentGateways (
        gateway_name, api_key, api_secret, endpoint_url, environment, status, created_at
    )
    VALUES (
        @GatewayName, @ApiKey, @ApiSecret, @EndpointUrl, @Environment, 'Active', GETDATE()
    );
END;

--23
-- إجراء لإنشاء عملية استرجاع جديدة
CREATE PROCEDURE CreateRefund
    @TransactionID INT,
    @OrderID INT,
    @Amount DECIMAL(12,2),
    @Reason NVARCHAR(255),
    @Method NVARCHAR(50)
AS
BEGIN
    INSERT INTO Refunds (transaction_id, order_id, amount, reason, method, status, refund_date)
    VALUES (@TransactionID, @OrderID, @Amount, @Reason, @Method, 'Pending', GETDATE());
END;

--24
-- إجراء لتطبيق الضريبة على طلب معين
CREATE PROCEDURE ApplyTax
    @UserID INT,
    @OrderID INT,
    @TaxRate DECIMAL(5,2),
    @IncomeThreshold DECIMAL(10,2)
AS
BEGIN
    DECLARE @OrderAmount DECIMAL(10,2);

    SELECT @OrderAmount = (Quantity * Price)
    FROM Orders
    WHERE OrderID = @OrderID;

    IF @OrderAmount >= @IncomeThreshold
    BEGIN
        INSERT INTO Taxes (user_id, order_id, income_threshold, tax_rate, tax_amount, status, created_at)
        VALUES (@UserID, @OrderID, @IncomeThreshold, @TaxRate, (@OrderAmount * @TaxRate / 100), 'Applied', GETDATE());
    END
    ELSE
    BEGIN
        INSERT INTO Taxes (user_id, order_id, income_threshold, tax_rate, tax_amount, status, created_at)
        VALUES (@UserID, @OrderID, @IncomeThreshold, @TaxRate, 0, 'Exempt', GETDATE());
    END
END;

--007 📂 Security Rules
--25
*****
CREATE PROCEDURE LogUserActivity
    @UserID INT,
    @Action NVARCHAR(200),
    @Details TEXT,
    @IPAddress NVARCHAR(50),
    @DeviceInfo NVARCHAR(150)
AS
BEGIN
    INSERT INTO AuditLogs (user_id, action, details, ip_address, device_info, logged_at)
    VALUES (@UserID, @Action, @Details, @IPAddress, @DeviceInfo, GETDATE());
END;

--008 📂 Automation & Orchestration
--26

-- إجراء لإنشاء حادث جديد
CREATE PROCEDURE CreateIncident
    @Title NVARCHAR(200),
    @Description TEXT,
    @Severity NVARCHAR(20)
AS
BEGIN
    INSERT INTO Incidents (title, description, severity, status, created_at)
    VALUES (@Title, @Description, @Severity, 'Open', GETDATE());
END;

--27
-- إجراء لتصعيد حادث

CREATE PROCEDURE EscalateIncident
    @IncidentID INT,
    @Level NVARCHAR(20)
AS
BEGIN
    INSERT INTO IncidentEscalations (incident_id, level, escalated_at)
    VALUES (@IncidentID, @Level, GETDATE());

    UPDATE Incidents
    SET status = 'In Progress'
    WHERE incident_id = @IncidentID;
END;

--28
-- إجراء لإرسال تنبيه
CREATE PROCEDURE SendNotification
    @UserID INT,
    @Channel NVARCHAR(50),
    @Message NVARCHAR(500)
AS
BEGIN
    INSERT INTO Notifications (user_id, channel, message, status, created_at)
    VALUES (@UserID, @Channel, @Message, 'Pending', GETDATE());

    -- هنا ممكن تضيف Integration مع API خارجي (Email/SMS/Push)
END;


--29

CREATE PROCEDURE SendNotification
    @UserID INT,
    @Channel NVARCHAR(50),
    @Message NVARCHAR(500)
AS
BEGIN
    INSERT INTO Notifications (user_id, channel, message, status, created_at)
    VALUES (@UserID, @Channel, @Message, 'Pending', GETDATE());

    -- هنا ممكن تضيف Integration مع API خارجي (Email/SMS/Push)
END; GO

--1- 009 📂 Analytics & Reports
--30
-- Procedure: Generate KPI Report
CREATE PROCEDURE GenerateKPIReport
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        k.kpi_name,
        AVG(h.recorded_value) AS AvgValue,
        MAX(h.recorded_value) AS MaxValue,
        MIN(h.recorded_value) AS MinValue,
        k.target_value,
        t.alert_level
    FROM KPIIndicators k
    JOIN KPIHistory h ON k.kpi_id = h.kpi_id
    JOIN KPIThresholds t ON k.kpi_id = t.kpi_id
    WHERE h.recorded_at BETWEEN @StartDate AND @EndDate
    GROUP BY k.kpi_name, k.target_value, t.alert_level;
END;

--010 📂 Dashboard
--011.1📂KPIReports
--31

-- Procedure: Generate Daily KPI Report
CREATE PROCEDURE GenerateDailyKPIs
AS
BEGIN
    SELECT 
        k.kpi_name,
        h.recorded_value,
        k.target_value,
        h.recorded_at
    FROM KPIIndicators k
    JOIN KPIHistory h ON k.kpi_id = h.kpi_id
    WHERE CAST(h.recorded_at AS DATE) = CAST(GETDATE() AS DATE);
END;
GO

--32
-- إجراء لإنشاء تنبيه KPI
CREATE PROCEDURE GenerateKPIAlerts
AS
BEGIN
    INSERT INTO KPIAlerts (kpi_id, recorded_value, threshold_value, alert_level, created_at)
    SELECT 
        h.kpi_id,
        h.recorded_value,
        t.max_value,
        CASE 
            WHEN h.recorded_value > t.max_value * 1.2 THEN 'Critical'
            WHEN h.recorded_value > t.max_value THEN 'Warning'
        END,
        GETDATE()
    FROM KPIHistory h
    JOIN KPIThresholds t ON h.kpi_id = t.kpi_id
    WHERE DATE(h.recorded_at) = CURDATE();
END;

--33
-- إجراء لتوليد تقرير KPI يومي
CREATE PROCEDURE GenerateDailyKPIReport
AS
BEGIN
    SELECT * 
    FROM KPIHistory
    WHERE CAST(recorded_at AS DATE) = CAST(GETDATE() AS DATE);
END;
GO

--34
-- إجراء لتوليد تقرير KPI أسبوعي
CREATE PROCEDURE GenerateWeeklyKPIReport
AS
BEGIN
    SELECT * 
    FROM KPIHistory
    WHERE DATEPART(YEAR, recorded_at) = DATEPART(YEAR, GETDATE())
      AND DATEPART(WEEK, recorded_at) = DATEPART(WEEK, GETDATE());
END;
GO

--35

-- إجراء لتوليد تقرير KPI شهري
CREATE PROCEDURE GenerateMonthlyKPIReport
AS
BEGIN
    SELECT * FROM KPIHistory
    WHERE MONTH(recorded_at) = MONTH(CURDATE())
      AND YEAR(recorded_at) = YEAR(CURDATE());
END;

--36

-- Procedure: Generate Monthly KPI Report
CREATE PROCEDURE GenerateMonthlyKPIs
AS
BEGIN
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
END;

--37

-- Procedure: Generate Weekly KPI Report
CREATE PROCEDURE GenerateWeeklyKPIs
AS
BEGIN
    SELECT 
        k.kpi_name,
        AVG(h.recorded_value) AS AvgValue,
        k.target_value,
        YEARWEEK(h.recorded_at) AS ReportWeek
    FROM KPIIndicators k
    JOIN KPIHistory h ON k.kpi_id = h.kpi_id
    WHERE YEARWEEK(h.recorded_at) = YEARWEEK(CURDATE())
    GROUP BY k.kpi_name, k.target_value, YEARWEEK(h.recorded_at);
END;

--011.2📂SalesReports
--38
-- Procedure: Generate Daily Sales Report
CREATE PROCEDURE GenerateDailySales
AS
BEGIN
    SELECT 
        DATE(order_date) AS ReportDate,
        SUM(total_amount) AS TotalSales,
        COUNT(order_id) AS TotalOrders,
        COUNT(DISTINCT customer_id) AS TotalCustomers,
        AVG(total_amount) AS AvgOrderValue
    FROM Orders
    WHERE DATE(order_date) = CURDATE()
    GROUP BY DATE(order_date);
END;

--39
-- Procedure: Generate Monthly Sales Report
CREATE PROCEDURE GenerateMonthlySales
AS
BEGIN
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
END;

--40
-- Procedure: Generate Sales Trends Report
CREATE PROCEDURE GenerateSalesTrends
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        p.product_name,
        t.trend_type,
        t.percentage_change,
        t.period_start,
        t.period_end
    FROM SalesTrends t
    JOIN Products p ON t.product_id = p.product_id
    WHERE t.period_start >= @StartDate AND t.period_end <= @EndDate;
END;

--41
-- Procedure: Generate Weekly Sales Report
CREATE PROCEDURE GenerateWeeklySales
AS
BEGIN
    SELECT 
        YEARWEEK(order_date) AS ReportWeek,
        SUM(total_amount) AS TotalSales,
        COUNT(order_id) AS TotalOrders,
        COUNT(DISTINCT customer_id) AS TotalCustomers,
        AVG(total_amount) AS AvgOrderValue
    FROM Orders
    WHERE YEARWEEK(order_date) = YEARWEEK(CURDATE())
    GROUP BY YEARWEEK(order_date);
END;

------------------------------END-----------------------------------------

























