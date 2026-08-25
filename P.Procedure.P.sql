
-- =============================================
-- Stored Procedure: [dbo].[AddBigMerchant]
-- =============================================



CREATE PROCEDURE AddBigMerchant
    @BigMerchantID INT,
    @CompanyName NVARCHAR(200),
    @TaxNumber NVARCHAR(100) = NULL
AS
BEGIN
    INSERT INTO BigMerchant (BigMerchantID, CompanyName, TaxNumber, CreatedAt)
    VALUES (@BigMerchantID, @CompanyName, @TaxNumber, GETDATE());
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[AddConfigItem]
-- =============================================
CREATE PROCEDURE AddConfigItem
    @ItemName NVARCHAR(150),
    @ItemType NVARCHAR(100),
    @Owner NVARCHAR(150)
AS
BEGIN
    INSERT INTO ConfigItems (ItemName, ItemType, Owner)
    VALUES (@ItemName, @ItemType, @Owner);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[AddIncident]
-- =============================================


CREATE PROCEDURE AddIncident
    @Title NVARCHAR(200),
    @Description NVARCHAR(500),
    @TypeID INT,
    @ReportedBy INT
AS
BEGIN
    INSERT INTO IncidentReports (Title, Description, TypeID, ReportedBy)
    VALUES (@Title, @Description, @TypeID, @ReportedBy);
END; 
GO


-- =============================================
-- Stored Procedure: [dbo].[AddMerchantProduct]
-- =============================================

CREATE PROCEDURE AddMerchantProduct
    @ProductID INT,
    @MerchantID INT,
    @StockQuantity INT,
    @SaleType NVARCHAR(20)
AS
BEGIN
    INSERT INTO MerchantProducts (ProductID, MerchantID, StockQuantity, SaleType)
    VALUES (@ProductID, @MerchantID, @StockQuantity, @SaleType);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[AddProblem]
-- =============================================


CREATE PROCEDURE AddProblem
    @Title NVARCHAR(200),
    @Description NVARCHAR(500),
    @Category NVARCHAR(100),
    @CreatedBy INT
AS
BEGIN
    INSERT INTO ProblemCatalog (Title, Description, Category, CreatedBy)
    VALUES (@Title, @Description, @Category, @CreatedBy);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[AddProduct]
-- =============================================

CREATE PROCEDURE AddProduct
    @ProductName NVARCHAR(200),
    @Description NVARCHAR(MAX),
    @Price DECIMAL(10,2),
    @StockQuantity INT
AS
BEGIN
    INSERT INTO Products (ProductName, Description, Price, StockQuantity)
    VALUES (@ProductName, @Description, @Price, @StockQuantity);
END;


GO


-- =============================================
-- Stored Procedure: [dbo].[AddRelease]
-- =============================================

CREATE PROCEDURE AddRelease
    @ReleaseName NVARCHAR(150),
    @PlannedDate DATE,
    @ReleaseManager NVARCHAR(150),
    @Notes NVARCHAR(500)
AS
BEGIN
    INSERT INTO Releases (ReleaseName, PlannedDate, ReleaseManager, Notes)
    VALUES (@ReleaseName, @PlannedDate, @ReleaseManager, @Notes);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[AddRole]
-- =============================================

CREATE PROCEDURE AddRole
    @RoleName NVARCHAR(100),
    @Note NVARCHAR(200) = NULL
AS
BEGIN
    INSERT INTO Roles (RoleName, Note, CreatedAt)
    VALUES (@RoleName, @Note, GETDATE());
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[AddRoleToUser]
-- =============================================

CREATE PROCEDURE AddRoleToUser
    @UserID INT,
    @RoleID INT
AS
BEGIN
    INSERT INTO UsersRoles (UserID, RoleID)
    VALUES (@UserID, @RoleID);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[AddSmallMerchant]
-- =============================================



CREATE PROCEDURE AddSmallMerchant
    @SmallMerchantID INT,
    @ShopName NVARCHAR(200),
    @LicenseNumber NVARCHAR(100) = NULL
AS
BEGIN
    INSERT INTO SmallMerchant (SmallMerchantID, ShopName, LicenseNumber, CreatedAt)
    VALUES (@SmallMerchantID, @ShopName, @LicenseNumber, GETDATE());
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[AddUser]
-- =============================================

    CREATE PROCEDURE AddUser
    @UserName NVARCHAR(100),
    @Email NVARCHAR(200),
    @PasswordHash NVARCHAR(200),
    @Notes NVARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO Users (UserName, Email, CreatedAT, PasswordHash, Status, Notes)
    VALUES (@UserName, @Email, GETDATE(), @PasswordHash, 'Active', @Notes);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[ApproveChangeRequest]
-- =============================================

 CREATE PROCEDURE ApproveChangeRequest
    @RequestID INT,
    @ApprovedBy INT,
    @ApprovalStatus NVARCHAR(50),
    @Notes NVARCHAR(500)
AS
BEGIN
    INSERT INTO ChangeApprovals (RequestID, ApprovedBy, ApprovalStatus, Notes)
    VALUES (@RequestID, @ApprovedBy, @ApprovalStatus, @Notes);

    UPDATE ChangeRequests
    SET Status = @ApprovalStatus
    WHERE RequestID = @RequestID;

    INSERT INTO ChangeLogs (RequestID, Action, ActionBy)
    VALUES (@RequestID, 'Change request ' + @ApprovalStatus, @ApprovedBy);
END;

GO


-- =============================================
-- Stored Procedure: [dbo].[AssignRoleToUser]
-- =============================================



CREATE PROCEDURE AssignRoleToUser
    @UserID INT,
    @RoleID INT
AS
BEGIN
    UPDATE Users
    SET RoleID = @RoleID
    WHERE UserID = @UserID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[AssignUserRole]
-- =============================================

   CREATE PROCEDURE AssignUserRole
    @UserID INT,
    @RoleID INT
AS
BEGIN
    -- تحديث جدول UsersData لإضافة الدور للمستخدم
    UPDATE UsersData
    SET RoleID = @RoleID,
        UpdatedAt = GETDATE()
    WHERE UserID = @UserID;
END;

GO


-- =============================================
-- Stored Procedure: [dbo].[ChangeUserStatus]
-- =============================================


   CREATE PROCEDURE ChangeUserStatus
    @UserID INT,
    @Status NVARCHAR(50)
AS
BEGIN
    UPDATE Users
    SET Status = @Status
    WHERE UserID = @UserID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[CloseTicket]
-- =============================================


  CREATE PROCEDURE CloseTicket
    @TicketID INT,
    @ClosedBy INT
AS
BEGIN
    UPDATE SupportTickets
    SET Status = 'Closed',
        ClosedAt = GETDATE()
    WHERE TicketID = @TicketID;

    INSERT INTO TicketLogs (TicketID, Action, ActionBy)
    VALUES (@TicketID, 'Ticket closed', @ClosedBy);
END;

 
GO


-- =============================================
-- Stored Procedure: [dbo].[CompareForecastWithActuals]
-- =============================================

   CREATE PROCEDURE CompareForecastWithActuals
    @ForecastID INT,
    @ActualValue DECIMAL(18,2)
AS
BEGIN
    DECLARE @ExpectedValue DECIMAL(18,2);

    -- جلب القيمة المتوقعة من جدول ForecastingReports
    SELECT @ExpectedValue = ExpectedValue
    FROM ForecastingReports
    WHERE ForecastID = @ForecastID;

    -- إدخال النتيجة الفعلية في جدول ForecastingHistory
    INSERT INTO ForecastingHistory (
        ForecastID,
        ActualValue,
        ComparisonDate,
        CreatedAt
    )
    VALUES (
        @ForecastID,
        @ActualValue,
        GETDATE(),
        GETDATE()
    );

    -- حساب نسبة الدقة
    SELECT 
        @ForecastID AS ForecastID,
        @ExpectedValue AS ExpectedValue,
        @ActualValue AS ActualValue,
        CASE 
            WHEN @ExpectedValue = 0 THEN 0
            ELSE ROUND(((@ActualValue / @ExpectedValue) * 100), 2)
        END AS AccuracyPercentage;
END; 
GO


-- =============================================
-- Stored Procedure: [dbo].[CreateOrder]
-- =============================================

CREATE PROCEDURE CreateOrder
    @UserID INT,
    @TotalAmount DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Orders (UserID, TotalAmount)
    VALUES (@UserID, @TotalAmount);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[Delete_Order]
-- =============================================
CREATE   PROCEDURE Delete_Order
    @OrderID INT
AS
BEGIN
    DELETE FROM Orders WHERE OrderID = @OrderID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[Delete_Payment]
-- =============================================



CREATE   PROCEDURE Delete_Payment
    @PaymentID INT
AS
BEGIN
    DELETE FROM Payments WHERE PaymentID = @PaymentID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[Delete_User]
-- =============================================



CREATE   PROCEDURE Delete_User
    @UserID INT
AS
BEGIN
    DELETE FROM Users WHERE UserID = @UserID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[DeleteAuditLog]
-- =============================================


CREATE   PROCEDURE DeleteAuditLog
    @LogID INT
AS
BEGIN
    DELETE FROM AuditLogs WHERE LogID = @LogID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[DeleteProduct]
-- =============================================

CREATE PROCEDURE DeleteProduct
    @ProductID INT
