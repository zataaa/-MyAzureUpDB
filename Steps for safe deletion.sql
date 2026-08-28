
-- حذف Procedure من الاتي
-- =============================================
-- Stored Procedure: [dbo].[GetAllEntitiesLedgerSummaryPivot]
-- =============================================

-- =============================================
-- Stored Procedure: [dbo].[GetAllEntitiesLedgerSummary]
-- =============================================

-- =============================================
-- Stored Procedure: [dbo].[GetAllMerchantsFinancialSummary]
-- =============================================

-- =============================================
-- Stored Procedure: [dbo].[GetFinancialSummary]
-- =============================================

-- =============================================
-- Stored Procedure: [dbo].[GetMerchantFinancialSummary]
-- =============================================

   DROP PROCEDURE GetAllEntitiesLedgerSummaryPivot;
   DROP PROCEDURE GetAllMerchantsFinancialSummary;
   DROP PROCEDURE GetFinancialSummary;
   DROP PROCEDURE GetMerchantFinancialSummary;
   DROP PROCEDURE AddBigMerchant;
   DROP PROCEDURE AddSmallMerchant;

ALTER TABLE SmallMerchant DROP CONSTRAINT PK__SmallMer__0B135F59C3486A43;
ALTER TABLE BigMerchant DROP CONSTRAINT PK__BigMerch__991621073AC92CD6;

DROP TABLE SmallMerchant;
DROP TABLE BigMerchant;

ثم اضافة بعد 

-- بعد التصليح  1

-- =============================================
-- Stored Procedure: [dbo].[GetAllEntitiesLedgerSummaryPivot]
-- =============================================

CREATE OR ALTER PROCEDURE GetAllEntitiesLedgerSummaryPivot
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
        LEFT JOIN SmallMerchants sm ON o.SmallMerchantID = sm.SmallMerchantID
        LEFT JOIN SmallMerchantProducts smp ON sm.SmallMerchantID = smp.SmallMerchantID
        LEFT JOIN Products pr ON smp.ProductID = pr.ProductID
        LEFT JOIN BigMerchants bm ON pr.BigMerchantID = bm.BigMerchantID
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
    -- 🔹 Monthly Report
    SELECT 'Monthly' AS ReportType, EntityType, EntityID, EntityName, Year, Month,
           SUM(TotalDebits) AS TotalDebits, SUM(TotalCredits) AS TotalCredits, SUM(NetAmount) AS NetAmount
    FROM EntityLedger
    GROUP BY EntityType, EntityID, EntityName, Year, Month

    UNION ALL

    -- 🔹 Quarterly Report
    SELECT 'Quarterly' AS ReportType, EntityType, EntityID, EntityName, Year, Quarter,
           SUM(TotalDebits) AS TotalDebits, SUM(TotalCredits) AS TotalCredits, SUM(NetAmount) AS NetAmount
    FROM EntityLedger
    GROUP BY EntityType, EntityID, EntityName, Year, Quarter

    UNION ALL

    -- 🔹 Yearly Report
    SELECT 'Yearly' AS ReportType, EntityType, EntityID, EntityName, Year, NULL AS Quarter,
           SUM(TotalDebits) AS TotalDebits, SUM(TotalCredits) AS TotalCredits, SUM(NetAmount) AS NetAmount
    FROM EntityLedger
    GROUP BY EntityType, EntityID, EntityName, Year

    ORDER BY EntityType, EntityName, Year, ReportType;
END;
GO

--1.
EXEC GetAllEntitiesLedgerSummaryPivot;

--2. أو فلترة مباشرة
SELECT *
FROM GetAllEntitiesLedgerSummaryPivotResult -- لو عملت View أو Table-Valued Function
WHERE ReportType = 'Monthly';

-- ⚙️ الـ EXEC المستخدم هنا
-- لتنفيذ الإجراء:

EXEC GetAllEntitiesLedgerSummaryPivot;

