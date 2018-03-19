SET ANSI_NULLS ON
GO

-- SECTION TO DROP EXTERNAL TABLES 
IF EXISTS ( SELECT * FROM sys.tables WHERE object_id = OBJECT_ID('[prd].[TransactionsFact]') )
    DROP  TABLE [prd].[TransactionsFact]
GO

CREATE TABLE [prd].[TransactionsFact]
WITH
(
    DISTRIBUTION = HASH([WWI Supplier Transaction ID])
,   CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT CAST(ct.TransactionDate AS date) AS [Date Key],
	   COALESCE(i.CustomerID, ct.CustomerID) AS [WWI Customer ID],
	   ct.CustomerID AS [WWI Bill To Customer ID],
	   CAST(NULL AS int) AS [WWI Supplier ID],
	   ct.TransactionTypeID AS [WWI Transaction Type ID],
	   ct.PaymentMethodID AS [WWI Payment Method ID],
       ct.CustomerTransactionID AS [WWI Customer Transaction ID],
       CAST(NULL AS int) AS [WWI Supplier Transaction ID],
       ct.InvoiceID AS [WWI Invoice ID],
       CAST(NULL AS int) AS [WWI Purchase Order ID],
       CAST(NULL AS nvarchar(20)) AS [Supplier Invoice Number],
       ct.AmountExcludingTax AS [Total Excluding Tax],
       ct.TaxAmount AS [Tax Amount],
       ct.TransactionAmount AS [Total Including Tax],
       ct.OutstandingBalance AS [Outstanding Balance],
       ct.IsFinalized AS [Is Finalized]
FROM [stg].[Sales_CustomerTransactions] AS ct
LEFT OUTER JOIN [stg].[Sales_Invoices] AS i
ON ct.InvoiceID = i.InvoiceID

UNION ALL

SELECT CAST(st.TransactionDate AS date) AS [Date Key],
       CAST(NULL AS int) AS [WWI Customer ID],
	   CAST(NULL AS int) AS [WWI Bill To Customer ID],
	   st.SupplierID AS [WWI Supplier ID],
	   st.TransactionTypeID AS [WWI Transaction Type ID],
	   st.PaymentMethodID AS [WWI Payment Method ID],
       CAST(NULL AS int) AS [WWI Customer Transaction ID],
       st.SupplierTransactionID AS [WWI Supplier Transaction ID],
       CAST(NULL AS int) AS [WWI Invoice ID],
       st.PurchaseOrderID AS [WWI Purchase Order ID],
       st.SupplierInvoiceNumber AS [Supplier Invoice Number],
       st.AmountExcludingTax AS [Total Excluding Tax],
       st.TaxAmount AS [Tax Amount],
       st.TransactionAmount AS [Total Including Tax],
       st.OutstandingBalance AS [Outstanding Balance],
       st.IsFinalized AS [Is Finalized]
FROM [stg].[Purchasing_SupplierTransactions] AS st
OPTION (LABEL = 'CTAS : [TransactionsFact]')