AS
BEGIN
    -- أولاً نحذف الصور المرتبطة بالمنتج
    DELETE FROM ProductImages
    WHERE ProductID = @ProductID;

    -- ثم نحذف تفاصيل الطلبات المرتبطة بالمنتج
    DELETE FROM OrderDetails
    WHERE ProductID = @ProductID;

    -- وأخيراً نحذف المنتج نفسه
    DELETE FROM Products
    WHERE ProductID = @ProductID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[DeleteRole]
-- =============================================

CREATE PROCEDURE DeleteRole
    @RoleID INT
AS
BEGIN
    -- أولاً نحذف الربط بين المستخدمين والدور
    DELETE FROM UsersRoles
    WHERE RoleID = @RoleID;

    -- ثم نحذف الدور نفسه
    DELETE FROM Roles
    WHERE RoleID = @RoleID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[DeleteUser]
-- =============================================

   CREATE PROCEDURE DeleteUser
    @UserID INT
AS
BEGIN
    DELETE FROM Users
    WHERE UserID = @UserID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[DeployRelease]
-- =============================================

CREATE PROCEDURE DeployRelease
    @ReleaseID INT,
    @Environment NVARCHAR(50),
    @DeployedBy NVARCHAR(150),
    @DeploymentNotes NVARCHAR(500)
AS
BEGIN
    INSERT INTO ReleaseDeployments (ReleaseID, Environment, DeployedBy, DeploymentNotes)
    VALUES (@ReleaseID, @Environment, @DeployedBy, @DeploymentNotes);

    INSERT INTO ReleaseLogs (ReleaseID, Action, ActionBy)
    VALUES (@ReleaseID, 'Release deployed to ' + @Environment, @DeployedBy);
END;

GO


-- =============================================
-- Stored Procedure: [dbo].[GenerateSalesForecast]
-- =============================================
 
   CREATE PROCEDURE GenerateSalesForecast
    @ProductID INT = NULL,              -- لو التوقع مرتبط بمنتج معين
    @ForecastType NVARCHAR(100),        -- Sales, Demand, Resource
    @ForecastPeriod NVARCHAR(50),       -- Daily, Weekly, Monthly
    @ForecastDate DATETIME,             -- تاريخ التوقع
    @ExpectedValue DECIMAL(18,2)        -- القيمة المتوقعة
AS
BEGIN
    INSERT INTO ForecastingReports (
        ProductID,
        ForecastType,
        ForecastPeriod,
        ForecastDate,
        ExpectedValue,
        CreatedAt
    )
    VALUES (
        @ProductID,
        @ForecastType,
        @ForecastPeriod,
        @ForecastDate,
        @ExpectedValue,
        GETDATE()
    );
END;

   
GO


-- =============================================
-- Stored Procedure: [dbo].[GetAllEntitiesLedgerSummary]
-- =============================================
CREATE   PROCEDURE GetAllEntitiesLedgerSummary
AS
BEGIN
    -- ملخص مالي للكيانات
    SELECT 
        'User' AS EntityType,
        u.UserID AS EntityID,
        u.UserName AS EntityName,
        YEAR(l.TransactionDate) AS Year,
        DATEPART(QUARTER, l.TransactionDate) AS Quarter,
        SUM(CASE WHEN l.DebitCredit = 'Debit' THEN l.Amount ELSE 0 END) AS TotalDebits,
        SUM(CASE WHEN l.DebitCredit = 'Credit' THEN l.Amount ELSE 0 END) AS TotalCredits,
        SUM(l.Amount) AS NetAmount
    FROM Users u
    INNER JOIN Orders o ON u.UserID = o.CustomerID
    INNER JOIN Payments p ON o.OrderID = p.OrderID
    INNER JOIN Ledger l ON l.ReferenceID = p.PaymentID AND l.TransactionType = 'Payment'
    GROUP BY u.UserID, u.UserName, YEAR(l.TransactionDate), DATEPART(QUARTER, l.TransactionDate)

    UNION ALL

    -- ملخص سجلات التدقيق
    SELECT 
        'AuditLog' AS EntityType,
        a.EntityID,
        a.EntityName,
        YEAR(a.ActionDate) AS Year,
        DATEPART(QUARTER, a.ActionDate) AS Quarter,
        COUNT(a.LogID) AS TotalDebits,   -- هنا بنستخدم Count كعدد عمليات
        0 AS TotalCredits,               -- مش محتاجين Credits في التدقيق
        COUNT(a.LogID) AS NetAmount      -- عدد العمليات كـ NetAmount
    FROM AuditLogs a
    GROUP BY a.EntityID, a.EntityName, YEAR(a.ActionDate), DATEPART(QUARTER, a.ActionDate);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetAllEntitiesLedgerSummaryPivot]
-- =============================================
CREATE   PROCEDURE GetAllEntitiesLedgerSummaryPivot
AS
BEGIN
    ;WITH EntityLedger AS (
        SELECT 
            CASE 
                WHEN u.UserID IS NOT NULL THEN 'User'
                WHEN r.RoleID IS NOT NULL THEN 'Role'
                WHEN sm.SmallMerchantID IS NOT NULL THEN 'SmallMerchant'
                WHEN bm.BigMerchantID IS NOT NULL THEN 'BigMerchant'
            END AS EntityType,
            ISNULL(u.UserID, ISNULL(r.RoleID, ISNULL(sm.SmallMerchantID, bm.BigMerchantID))) AS EntityID,
            ISNULL(u.UserName, ISNULL(r.RoleName, ISNULL(sm.ShopName, bm.CompanyName))) AS EntityName,
            YEAR(l.TransactionDate) AS Year,
            MONTH(l.TransactionDate) AS Month,
            DATEPART(QUARTER, l.TransactionDate) AS Quarter,
            SUM(CASE WHEN l.DebitCredit = 'Debit' THEN l.Amount ELSE 0 END) AS TotalDebits,
            SUM(CASE WHEN l.DebitCredit = 'Credit' THEN l.Amount ELSE 0 END) AS TotalCredits,
            SUM(l.Amount) AS NetAmount
        FROM Ledger l
        LEFT JOIN Payments p ON l.ReferenceID = p.PaymentID AND l.TransactionType = 'Payment'
        LEFT JOIN Orders o ON p.OrderID = o.OrderID
        LEFT JOIN Users u ON o.CustomerID = u.UserID
        LEFT JOIN Roles r ON u.RoleID = r.RoleID
        LEFT JOIN SmallMerchant sm ON o.SmallMerchantID = sm.SmallMerchantID
        LEFT JOIN SmallMerchantProducts smp ON sm.SmallMerchantID = smp.SmallMerchantID
        LEFT JOIN Products pr ON smp.ProductID = pr.ProductID
        LEFT JOIN BigMerchant bm ON pr.BigMerchantID = bm.BigMerchantID
        GROUP BY 
            CASE 
                WHEN u.UserID IS NOT NULL THEN 'User'
                WHEN r.RoleID IS NOT NULL THEN 'Role'
                WHEN sm.SmallMerchantID IS NOT NULL THEN 'SmallMerchant'
                WHEN bm.BigMerchantID IS NOT NULL THEN 'BigMerchant'
            END,
            ISNULL(u.UserID, ISNULL(r.RoleID, ISNULL(sm.SmallMerchantID, bm.BigMerchantID))),
            ISNULL(u.UserName, ISNULL(r.RoleName, ISNULL(sm.ShopName, bm.CompanyName))),
            YEAR(l.TransactionDate),
            MONTH(l.TransactionDate),
            DATEPART(QUARTER, l.TransactionDate)
    )
    -- Monthly Report
    SELECT 'Monthly' AS ReportType, EntityType, EntityID, EntityName, Year, Month,
           SUM(TotalDebits) AS TotalDebits, SUM(TotalCredits) AS TotalCredits, SUM(NetAmount) AS NetAmount
    FROM EntityLedger
    GROUP BY EntityType, EntityID, EntityName, Year, Month

    UNION ALL

    -- Quarterly Report
    SELECT 'Quarterly' AS ReportType, EntityType, EntityID, EntityName, Year, Quarter,
           SUM(TotalDebits) AS TotalDebits, SUM(TotalCredits) AS TotalCredits, SUM(NetAmount) AS NetAmount
    FROM EntityLedger
    GROUP BY EntityType, EntityID, EntityName, Year, Quarter

    UNION ALL

    -- Yearly Report
    SELECT 'Yearly' AS ReportType, EntityType, EntityID, EntityName, Year, NULL AS Quarter,
           SUM(TotalDebits) AS TotalDebits, SUM(TotalCredits) AS TotalCredits, SUM(NetAmount) AS NetAmount
    FROM EntityLedger
    GROUP BY EntityType, EntityID, EntityName, Year

    ORDER BY EntityType, EntityName, Year, ReportType;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetAllMerchantsFinancialSummary]
-- =============================================
CREATE   PROCEDURE GetAllMerchantsFinancialSummary
AS
BEGIN
    -- ملخص للتجار الصغار
    SELECT 
        'SmallMerchant' AS MerchantType,
        sm.SmallMerchantID AS MerchantID,
        sm.ShopName AS MerchantName,
        COUNT(o.OrderID) AS TotalOrders,
        SUM(o.TotalAmount) AS TotalOrderAmount,
        SUM(p.Amount) AS TotalPayments
    FROM SmallMerchant sm
    INNER JOIN Orders o ON sm.SmallMerchantID = o.SmallMerchantID
    INNER JOIN Payments p ON o.OrderID = p.OrderID
    GROUP BY sm.SmallMerchantID, sm.ShopName

    UNION ALL

    -- ملخص للتجار الكبار
    SELECT 
        'BigMerchant' AS MerchantType,
        bm.BigMerchantID AS MerchantID,
        bm.CompanyName AS MerchantName,
        COUNT(p.PaymentID) AS TotalPaymentsCount,
        SUM(p.Amount) AS TotalPayments,
        SUM(o.TotalAmount) AS TotalOrdersAmount
    FROM BigMerchant bm
    INNER JOIN Products pr ON bm.BigMerchantID = pr.BigMerchantID
    INNER JOIN SmallMerchantProducts smp ON pr.ProductID = smp.ProductID
    INNER JOIN Orders o ON smp.SmallMerchantID = o.SmallMerchantID
    INNER JOIN Payments p ON o.OrderID = p.OrderID
    GROUP BY bm.BigMerchantID, bm.CompanyName;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetAllRolesLedgerSummary]
-- =============================================
CREATE   PROCEDURE GetAllRolesLedgerSummary
AS
BEGIN
    SELECT 
        r.RoleID,
        r.RoleName,
        YEAR(l.TransactionDate) AS Year,
        DATEPART(QUARTER, l.TransactionDate) AS Quarter,
        SUM(CASE WHEN l.DebitCredit = 'Debit' THEN l.Amount ELSE 0 END) AS TotalDebits,
        SUM(CASE WHEN l.DebitCredit = 'Credit' THEN l.Amount ELSE 0 END) AS TotalCredits,
        SUM(l.Amount) AS NetAmount
    FROM Roles r
    INNER JOIN Users u ON r.RoleID = u.RoleID
    INNER JOIN Orders o ON u.UserID = o.CustomerID
    INNER JOIN Payments p ON o.OrderID = p.OrderID
    INNER JOIN Ledger l ON l.ReferenceID = p.PaymentID AND l.TransactionType = 'Payment'
    GROUP BY r.RoleID, r.RoleName, YEAR(l.TransactionDate), DATEPART(QUARTER, l.TransactionDate)
    ORDER BY r.RoleName, Year, Quarter;
END;
     
GO

-- =============================================
-- Stored Procedure: [dbo].[GetAuditAndLedgerCombinedSummary]
-- =============================================
CREATE   PROCEDURE GetAuditAndLedgerCombinedSummary
AS
BEGIN
    ;WITH LedgerData AS (
        SELECT 
            'Ledger' AS SourceType,
            YEAR(TransactionDate) AS Year,
            MONTH(TransactionDate) AS Month,
            DATEPART(QUARTER, TransactionDate) AS Quarter,
            SUM(CASE WHEN DebitCredit = 'Debit' THEN Amount ELSE 0 END) AS TotalDebits,
            SUM(CASE WHEN DebitCredit = 'Credit' THEN Amount ELSE 0 END) AS TotalCredits,
            SUM(Amount) AS NetAmount,
            COUNT(LedgerID) AS TransactionCount
        FROM Ledger
        GROUP BY YEAR(TransactionDate), MONTH(TransactionDate), DATEPART(QUARTER, TransactionDate)
    ),
    AuditData AS (
        SELECT 
            'AuditLog' AS SourceType,
            YEAR(ActionDate) AS Year,
            MONTH(ActionDate) AS Month,
            DATEPART(QUARTER, ActionDate) AS Quarter,
            0 AS TotalDebits,
            0 AS TotalCredits,
            COUNT(LogID) AS NetAmount, -- عدد العمليات كـ NetAmount
            COUNT(LogID) AS TransactionCount
        FROM AuditLogs
        GROUP BY YEAR(ActionDate), MONTH(ActionDate), DATEPART(QUARTER, ActionDate)
    ),
    Combined AS (
        SELECT * FROM LedgerData
        UNION ALL
        SELECT * FROM AuditData
    )
    -- Monthly Report
    SELECT 'Monthly' AS ReportType, SourceType, Year, Month, Quarter,
           SUM(TotalDebits) AS TotalDebits,
           SUM(TotalCredits) AS TotalCredits,
           SUM(NetAmount) AS NetAmount,
           SUM(TransactionCount) AS TransactionCount
    FROM Combined
    GROUP BY SourceType, Year, Month, Quarter

    UNION ALL

    -- Quarterly Report
    SELECT 'Quarterly' AS ReportType, SourceType, Year, NULL AS Month, Quarter,
           SUM(TotalDebits) AS TotalDebits,
           SUM(TotalCredits) AS TotalCredits,
           SUM(NetAmount) AS NetAmount,
           SUM(TransactionCount) AS TransactionCount
    FROM Combined
    GROUP BY SourceType, Year, Quarter

    UNION ALL

    -- Yearly Report
    SELECT 'Yearly' AS ReportType, SourceType, Year, NULL AS Month, NULL AS Quarter,
           SUM(TotalDebits) AS TotalDebits,
           SUM(TotalCredits) AS TotalCredits,
           SUM(NetAmount) AS NetAmount,
           SUM(TransactionCount) AS TransactionCount
    FROM Combined
    GROUP BY SourceType, Year

    ORDER BY ReportType, SourceType, Year, Quarter, Month;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetAuditLogSummary]
-- =============================================


CREATE   PROCEDURE GetAuditLogSummary
AS
BEGIN
    SELECT 
        EntityName,
        EntityID,
        Action,
        ActionBy,
        YEAR(ActionDate) AS Year,
        DATEPART(QUARTER, ActionDate) AS Quarter,
        COUNT(LogID) AS ActionCount
    FROM AuditLogs
    GROUP BY EntityName, EntityID, Action, ActionBy, YEAR(ActionDate), DATEPART(QUARTER, ActionDate)
    ORDER BY Year, Quarter, EntityName;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetAuditLogSummaryPivot]
-- =============================================


CREATE   PROCEDURE GetAuditLogSummaryPivot
AS
BEGIN
    ;WITH AuditData AS (
        SELECT 
            EntityName,
            EntityID,
            Action,
            ActionBy,
            YEAR(ActionDate) AS Year,
            MONTH(ActionDate) AS Month,
            DATEPART(QUARTER, ActionDate) AS Quarter,
            COUNT(LogID) AS ActionCount
        FROM AuditLogs
        GROUP BY EntityName, EntityID, Action, ActionBy, YEAR(ActionDate), MONTH(ActionDate), DATEPART(QUARTER, ActionDate)
    )
    -- Monthly Report
    SELECT 'Monthly' AS ReportType, EntityName, EntityID, Action, ActionBy, Year, Month,
           SUM(ActionCount) AS TotalActions
    FROM AuditData
    GROUP BY EntityName, EntityID, Action, ActionBy, Year, Month

    UNION ALL

    -- Quarterly Report
    SELECT 'Quarterly' AS ReportType, EntityName, EntityID, Action, ActionBy, Year, Quarter,
           SUM(ActionCount) AS TotalActions
    FROM AuditData
    GROUP BY EntityName, EntityID, Action, ActionBy, Year, Quarter

    UNION ALL

    -- Yearly Report
    SELECT 'Yearly' AS ReportType, EntityName, EntityID, Action, ActionBy, Year, NULL AS Quarter,
           SUM(ActionCount) AS TotalActions
    FROM AuditData
    GROUP BY EntityName, EntityID, Action, ActionBy, Year

    ORDER BY EntityName, Year, ReportType;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetAvailabilitySummary]
-- =============================================

CREATE PROCEDURE GetAvailabilitySummary
AS
BEGIN
    -- إجمالي عدد الأنظمة المراقبة
    SELECT COUNT(*) AS TotalSystems
    FROM AvailabilityTargets;

    -- نسبة التوفر الفعلي مقابل المستهدف
    SELECT 
        AT.SystemName,
        AT.TargetUptime,
        AVG(AR.ActualUptime) AS AvgActualUptime,
        CAST(AVG(AR.ActualUptime) * 100.0 / AT.TargetUptime AS DECIMAL(5,2)) AS AchievementPercentage
    FROM AvailabilityTargets AT
    INNER JOIN AvailabilityRecords AR ON AT.TargetID = AR.TargetID
    GROUP BY AT.SystemName, AT.TargetUptime;

    -- عدد الانقطاعات المسجلة
    SELECT 
        AT.SystemName,
        COUNT(CASE WHEN AR.Status = 'Unavailable' THEN 1 END) AS DowntimeCount
    FROM AvailabilityTargets AT
    INNER JOIN AvailabilityRecords AR ON AT.TargetID = AR.TargetID
    GROUP BY AT.SystemName;

    -- متوسط زمن الانقطاع لكل نظام
    SELECT 
        AT.SystemName,
        AVG(AR.DowntimeMinutes) AS AvgDowntimeMinutes
    FROM AvailabilityTargets AT
    INNER JOIN AvailabilityRecords AR ON AT.TargetID = AR.TargetID
    GROUP BY AT.SystemName;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetAvailabilityTrendKPIs]
-- =============================================
CREATE PROCEDURE GetAvailabilityTrendKPIs
AS
BEGIN
    -- إجمالي عدد الأنظمة المراقبة
    SELECT COUNT(*) AS TotalSystems
    FROM AvailabilityTargets;

    -- نسبة التوفر الفعلي مقابل المستهدف لكل نظام
    SELECT 
        AT.SystemName,
        AT.TargetUptime,
        AVG(AR.ActualUptime) AS AvgActualUptime,
        CAST(AVG(AR.ActualUptime) * 100.0 / AT.TargetUptime AS DECIMAL(5,2)) AS AchievementPercentage
    FROM AvailabilityTargets AT
    INNER JOIN AvailabilityRecords AR ON AT.TargetID = AR.TargetID
    GROUP BY AT.SystemName, AT.TargetUptime;

    -- عدد الانقطاعات ومتوسط زمن الانقطاع لكل نظام
    SELECT 
        AT.SystemName,
        COUNT(CASE WHEN AR.Status = 'Unavailable' THEN 1 END) AS DowntimeCount,
        AVG(AR.DowntimeMinutes) AS AvgDowntimeMinutes
    FROM AvailabilityTargets AT
    INNER JOIN AvailabilityRecords AR ON AT.TargetID = AR.TargetID
    GROUP BY AT.SystemName;

    -- 📊 Trend Analysis: التوفر والانقطاعات شهرياً
    SELECT 
        AT.SystemName,
        FORMAT(AR.RecordedAt, 'yyyy-MM') AS Month,
        AVG(AR.ActualUptime) AS AvgMonthlyUptime,
        SUM(AR.DowntimeMinutes) AS TotalDowntimeMinutes,
        COUNT(CASE WHEN AR.Status = 'Unavailable' THEN 1 END) AS MonthlyDowntimeCount
    FROM AvailabilityTargets AT
    INNER JOIN AvailabilityRecords AR ON AT.TargetID = AR.TargetID
    GROUP BY AT.SystemName, FORMAT(AR.RecordedAt, 'yyyy-MM')
    ORDER BY AT.SystemName, Month DESC;
END;
GO
-- =============================================
-- Stored Procedure: [dbo].[GetCapacitySummary]
-- =============================================
CREATE PROCEDURE GetCapacitySummary
AS
BEGIN
    -- إجمالي عدد الموارد المراقبة
    SELECT COUNT(*) AS TotalResources
    FROM CapacityTargets;

    -- نسبة الاستخدام الفعلي مقابل المستهدف لكل مورد
    SELECT 
        CT.ResourceType,
        CT.TargetUsage,
        AVG(CR.ActualUsage) AS AvgActualUsage,
        CAST(AVG(CR.ActualUsage) * 100.0 / CT.TargetUsage AS DECIMAL(5,2)) AS AchievementPercentage
    FROM CapacityTargets CT
    INNER JOIN CapacityRecords CR ON CT.TargetID = CR.TargetID
    GROUP BY CT.ResourceType, CT.TargetUsage;

    -- عدد الحالات الحرجة (Critical) لكل مورد
    SELECT 
        CT.ResourceType,
        COUNT(CASE WHEN CR.Status = 'Critical' THEN 1 END) AS CriticalCount,
        COUNT(CASE WHEN CR.Status = 'Warning' THEN 1 END) AS WarningCount,
        COUNT(CASE WHEN CR.Status = 'Normal' THEN 1 END) AS NormalCount
    FROM CapacityTargets CT
    INNER JOIN CapacityRecords CR ON CT.TargetID = CR.TargetID
    GROUP BY CT.ResourceType;

    -- متوسط الاستخدام لكل مورد
    SELECT 
        CT.ResourceType,
        AVG(CR.ActualUsage) AS AvgUsage,
        MAX(CR.ActualUsage) AS PeakUsage,
        MIN(CR.ActualUsage) AS MinUsage
    FROM CapacityTargets CT
    INNER JOIN CapacityRecords CR ON CT.TargetID = CR.TargetID
    GROUP BY CT.ResourceType;

    -- 📊 Trend Analysis: الاستخدام الشهري
    SELECT 
        CT.ResourceType,
        FORMAT(CR.RecordedAt, 'yyyy-MM') AS Month,
        AVG(CR.ActualUsage) AS AvgMonthlyUsage,
        MAX(CR.ActualUsage) AS PeakMonthlyUsage,
        COUNT(CASE WHEN CR.Status = 'Critical' THEN 1 END) AS MonthlyCriticalCount
    FROM CapacityTargets CT
    INNER JOIN CapacityRecords CR ON CT.TargetID = CR.TargetID
    GROUP BY CT.ResourceType, FORMAT(CR.RecordedAt, 'yyyy-MM')
    ORDER BY CT.ResourceType, Month DESC;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetConfigKPIs]
-- =============================================

CREATE PROCEDURE GetConfigKPIs
AS
BEGIN
    -- إجمالي العناصر
    SELECT COUNT(*) AS TotalConfigItems
    FROM ConfigItems;

    -- نسبة العناصر النشطة مقابل المتوقفة
    SELECT 
        SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) AS ActiveCount,
        SUM(CASE WHEN Status <> 'Active' THEN 1 ELSE 0 END) AS InactiveCount,
        CAST(SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS ActivePercentage,
        CAST(SUM(CASE WHEN Status <> 'Active' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS InactivePercentage
    FROM ConfigItems;

    -- معدل التغييرات لكل عنصر
    SELECT 
        CI.ItemType,
        COUNT(CC.ChangeID) AS TotalChanges,
        CAST(COUNT(CC.ChangeID) * 1.0 / COUNT(DISTINCT CI.ConfigID) AS DECIMAL(5,2)) AS AvgChangesPerItem
    FROM ConfigItems CI
    LEFT JOIN ConfigChanges CC ON CI.ConfigID = CC.ConfigID
    GROUP BY CI.ItemType;

    -- معدل التغييرات الشهري
    SELECT 
        FORMAT(ChangeDate, 'yyyy-MM') AS Month,
        COUNT(*) AS ChangesCount
    FROM ConfigChanges
    GROUP BY FORMAT(ChangeDate, 'yyyy-MM')
    ORDER BY Month DESC;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetConfigSummary]
-- =============================================

CREATE PROCEDURE GetConfigSummary
AS
BEGIN
    -- عدد العناصر حسب الحالة
    SELECT 
        Status,
        COUNT(*) AS ConfigCount
    FROM ConfigItems
    GROUP BY Status;

    -- عدد العناصر حسب النوع
    SELECT 
        ItemType,
        COUNT(*) AS ConfigCount
    FROM ConfigItems
    GROUP BY ItemType;

    -- عدد العناصر حسب المالك
    SELECT 
        Owner,
        COUNT(*) AS ConfigCount
    FROM ConfigItems
    GROUP BY Owner;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetContinuitySummary]
-- =============================================


CREATE PROCEDURE GetContinuitySummary
AS
BEGIN
    -- إجمالي عدد الخطط
    SELECT COUNT(*) AS TotalPlans
    FROM ContinuityPlans;

    -- عدد الخطط حسب الحالة
    SELECT 
        Status,
        COUNT(*) AS PlanCount
    FROM ContinuityPlans
    GROUP BY Status;

    -- نسبة الاختبارات الناجحة مقابل الفاشلة
    SELECT 
        CP.PlanName,
        COUNT(CT.TestID) AS TotalTests,
        SUM(CASE WHEN CT.TestStatus = 'Successful' THEN 1 ELSE 0 END) AS SuccessfulTests,
        SUM(CASE WHEN CT.TestStatus = 'Failed' THEN 1 ELSE 0 END) AS FailedTests,
        CAST(SUM(CASE WHEN CT.TestStatus = 'Successful' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(CT.TestID),0) AS DECIMAL(5,2)) AS SuccessRate,
        CAST(SUM(CASE WHEN CT.TestStatus = 'Failed' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(CT.TestID),0) AS DECIMAL(5,2)) AS FailureRate
    FROM ContinuityPlans CP
    LEFT JOIN ContinuityTests CT ON CP.PlanID = CT.PlanID
    GROUP BY CP.PlanName;

    -- متوسط عدد الاختبارات لكل خطة
    SELECT 
        CP.PlanName,
        AVG(TestCount) AS AvgTestsPerPlan
    FROM (
        SELECT PlanID, COUNT(TestID) AS TestCount
        FROM ContinuityTests
        GROUP BY PlanID
    ) AS Sub
    INNER JOIN ContinuityPlans CP ON Sub.PlanID = CP.PlanID
    GROUP BY CP.PlanName;

    -- 📊 Trend Analysis: الاختبارات شهرياً
    SELECT 
        CP.PlanName,
        FORMAT(CT.TestDate, 'yyyy-MM') AS Month,
        COUNT(*) AS MonthlyTests,
        SUM(CASE WHEN CT.TestStatus = 'Successful' THEN 1 ELSE 0 END) AS MonthlySuccessful,
        SUM(CASE WHEN CT.TestStatus = 'Failed' THEN 1 ELSE 0 END) AS MonthlyFailed
    FROM ContinuityPlans CP
    INNER JOIN ContinuityTests CT ON CP.PlanID = CT.PlanID
    GROUP BY CP.PlanName, FORMAT(CT.TestDate, 'yyyy-MM')
    ORDER BY CP.PlanName, Month DESC;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetCustomerSegmentationAnalytics]
-- =============================================

CREATE PROCEDURE GetCustomerSegmentationAnalytics
    @Gender NVARCHAR(10) = NULL,   -- Male / Female
    @MinAge INT = NULL,
    @MaxAge INT = NULL,
    @Region NVARCHAR(100) = NULL,
    @RoleName NVARCHAR(50) = NULL  -- SmallMerchant / BigMerchant / Consumer