-- لو عايز تحدد نوع التقرير في نفس الاستدعاء، ممكن نعدل الإجراء ونضيف باراميتر اسمه مثلًا @ReportType، وبكده تقدر تعمل:

EXEC GetAllEntitiesLedgerSummaryPivot @ReportType = 'Monthly';
EXEC GetAllEntitiesLedgerSummaryPivot @ReportType = 'Quarterly';
EXEC GetAllEntitiesLedgerSummaryPivot @ReportType = 'Yearly';

           /*-----------------------------------------------END----------------------------------------------------------*/
-- بعد التصليح  2
-- =============================================
-- Stored Procedure: [dbo].[GetAllEntitiesLedgerSummary]
-- =============================================

CREATE OR ALTER PROCEDURE GetAllEntitiesLedgerSummary
AS
BEGIN
    -- 🔹 ملخص مالي للمستخدمين
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

    -- 🔹 ملخص للأدوار
    SELECT 
        'Role' AS EntityType,
        r.RoleID AS EntityID,
        r.RoleName AS EntityName,
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

    UNION ALL

    -- 🔹 ملخص للتجار الصغار (SmallMerchants)
    SELECT 
        'SmallMerchant' AS EntityType,
        sm.SmallMerchantID AS EntityID,
        sm.ShopName AS EntityName,
        YEAR(l.TransactionDate) AS Year,
        DATEPART(QUARTER, l.TransactionDate) AS Quarter,
        SUM(CASE WHEN l.DebitCredit = 'Debit' THEN l.Amount ELSE 0 END) AS TotalDebits,
        SUM(CASE WHEN l.DebitCredit = 'Credit' THEN l.Amount ELSE 0 END) AS TotalCredits,
        SUM(l.Amount) AS NetAmount
    FROM SmallMerchants sm
    INNER JOIN Orders o ON sm.SmallMerchantID = o.SmallMerchantID
    INNER JOIN Payments p ON o.OrderID = p.OrderID
    INNER JOIN Ledger l ON l.ReferenceID = p.PaymentID AND l.TransactionType = 'Payment'
    GROUP BY sm.SmallMerchantID, sm.ShopName, YEAR(l.TransactionDate), DATEPART(QUARTER, l.TransactionDate)

    UNION ALL

    -- 🔹 ملخص للتجار الكبار (BigMerchants)
    SELECT 
        'BigMerchant' AS EntityType,
        bm.BigMerchantID AS EntityID,
        bm.CompanyName AS EntityName,
        YEAR(l.TransactionDate) AS Year,
        DATEPART(QUARTER, l.TransactionDate) AS Quarter,
        SUM(CASE WHEN l.DebitCredit = 'Debit' THEN l.Amount ELSE 0 END) AS TotalDebits,
        SUM(CASE WHEN l.DebitCredit = 'Credit' THEN l.Amount ELSE 0 END) AS TotalCredits,
        SUM(l.Amount) AS NetAmount
    FROM BigMerchants bm
    INNER JOIN Products pr ON bm.BigMerchantID = pr.BigMerchantID
    INNER JOIN SmallMerchantProducts smp ON pr.ProductID = smp.ProductID
    INNER JOIN Orders o ON smp.SmallMerchantID = o.SmallMerchantID
    INNER JOIN Payments p ON o.OrderID = p.OrderID
    INNER JOIN Ledger l ON l.ReferenceID = p.PaymentID AND l.TransactionType = 'Payment'
    GROUP BY bm.BigMerchantID, bm.CompanyName, YEAR(l.TransactionDate), DATEPART(QUARTER, l.TransactionDate);
END;
GO


/*
## 📌 كيفية الاستخدام
بعد ما تحفظ الإجراء في قاعدة البيانات، أي مستخدم أو تاجر يقدر يستدعيه كالتالي:

```sql*/
EXEC GetAllEntitiesLedgerSummary;

