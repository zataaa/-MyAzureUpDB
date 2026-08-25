-- =============================================
-- View: [dbo].[AuditAndLedgerDashboardView]
-- =============================================
CREATE   VIEW AuditAndLedgerDashboardView AS
WITH LedgerData AS (
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
SELECT 
    SourceType,
    Year,
    Month,
    Quarter,
    SUM(TotalDebits) AS TotalDebits,
    SUM(TotalCredits) AS TotalCredits,
    SUM(NetAmount) AS NetAmount,
    SUM(TransactionCount) AS TransactionCount
FROM Combined
GROUP BY SourceType, Year, Month, Quarter;
GO

-- =============================================
-- View: [dbo].[AuditAndLedgerFullDashboardView]
-- =============================================

CREATE   VIEW AuditAndLedgerFullDashboardView AS
WITH LedgerData AS (
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
        COUNT(LogID) AS NetAmount,
        COUNT(LogID) AS TransactionCount
    FROM AuditLogs
    GROUP BY YEAR(ActionDate), MONTH(ActionDate), DATEPART(QUARTER, ActionDate)
),
InvoiceData AS (
    SELECT 
        'Invoices' AS SourceType,
        YEAR(IssueDate) AS Year,
        MONTH(IssueDate) AS Month,
        DATEPART(QUARTER, IssueDate) AS Quarter,
        SUM(Amount) AS TotalDebits,
        0 AS TotalCredits,
        SUM(Amount) AS NetAmount,
        COUNT(InvoiceID) AS TransactionCount
    FROM Invoices
    GROUP BY YEAR(IssueDate), MONTH(IssueDate), DATEPART(QUARTER, IssueDate)
),
RefundData AS (
    SELECT 
        'Refunds' AS SourceType,
        YEAR(RefundDate) AS Year,
        MONTH(RefundDate) AS Month,
        DATEPART(QUARTER, RefundDate) AS Quarter,
        0 AS TotalDebits,
        SUM(RefundAmount) AS TotalCredits,
        SUM(RefundAmount) AS NetAmount,
        COUNT(RefundID) AS TransactionCount
    FROM Refunds
    GROUP BY YEAR(RefundDate), MONTH(RefundDate), DATEPART(QUARTER, RefundDate)
),
TaxData AS (
    SELECT 
        'Taxes' AS SourceType,
        YEAR(o.CreatedAt) AS Year,
        MONTH(o.CreatedAt) AS Month,
        DATEPART(QUARTER, o.CreatedAt) AS Quarter,
        SUM(t.TaxAmount) AS TotalDebits,
        0 AS TotalCredits,
        SUM(t.TaxAmount) AS NetAmount,
        COUNT(t.TaxID) AS TransactionCount
    FROM Taxes t
    INNER JOIN Orders o ON t.OrderID = o.OrderID
    GROUP BY YEAR(o.CreatedAt), MONTH(o.CreatedAt), DATEPART(QUARTER, o.CreatedAt)
),
Combined AS (
    SELECT * FROM LedgerData
    UNION ALL
    SELECT * FROM AuditData
    UNION ALL
    SELECT * FROM InvoiceData
    UNION ALL
    SELECT * FROM RefundData
    UNION ALL
    SELECT * FROM TaxData
)
SELECT 
    SourceType,
    Year,
    Month,
    Quarter,
    SUM(TotalDebits) AS TotalDebits,
    SUM(TotalCredits) AS TotalCredits,
    SUM(NetAmount) AS NetAmount,
    SUM(TransactionCount) AS TransactionCount
FROM Combined
GROUP BY SourceType, Year, Month, Quarter;
GO

-- =============================================
-- View: [dbo].[AuditLogsSummary]
-- =============================================
CREATE   VIEW AuditLogsSummary AS
SELECT 
    LogID,
    EntityName,
    EntityID,
    Action,
    ActionBy,
    ActionDate,
    Notes
FROM AuditLogs;
GO

-- =============================================
-- View: [dbo].[AvailabilityDashboard]
-- =============================================

CREATE VIEW AvailabilityDashboard AS
SELECT 
    AT.SystemName,
    AT.TargetUptime,
    AR.ActualUptime,
    AR.DowntimeMinutes,
    AR.Status,
    AR.RecordedAt,
    (AR.ActualUptime - AT.TargetUptime) AS Deviation
FROM AvailabilityTargets AT
INNER JOIN AvailabilityRecords AR ON AT.TargetID = AR.TargetID;
GO

-- =============================================
-- View: [dbo].[CapacitySummary]
-- =============================================
CREATE VIEW CapacitySummary AS
SELECT 
    CT.ResourceType,
    CT.TargetUsage,
    AVG(CR.ActualUsage) AS AvgUsage,
    MAX(CR.ActualUsage) AS PeakUsage,
    MIN(CR.ActualUsage) AS MinUsage,
    COUNT(CR.RecordID) AS RecordsCount
FROM CapacityTargets CT
INNER JOIN CapacityRecords CR ON CT.TargetID = CR.TargetID
GROUP BY CT.ResourceType, CT.TargetUsage;

GO

-- =============================================
-- View: [dbo].[ChangeSummary]
-- =============================================

 CREATE VIEW ChangeSummary AS
SELECT 
    CR.RequestID,
    CR.Title,
    CR.Priority,
    CR.Status,
    U.UserName AS RequestedBy,
    CR.RequestedAt,
    CA.ApprovalStatus,
    CA.ApprovedBy,
    CA.ApprovedAt
FROM ChangeRequests CR
LEFT JOIN ChangeApprovals CA ON CR.RequestID = CA.RequestID
INNER JOIN Users U ON CR.RequestedBy = U.UserID;

GO

-- =============================================
-- View: [dbo].[ConfigSummary]
-- =============================================

CREATE VIEW ConfigSummary AS
SELECT 
    CI.ConfigID,
    CI.ItemName,
    CI.ItemType,
    CI.Status,
    CI.Owner,
    CI.CreatedAt,
    COUNT(CC.ChangeID) AS TotalChanges,
    COUNT(CL.LogID) AS TotalLogs
FROM ConfigItems CI
LEFT JOIN ConfigChanges CC ON CI.ConfigID = CC.ConfigID
LEFT JOIN ConfigLogs CL ON CI.ConfigID = CL.ConfigID
GROUP BY CI.ConfigID, CI.ItemName, CI.ItemType, CI.Status, CI.Owner, CI.CreatedAt;
GO

-- =============================================
-- View: [dbo].[ContinuitySummary]
-- =============================================


CREATE VIEW ContinuitySummary AS
SELECT 
    CP.PlanID,
    CP.PlanName,
    CP.Status,
    CP.Owner,
    CP.CreatedAt,
    COUNT(CT.TestID) AS TotalTests,
    SUM(CASE WHEN CT.TestStatus = 'Successful' THEN 1 ELSE 0 END) AS SuccessfulTests,
    SUM(CASE WHEN CT.TestStatus = 'Failed' THEN 1 ELSE 0 END) AS FailedTests
FROM ContinuityPlans CP
LEFT JOIN ContinuityTests CT ON CP.PlanID = CT.PlanID
GROUP BY CP.PlanID, CP.PlanName, CP.Status, CP.Owner, CP.CreatedAt;
GO

-- =============================================
-- View: [dbo].[CustomerSegmentationReport]
-- =============================================
CREATE   VIEW CustomerSegmentationReport AS
SELECT 
    U.UserID,
    U.UserName,
    CP.Gender,
    CP.Age,
    CP.Region,
    CP.IncomeLevel,
    CP.Education,
    CP.MaritalStatus,
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
LEFT JOIN UsersRoles UR ON U.UserID = UR.UserID
LEFT JOIN Roles R ON UR.RoleID = R.RoleID
LEFT JOIN ForecastingReports FR ON U.UserID = FR.ProductID
LEFT JOIN ForecastingHistory FH ON FR.ForecastID = FH.ForecastID;
GO

-- =============================================
-- View: [dbo].[IncidentDashboard]
-- =============================================

  CREATE VIEW IncidentDashboard AS
SELECT 
    IR.IncidentID,
    IR.Title,
    IT.TypeName,
    IR.Status,
    U1.UserName AS ReportedBy,
    U2.UserName AS AssignedTo,
    IR.ReportedAt,
    IR.ResolvedAt
FROM IncidentReports IR
INNER JOIN IncidentTypes IT ON IR.TypeID = IT.TypeID
INNER JOIN Users U1 ON IR.ReportedBy = U1.UserID
LEFT JOIN Users U2 ON IR.AssignedTo = U2.UserID;

  
GO

-- =============================================
-- View: [dbo].[InvoiceSummary]
-- =============================================


CREATE   VIEW InvoiceSummary AS
SELECT 
    i.InvoiceID,
    i.InvoiceNumber,
    i.IssueDate,
    i.DueDate,
    i.Amount,
    i.Status,
    o.CustomerID,
    u.UserName
FROM Invoices i
INNER JOIN Orders o ON i.OrderID = o.OrderID
INNER JOIN Users u ON o.CustomerID = u.UserID;
GO

-- =============================================
-- View: [dbo].[LedgerSummary]
-- =============================================


CREATE   VIEW LedgerSummary AS
SELECT 
    l.LedgerID,
    l.TransactionType,
    l.ReferenceID,
    l.Amount,
    l.DebitCredit,
    l.TransactionDate,
    l.Notes
FROM Ledger l;
GO

-- =============================================
-- View: [dbo].[OrderSummary]
-- =============================================
CREATE   VIEW OrderSummary AS
SELECT 
    o.OrderID,
    o.CustomerID,
    o.CreatedAt AS OrderDate,
    o.Status,
    o.TotalAmount,
    COUNT(p.PaymentID) AS PaymentCount
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
GROUP BY o.OrderID, o.CustomerID, o.CreatedAt, o.Status, o.TotalAmount;
GO

-- =============================================
-- View: [dbo].[ProblemDashboard]
-- =============================================


CREATE VIEW ProblemDashboard AS
SELECT 
    PC.ProblemID,
    PC.Title,
    PC.Category,
    PC.Status,
    U.UserName AS CreatedBy,
    PC.CreatedAt,
    COUNT(PR.RecordID) AS TotalActions,
    COUNT(PL.LogID) AS TotalLogs
FROM ProblemCatalog PC
LEFT JOIN ProblemRecords PR ON PC.ProblemID = PR.ProblemID
LEFT JOIN ProblemLogs PL ON PC.ProblemID = PL.ProblemID
INNER JOIN Users U ON PC.CreatedBy = U.UserID
GROUP BY PC.ProblemID, PC.Title, PC.Category, PC.Status, U.UserName, PC.CreatedAt;
GO

-- =============================================
-- View: [dbo].[ProductImagesView]
-- =============================================

CREATE VIEW ProductImagesView AS
SELECT 
    p.ProductID,
    p.ProductName,
    pi.ImageURL,
    pi.AltText,
    pi.IsPrimary
FROM Products p
JOIN ProductImages pi ON p.ProductID = pi.ProductID;

GO

-- =============================================
-- View: [dbo].[ProductStockView]
-- =============================================
CREATE   VIEW ProductStockView AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.StockQuantity AS SupplierStock,
    smp.SmallMerchantID,
    smp.VisibleStock AS MerchantStock,
    smp.SaleType
FROM Products p
LEFT JOIN SmallMerchantProducts smp ON p.ProductID = smp.ProductID;
GO

-- =============================================
-- View: [dbo].[RefundSummary]
-- =============================================


CREATE   VIEW RefundSummary AS
SELECT 
    r.RefundID,
    r.RefundAmount,
    r.RefundDate,
    r.Reason,
    p.PaymentID,
    o.OrderID
FROM Refunds r
INNER JOIN Payments p ON r.PaymentID = p.PaymentID
INNER JOIN Orders o ON p.OrderID = o.OrderID;
GO

-- =============================================
-- View: [dbo].[ReleaseSummary]
-- =============================================

CREATE VIEW ReleaseSummary AS
SELECT 
    R.ReleaseID,
    R.ReleaseName,
    R.PlannedDate,
    R.Status,
    R.ReleaseManager,
    R.Notes,
    COUNT(RD.DeploymentID) AS TotalDeployments,
    SUM(CASE WHEN RD.DeploymentStatus = 'Successful' THEN 1 ELSE 0 END) AS SuccessfulDeployments,
    SUM(CASE WHEN RD.DeploymentStatus = 'Failed' THEN 1 ELSE 0 END) AS FailedDeployments
FROM Releases R
LEFT JOIN ReleaseDeployments RD ON R.ReleaseID = RD.ReleaseID
GROUP BY R.ReleaseID, R.ReleaseName, R.PlannedDate, R.Status, R.ReleaseManager, R.Notes;
GO

-- =============================================
-- View: [dbo].[SalesForecastView]
-- =============================================
   CREATE VIEW SalesForecastView
AS
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
  AND FR.ForecastPeriod = 'Monthly';
GO

-- =============================================
-- View: [dbo].[TaxSummary]
-- =============================================


CREATE   VIEW TaxSummary AS
SELECT 
    t.TaxID,
    t.TaxRate,
    t.TaxAmount,
    o.OrderID,
    o.TotalAmount
FROM Taxes t
INNER JOIN Orders o ON t.OrderID = o.OrderID;
GO

-- =============================================
-- View: [dbo].[TicketSummary]
-- =============================================


 CREATE VIEW TicketSummary AS
SELECT 
    ST.TicketID,
    ST.Title,
    TC.CategoryName,
    ST.Status,
    U1.UserName AS OpenedBy,
    U2.UserName AS AssignedTo,
    ST.OpenedAt,
    ST.ClosedAt
FROM SupportTickets ST
INNER JOIN TicketCategories TC ON ST.CategoryID = TC.CategoryID
INNER JOIN Users U1 ON ST.OpenedBy = U1.UserID
LEFT JOIN Users U2 ON ST.AssignedTo = U2.UserID;

GO

-- =============================================
-- View: [dbo].[TrendingProducts]
-- =============================================

CREATE VIEW TrendingProducts AS
SELECT TOP 10
    p.ProductID,
    p.ProductName,
    COUNT(od.OrderID) AS OrderCount
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY OrderCount DESC;


GO

-- =============================================
-- View: [dbo].[UserRolesSummary]
-- =============================================

CREATE VIEW UserRolesSummary AS
SELECT 
    u.UserID,
    u.UserName,
    r.RoleName,
    r.Note,
    r.CreatedAt
FROM UsersData u
JOIN UsersRoles ur ON u.UserID = ur.UserID
JOIN Roles r ON ur.RoleID = r.RoleID;
GO

-- =============================================
-- View: [dbo].[UserSummary]
-- =============================================

    CREATE VIEW UserSummary AS
SELECT 
    ud.UserID,
    ud.UserName,
    ud.Email,
    r.RoleName,
    MAX(al.LoginTime) AS LastLoginDate,
    ud.Phone1,
    ud.Phone2,
    ud.Address,
    ud.CreatedAt,
    ud.UpdatedAt
FROM UsersData ud
LEFT JOIN Roles r ON ud.RoleID = r.RoleID
LEFT JOIN AuthenticationLogs al ON ud.UserID = al.UserID
GROUP BY 
    ud.UserID, 
    ud.UserName, 
    ud.Email, 
    r.RoleName, 
    ud.Phone1, 
    ud.Phone2, 
    ud.Address, 
    ud.CreatedAt, 
    ud.UpdatedAt;
GO

-- =============================================
-- View: [dbo].[YearlySalesForecastSummary]
-- =============================================
  
CREATE VIEW YearlySalesForecastSummary
AS
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
GROUP BY YEAR(FR.ForecastDate);
GO