AS
BEGIN
    SELECT 
        U.UserID,
        U.UserName,
        U.Email,
        CP.Gender,
        CP.Age,
        CP.Region,
        R.RoleName,
        FR.ForecastType,
        FR.ForecastPeriod,
        FR.ForecastDate,
        FR.ExpectedValue,
        FH.ActualValue,
        CASE 
            WHEN FR.ExpectedValue = 0 THEN 0
            ELSE ROUND((ISNULL(FH.ActualValue,0) / FR.ExpectedValue) * 100, 2)
        END AS AccuracyPercentage
    FROM Users U
    INNER JOIN UsersData UD ON U.UserID = UD.UserID
    INNER JOIN Roles R ON UD.RoleID = R.RoleID
    LEFT JOIN CustomerProfile CP ON U.UserID = CP.UserID
    LEFT JOIN ForecastingReports FR ON U.UserID = FR.ProductID
    LEFT JOIN ForecastingHistory FH ON FR.ForecastID = FH.ForecastID
    WHERE (@Gender IS NULL OR CP.Gender = @Gender)
      AND (@MinAge IS NULL OR CP.Age >= @MinAge)
      AND (@MaxAge IS NULL OR CP.Age <= @MaxAge)
      AND (@Region IS NULL OR CP.Region = @Region)
      AND (@RoleName IS NULL OR R.RoleName = @RoleName)
    ORDER BY FR.ForecastDate DESC;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetCustomerSegmentationAnalyticsWithStats]
-- =============================================

CREATE PROCEDURE GetCustomerSegmentationAnalyticsWithStats
    @Gender NVARCHAR(10) = NULL,   -- Male / Female
    @MinAge INT = NULL,
    @MaxAge INT = NULL,
    @Region NVARCHAR(100) = NULL,
    @RoleName NVARCHAR(50) = NULL  -- SmallMerchant / BigMerchant / Consumer
AS
BEGIN
    -- تفاصيل العملاء مع التوقعات
    SELECT 
        U.UserID,
        U.UserName,
        U.Email,
        CP.Gender,
        CP.Age,
        CP.Region,
        R.RoleName,
        FR.ForecastType,
        FR.ForecastPeriod,
        FR.ForecastDate,
        FR.ExpectedValue,
        FH.ActualValue,
        CASE 
            WHEN FR.ExpectedValue = 0 THEN 0
            ELSE ROUND((ISNULL(FH.ActualValue,0) / FR.ExpectedValue) * 100, 2)
        END AS AccuracyPercentage
    FROM Users U
    INNER JOIN UsersData UD ON U.UserID = UD.UserID
    INNER JOIN Roles R ON UD.RoleID = R.RoleID
    LEFT JOIN CustomerProfile CP ON U.UserID = CP.UserID
    LEFT JOIN ForecastingReports FR ON U.UserID = FR.ProductID
    LEFT JOIN ForecastingHistory FH ON FR.ForecastID = FH.ForecastID
    WHERE (@Gender IS NULL OR CP.Gender = @Gender)
      AND (@MinAge IS NULL OR CP.Age >= @MinAge)
      AND (@MaxAge IS NULL OR CP.Age <= @MaxAge)
      AND (@Region IS NULL OR CP.Region = @Region)
      AND (@RoleName IS NULL OR R.RoleName = @RoleName)
    ORDER BY FR.ForecastDate DESC;

    -- إحصائيات مجمعة حسب النوع
    SELECT 
        CP.Gender,
        COUNT(*) AS CustomerCount
    FROM CustomerProfile CP
    INNER JOIN Users U ON CP.UserID = U.UserID
    GROUP BY CP.Gender;

    -- إحصائيات مجمعة حسب الفئة العمرية
    SELECT 
        CASE 
            WHEN CP.Age BETWEEN 18 AND 25 THEN '18-25'
            WHEN CP.Age BETWEEN 26 AND 35 THEN '26-35'
            WHEN CP.Age BETWEEN 36 AND 45 THEN '36-45'
            WHEN CP.Age BETWEEN 46 AND 60 THEN '46-60'
            ELSE '60+'
        END AS AgeGroup,
        COUNT(*) AS CustomerCount
    FROM CustomerProfile CP
    INNER JOIN Users U ON CP.UserID = U.UserID
    GROUP BY CASE 
            WHEN CP.Age BETWEEN 18 AND 25 THEN '18-25'
            WHEN CP.Age BETWEEN 26 AND 35 THEN '26-35'
            WHEN CP.Age BETWEEN 36 AND 45 THEN '36-45'
            WHEN CP.Age BETWEEN 46 AND 60 THEN '46-60'
            ELSE '60+'
        END;

    -- إحصائيات مجمعة حسب المنطقة
    SELECT 
        CP.Region,
        COUNT(*) AS CustomerCount
    FROM CustomerProfile CP
    INNER JOIN Users U ON CP.UserID = U.UserID
    GROUP BY CP.Region;

    -- إحصائيات مجمعة حسب نوع التاجر
    SELECT 
        R.RoleName,
        COUNT(*) AS CustomerCount
    FROM Roles R
    INNER JOIN UsersData UD ON R.RoleID = UD.RoleID
    INNER JOIN Users U ON UD.UserID = U.UserID
    GROUP BY R.RoleName;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetDailyReports]
-- =============================================



CREATE PROCEDURE GetDailyReports
AS
BEGIN
    SELECT * FROM Reports WHERE ReportType = 'Operational' AND CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetDynamicCustomerSegmentationReport]
-- =============================================

  CREATE PROCEDURE GetDynamicCustomerSegmentationReport
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    -- بناء الأعمدة ديناميكيًا من جدول CustomerProfile
    SELECT @sql = STRING_AGG(QUOTENAME(c.name), ', ')
    FROM sys.columns c
    INNER JOIN sys.tables t ON c.object_id = t.object_id
    WHERE t.name = 'CustomerProfile'
      AND c.name NOT IN ('ProfileID','UserID','CreatedAt'); -- استبعاد الأعمدة الأساسية

    -- بناء الاستعلام النهائي
    SET @sql = '
    SELECT 
        U.UserID,
        U.UserName,
        U.Email,
        ' + @sql + ',
        R.RoleName,
        FR.ForecastType,
        FR.ForecastPeriod,
        FR.ForecastDate,
        FR.ExpectedValue,
        FH.ActualValue,
        CASE 
            WHEN FR.ExpectedValue = 0 THEN 0
            ELSE ROUND((ISNULL(FH.ActualValue,0) / FR.ExpectedValue) * 100, 2)
        END AS AccuracyPercentage
    FROM Users U
    LEFT JOIN CustomerProfile CP ON U.UserID = CP.UserID
    LEFT JOIN Roles R ON U.UserID = R.RoleID
    LEFT JOIN ForecastingReports FR ON U.UserID = FR.ProductID
    LEFT JOIN ForecastingHistory FH ON FR.ForecastID = FH.ForecastID
    ORDER BY FR.ForecastDate DESC;';

    EXEC sp_executesql @sql;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetDynamicCustomerSegmentationWithStats]
-- =============================================

CREATE PROCEDURE GetDynamicCustomerSegmentationWithStats
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    -- بناء الاستعلام الأساسي للتفاصيل
    SET @sql = '
    SELECT 
        U.UserID,
        U.UserName,
        U.Email,
        CP.*,
        R.RoleName,
        FR.ForecastType,
        FR.ForecastPeriod,
        FR.ForecastDate,
        FR.ExpectedValue,
        FH.ActualValue,
        CASE 
            WHEN FR.ExpectedValue = 0 THEN 0
            ELSE ROUND((ISNULL(FH.ActualValue,0) / FR.ExpectedValue) * 100, 2)
        END AS AccuracyPercentage
    FROM Users U
    LEFT JOIN CustomerProfile CP ON U.UserID = CP.UserID
    LEFT JOIN Roles R ON U.UserID = R.RoleID
    LEFT JOIN ForecastingReports FR ON U.UserID = FR.ProductID
    LEFT JOIN ForecastingHistory FH ON FR.ForecastID = FH.ForecastID
    ORDER BY FR.ForecastDate DESC;';

    EXEC sp_executesql @sql;

    -- إحصائيات مجمعة ديناميكية: لكل عمود في CustomerProfile
    DECLARE cur CURSOR FOR
    SELECT c.name
    FROM sys.columns c
    INNER JOIN sys.tables t ON c.object_id = t.object_id
    WHERE t.name = 'CustomerProfile'
      AND c.name NOT IN ('ProfileID','UserID','CreatedAt');

    DECLARE @col NVARCHAR(128);

    OPEN cur;
    FETCH NEXT FROM cur INTO @col;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = '
        SELECT ''' + @col + ''' AS ColumnName, ' + @col + ' AS Value, COUNT(*) AS CustomerCount
        FROM CustomerProfile
        GROUP BY ' + @col + ';';

        EXEC sp_executesql @sql;

        FETCH NEXT FROM cur INTO @col;
    END;

    CLOSE cur;
    DEALLOCATE cur;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetFinancialSummary]
-- =============================================
CREATE   PROCEDURE GetFinancialSummary
    @EntityType NVARCHAR(50), -- 'SmallMerchant' أو 'BigMerchant' أو 'Role'
    @EntityID INT