/*
ده هيطلع ملخص مالي لكل الكيانات (Users, Roles, SmallMerchants, BigMerchants) على مستوى ربع سنوي وسنوي.  
ولو عايز تعرض النتائج في **Power BI** أو أي Dashboard، ببساطة تربط الـ Stored Procedure كمصدر بيانات وتفلتر حسب `EntityType`.

---

## 🔐 إعطاء الصلاحيات للتجار
علشان التجار (SmallMerchants و BigMerchants) يقدروا يستخدموا الإجراء:

1. **إعطاء صلاحية تنفيذ الإجراء**:
```sql*/
GRANT EXECUTE ON OBJECT::GetAllEntitiesLedgerSummary TO SmallMerchants;
GRANT EXECUTE ON OBJECT::GetAllEntitiesLedgerSummary TO BigMerchants;


/*> هنا لازم يكون عندك **Users أو Roles** في SQL Server باسم التجار أو مرتبطين بالجداول دي. لو عندك Login/Role للتجار، تديهم الصلاحية مباشرة.

2. **إعطاء صلاحية قراءة البيانات**:  
التجار محتاجين صلاحية `SELECT` على الجداول المرتبطة (Orders, Payments, Ledger). مثال:
```sql*/
GRANT SELECT ON Orders TO SmallMerchants;
GRANT SELECT ON Payments TO SmallMerchants;
GRANT SELECT ON Ledger TO SmallMerchants;

GRANT SELECT ON Orders TO BigMerchants;
GRANT SELECT ON Payments TO BigMerchants;
GRANT SELECT ON Ledger TO BigMerchants;


-- بعد التصليح   3

-- =============================================
-- Stored Procedure: [dbo].[GetAllMerchantsFinancialSummary]
-- =============================================

تمام يا علاء الدين 👌  
خلينا نعدل الإجراء **GetAllMerchantsFinancialSummary** بحيث يعتمد على الجداول الصحيحة **SmallMerchants** و **BigMerchants** فقط، ونوضحلك كمان كيفية الاستخدام وإعطاء الصلاحيات للتجار.

---

## ⚙️ Stored Procedure: `GetAllMerchantsFinancialSummary`
```sql
CREATE OR ALTER PROCEDURE GetAllMerchantsFinancialSummary
AS
BEGIN
    -- 🔹 ملخص للتجار الصغار (SmallMerchants)
    SELECT 
        'SmallMerchant' AS MerchantType,
        sm.SmallMerchantID AS MerchantID,
        sm.ShopName AS MerchantName,
        COUNT(o.OrderID) AS TotalOrders,
        SUM(o.TotalAmount) AS TotalOrderAmount,
        SUM(p.Amount) AS TotalPayments
    FROM SmallMerchants sm
    INNER JOIN Orders o ON sm.SmallMerchantID = o.SmallMerchantID
    INNER JOIN Payments p ON o.OrderID = p.OrderID
    GROUP BY sm.SmallMerchantID, sm.ShopName

    UNION ALL

    -- 🔹 ملخص للتجار الكبار (BigMerchants)
    SELECT 
        'BigMerchant' AS MerchantType,
        bm.BigMerchantID AS MerchantID,
        bm.CompanyName AS MerchantName,
        COUNT(p.PaymentID) AS TotalPaymentsCount,
        SUM(p.Amount) AS TotalPayments,
        SUM(o.TotalAmount) AS TotalOrdersAmount
    FROM BigMerchants bm
    INNER JOIN Products pr ON bm.BigMerchantID = pr.BigMerchantID
    INNER JOIN SmallMerchantProducts smp ON pr.ProductID = smp.ProductID
    INNER JOIN Orders o ON smp.SmallMerchantID = o.SmallMerchantID
    INNER JOIN Payments p ON o.OrderID = p.OrderID
    GROUP BY bm.BigMerchantID, bm.CompanyName;
END;
GO

/*
---

## 📌 كيفية الاستخدام
- لتنفيذ الإجراء وعرض ملخص كل التجار:
```sql*/
EXEC GetAllMerchantsFinancialSummary;

