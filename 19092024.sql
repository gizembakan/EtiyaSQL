--Verilen Customers ve Orders tablolarını kullanarak, Customers tablosundaki müşterileri ve onların verdikleri siparişleri birleştirerek listeleyin. Müşteri adı, sipariş ID'si ve sipariş tarihini gösterin.
SELECT 
	Customers.customerid,
    orderid, 
    orderdate
FROM Customers
	JOIN Orders 
    	ON Customers.CustomerID = Orders.CustomerID

--Verilen Suppliers ve Products tablolarını kullanarak tüm tedarikçileri ve onların sağladıkları ürünleri listeleyin. Eğer bir tedarikçinin ürünü yoksa, NULL olarak gösterilsin.
SELECT 
	Suppliers.SupplierID,
    Products.ProductID,
    Products.ProductName
FROM Suppliers 
	LEFT JOIN Products
    	on Suppliers.SupplierID = Products.SupplierID

--Verilen Employees ve Orders tablolarını kullanarak tüm siparişleri ve bu siparişleri işleyen çalışanları listeleyin. Eğer bir sipariş bir çalışan tarafından işlenmediyse, çalışan bilgileri NULL olarak gösterilsin.
SELECT
	Orders.OrderID,
    Employees.EmployeeID,
    CONCAT
    (
    Employees.FirstName,
    Employees.LastName
    )
from Employees
	RIGHT JOIN Orders
    	ON 	Employees.EmployeeID = Orders.EmployeeID
ORDER BY Employees.employeeid

--Verilen Customers ve Orders tablolarını kullanarak tüm müşterileri ve tüm siparişleri listeleyin. Sipariş vermeyen müşteriler ve müşterisi olmayan siparişler için NULL döndürün.
SELECT
	Customers.CustomerID,
    Orders.*
FROM Customers 
	FULL JOIN Orders
    	ON Customers.CustomerID = Orders.CustomerID

--Verilen Products ve Categories tablolarını kullanarak tüm ürünler ve tüm kategoriler için olası tüm kombinasyonları listeleyin. Sonuç kümesindeki her satır bir ürün ve bir kategori kombinasyonunu göstermelidir.
SELECT
	Products.ProductID,
    Products.ProductName,
    Categories.CategoryID,
    Categories.CategoryName
FROM Products
CROSS JOIN Categories

--Verilen Orders, Customers, Employees tablolarını kullanarak bu tabloları birleştirin ve 1998 yılında verilen siparişleri listeleyin. Müşteri adı, sipariş ID'si, sipariş tarihi ve ilgili çalışan adı gösterilsin.
SELECT
   Customers.CustomerID,
   Orders.OrderID,
   Orders.OrderDate,
   CONCAT(
   Employees.FirstName,
   Employees.LastName
   )
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE STRFTIME('%Y', Orders.OrderDate) = '2013' 

--Verilen Orders ve Customers tablolarını kullanarak müşterileri, verdikleri sipariş sayısına göre gruplandırın. Sadece 5’ten fazla sipariş veren müşterileri listeleyin.
SELECT
	Customers.CustomerID, 
    COUNT(Orders.OrderID) AS "Order Count"
FROM Orders
JOIN Customers
	ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID
HAVING "Order Count" > 5
ORDER BY "Order Count" DESC

--Verilen OrderDetails ve Products tablolarını kullanarak her ürün için kaç adet satıldığını ve toplam satış miktarını listeleyin. Ürün adı, satılan toplam adet ve toplam kazancı (Quantity * UnitPrice) gösterin.
SELECT
	Products.ProductID,
    Products.ProductName,
    Products.UnitPrice * Products.QuantityPerUnit AS "Toplam Kazanç",
    COUNT(*) AS "Toplam Satış Adedi"
FROM "Order Details"
	JOIN Products 
    	ON "Order Details".ProductID = Products.ProductID
GROUP BY Products.ProductID, Products.ProductName

--Verilen Customers ve Orders tablolarını kullanarak, müşteri adı "B" harfiyle başlayan müşterilerin siparişlerini listeleyin.
SELECT
	DISTINCT Customers.ContactName
FROM Customers
	JOIN Orders
    	ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.ContactName LIKE 'B%'

--Verilen Products ve Categories tablolarını kullanarak tüm kategorileri listeleyin ve ürünleri olmayan kategorileri bulun. Ürün adı NULL olan satırları gösterin.
SELECT
	Categories.CategoryID,
    Products.ProductID
FROM Products
RIGHT JOIN Categories	
	ON Products.CategoryID = Categories.CategoryID