AS
BEGIN
    IF @EntityType = 'SmallMerchant'
    BEGIN
        SELECT 
            sm.SmallMerchantID,
            sm.ShopName,
            COUNT(o.OrderID) AS TotalOrders,
            SUM(o.TotalAmount) AS TotalOrderAmount,
            SUM(p.Amount) AS TotalPayments
        FROM SmallMerchant sm
        INNER JOIN Orders o ON sm.SmallMerchantID = o.SmallMerchantID
        INNER JOIN Payments p ON o.OrderID = p.OrderID
        WHERE sm.SmallMerchantID = @EntityID
        GROUP BY sm.SmallMerchantID, sm.ShopName;
    END

    ELSE IF @EntityType = 'BigMerchant'
    BEGIN
        SELECT 
            bm.BigMerchantID,
            bm.CompanyName,
            COUNT(p.PaymentID) AS TotalPaymentsCount,
            SUM(p.Amount) AS TotalPayments,
            SUM(o.TotalAmount) AS TotalOrdersAmount
        FROM BigMerchant bm
        INNER JOIN Products pr ON bm.BigMerchantID = pr.BigMerchantID
        INNER JOIN SmallMerchantProducts smp ON pr.ProductID = smp.ProductID
        INNER JOIN Orders o ON smp.SmallMerchantID = o.SmallMerchantID
        INNER JOIN Payments p ON o.OrderID = p.OrderID
        WHERE bm.BigMerchantID = @EntityID
        GROUP BY bm.BigMerchantID, bm.CompanyName;
    END

    ELSE IF @EntityType = 'Role'
    BEGIN
        SELECT 
            r.RoleID,
            r.RoleName,
            COUNT(o.OrderID) AS TotalOrders,
            SUM(o.TotalAmount) AS TotalOrderAmount,
            SUM(p.Amount) AS TotalPayments
        FROM Roles r
        INNER JOIN Users u ON r.RoleID = u.RoleID
        INNER JOIN Orders o ON u.UserID = o.CustomerID
        INNER JOIN Payments p ON o.OrderID = p.OrderID
        WHERE r.RoleID = @EntityID
        GROUP BY r.RoleID, r.RoleName;
    END
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetForecastAccuracyReport]
-- =============================================

   CREATE PROCEDURE GetForecastAccuracyReport
AS
BEGIN
    SELECT 
        FR.ForecastID,
        FR.ProductID,
        FR.ForecastType,
        FR.ForecastPeriod,
        FR.ForecastDate,
        FR.ExpectedValue,
        FH.ActualValue,
        FH.ComparisonDate,
        CASE 
            WHEN FR.ExpectedValue = 0 THEN 0
            ELSE ROUND((FH.ActualValue / FR.ExpectedValue) * 100, 2)
        END AS AccuracyPercentage
    FROM ForecastingReports FR
    INNER JOIN ForecastingHistory FH 
        ON FR.ForecastID = FH.ForecastID
    ORDER BY FR.ForecastDate DESC;
END;

   
GO


-- =============================================
-- Stored Procedure: [dbo].[GetInvoiceFinancialSummary]
-- =============================================


CREATE   PROCEDURE GetInvoiceFinancialSummary
AS
BEGIN
    SELECT 
        YEAR(i.IssueDate) AS Year,
        MONTH(i.IssueDate) AS Month,
        SUM(i.Amount) AS TotalInvoiceAmount,
        COUNT(i.InvoiceID) AS InvoiceCount
    FROM Invoices i
    GROUP BY YEAR(i.IssueDate), MONTH(i.IssueDate)
    ORDER BY Year, Month;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetLedgerFinancialSummary]
-- =============================================


CREATE   PROCEDURE GetLedgerFinancialSummary
AS
BEGIN
    SELECT 
        YEAR(TransactionDate) AS Year,
        MONTH(TransactionDate) AS Month,
        SUM(CASE WHEN DebitCredit = 'Debit' THEN Amount ELSE 0 END) AS TotalDebits,
        SUM(CASE WHEN DebitCredit = 'Credit' THEN Amount ELSE 0 END) AS TotalCredits,
        SUM(Amount) AS NetAmount
    FROM Ledger
    GROUP BY YEAR(TransactionDate), MONTH(TransactionDate)
    ORDER BY Year, Month;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetLoginAnalytics]
-- =============================================

   
   CREATE PROCEDURE GetLoginAnalytics
AS
BEGIN
    -- أكثر الساعات كثافة دخول
    SELECT 
        DATEPART(HOUR, LoginTime) AS HourOfDay,
        COUNT(*) AS LoginCount
    FROM UserSessions
    GROUP BY DATEPART(HOUR, LoginTime)
    ORDER BY LoginCount DESC;

    -- أكثر الأيام كثافة دخول
    SELECT 
        DATENAME(WEEKDAY, LoginTime) AS DayOfWeek,
        COUNT(*) AS LoginCount
    FROM UserSessions
    GROUP BY DATENAME(WEEKDAY, LoginTime)
    ORDER BY LoginCount DESC;

    -- أكثر أنواع الأجهزة استخدامًا
    SELECT 
        DeviceType,
        COUNT(*) AS DeviceCount
    FROM UserSessions
    GROUP BY DeviceType
    ORDER BY DeviceCount DESC;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetMerchantFinancialSummary]
-- =============================================
CREATE   PROCEDURE GetMerchantFinancialSummary
    @MerchantType NVARCHAR(50), -- 'Small' أو 'Big'
    @MerchantID INT
AS
BEGIN
    IF @MerchantType = 'Small'
    BEGIN
        SELECT 
            sm.SmallMerchantID,
            sm.ShopName,
            COUNT(o.OrderID) AS TotalOrders,
            SUM(o.TotalAmount) AS TotalOrderAmount,
            SUM(p.Amount) AS TotalPayments
        FROM SmallMerchant sm
        INNER JOIN Orders o ON sm.SmallMerchantID = o.SmallMerchantID
        INNER JOIN Payments p ON o.OrderID = p.OrderID
        WHERE sm.SmallMerchantID = @MerchantID
        GROUP BY sm.SmallMerchantID, sm.ShopName;
    END

    ELSE IF @MerchantType = 'Big'
    BEGIN
        SELECT 
            bm.BigMerchantID,
            bm.CompanyName,
            COUNT(p.PaymentID) AS TotalPaymentsCount,
            SUM(p.Amount) AS TotalPayments,
            SUM(o.TotalAmount) AS TotalOrdersAmount
        FROM BigMerchant bm
        INNER JOIN Products pr ON bm.BigMerchantID = pr.BigMerchantID
        INNER JOIN SmallMerchantProducts smp ON pr.ProductID = smp.ProductID
        INNER JOIN Orders o ON smp.SmallMerchantID = o.SmallMerchantID
        INNER JOIN Payments p ON o.OrderID = p.OrderID
        WHERE bm.BigMerchantID = @MerchantID
        GROUP BY bm.BigMerchantID, bm.CompanyName;
    END
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetMonthlyFinancialSummary]
-- =============================================



CREATE   PROCEDURE GetMonthlyFinancialSummary
AS
BEGIN
    SELECT 
        YEAR(p.PaymentDate) AS Year,
        MONTH(p.PaymentDate) AS Month,
        SUM(p.Amount) AS TotalPayments,
        COUNT(p.PaymentID) AS PaymentCount,
        SUM(o.TotalAmount) AS TotalOrders
    FROM Payments p
    INNER JOIN Orders o ON p.OrderID = o.OrderID
    GROUP BY YEAR(p.PaymentDate), MONTH(p.PaymentDate)
    ORDER BY Year, Month;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetMonthlyReports]
-- =============================================



CREATE PROCEDURE GetMonthlyReports
AS
BEGIN
    SELECT * FROM Reports WHERE ReportType = 'Financial' AND MONTH(CreatedAt) = MONTH(GETDATE());
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetMonthlySalesForecastReport]
-- =============================================

   CREATE PROCEDURE GetMonthlySalesForecastReport
AS
BEGIN
    -- تفاصيل التوقعات لكل منتج
    SELECT 
        FR.ForecastID,
        FR.ProductID,
        P.ProductName,
        FR.ForecastType,
        FR.ForecastPeriod,
        FR.ForecastDate,
        FR.ExpectedValue,
        FH.ActualValue,
        FH.ComparisonDate,
        CASE 
            WHEN FR.ExpectedValue = 0 THEN 0
            ELSE ROUND((FH.ActualValue / FR.ExpectedValue) * 100, 2)
        END AS AccuracyPercentage
    FROM ForecastingReports FR
    LEFT JOIN ForecastingHistory FH 
        ON FR.ForecastID = FH.ForecastID
    LEFT JOIN Products P 
        ON FR.ProductID = P.ProductID
    WHERE FR.ForecastType = 'Sales'
      AND FR.ForecastPeriod = 'Monthly'
    ORDER BY FR.ForecastDate DESC;

    -- ملخص شهري على مستوى كل المنتجات
    SELECT 
        FR.ForecastPeriod,
        FR.ForecastDate,
        SUM(FR.ExpectedValue) AS TotalExpectedSales,
        SUM(ISNULL(FH.ActualValue,0)) AS TotalActualSales,
        CASE 
            WHEN SUM(FR.ExpectedValue) = 0 THEN 0
            ELSE ROUND((SUM(ISNULL(FH.ActualValue,0)) / SUM(FR.ExpectedValue)) * 100, 2)
        END AS OverallAccuracyPercentage
    FROM ForecastingReports FR
    LEFT JOIN ForecastingHistory FH 
        ON FR.ForecastID = FH.ForecastID
    WHERE FR.ForecastType = 'Sales'
      AND FR.ForecastPeriod = 'Monthly'
    GROUP BY FR.ForecastPeriod, FR.ForecastDate
    ORDER BY FR.ForecastDate DESC;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetPeakLoginTimesAndDevices]
-- =============================================