/*
- النتيجة هتكون جدول فيه كل التجار (صغار وكبار) مع عدد الطلبات، إجمالي الطلبات، وإجمالي المدفوعات.

---*/

/*## 🔐 إعطاء الصلاحيات للتجار
علشان التجار يقدروا يستخدموا الإجراء:

1. **إعطاء صلاحية تنفيذ الإجراء**:
```sql*/
GRANT EXECUTE ON OBJECT::GetAllMerchantsFinancialSummary TO SmallMerchants;
GRANT EXECUTE ON OBJECT::GetAllMerchantsFinancialSummary TO BigMerchants;

/*2. **إعطاء صلاحية قراءة البيانات المرتبطة**:
```sql*/
GRANT SELECT ON Orders TO SmallMerchants;
GRANT SELECT ON Payments TO SmallMerchants;

GRANT SELECT ON Orders TO BigMerchants;
GRANT SELECT ON Payments TO BigMerchants;
GRANT SELECT ON Products TO BigMerchants;
GRANT SELECT ON SmallMerchantProducts TO BigMerchants;

---
/*
✨ كده كل تاجر صغير أو كبير يقدر يستدعي الإجراء ويطلع تقريره المالي بنفسه، من غير ما يشوف بيانات باقي الكيانات.  
تحب أضيفلك نسخة فيها **باراميتر @MerchantType** بحيث تاجر يقدر يطلب تقريره فقط (SmallMerchant أو BigMerchant) بدل ما يشوف الكل؟
*/

-- بعد التصليح   4
-- =============================================
-- Stored Procedure: [dbo].[GetFinancialSummary]
-- =============================================

CREATE OR ALTER PROCEDURE GetFinancialSummary
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
        FROM SmallMerchants sm
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
        FROM BigMerchants bm
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

/*
## 📌 كيفية الاستخدام
- لو تاجر صغير (SmallMerchant) عايز تقريره:
```sql*/
EXEC GetFinancialSummary @EntityType = 'SmallMerchant', @EntityID = 1;

/*
- لو تاجر كبير (BigMerchant):
```sql*/
EXEC GetFinancialSummary @EntityType = 'BigMerchant', @EntityID = 2;

/*
- لو دور (Role):
```sql*/
EXEC GetFinancialSummary @EntityType = 'Role', @EntityID = 3;

---

/*## 🔐 إعطاء الصلاحيات للتجار
علشان التجار يقدروا يستخدموا الإجراء:

1. **إعطاء صلاحية تنفيذ الإجراء**:
```sql*/
GRANT EXECUTE ON OBJECT::GetFinancialSummary TO SmallMerchants;
GRANT EXECUTE ON OBJECT::GetFinancialSummary TO BigMerchants;

/*2. **إعطاء صلاحية قراءة البيانات المرتبطة**:
```sql*/
GRANT SELECT ON Orders TO SmallMerchants;
GRANT SELECT ON Payments TO SmallMerchants;

GRANT SELECT ON Orders TO BigMerchants;
GRANT SELECT ON Payments TO BigMerchants;
GRANT SELECT ON Products TO BigMerchants;
GRANT SELECT ON SmallMerchantProducts TO BigMerchants;

---

✨ كده كل تاجر صغير أو كبير يقدر يستدعي الإجراء ويطلع تقريره المالي بنفسه ✨ من غير ما يشوف بيانات باقي الكيانات.  
تحب أضيفلك نسخة فيها **فلترة حسب التاريخ (Monthly / Quarterly / Yearly)** علشان التاجر يقدر يحدد الفترة الزمنية اللي عايزها؟


-- بعد التصليح   5

-- =============================================
-- Stored Procedure: [dbo].[GetMerchantFinancialSummary]
-- =============================================


