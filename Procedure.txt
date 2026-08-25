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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  



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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/







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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/



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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/


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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/


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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

    
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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  



 
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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE AddProduct;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   

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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  



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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/


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
-- Stored Procedure: [dbo].[DeleteProduct]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/







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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/


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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   

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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
   
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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  



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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  



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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  







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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  







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
-- Stored Procedure: [dbo].[GetForecastAccuracyReport]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

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
-- Stored Procedure: [dbo].[GetLoginAnalytics]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
   
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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
   
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
-- Stored Procedure: [dbo].[GetUsersByRole]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
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

/*

CREATE VIEW UserSummary AS
SELECT 
    u.UserID,
    u.UserName,
    MAX(al.LoginTime) AS LastLoginDate
FROM Users u
LEFT JOIN AuthenticationLogs al ON u.UserID = al.UserID
GROUP BY u.UserID, u.UserName;
*/

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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   

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
-- Stored Procedure: [dbo].[GetYearlySalesForecastReport]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  
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

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/




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

-- =============================================
-- Stored Procedure: [dbo].[OpenTicket]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  



  CREATE PROCEDURE OpenTicket
    @Title NVARCHAR(200),
    @Description NVARCHAR(500),
    @CategoryID INT,
    @OpenedBy INT
AS
BEGIN
    INSERT INTO SupportTickets (Title, Description, CategoryID, OpenedBy)
    VALUES (@Title, @Description, @CategoryID, @OpenedBy);
END;

 
GO

-- =============================================
-- Stored Procedure: [dbo].[RegisterPayment]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/



CREATE PROCEDURE RegisterPayment
    @OrderID INT,
    @Method NVARCHAR(50),
    @Amount DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Payments (OrderID, Method, Amount)
    VALUES (@OrderID, @Method, @Amount);
END;
GO

-- =============================================
-- Stored Procedure: [dbo].[RemoveRoleFromUser]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/


CREATE PROCEDURE RemoveRoleFromUser
    @UserID INT,
    @RoleID INT
AS
BEGIN
    DELETE FROM UsersRoles
    WHERE UserID = @UserID AND RoleID = @RoleID;
END;
GO

-- =============================================
-- Stored Procedure: [dbo].[ResolveProblem]
-- =============================================


CREATE PROCEDURE ResolveProblem
    @ProblemID INT,
    @ActionTaken NVARCHAR(250),
    @ActionBy INT
AS
BEGIN
    UPDATE ProblemCatalog
    SET Status = 'Resolved'
    WHERE ProblemID = @ProblemID;

    INSERT INTO ProblemRecords (ProblemID, ActionTaken, ActionBy)
    VALUES (@ProblemID, @ActionTaken, @ActionBy);

    INSERT INTO ProblemLogs (ProblemID, LogDescription, LoggedBy)
    VALUES (@ProblemID, 'Problem resolved: ' + @ActionTaken, @ActionBy);
END;
GO

-- =============================================
-- Stored Procedure: [dbo].[SubmitChangeRequest]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  



 
 CREATE PROCEDURE SubmitChangeRequest
    @Title NVARCHAR(200),
    @Description NVARCHAR(500),
    @Priority NVARCHAR(20),
    @RequestedBy INT
AS
BEGIN
    INSERT INTO ChangeRequests (Title, Description, Priority, RequestedBy)
    VALUES (@Title, @Description, @Priority, @RequestedBy);
END;

GO

-- =============================================
-- Stored Procedure: [dbo].[TestContinuityPlan]
-- =============================================


CREATE PROCEDURE TestContinuityPlan
    @PlanID INT,
    @Scenario NVARCHAR(100),
    @TestedBy NVARCHAR(150)
AS
BEGIN
    INSERT INTO ContinuityTests (PlanID, Scenario, TestedBy)
    VALUES (@PlanID, @Scenario, @TestedBy);

    INSERT INTO ContinuityLogs (PlanID, Action, ActionBy)
    VALUES (@PlanID, 'Continuity plan tested with scenario: ' + @Scenario, @TestedBy);
END;
GO

-- =============================================
-- Stored Procedure: [dbo].[UpdateAvailabilityStatus]
-- =============================================





CREATE PROCEDURE UpdateAvailabilityStatus
    @RecordID INT,
    @Status NVARCHAR(50),
    @DowntimeMinutes INT
AS
BEGIN
    UPDATE AvailabilityRecords
    SET Status = @Status,
        DowntimeMinutes = @DowntimeMinutes,
        ActualUptime = 100 - (@DowntimeMinutes * 100.0 / (30*24*60))
    WHERE RecordID = @RecordID;

    INSERT INTO AvailabilityLogs (RecordID, IncidentDescription, LoggedBy)
    VALUES (@RecordID, 'Availability status updated to ' + @Status, 0);
END;
GO

-- =============================================
-- Stored Procedure: [dbo].[UpdateCapacity]
-- =============================================



CREATE PROCEDURE UpdateCapacity
    @RecordID INT,
    @ActualUsage DECIMAL(10,2),
    @Status NVARCHAR(50),
    @ActionBy INT
AS
BEGIN
    UPDATE CapacityRecords
    SET ActualUsage = @ActualUsage,
        Status = @Status
    WHERE RecordID = @RecordID;

    INSERT INTO CapacityLogs (RecordID, Action, ActionBy)
    VALUES (@RecordID, 'Capacity updated to ' + CAST(@ActualUsage AS NVARCHAR), @ActionBy);
END;
GO

-- =============================================
-- Stored Procedure: [dbo].[UpdateConfigItem]
-- =============================================




