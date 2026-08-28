
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