CREATE PROCEDURE GetPeakLoginTimesAndDevices
AS
BEGIN
    -- أكثر الأوقات كثافة دخول
    SELECT 
        DATEPART(HOUR, LoginTime) AS HourOfDay,
        COUNT(*) AS LoginCount
    FROM UserSessions
    GROUP BY DATEPART(HOUR, LoginTime)
    ORDER BY LoginCount DESC;

    -- أكثر أنواع الأجهزة استخدامًا
    SELECT 
        DeviceType,
        COUNT(*) AS DeviceCount
    FROM UserSessions
    GROUP BY DeviceType
    ORDER BY DeviceCount DESC;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetProblemSummary]
-- =============================================


CREATE PROCEDURE GetProblemSummary
AS
BEGIN
    -- عدد المشاكل حسب الحالة
    SELECT 
        Status,
        COUNT(*) AS ProblemCount
    FROM ProblemCatalog
    GROUP BY Status;

    -- عدد المشاكل حسب الفئة (Category)
    SELECT 
        Category,
        COUNT(*) AS ProblemCount
    FROM ProblemCatalog
    GROUP BY Category;

    -- عدد المشاكل حسب المستخدم اللي سجلها
    SELECT 
        U.UserName AS CreatedBy,
        COUNT(*) AS ProblemCount
    FROM ProblemCatalog PC
    INNER JOIN Users U ON PC.CreatedBy = U.UserID
    GROUP BY U.UserName;

    -- عدد المشاكل المرتبطة بالحوادث (Incidents)
    SELECT 
        IR.IncidentID,
        COUNT(*) AS RelatedProblems
    FROM ProblemRecords PR
    INNER JOIN IncidentReports IR ON PR.RelatedIncidentID = IR.IncidentID
    GROUP BY IR.IncidentID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetQuarterlyLedgerSummary]
-- =============================================
CREATE   PROCEDURE GetQuarterlyLedgerSummary
AS
BEGIN
    SELECT 
        YEAR(TransactionDate) AS Year,
        DATEPART(QUARTER, TransactionDate) AS Quarter,
        SUM(CASE WHEN DebitCredit = 'Debit' THEN Amount ELSE 0 END) AS TotalDebits,
        SUM(CASE WHEN DebitCredit = 'Credit' THEN Amount ELSE 0 END) AS TotalCredits,
        SUM(Amount) AS NetAmount
    FROM Ledger
    GROUP BY YEAR(TransactionDate), DATEPART(QUARTER, TransactionDate)
    ORDER BY Year, Quarter;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetRefundFinancialSummary]
-- =============================================


CREATE   PROCEDURE GetRefundFinancialSummary
AS
BEGIN
    SELECT 
        YEAR(r.RefundDate) AS Year,
        MONTH(r.RefundDate) AS Month,
        SUM(r.RefundAmount) AS TotalRefunds,
        COUNT(r.RefundID) AS RefundCount
    FROM Refunds r
    GROUP BY YEAR(r.RefundDate), MONTH(r.RefundDate)
    ORDER BY Year, Month;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetReleaseKPIs]
-- =============================================
CREATE PROCEDURE GetReleaseKPIs
AS
BEGIN
    -- إجمالي عدد الإصدارات
    SELECT COUNT(*) AS TotalReleases
    FROM Releases;

    -- نسبة الإصدارات المكتملة مقابل المخططة
    SELECT 
        SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END) AS CompletedCount,
        SUM(CASE WHEN Status = 'Planned' THEN 1 ELSE 0 END) AS PlannedCount,
        CAST(SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS CompletedPercentage,
        CAST(SUM(CASE WHEN Status = 'Planned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS PlannedPercentage
    FROM Releases;

    -- نسبة النشرات الناجحة مقابل الفاشلة
    SELECT 
        SUM(CASE WHEN DeploymentStatus = 'Successful' THEN 1 ELSE 0 END) AS SuccessfulCount,
        SUM(CASE WHEN DeploymentStatus = 'Failed' THEN 1 ELSE 0 END) AS FailedCount,
        CAST(SUM(CASE WHEN DeploymentStatus = 'Successful' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS SuccessRate,
        CAST(SUM(CASE WHEN DeploymentStatus = 'Failed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS FailureRate
    FROM ReleaseDeployments;

    -- معدل النشر الشهري (Trend Analysis)
    SELECT 
        FORMAT(DeployedAt, 'yyyy-MM') AS Month,
        COUNT(*) AS DeploymentsCount
    FROM ReleaseDeployments
    GROUP BY FORMAT(DeployedAt, 'yyyy-MM')
    ORDER BY Month DESC;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetReleaseSummary]
-- =============================================

CREATE PROCEDURE GetReleaseSummary
AS
BEGIN
    -- عدد الإصدارات حسب الحالة
    SELECT 
        Status,
        COUNT(*) AS ReleaseCount
    FROM Releases
    GROUP BY Status;

    -- عدد النشرات حسب حالة النشر
    SELECT 
        DeploymentStatus,
        COUNT(*) AS DeploymentCount
    FROM ReleaseDeployments
    GROUP BY DeploymentStatus;

    -- عدد الإصدارات مع إجمالي النشرات المرتبطة بها
    SELECT 
        R.ReleaseID,
        R.ReleaseName,
        R.Status,
        COUNT(RD.DeploymentID) AS TotalDeployments,
        SUM(CASE WHEN RD.DeploymentStatus = 'Successful' THEN 1 ELSE 0 END) AS SuccessfulDeployments,
        SUM(CASE WHEN RD.DeploymentStatus = 'Failed' THEN 1 ELSE 0 END) AS FailedDeployments
    FROM Releases R
    LEFT JOIN ReleaseDeployments RD ON R.ReleaseID = RD.ReleaseID
    GROUP BY R.ReleaseID, R.ReleaseName, R.Status;
END;

GO


-- =============================================
-- Stored Procedure: [dbo].[GetRoleLedgerSummary]
-- =============================================


CREATE   PROCEDURE GetRoleLedgerSummary
    @RoleID INT
AS
BEGIN
    SELECT 
        r.RoleID,
        r.RoleName,
        YEAR(l.TransactionDate) AS Year,
        DATEPART(QUARTER, l.TransactionDate) AS Quarter,
        SUM(CASE WHEN l.DebitCredit = 'Debit' THEN l.Amount ELSE 0 END) AS TotalDebits,
        SUM(CASE WHEN l.DebitCredit = 'Credit' THEN l.Amount ELSE 0 END) AS TotalCredits,
        SUM(l.Amount) AS NetAmount
    FROM Roles r
    INNER JOIN Users u ON r.RoleID = u.RoleID
    INNER JOIN Orders o ON u.UserID = o.CustomerID
    INNER JOIN Payments p ON o.OrderID = p.OrderID
    INNER JOIN Ledger l ON l.ReferenceID = p.PaymentID AND l.TransactionType = 'Payment'
    WHERE r.RoleID = @RoleID
    GROUP BY r.RoleID, r.RoleName, YEAR(l.TransactionDate), DATEPART(QUARTER, l.TransactionDate)
    ORDER BY Year, Quarter;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetTaxFinancialSummary]
-- =============================================


CREATE   PROCEDURE GetTaxFinancialSummary
AS
BEGIN
    SELECT 
        YEAR(o.CreatedAt) AS Year,
        MONTH(o.CreatedAt) AS Month,
        SUM(t.TaxAmount) AS TotalTaxes,
        AVG(t.TaxRate) AS AvgTaxRate
    FROM Taxes t
    INNER JOIN Orders o ON t.OrderID = o.OrderID
    GROUP BY YEAR(o.CreatedAt), MONTH(o.CreatedAt)
    ORDER BY Year, Month;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetUserFinancialSummary]
-- =============================================



CREATE   PROCEDURE GetUserFinancialSummary
    @UserID INT
AS
BEGIN
    SELECT 
        u.UserID,
        u.UserName,
        COUNT(o.OrderID) AS TotalOrders,
        SUM(o.TotalAmount) AS TotalOrderAmount,
        SUM(p.Amount) AS TotalPayments
    FROM Users u
    LEFT JOIN Orders o ON u.UserID = o.CustomerID
    LEFT JOIN Payments p ON o.OrderID = p.OrderID
    WHERE u.UserID = @UserID
    GROUP BY u.UserID, u.UserName;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetUsersByRole]
-- =============================================

CREATE PROCEDURE GetUsersByRole
    @RoleName NVARCHAR(100)
AS
BEGIN
    SELECT 
        U.UserID,
        U.UserName,
        U.Email,
        U.Status,
        R.RoleName
    FROM Users U
    INNER JOIN UsersData UD ON U.UserID = UD.UserID
    INNER JOIN Roles R ON UD.RoleID = R.RoleID
    WHERE R.RoleName = @RoleName;
END;

GO


-- =============================================
-- Stored Procedure: [dbo].[GetUsersByStatus]
-- =============================================
   
CREATE PROCEDURE GetUsersByStatus
    @Status NVARCHAR(50)
AS
BEGIN
    SELECT 
        U.UserID,
        U.UserName,
        U.Email,
        U.Status,
        R.RoleName
    FROM Users U
    INNER JOIN UsersData UD ON U.UserID = UD.UserID
    INNER JOIN Roles R ON UD.RoleID = R.RoleID
    WHERE U.Status = @Status;
END;

GO


-- =============================================
-- Stored Procedure: [dbo].[GetUserSummary]
-- =============================================

CREATE PROCEDURE GetUserSummary
    @UserID INT
AS
BEGIN
    SELECT * FROM UserSummary WHERE UserID = @UserID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetUserWithRole]
-- =============================================

CREATE PROCEDURE GetUserWithRole
    @UserID INT
AS
BEGIN
    SELECT 
        U.UserID,
        U.UserName,
        U.Email,
        U.Status,
        R.RoleName,
        R.Description
    FROM Users U
    INNER JOIN UsersData UD ON U.UserID = UD.UserID
    INNER JOIN Roles R ON UD.RoleID = R.RoleID
    WHERE U.UserID = @UserID;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetYearlyFinancialSummary]
-- =============================================

CREATE   PROCEDURE GetYearlyFinancialSummary
AS
BEGIN
    SELECT 
        YEAR(p.PaymentDate) AS Year,
        SUM(p.Amount) AS TotalPayments,
        COUNT(p.PaymentID) AS PaymentCount,
        SUM(o.TotalAmount) AS TotalOrders
    FROM Payments p
    INNER JOIN Orders o ON p.OrderID = o.OrderID
    GROUP BY YEAR(p.PaymentDate)
    ORDER BY Year;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetYearlyLedgerSummary]