CREATE PROCEDURE UpdateConfigItem
    @ConfigID INT,
    @Status NVARCHAR(50),
    @ChangeDescription NVARCHAR(500),
    @ChangedBy INT
AS
BEGIN
    UPDATE ConfigItems
    SET Status = @Status
    WHERE ConfigID = @ConfigID;

    INSERT INTO ConfigChanges (ConfigID, ChangeDescription, ChangedBy)
    VALUES (@ConfigID, @ChangeDescription, @ChangedBy);

    INSERT INTO ConfigLogs (ConfigID, Action, ActionBy)
    VALUES (@ConfigID, 'Config item updated: ' + @ChangeDescription, @ChangedBy);
END;
GO

-- =============================================
-- Stored Procedure: [dbo].[UpdateContinuityPlan]
-- =============================================


CREATE PROCEDURE UpdateContinuityPlan
    @PlanID INT,
    @Status NVARCHAR(50),
    @ActionBy NVARCHAR(150)
AS
BEGIN
    UPDATE ContinuityPlans
    SET Status = @Status
    WHERE PlanID = @PlanID;

    INSERT INTO ContinuityLogs (PlanID, Action, ActionBy)
    VALUES (@PlanID, 'Continuity plan status updated to ' + @Status, @ActionBy);
END;
GO

-- =============================================
-- Stored Procedure: [dbo].[UpdateIncidentStatus]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE DeleteUser;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

   
   
  

   
  
  



  CREATE PROCEDURE UpdateIncidentStatus
    @IncidentID INT,
    @Status NVARCHAR(50),
    @AssignedTo INT = NULL
AS
BEGIN
    UPDATE IncidentReports
    SET Status = @Status,
        AssignedTo = @AssignedTo,
        ResolvedAt = CASE WHEN @Status = 'Resolved' THEN GETDATE() ELSE ResolvedAt END
    WHERE IncidentID = @IncidentID;

    INSERT INTO IncidentLogs (IncidentID, Action, ActionBy)
    VALUES (@IncidentID, 'Status updated to ' + @Status, @AssignedTo);
END;


  
GO

-- =============================================
-- Stored Procedure: [dbo].[UpdateOrderStatus]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/





CREATE PROCEDURE UpdateOrderStatus
    @OrderID INT,
    @NewStatus NVARCHAR(50)
AS
BEGIN
    UPDATE Orders
    SET Status = @NewStatus
    WHERE OrderID = @OrderID;
END;

GO

-- =============================================
-- Stored Procedure: [dbo].[UpdateProduct]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/



CREATE PROCEDURE UpdateProduct
    @ProductID INT,
    @ProductName NVARCHAR(200),
    @Description NVARCHAR(MAX),
    @Price DECIMAL(10,2),
    @StockQuantity INT
AS
BEGIN
    UPDATE Products
    SET ProductName = @ProductName,
        Description = @Description,
        Price = @Price,
        StockQuantity = @StockQuantity,
        UpdatedAt = GETDATE()
    WHERE ProductID = @ProductID;
END;



GO

-- =============================================
-- Stored Procedure: [dbo].[UpdateUser]
-- =============================================

/*
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UsersData';
*/

/*
ALTER TABLE Products
ADD 

DROP PROCEDURE AddProduct;

CONSTRAINT FK_Products_BigMerchants FOREIGN KEY (BigMerchantID)
        REFERENCES BigMerchants(BigMerchantID);*/

    CREATE PROCEDURE UpdateUser
    @UserID INT,
    @UserName NVARCHAR(100),
    @Email NVARCHAR(200),
    @Notes NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE Users
    SET UserName = @UserName,
        Email = @Email,
        Notes = @Notes,
        CreatedAT = CreatedAT -- يفضل عدم تغييره
    WHERE UserID = @UserID;
END;

   
GO

-- =============================================
-- Stored Procedure: [dbo].[UpdateUserPassword]
-- =============================================



CREATE PROCEDURE UpdateUserPassword
    @UserID INT,
    @NewPasswordHash NVARCHAR(200)
AS
BEGIN
    UPDATE Users
    SET PasswordHash = @NewPasswordHash
    WHERE UserID = @UserID;
END;
GO

-- =============================================
-- Stored Procedure: [dbo].[UserLogin]
-- =============================================

/*

CREATE VIEW UserSummary AS
SELECT 
    u.UserID,
    u.UserName,
    MAX(al.LoginTime) AS LastLoginDate
FROM Users u
LEFT JOIN AuthenticationLogs al ON u.UserID = al.UserID
GROUP BY u.UserID, u.UserName;
*/

CREATE PROCEDURE UserLogin
    @Email NVARCHAR(200),
    @PasswordHash NVARCHAR(200),
    @IPAddress NVARCHAR(50)
AS
BEGIN
    DECLARE @UserID INT;

    SELECT @UserID = UserID
    FROM Users
    WHERE Email = @Email AND PasswordHash = @PasswordHash;

    IF @UserID IS NOT NULL
    BEGIN
        INSERT INTO AuthenticationLogs (UserID, IsSuccessful, IPAddress)
        VALUES (@UserID, 1, @IPAddress);

        SELECT * FROM UserSummary WHERE UserID = @UserID;
    END
    ELSE
    BEGIN
        INSERT INTO AuthenticationLogs (UserID, IsSuccessful, IPAddress)
        VALUES (0, 0, @IPAddress); -- 0 لو المستخدم مش موجود

        SELECT 'Login Failed' AS Message;
    END
END;
GO


Completion time: 2026-08-25T19:14:25.3039504+03:00