WHERE productid IS NULL

--Verilen Employees tablosunu kullanarak her çalışanın yöneticisiyle birlikte bir liste oluşturun.
SELECT
	E1.EmployeeID, 
    CONCAT(E1.FirstName, ' ',  E1.LastName) AS "Employee Full Name",
    CONCAT(E2.FirstName, ' ',  E2.LastName) AS "Manager"
FROM Employees AS E1
	JOIN Employees AS E2
    	ON E1.EmployeeID = E2.ReportsTo

--Verilen Products tablosunu kullanarak her kategorideki en pahalı ürünleri ve bu ürünlerin farklı fiyatlara sahip olup olmadığını sorgulayın.
--
SELECT
	Categories.CategoryID,
	Products.ProductID,
    Products.UnitPrice
FROM Products 
JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryID
ORDER BY Products.UnitPrice DESC
LIMIT 1

--Verilen Orders ve OrderDetails tablolarını kullanarak bu tabloları birleştirin ve her siparişin detaylarını sipariş ID'sine göre artan sırada listeleyin.
SELECT 
	"Order Details".*
FROM Orders 
	JOIN "Order Details"
    	on Orders.OrderID = "Order Details".OrderID
GROUP BY Orders.OrderID 
ORDER BY Orders.OrderID asc
        
--Verilen Employees ve Orders tablolarını kullanarak her çalışanın kaç tane sipariş işlediğini listeleyin. Sipariş işlemeyen çalışanlar da gösterilsin.
SELECT 
	Employees.EmployeeID,
    COUNT(DISTINCT Orders.OrderID)
FROM Employees
LEFT JOIN Orders 
	ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID

--Verilen Products tablosunu kullanarak bir kategorideki ürünleri kendi arasında fiyatlarına göre karşılaştırın ve fiyatı düşük olan ürünleri listeleyin.
--
SELECT
	Categories.CategoryID,
	Products.ProductID,
    Products.ProductName,
    Products.UnitPrice
FROM Products
JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryID
Order BY Categories.CategoryID, Products.UnitPrice ASC

--Verilen Products ve Suppliers tablolarını kullanarak tedarikçiden alınan en pahalı ürünleri listeleyin.
--
SELECT
	Suppliers.SupplierID,
    Products.ProductID,
    Products.ProductName,
    Products.UnitPrice
FROM Products 
	JOIN Suppliers
    	ON Products.SupplierID = Suppliers.SupplierID
GROUP BY Suppliers.SupplierID
ORDER BY Suppliers.SupplierID, Products.UnitPrice DESC

--Verilen Employees ve Orders tablolarını kullanarak her çalışanın işlediği en son siparişi bulun.
--
SELECT
	*
FROM(
	SELECT
      Employees.EmployeeID,
      CONCAT(
      Employees.FirstName,
      Employees.LastName
       ) AS "Employee Full Name",
      Orders.ShippedDate
  FROM Employees
  JOIN Orders
      ON Employees.EmployeeID = Orders.EmployeeID
  GROUP BY Employees.EmployeeID
  ORDER BY Orders.ShippedDate DESC
  ) as a
 WHERE a.ShippedDate = MAX(a.ShippedDate)
 GROUP BY a.EmployeeID
 

--Verilen Products tablosunu kullanarak ürünleri fiyatlarına göre gruplandırın ve fiyatı 20 birimden fazla olan ürünlerin sayısını listeleyin.
SELECT
	Products.UnitPrice,
	Products.ProductID,
    Products.ProductName
FROM Products
WHERE Products.UnitPrice > 20
GROUP BY Products.UnitPrice
ORDER BY unitprice DESC, productid DESC


--Verilen Orders ve Customers tablolarını kullanarak 1997 ile 1998 yılları arasında verilen siparişleri müşteri adıyla birlikte listeleyin.
SELECT
	Customers.CustomerID,
    Customers.ContactName,
    Orders.OrderID,
    Orders.OrderDate
FROM Orders
	JOIN Customers 
		ON Orders.CustomerID = Customers.CustomerID
WHERE STRFTIME('%Y', Orders.OrderDate) BETWEEN '2012' AND '2013'
GROUP BY Customers.CustomerID
ORDER BY Customers.CustomerID, Orders.OrderDate

--Verilen Customers ve Orders tablolarını kullanarak hiç sipariş vermeyen müşterileri listeleyin.
SELECT 
	Customers.CustomerID,
 	Customers.ContactName,
    Orders.OrderID
FROM Customers
LEFT JOIN Orders 
 	ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL

    
