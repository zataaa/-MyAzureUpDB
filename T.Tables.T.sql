-- =============================================
-- Table: [dbo].[AuditLogs]
-- =============================================
CREATE TABLE [dbo].[AuditLogs] (    [LogID] int NOT NULL,    [EntityName] nvarchar(100) NOT NULL,    [EntityID] int NOT NULL,    [Action] nvarchar(50) NOT NULL,    [ActionBy] nvarchar(150) NOT NULL,    [ActionDate] datetime NULL,    [Notes] nvarchar(250) NULL);
-- =============================================
-- Table: [dbo].[AuthenticationLogs]
-- =============================================
CREATE TABLE [dbo].[AuthenticationLogs] (    [LogID] int NOT NULL,    [UserID] int NOT NULL,    [LoginTime] datetime NOT NULL,    [IsSuccessful] bit NOT NULL,    [IPAddress] nvarchar(50) NULL);
-- =============================================
-- Table: [dbo].[AvailabilityLogs]
-- =============================================
CREATE TABLE [dbo].[AvailabilityLogs] (    [LogID] int NOT NULL,    [RecordID] int NOT NULL,    [IncidentDescription] nvarchar(500) NULL,    [LogDate] datetime NULL,    [LoggedBy] int NOT NULL);
-- =============================================
-- Table: [dbo].[AvailabilityRecords]
-- =============================================
CREATE TABLE [dbo].[AvailabilityRecords] (    [RecordID] int NOT NULL,    [TargetID] int NOT NULL,    [ActualUptime] decimal(5,2) NULL,    [DowntimeMinutes] int NULL,    [Status] nvarchar(50) NULL,    [RecordedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[AvailabilityTargets]
-- =============================================
CREATE TABLE [dbo].[AvailabilityTargets] (    [TargetID] int NOT NULL,    [SystemName] nvarchar(150) NOT NULL,    [TargetUptime] decimal(5,2) NOT NULL,    [Period] nvarchar(50) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[BigMerchant]
-- =============================================
CREATE TABLE [dbo].[BigMerchant] (    [BigMerchantID] int NOT NULL,    [CompanyName] nvarchar(200) NOT NULL,    [TaxNumber] nvarchar(100) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[BigMerchants]
-- =============================================
CREATE TABLE [dbo].[BigMerchants] (    [BigMerchantID] int NOT NULL,    [Name] nvarchar(150) NOT NULL,    [ContactInfo] nvarchar(255) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[CapacityLogs]
-- =============================================
CREATE TABLE [dbo].[CapacityLogs] (    [LogID] int NOT NULL,    [RecordID] int NOT NULL,    [Action] nvarchar(200) NULL,    [ActionDate] datetime NULL,    [ActionBy] int NOT NULL);
-- =============================================
-- Table: [dbo].[CapacityRecords]
-- =============================================
CREATE TABLE [dbo].[CapacityRecords] (    [RecordID] int NOT NULL,    [TargetID] int NOT NULL,    [ActualUsage] decimal(10,2) NOT NULL,    [Status] nvarchar(50) NULL,    [RecordedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[CapacityTargets]
-- =============================================
CREATE TABLE [dbo].[CapacityTargets] (    [TargetID] int NOT NULL,    [ResourceType] nvarchar(50) NOT NULL,    [TargetUsage] decimal(10,2) NOT NULL,    [Period] nvarchar(50) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[CashOnDelivery]
-- =============================================
CREATE TABLE [dbo].[CashOnDelivery] (    [CODID] int NOT NULL,    [PaymentID] int NULL,    [DeliveryAddress] nvarchar(250) NOT NULL,    [DeliveryDate] datetime NULL,    [IsPaid] bit NULL,    [OrderID] int NOT NULL);
-- =============================================
-- Table: [dbo].[Categories]
-- =============================================
CREATE TABLE [dbo].[Categories] (    [CategoryID] int NOT NULL,    [CategoryName] nvarchar(100) NOT NULL,    [Description] nvarchar(255) NULL);
-- =============================================
-- Table: [dbo].[ChangeApprovals]
-- =============================================
CREATE TABLE [dbo].[ChangeApprovals] (    [ApprovalID] int NOT NULL,    [RequestID] int NOT NULL,    [ApprovedBy] int NOT NULL,    [ApprovalStatus] nvarchar(50) NOT NULL,    [Notes] nvarchar(500) NULL,    [ApprovedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[ChangeLogs]
-- =============================================
CREATE TABLE [dbo].[ChangeLogs] (    [LogID] int NOT NULL,    [RequestID] int NOT NULL,    [Action] nvarchar(200) NULL,    [ActionDate] datetime NULL,    [ActionBy] int NOT NULL);
-- =============================================
-- Table: [dbo].[ChangeRequests]
-- =============================================
CREATE TABLE [dbo].[ChangeRequests] (    [RequestID] int NOT NULL,    [Title] nvarchar(200) NOT NULL,    [Description] nvarchar(500) NULL,    [Priority] nvarchar(20) NULL,    [Status] nvarchar(50) NULL,    [RequestedBy] int NOT NULL,    [RequestedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[ConfigChanges]
-- =============================================
CREATE TABLE [dbo].[ConfigChanges] (    [ChangeID] int NOT NULL,    [ConfigID] int NOT NULL,    [ChangeDescription] nvarchar(500) NULL,    [ChangedBy] int NOT NULL,    [ChangeDate] datetime NULL);
-- =============================================
-- Table: [dbo].[ConfigItems]
-- =============================================
CREATE TABLE [dbo].[ConfigItems] (    [ConfigID] int NOT NULL,    [ItemName] nvarchar(150) NOT NULL,    [ItemType] nvarchar(100) NULL,    [Status] nvarchar(50) NULL,    [Owner] nvarchar(150) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[ConfigLogs]
-- =============================================
CREATE TABLE [dbo].[ConfigLogs] (    [LogID] int NOT NULL,    [ConfigID] int NOT NULL,    [Action] nvarchar(200) NULL,    [ActionDate] datetime NULL,    [ActionBy] int NOT NULL);
-- =============================================
-- Table: [dbo].[ContinuityLogs]
-- =============================================
CREATE TABLE [dbo].[ContinuityLogs] (    [LogID] int NOT NULL,    [PlanID] int NOT NULL,    [Action] nvarchar(200) NULL,    [ActionDate] datetime NULL,    [ActionBy] nvarchar(150) NULL);
-- =============================================
-- Table: [dbo].[ContinuityPlans]
-- =============================================
CREATE TABLE [dbo].[ContinuityPlans] (    [PlanID] int NOT NULL,    [PlanName] nvarchar(150) NOT NULL,    [Description] nvarchar(500) NULL,    [Status] nvarchar(50) NULL,    [Owner] nvarchar(150) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[ContinuityTests]
-- =============================================
CREATE TABLE [dbo].[ContinuityTests] (    [TestID] int NOT NULL,    [PlanID] int NOT NULL,    [Scenario] nvarchar(100) NULL,    [TestStatus] nvarchar(50) NULL,    [TestedBy] nvarchar(150) NULL,    [TestDate] datetime NULL);
-- =============================================
-- Table: [dbo].[CustomerProfile]
-- =============================================
CREATE TABLE [dbo].[CustomerProfile] (    [ProfileID] int NOT NULL,    [UserID] int NOT NULL,    [Gender] nvarchar(10) NULL,    [Age] int NULL,    [Region] nvarchar(100) NULL,    [CreatedAt] datetime NULL,    [IncomeLevel] nvarchar(50) NULL,    [Education] nvarchar(100) NULL,    [MaritalStatus] nvarchar(20) NULL);
-- =============================================
-- Table: [dbo].[Customers]
-- =============================================
CREATE TABLE [dbo].[Customers] (    [CustomerID] int NOT NULL,    [FullName] nvarchar(200) NULL,    [Email] nvarchar(200) NULL,    [Phone] nvarchar(50) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[DigitalWallets]
-- =============================================
CREATE TABLE [dbo].[DigitalWallets] (    [WalletID] int NOT NULL,    [UserID] int NOT NULL,    [Balance] decimal(15,2) NULL,    [Status] nvarchar(50) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[ForecastingHistory]
-- =============================================
CREATE TABLE [dbo].[ForecastingHistory] (    [HistoryID] int NOT NULL,    [ForecastID] int NOT NULL,    [ActualValue] decimal(18,2) NOT NULL,    [ComparisonDate] datetime NOT NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[ForecastingReports]
-- =============================================
CREATE TABLE [dbo].[ForecastingReports] (    [ForecastID] int NOT NULL,    [ProductID] int NULL,    [ForecastType] nvarchar(100) NOT NULL,    [ForecastPeriod] nvarchar(50) NOT NULL,    [ForecastDate] datetime NOT NULL,    [ExpectedValue] decimal(18,2) NOT NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[IncidentReports]
-- =============================================
CREATE TABLE [dbo].[IncidentReports] (    [IncidentID] int NOT NULL,    [Title] nvarchar(200) NOT NULL,    [Description] nvarchar(500) NULL,    [TypeID] int NOT NULL,    [Status] nvarchar(50) NULL,    [ReportedBy] int NOT NULL,    [AssignedTo] int NULL,    [ReportedAt] datetime NULL,    [ResolvedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[IncidentTypes]
-- =============================================
CREATE TABLE [dbo].[IncidentTypes] (    [TypeID] int NOT NULL,    [TypeName] nvarchar(100) NOT NULL,    [Description] nvarchar(250) NULL);
-- =============================================
-- Table: [dbo].[Invoices]
-- =============================================
CREATE TABLE [dbo].[Invoices] (    [InvoiceID] int NOT NULL,    [OrderID] int NOT NULL,    [InvoiceNumber] nvarchar(50) NOT NULL,    [IssueDate] datetime NULL,    [DueDate] datetime NULL,    [Amount] decimal(18,2) NOT NULL,    [Status] nvarchar(50) NULL);
-- =============================================
-- Table: [dbo].[Ledger]
-- =============================================
CREATE TABLE [dbo].[Ledger] (    [LedgerID] int NOT NULL,    [TransactionType] nvarchar(50) NOT NULL,    [ReferenceID] int NOT NULL,    [Amount] decimal(18,2) NOT NULL,    [DebitCredit] nvarchar(10) NOT NULL,    [TransactionDate] datetime NULL,    [Notes] nvarchar(250) NULL);
-- =============================================
-- Table: [dbo].[MerchantProducts]
-- =============================================
CREATE TABLE [dbo].[MerchantProducts] (    [MerchantProductID] int NOT NULL,    [ProductID] int NOT NULL,    [MerchantID] int NOT NULL,    [StockQuantity] int NULL,    [SaleType] nvarchar(20) NULL);
-- =============================================
-- Table: [dbo].[OrderDetails]
-- =============================================
CREATE TABLE [dbo].[OrderDetails] (    [OrderDetailID] int NOT NULL,    [OrderID] int NOT NULL,    [SmallMerchantProductID] int NOT NULL,    [Quantity] int NOT NULL,    [Price] decimal(18,2) NOT NULL,    [Subtotal] decimal(29,2) NULL);
-- =============================================
-- Table: [dbo].[Orders]
-- =============================================
CREATE TABLE [dbo].[Orders] (    [OrderID] int NOT NULL,    [CustomerID] int NOT NULL,    [SmallMerchantID] int NULL,    [Status] nvarchar(50) NULL,    [PaymentStatus] nvarchar(50) NULL,    [TotalAmount] decimal(18,2) NOT NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[Payments]
-- =============================================
CREATE TABLE [dbo].[Payments] (    [PaymentID] int NOT NULL,    [OrderID] int NOT NULL,    [MerchantType] nvarchar(50) NOT NULL,    [MerchantID] int NOT NULL,    [Amount] decimal(18,2) NOT NULL,    [Status] nvarchar(50) NULL,    [PaymentDate] datetime NULL,    [ReleaseDate] datetime NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[ProblemCatalog]
-- =============================================
CREATE TABLE [dbo].[ProblemCatalog] (    [ProblemID] int NOT NULL,    [Title] nvarchar(200) NOT NULL,    [Description] nvarchar(500) NULL,    [Category] nvarchar(100) NULL,    [Status] nvarchar(50) NULL,    [CreatedAt] datetime NULL,    [CreatedBy] int NOT NULL);
-- =============================================
-- Table: [dbo].[ProblemLogs]
-- =============================================
CREATE TABLE [dbo].[ProblemLogs] (    [LogID] int NOT NULL,    [ProblemID] int NOT NULL,    [LogDescription] nvarchar(500) NULL,    [LogDate] datetime NULL,    [LoggedBy] int NOT NULL);
-- =============================================
-- Table: [dbo].[ProblemRecords]
-- =============================================
CREATE TABLE [dbo].[ProblemRecords] (    [RecordID] int NOT NULL,    [ProblemID] int NOT NULL,    [RelatedIncidentID] int NULL,    [ActionTaken] nvarchar(250) NULL,    [ActionDate] datetime NULL,    [ActionBy] int NOT NULL);
-- =============================================
-- Table: [dbo].[ProductImages]
-- =============================================
CREATE TABLE [dbo].[ProductImages] (    [ImageID] int NOT NULL,    [ProductID] int NOT NULL,    [ImageURL] nvarchar(300) NOT NULL,    [AltText] nvarchar(200) NULL,    [IsPrimary] bit NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[Products]
-- =============================================
CREATE TABLE [dbo].[Products] (    [ProductID] int NOT NULL,    [ProductName] nvarchar(200) NOT NULL,    [Description] nvarchar(MAX) NULL,    [Price] decimal(10,2) NOT NULL,    [StockQuantity] int NULL,    [CreatedAt] datetime NULL,    [UpdatedAt] datetime NULL,    [BigMerchantID] int NOT NULL,    [CategoryID] int NULL,    [IsActive] bit NULL);
-- =============================================
-- Table: [dbo].[Refunds]
-- =============================================
CREATE TABLE [dbo].[Refunds] (    [RefundID] int NOT NULL,    [PaymentID] int NOT NULL,    [RefundAmount] decimal(18,2) NOT NULL,    [RefundDate] datetime NULL,    [Reason] nvarchar(250) NULL);
-- =============================================
-- Table: [dbo].[ReleaseDeployments]
-- =============================================
CREATE TABLE [dbo].[ReleaseDeployments] (    [DeploymentID] int NOT NULL,    [ReleaseID] int NOT NULL,    [Environment] nvarchar(50) NOT NULL,    [DeploymentStatus] nvarchar(50) NULL,    [DeployedBy] nvarchar(150) NULL,    [DeploymentNotes] nvarchar(500) NULL,    [DeployedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[ReleaseLogs]
-- =============================================
CREATE TABLE [dbo].[ReleaseLogs] (    [LogID] int NOT NULL,    [ReleaseID] int NOT NULL,    [Action] nvarchar(200) NULL,    [ActionDate] datetime NULL,    [ActionBy] nvarchar(150) NULL);
-- =============================================
-- Table: [dbo].[Releases]
-- =============================================
CREATE TABLE [dbo].[Releases] (    [ReleaseID] int NOT NULL,    [ReleaseName] nvarchar(150) NOT NULL,    [PlannedDate] date NOT NULL,    [Status] nvarchar(50) NULL,    [ReleaseManager] nvarchar(150) NULL,    [Notes] nvarchar(500) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[ReportLogs]
-- =============================================
CREATE TABLE [dbo].[ReportLogs] (    [LogID] int NOT NULL,    [ReportID] int NOT NULL,    [Action] nvarchar(100) NULL,    [ActionDate] datetime NULL);
-- =============================================
-- Table: [dbo].[ReportRuns]
-- =============================================
CREATE TABLE [dbo].[ReportRuns] (    [RunID] int NOT NULL,    [ReportID] int NOT NULL,    [RunDate] datetime NULL,    [GeneratedBy] int NOT NULL);
-- =============================================
-- Table: [dbo].[Reports]
-- =============================================
CREATE TABLE [dbo].[Reports] (    [ReportID] int NOT NULL,    [ReportName] nvarchar(150) NOT NULL,    [ReportType] nvarchar(50) NOT NULL,    [CreatedBy] int NOT NULL,    [CreatedAt] datetime NULL,    [Status] nvarchar(50) NULL);
-- =============================================
-- Table: [dbo].[Roles]
-- =============================================
CREATE TABLE [dbo].[Roles] (    [RoleID] int NOT NULL,    [RoleName] nvarchar(100) NOT NULL,    [Note] nvarchar(200) NULL,    [CreatedAt] datetime NULL,    [Description] nvarchar(255) NULL);
-- =============================================
-- Table: [dbo].[Shipping]
-- =============================================
CREATE TABLE [dbo].[Shipping] (    [ShippingID] int NOT NULL,    [OrderID] int NOT NULL,    [CompanyName] nvarchar(150) NOT NULL,    [TrackingNumber] nvarchar(100) NOT NULL,    [Status] nvarchar(50) NOT NULL,    [ShipmentDate] datetime NULL,    [DeliveryDate] datetime NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[SmallMerchant]
-- =============================================
CREATE TABLE [dbo].[SmallMerchant] (    [SmallMerchantID] int NOT NULL,    [ShopName] nvarchar(200) NOT NULL,    [LicenseNumber] nvarchar(100) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[SmallMerchantProducts]
-- =============================================
CREATE TABLE [dbo].[SmallMerchantProducts] (    [SmallMerchantProductID] int NOT NULL,    [SmallMerchantID] int NOT NULL,    [ProductID] int NOT NULL,    [SaleType] nvarchar(50) NOT NULL,    [VisibleStock] int NOT NULL,    [CreatedAt] datetime NULL,    [IsActive] bit NULL);
-- =============================================
-- Table: [dbo].[SmallMerchants]
-- =============================================
CREATE TABLE [dbo].[SmallMerchants] (    [SmallMerchantID] int NOT NULL,    [Name] nvarchar(150) NOT NULL,    [StoreName] nvarchar(150) NOT NULL,    [ContactInfo] nvarchar(255) NULL,    [CreatedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[SupportTickets]
-- =============================================
CREATE TABLE [dbo].[SupportTickets] (    [TicketID] int NOT NULL,    [Title] nvarchar(200) NOT NULL,    [Description] nvarchar(500) NULL,    [CategoryID] int NOT NULL,    [Status] nvarchar(50) NULL,    [OpenedBy] int NOT NULL,    [AssignedTo] int NULL,    [OpenedAt] datetime NULL,    [ClosedAt] datetime NULL);
-- =============================================
-- Table: [dbo].[Taxes]
-- =============================================
CREATE TABLE [dbo].[Taxes] (    [TaxID] int NOT NULL,    [OrderID] int NOT NULL,    [TaxRate] decimal(5,2) NOT NULL,    [TaxAmount] decimal(18,2) NOT NULL,    [TaxDate] datetime NULL);
-- =============================================
-- Table: [dbo].[TicketCategories]
-- =============================================
CREATE TABLE [dbo].[TicketCategories] (    [CategoryID] int NOT NULL,    [CategoryName] nvarchar(100) NOT NULL,    [Description] nvarchar(250) NULL);
-- =============================================
-- Table: [dbo].[TicketLogs]
-- =============================================
CREATE TABLE [dbo].[TicketLogs] (    [LogID] int NOT NULL,    [TicketID] int NOT NULL,    [Action] nvarchar(200) NULL,    [ActionDate] datetime NULL,    [ActionBy] int NOT NULL);
-- =============================================
-- Table: [dbo].[Users]
-- =============================================
CREATE TABLE [dbo].[Users] (    [UserID] int NOT NULL,    [UserName] nvarchar(150) NOT NULL,    [Email] nvarchar(200) NOT NULL,    [PasswordHash] nvarchar(200) NOT NULL,    [CreatedAt] datetime NULL,    [Status] nvarchar(50) NULL,    [Notes] nvarchar(250) NULL,    [RoleID] int NULL,    [Gender] nvarchar(20) NULL,    [Age] int NULL,    [Region] nvarchar(100) NULL);
-- =============================================
-- Table: [dbo].[UsersData]
-- =============================================
CREATE TABLE [dbo].[UsersData] (    [UserID] int NOT NULL,    [FacebookAccount] nvarchar(200) NULL,    [InstagramAccount] nvarchar(200) NULL,    [TwitterAccount] nvarchar(200) NULL,    [TikTokAccount] nvarchar(200) NULL,    [LinkedInAccount] nvarchar(200) NULL,    [Phone1] nvarchar(20) NULL,    [Phone2] nvarchar(20) NULL,    [Address] nvarchar(300) NULL,    [CreatedAt] datetime NULL,    [UpdatedAt] datetime NULL,    [UserName] nvarchar(100) NOT NULL,    [Email] nvarchar(200) NOT NULL,    [PasswordHash] nvarchar(200) NOT NULL,    [RoleID] int NOT NULL);
-- =============================================
-- Table: [dbo].[UserSessions]
-- =============================================
CREATE TABLE [dbo].[UserSessions] (    [SessionID] int NOT NULL,    [UserID] int NOT NULL,    [LoginTime] datetime NOT NULL,    [DeviceType] nvarchar(100) NOT NULL,    [Browser] nvarchar(100) NULL,    [IPAddress] nvarchar(50) NULL);
-- =============================================
-- Table: [dbo].[UsersRoles]
-- =============================================
CREATE TABLE [dbo].[UsersRoles] (    [UserID] int NOT NULL,    [RoleID] int NOT NULL);
-- =============================================
-- Table: [dbo].[WalletTransactions]
-- =============================================
CREATE TABLE [dbo].[WalletTransactions] (    [TransactionID] int NOT NULL,    [WalletID] int NOT NULL,    [TransactionType] nvarchar(50) NULL,    [Amount] decimal(15,2) NOT NULL,    [TransactionDate] datetime NULL);

Completion time: 2026-08-25T23:16:00.5045983+03:00
