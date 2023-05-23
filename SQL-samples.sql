-- SQL Technical Report: Create a SQL Query that Answers the Following
-- -------------------------------------------------------------------------------------------------------------------

-- Identify the list of customers (customerid and full names) who had >3x more sales in 2013 than they did in 2012.
-- Your final table should display the columns: Customer ID | Customer Full Name | 2012 Sales | 2013 Sales
-- An example record you will see should be: 	6 			| "Helena Holy" 	 | 0.99		  | 27.84

-------------------------------------------------------------------------------------------------------------------
SELECT
    "Customer".customerid,
    "Customer".firstname || ' ' || "Customer".lastname AS Customer_full_name,
    ( SELECT SUM("InvoiceLine".unitprice)
        FROM "InvoiceLine" 
        LEFT JOIN "Invoice" ON "InvoiceLine".invoiceid = "Invoice".invoiceid
        WHERE "Invoice".invoicedate >= '2012-01-01' AND "Invoice".invoicedate < '2013-01-01' AND "Invoice".customerid = "Customer".customerid) AS sales_2012,
    (SELECT SUM("InvoiceLine".unitprice)
        FROM "InvoiceLine" 
        LEFT JOIN "Invoice" ON "InvoiceLine".invoiceid = "Invoice".invoiceid
        WHERE "Invoice".invoicedate >= '2013-01-01' AND "Invoice".invoicedate < '2014-01-01' AND "Invoice".customerid = "Customer".customerid) AS sales_2013
FROM "Customer" 
WHERE
    (SELECT SUM("InvoiceLine".unitprice) 
        FROM "InvoiceLine" 
        LEFT JOIN "Invoice" ON "InvoiceLine".invoiceid = "Invoice".invoiceid 
        WHERE "Invoice".invoicedate >= '2013-01-01' AND "Invoice".invoicedate < '2014-01-01' AND "Invoice".customerid = "Customer".customerid) > 3 *
    (SELECT SUM("InvoiceLine".unitprice) 
        FROM "InvoiceLine" 
        LEFT JOIN "Invoice" ON "InvoiceLine".invoiceid = "Invoice".invoiceid 
        WHERE "Invoice".invoicedate >= '2012-01-01' AND "Invoice".invoicedate < '2013-01-01' AND "Invoice".customerid = "Customer".customerid);