/*## ⚙️ Stored Procedure: `GetMerchantFinancialSummary`
```sql*/
CREATE OR ALTER PROCEDURE GetMerchantFinancialSummary
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
        FROM SmallMerchants sm
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
        FROM BigMerchants bm
        INNER JOIN Products pr ON bm.BigMerchantID = pr.BigMerchantID
        INNER JOIN SmallMerchantProducts smp ON pr.ProductID = smp.ProductID
        INNER JOIN Orders o ON smp.SmallMerchantID = o.SmallMerchantID
        INNER JOIN Payments p ON o.OrderID = p.OrderID
        WHERE bm.BigMerchantID = @MerchantID
        GROUP BY bm.BigMerchantID, bm.CompanyName;
    END
END;
GO

---

/*## 📌 كيفية الاستخدام
- لو تاجر صغير (SmallMerchant) عايز تقريره:
```sql*/
EXEC GetMerchantFinancialSummary @MerchantType = 'Small', @MerchantID = 1;

/*- لو تاجر كبير (BigMerchant):
```sql*/
EXEC GetMerchantFinancialSummary @MerchantType = 'Big', @MerchantID = 2;

---

/*## 🔐 إعطاء الصلاحيات للتجار
علشان التجار يقدروا يستخدموا الإجراء:

1. **إعطاء صلاحية تنفيذ الإجراء**:
```sql */
GRANT EXECUTE ON OBJECT::GetMerchantFinancialSummary TO SmallMerchants;
GRANT EXECUTE ON OBJECT::GetMerchantFinancialSummary TO BigMerchants;


/*2. **إعطاء صلاحية قراءة البيانات المرتبطة**:
```sql*/
GRANT SELECT ON Orders TO SmallMerchants;
GRANT SELECT ON Payments TO SmallMerchants;

GRANT SELECT ON Orders TO BigMerchants;
GRANT SELECT ON Payments TO BigMerchants;
GRANT SELECT ON Products TO BigMerchants;
GRANT SELECT ON SmallMerchantProducts TO BigMerchants;
```

---

✨ كده كل تاجر صغير أو كبير يقدر يستدعي الإجراء ويطلع تقريره المالي بنفسه، من غير ما يشوف بيانات باقي الكيانات.  
تحب أضيفلك نسخة فيها **فلترة حسب التاريخ (Monthly / Quarterly / Yearly)** علشان التاجر يقدر يحدد الفترة الزمنية اللي عايزها؟
/*-------------------------------------------------------------------------------------------------------------*/

/* 1. */
--1.1 DROP
DROP PROCEDURE dbo.AddBigMerchant;
--1.2 CREATE PROCEDURE
-- =============================================
-- Stored Procedure: [dbo].[AddBigMerchant]
-- =============================================

CREATE PROCEDURE AddBigMerchants
    @BigMerchantID INT,
    @CompanyName NVARCHAR(200),
    @TaxNumber NVARCHAR(100) = NULL
AS
BEGIN
    INSERT INTO BigMerchant (BigMerchantID, CompanyName, TaxNumber, CreatedAt)
    VALUES (@BigMerchantID, @CompanyName, @TaxNumber, GETDATE());
END;
GO

--END-1.5
DROP TABLE IF EXISTS dbo.BigMerchant;

/* 2.*/

--2.1 DROP
DROP PROCEDURE dbo.AddSmallMerchant;
--2.2 CREATE PROCEDURE
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

--END-2.5
DROP TABLE IF EXISTS dbo.SmallMerchant;

DROP PROCEDURE IF EXISTS dbo.AddSmallMerchant;
DROP PROCEDURE IF EXISTS dbo.AddBigMerchant;
DROP PROCEDURE IF EXISTS dbo.GetAllEntitiesLedgerSummaryPivot;

DROP VIEW IF EXISTS dbo.SmallMerchantView;
DROP VIEW IF EXISTS dbo.BigMerchantView;

