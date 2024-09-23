--1. En Pahalı Ürünü Getirin
SELECT
    productid,
    productname,
    unitprice
FROM Products
    WHERE unitprice = (SELECT MAX(unitprice) FROM Products)
    
--2. En Son Verilen Siparişi Bulun
SELECT
	orderid
FROM Orders
    WHERE orderdate = (SELECT MAX(orderdate) FROM Orders)
    
--3. Fiyatı Ortalama Fiyattan Yüksek Olan Ürünleri Getirin
SELECT
   	productid,
    productname,
    unitprice
FROM Products
    WHERE unitprice > (SELECT AVG(unitprice) FROM Products)
    
--4. Belirli Kategorilerdeki Ürünleri Listeleyin
--
SELECT 
	Categories.CategoryID,
    Products.ProductID
FROM Categories
	INNER JOIN Products 
    	ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryID
ORDER BY Categories.CategoryID

--5. En Yüksek Fiyatlı Ürünlere Sahip Kategorileri Listeleyin
--
SELECT
	Categories.CategoryID,
    Categories.CategoryName
FROM Categories
	INNER JOIN Products 
    	ON Categories.CategoryID = Products.CategoryID
 	WHERE Products.UnitPrice = (SELECT MAX(Products.unitprice) FROM Products)

--6. Bir Ülkedeki Müşterilerin Verdiği Siparişleri Listeleyin
--
SELECT
	DISTINCT shipcountry,
    orderid
FROM Orders 
--WHERE shipcountry = 'Spain' --With this line of code, filtering can be executed.
GROUP BY shipcountry
ORDER BY shipcountry, orderid

--7. Her Kategori İçin Ortalama Fiyatın Üzerinde Olan Ürünleri Listeleyin
--
SELECT
	Categories.CategoryID,
   	productid,
    productname,
    unitprice
FROM Products
	JOIN Categories
    	ON Products.CategoryID = Categories.CategoryID
    WHERE unitprice > (SELECT AVG(unitprice) FROM Products)
GROUP BY Categories.CategoryID

--8. Her Müşterinin En Son Verdiği Siparişi Listeleyin
SELECT
	Customers.CustomerID,
    Customers.ContactName,
    Orders.OrderID,
    Orders.OrderDate,
    MAX(Orders.OrderDate)
FROM Customers
	INNER JOIN Orders 
    	ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID
ORDER BY Customers.CustomerID

--9. Her Çalışanın Kendi Departmanındaki Ortalama Maaşın Üzerinde Maaş Alıp Almadığını Bulun
-- Salary information is lost.

--10. En Az 10 Ürün Satın Alınan Siparişleri Listeleyin
SELECT 
     Orders.OrderID, 
     SUM("Order Details".Quantity) AS TotalQuantity 
FROM Orders 
   JOIN "Order Details" 
   		ON Orders.OrderID = "Order Details".OrderID 
GROUP BY Orders.OrderID 
HAVING TotalQuantity >= 10

--11. Her Kategoride En Pahalı Olan Ürünlerin Ortalama Fiyatını Bulun
SELECT 
     CategoryID, 
     AVG(UnitPrice) 
FROM Products 
   WHERE 
     UnitPrice = (
       SELECT 
         MAX(UnitPrice) 
       FROM Products AS p2 
       WHERE p2.CategoryID = Products.CategoryID
     ) 
   GROUP BY CategoryID
   
--12. Müşterilerin Verdiği Toplam Sipariş Sayısına Göre Sıralama Yapın
SELECT 
	Customers.CompanyName, 
	COUNT(Orders.OrderID) AS TotalOrders 
FROM Customers
	JOIN Orders 
    	ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CompanyName
ORDER BY TotalOrders DESC

--13. En Fazla Sipariş Vermiş 5 Müşteriyi ve Son Sipariş Tarihlerini Listeleyin
SELECT 
	Customers.CompanyName, 
    COUNT(Orders.OrderID), 
    MAX(Orders.OrderDate) 
FROM Customers
JOIN Orders 
	ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CompanyName
ORDER BY TotalOrders DESC
LIMIT 5

--14. Toplam Ürün Sayısı 15'ten Fazla Olan Kategorileri Listeleyin
SELECT 
     CategoryID, 
     COUNT(*) 
FROM Products 
GROUP BY CategoryID 
HAVING TotalProducts > 15

--15. En Fazla 80 Farklı Ürün Sipariş Eden Müşterileri Listeleyin
SELECT
	Customers.CustomerID,
    COUNT(DISTINCT productid) AS ordered_product_count
FROM Customers
	JOIN Orders
    	ON Customers.CustomerID = Orders.CustomerID
     JOIN "Order Details"
     	ON "Order Details".OrderID = Orders.OrderID
HAVING ordered_product_count <= 80

--16. 20'den Fazla Ürün Sağlayan Tedarikçileri Listeleyin
SELECT 
	Suppliers.CompanyName, 
	COUNT(Products.ProductID) AS TotalProducts 
FROM Suppliers
JOIN Products 
	ON Suppliers.SupplierID = Products.SupplierID
GROUP BY Suppliers.CompanyName
HAVING TotalProducts > 2

--17. Her Müşteri İçin En Pahalı Ürünü Bulun
SELECT 
	Customers.CompanyName, 
    Products.ProductName, 
    MAX("Order Details".UnitPrice) AS MaxPrice 
FROM Customers
JOIN Orders 
	ON Customers.CustomerID = Orders.CustomerID
JOIN "Order Details" 
	ON Orders.OrderID = "Order Details".OrderID
JOIN Products 
	ON "Order Details".ProductID = Products.ProductID
GROUP BY Customers.CompanyName

--18. 10.000'den Fazla Sipariş Değeri Olan Çalışanları Listeleyin
--19. Kategorisine Göre En Çok Sipariş Edilen Ürünü Bulun

--20. Müşterilerin En Son Sipariş Verdiği Ürün ve Tarihlerini Listeleyin
SELECT 
     Customers.CustomerID, 
     Customers.CustomerName, 
     Products.ProductName, 
     Orders.OrderDate 
FROM Customers
   JOIN Orders 
     ON Customers.CustomerID = Orders.CustomerID 
   JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID 
   JOIN Products ON "Order Details".ProductID = Products.ProductID 
   WHERE 
     Orders.OrderDate = (
       SELECT 
         MAX(o2.OrderDate) 
       FROM 
         Orders o2 
       WHERE 
         o2.CustomerID = Customers.CustomerID
     )

--21. Her Çalışanın Teslim Ettiği En Pahalı Siparişi ve Tarihini Listeleyin
SELECT 
	Employees.EmployeeID, 
	Orders.OrderID, 
    MAX("Order Details".UnitPrice * "Order Details".Quantity) AS MaxOrderValue, 
    MAX(Orders.OrderDate) AS OrderDate 
FROM Employees
	JOIN Orders 
    	ON Employees.EmployeeID = Orders.EmployeeID
	JOIN "Order Details" 
    	ON Orders.OrderID = "Order Details".OrderID
GROUP BY Employees.EmployeeID;


--22. En Fazla Sipariş Verilen Ürünü ve Bilgilerini Listeleyin
SELECT 
	Products.ProductID, 
	Products.ProductName, 
    Products.CategoryID, 
    SUM("Order Details".Quantity) AS TotalOrdered
FROM Products
   	JOIN "Order Details" 
   		ON Products.ProductID = "Order Details".ProductID
   	JOIN Orders
    	ON "Order Details".OrderID = Orders.OrderID
GROUP BY Products.ProductID, Products.ProductName, Products.CategoryID
ORDER BY TotalOrdered DESC
LIMIT 1
