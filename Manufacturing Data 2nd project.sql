-- Step1:Create a Database
CREATE DATABASE manufacturing_data;
USE manufacturing_data;

-- Step 2: Create a table 
-- 1.Manufacturing_data
CREATE TABLE manufacturing_data (
    DocNum BIGINT PRIMARY KEY,
    DocDate DATE,
    BuyerCustCode VARCHAR(50),
    CustName VARCHAR(100),
    DeliveryPeriod VARCHAR(20),
    DepartmentName VARCHAR(50),
    Designer VARCHAR(50),
    EmpCode VARCHAR(20),
    EmpName VARCHAR(100),
    ManufacturedQty INT,
    TotalQty INT,
    TotalValue DECIMAL(15,2),
    WOQty INT,
    MachineCode VARCHAR(20),
    OperationName VARCHAR(50),
    OperationCode VARCHAR(20),
    ItemCode VARCHAR(50),
    ItemName VARCHAR(255)
);

-- Show data from table
SELECT * FROM  manufacturing_data;

-- Step 3 : Insert Table

INSERT INTO manufacturing_data 
(DocNum, DocDate, BuyerCustCode, CustName, DeliveryPeriod, DepartmentName, Designer, EmpCode, EmpName, ManufacturedQty, TotalQty, TotalValue, WOQty, MachineCode, OperationName, OperationCode, ItemCode, ItemName)
VALUES
(26007727303764567, '2015-06-05', 'H&M C863975', 'Sharma Fabrics', 'Late', 'Printed Fabric', '0', 'EM540', 'Rajesh Verma', 9008, 98435, 94571.93, 8244, 'MC033', 'Cut & Fold', 'OP002', 'P3IEESL1I63KVAZ83CN5', 'WASH FABRIC WASH SATIN HOME NOC FABRIC BOOK WASH...'),

(26008060494064541, '2015-11-13', 'Uniqlo C754725', 'Sharma Fabrics', 'On Time', 'Printed Fabric', '0', 'EM942', 'Rajesh Verma', 9048, 192113, 63863.91, 9785, 'MC033', 'Cut & Fold', 'OP002', '2WCT1K0AE0HFMEPA', 'WHITE SIZE SATIN WASH CARE LABEL FLAP'),

(26002354358228540, '2015-02-19', 'Nike C812861', 'Patel Textiles', 'Early', 'Knitwear', '1', 'EM688', 'Shruti Singh', 493, 135642, 50067.80, 7394, 'MC033', 'Cut & Fold', 'OP002', 'YPJ0JSOHG8LRIQTUD19', 'NOC BOOK OFF SATIN WASH WHITE SIZE PLAIN ...'),

(26008080375232925, '2015-11-17', 'Nike C964348', 'Gupta Manufacturing', 'Late', 'Woven Lables', '0', 'EM690', 'Amit Kumar', 1975, 79088, 117625.39, 9455, 'MC033', 'Cut & Fold', 'OP002', 'BRSVQ3VS4918ZMN5A', 'COSY PLAIN LABEL WHITE CARE BLACK'),

(26008048742117866, '2015-01-18', 'Uniqlo C348981', 'Patel Textiles', 'Early', 'Printed Fabric', '1', 'EM455', 'Amit Kumar', 6470, 191836, 68737.75, 9600, 'MC033', 'Cut & Fold', 'OP002', 'LSMNMA5K2B67BVT', 'CARE FOLD LABEL WASH FABRIC');

-- Show data from table
SELECT * FROM  manufacturing_data;

-- Step 4. KPI Queries:
-- Question:1 -Manufacture Qty: 
SELECT SUM(ManufacturedQty) AS Manufacture_Qty
FROM manufacturing_data;

-- Question:2 -Rejected Qty
SELECT SUM(WOQty - ManufacturedQty) AS Rejected_Qty
FROM manufacturing_data;

-- Question:3-Processed Qty
SELECT SUM(ManufacturedQty) AS Processed_Qty
FROM manufacturing_data;

-- Question:4 - Wastage Qty
SELECT SUM(CASE WHEN WOQty > ManufacturedQty THEN WOQty - ManufacturedQty ELSE 0 END) AS Wastage_Qty
FROM manufacturing_data;

-- Question:5 - Employee Wise Rejected Qty
SELECT EmpCode, EmpName,
       SUM(WOQty - ManufacturedQty) AS Rejected_Qty
FROM manufacturing_data
GROUP BY EmpCode, EmpName
ORDER BY Rejected_Qty DESC;

-- Question:6 -Machine Wise Rejected Qty
SELECT MachineCode,
       SUM(WOQty - ManufacturedQty) AS Rejected_Qty
FROM manufacturing_data
GROUP BY MachineCode
ORDER BY Rejected_Qty DESC;

-- Question: 7- Production Comparison Trend (Monthly)
SELECT DATE_FORMAT(DocDate, '%Y-%m') AS Month,
       SUM(ManufacturedQty) AS Total_Manufactured
FROM manufacturing_data
GROUP BY DATE_FORMAT(DocDate, '%Y-%m')
ORDER BY Month;

-- Question:8- Manufacture Vs Rejected
SELECT
  SUM(ManufacturedQty) AS Total_Manufactured,
  SUM(WOQty - ManufacturedQty) AS Total_Rejected
FROM manufacturing_data;

-- Question: 9- Department Wise Manufacture Vs Rejected
SELECT DepartmentName,
       SUM(ManufacturedQty) AS Manufactured_Qty,
       SUM(WOQty - ManufacturedQty) AS Rejected_Qty
FROM manufacturing_data
GROUP BY DepartmentName
ORDER BY DepartmentName;