-- =============================================


CREATE   PROCEDURE GetYearlyLedgerSummary
AS
BEGIN
    SELECT 
        YEAR(TransactionDate) AS Year,
        SUM(CASE WHEN DebitCredit = 'Debit' THEN Amount ELSE 0 END) AS TotalDebits,
        SUM(CASE WHEN DebitCredit = 'Credit' THEN Amount ELSE 0 END) AS TotalCredits,
        SUM(Amount) AS NetAmount
    FROM Ledger
    GROUP BY YEAR(TransactionDate)
    ORDER BY Year;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[GetYearlySalesForecastReport]
-- =============================================
  
CREATE PROCEDURE GetYearlySalesForecastReport
AS
BEGIN
    -- تفاصيل التوقعات لكل منتج على مستوى السنة
    SELECT 
        FR.ForecastID,
        FR.ProductID,
        P.ProductName,
        FR.ForecastType,
        FR.ForecastPeriod,
        YEAR(FR.ForecastDate) AS ForecastYear,
        FR.ExpectedValue,
        FH.ActualValue,
        FH.ComparisonDate,
        CASE 
            WHEN FR.ExpectedValue = 0 THEN 0
            ELSE ROUND((FH.ActualValue / FR.ExpectedValue) * 100, 2)
        END AS AccuracyPercentage
    FROM ForecastingReports FR
    LEFT JOIN ForecastingHistory FH 
        ON FR.ForecastID = FH.ForecastID
    LEFT JOIN Products P 
        ON FR.ProductID = P.ProductID
    WHERE FR.ForecastType = 'Sales'
      AND FR.ForecastPeriod = 'Yearly'
    ORDER BY ForecastYear DESC;

    -- ملخص سنوي على مستوى كل المنتجات
    SELECT 
        YEAR(FR.ForecastDate) AS ForecastYear,
        SUM(FR.ExpectedValue) AS TotalExpectedSales,
        SUM(ISNULL(FH.ActualValue,0)) AS TotalActualSales,
        CASE 
            WHEN SUM(FR.ExpectedValue) = 0 THEN 0
            ELSE ROUND((SUM(ISNULL(FH.ActualValue,0)) / SUM(FR.ExpectedValue)) * 100, 2)
        END AS OverallAccuracyPercentage
    FROM ForecastingReports FR
    LEFT JOIN ForecastingHistory FH 
        ON FR.ForecastID = FH.ForecastID
    WHERE FR.ForecastType = 'Sales'
      AND FR.ForecastPeriod = 'Yearly'
    GROUP BY YEAR(FR.ForecastDate)
    ORDER BY ForecastYear DESC;
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[HandleCashOnDelivery]
-- =============================================

CREATE PROCEDURE HandleCashOnDelivery
    @PaymentID INT,
    @DeliveryAddress NVARCHAR(300),
    @DeliveryDate DATETIME
AS
BEGIN
    INSERT INTO CashOnDelivery (PaymentID, DeliveryAddress, DeliveryDate, IsPaid)
    VALUES (@PaymentID, @DeliveryAddress, @DeliveryDate, 0);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[Insert_Order]
-- =============================================
CREATE   PROCEDURE Insert_Order
    @CustomerID INT,
    @SmallMerchantID INT = NULL,
    @Status NVARCHAR(50) = 'Pending',
    @PaymentStatus NVARCHAR(50) = 'Unpaid',
    @TotalAmount DECIMAL(18,2)
AS
BEGIN
    INSERT INTO Orders (CustomerID, SmallMerchantID, Status, PaymentStatus, TotalAmount, CreatedAt)
    VALUES (@CustomerID, @SmallMerchantID, @Status, @PaymentStatus, @TotalAmount, GETDATE());
END;

GO

-- =============================================
-- Stored Procedure: [dbo].[Insert_Payment]
-- =============================================
CREATE   PROCEDURE Insert_Payment
    @OrderID INT,
    @MerchantType NVARCHAR(50),
    @MerchantID INT,
    @Amount DECIMAL(18,2),
    @Status NVARCHAR(50) = 'Pending'
AS
BEGIN
    INSERT INTO Payments (OrderID, MerchantType, MerchantID, Amount, Status, PaymentDate, CreatedAt)
    VALUES (@OrderID, @MerchantType, @MerchantID, @Amount, @Status, GETDATE(), GETDATE());
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[Insert_User]
-- =============================================


CREATE   PROCEDURE Insert_User
    @UserName NVARCHAR(150),
    @Email NVARCHAR(200),
    @PasswordHash NVARCHAR(200),
    @Status NVARCHAR(50) = 'Active',
    @Notes NVARCHAR(250) = NULL,
    @RoleID INT = NULL,
    @Gender NVARCHAR(20) = NULL,
    @Age INT = NULL,
    @Region NVARCHAR(100) = NULL
AS
BEGIN
    INSERT INTO Users (UserName, Email, PasswordHash, Status, Notes, RoleID, Gender, Age, Region, CreatedAt)
    VALUES (@UserName, @Email, @PasswordHash, @Status, @Notes, @RoleID, @Gender, @Age, @Region, GETDATE());
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[Insert_Users]
-- =============================================
CREATE   PROCEDURE Insert_Users
    @UserName NVARCHAR(150),
    @Email NVARCHAR(200),
    @PasswordHash NVARCHAR(200),
    @Status NVARCHAR(50) = 'Active',
    @Notes NVARCHAR(250) = NULL,
    @RoleID INT = NULL,
    @Gender NVARCHAR(20) = NULL,
    @Age INT = NULL,
    @Region NVARCHAR(100) = NULL
AS
BEGIN
    INSERT INTO Users (UserName, Email, PasswordHash, Status, Notes, RoleID, Gender, Age, Region, CreatedAt)
    VALUES (@UserName, @Email, @PasswordHash, @Status, @Notes, @RoleID, @Gender, @Age, @Region, GETDATE());
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[InsertAuditLog]
-- =============================================
CREATE   PROCEDURE InsertAuditLog
    @EntityName NVARCHAR(100),
    @EntityID INT,
    @Action NVARCHAR(50),
    @ActionBy NVARCHAR(150),
    @Notes NVARCHAR(250) = NULL
AS
BEGIN
    INSERT INTO AuditLogs (EntityName, EntityID, Action, ActionBy, ActionDate, Notes)
    VALUES (@EntityName, @EntityID, @Action, @ActionBy, GETDATE(), @Notes);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[LogDowntime]
-- =============================================
CREATE PROCEDURE LogDowntime
    @TargetID INT,
    @DowntimeMinutes INT,
    @Status NVARCHAR(50),
    @LoggedBy INT,
    @IncidentDescription NVARCHAR(500)
AS
BEGIN
    INSERT INTO AvailabilityRecords (TargetID, ActualUptime, DowntimeMinutes, Status)
    VALUES (@TargetID, 100 - (@DowntimeMinutes * 100.0 / (30*24*60)), @DowntimeMinutes, @Status);

    DECLARE @RecordID INT = SCOPE_IDENTITY();

    INSERT INTO AvailabilityLogs (RecordID, IncidentDescription, LoggedBy)
    VALUES (@RecordID, @IncidentDescription, @LoggedBy);
END;
GO


-- =============================================
-- Stored Procedure: [dbo].[MonitorCapacity]
-- =============================================
CREATE PROCEDURE MonitorCapacity
    @TargetID INT,
    @ActualUsage DECIMAL(10,2),
    @ActionBy INT
AS
BEGIN
    DECLARE @TargetUsage DECIMAL(10,2);
    SELECT @TargetUsage = TargetUsage FROM CapacityTargets WHERE TargetID = @TargetID;

    DECLARE @Status NVARCHAR(50) = 
        CASE 
            WHEN @ActualUsage < @TargetUsage * 0.8 THEN 'Normal'
            WHEN @ActualUsage < @TargetUsage THEN 'Warning'
            ELSE 'Critical'
        END;

    INSERT INTO CapacityRecords (TargetID, ActualUsage, Status)
    VALUES (@TargetID, @ActualUsage, @Status);

    DECLARE @RecordID INT = SCOPE_IDENTITY();

    INSERT INTO CapacityLogs (RecordID, Action, ActionBy)
    VALUES (@RecordID, 'Capacity monitored: ' + CAST(@ActualUsage AS NVARCHAR), @ActionBy);
END;
GO



Completion time: 2026-08-25T22:58:37.8171114+03:00
