--Her kategorideki (CategoryID) ürün sayısını gösteren bir sorgu yazın.
SELECT 
	categoryid, 
    count(*)
FROM products 
group by categoryid
ORDER BY categoryid

--Birim fiyatı en yüksek 5 ürünü listeleyin.
SELECT 
*
FROM products
ORDER BY unitprice DESC
LIMIT 5

--Her tedarikçinin sattığı ürünlerin ortalama fiyatını listeleyin.
SELECT 
	supplierid,
    AVG(unitprice)
FROM products
group by supplierid

--"Products" tablosunda birim fiyatı 100'den büyük olan ürünlerin kategorilerini ve bu kategorilerdeki ortalama fiyatı listeleyin.
SELECT 
	categoryid,
    AVG(unitprice)
FROM products
WHERE unitprice > 100
GROUP BY categoryid

--"OrderDetails" tablosunda birim fiyat ve miktar çarpımıyla toplam satış değeri 1000'den fazla olan siparişleri listeleyin.
SELECT
	*,
	unitprice * quantity AS [toplam satış değeri]
FROM 'order details'
WHERE [toplam satış değeri] > 1000
ORDER BY [toplam satış değeri] DESC

--En son sevk edilen 10 siparişi listeleyin.
SELECT 
	*
FROM orders
ORDER BY shippeddate DESC
LIMIT 10

--"Products" tablosundaki ürünlerin ortalama fiyatını hesaplayın.
SELECT 
	AVG(unitprice)
FROM products

--"Products" tablosunda fiyatı 50’den büyük olan ürünlerin toplam stok miktarını hesaplayın.
SELECT 
	SUM(unitsinstock)
FROM products
WHERE unitprice > 50 

--"Orders" tablosundaki en eski sipariş tarihini bulun.
SELECT 
 orderdate 
FROM orders
ORDER BY orderdate DESC
LIMIT 1

--"Employees" tablosundaki çalışanların kaç yıl önce işe başladıklarını gösteren bir sorgu yazın.
SELECT 
	*, 
	CURRENT_DATE - hiredate AS [working_years]
FROM employees

--"OrderDetails" tablosundaki her bir sipariş için, birim fiyatın toplamını yuvarlayarak (ROUND) hesaplayın.
SELECT 
	orderid,
    ROUND(SUM(unitprice)) AS [Total Price]
FROM [order details]
GROUP BY orderid

--"Products" tablosunda stoktaki (UnitsInStock) ürün sayısını gösteren bir COUNT sorgusu yazın.
SELECT 
	COUNT (DISTINCT productname) -- Stokta olan distinct ürünlerin sayısı
FROM products
WHERE unitsinstock != 0

--"Products" tablosundaki en düşük ve en yüksek fiyatları hesaplayın.
SELECT 
	MIN(unitprice) AS [Min. Unit Price],
    MAX(unitprice) AS [Max. Unit Price]
FROM products


--"Orders" tablosunda her yıl kaç sipariş alındığını listeleyin (YEAR() fonksiyonunu kullanarak).
SELECT 
	strftime('%Y', orderdate) as [year], 
    COUNT(*) AS [order count]
FROM orders
group by [year]
ORDER BY [year] 

--"Employees" tablosundaki çalışanların tam adını (FirstName + LastName) birleştirerek gösterin.
SELECT 
	CONCAT(firstname, ' ', lastname) as [Full Name]
FROM employees

--"Customers" tablosundaki şehir adlarının uzunluğunu (LENGTH) hesaplayın.
SELECT 
	city,
	LENGTH(city)
FROM customers
WHERE CITY IS NOT NULL
GROUP BY city

--"Products" tablosundaki her ürünün fiyatını iki ondalık basamağa yuvarlayarak gösterin.
SELECT 
	productname,
    printf('%.2f', unitprice)
FROM products
GROUP BY productname

--"Orders" tablosundaki tüm siparişlerin toplam sayısını bulun.
SELECT 
	COUNT(DISTINCT orderid)
FROM orders 

--"Products" tablosunda her kategorideki (CategoryID) ürünlerin ortalama fiyatını (AVG) hesaplayın.
-- Ürün başına ortalama isteniyorsa:
SELECT 
	categoryid,
    productname,
    AVG(unitprice)
FROM products
GROUP BY categoryid, productname
--Kategori başına ortalama isteniyorsa:
SELECT 
	categoryid,
    AVG(unitprice)
FROM products
GROUP BY categoryid

--"Orders" tablosunda sevk tarihi (ShippedDate) boş olan siparişlerin yüzdesini (COUNT ve toplam sipariş sayısını kullanarak) hesaplayın.
SELECT 
      COUNT(*)
FROM orders
WHERE shippeddate IS NULL
 
 

--"Products" tablosundaki en pahalı ürünün fiyatını bulun ve bir fonksiyon kullanarak fiyatı 10% artırın.
SELECT 
* 
FROM products

--"Products" tablosundaki ürün adlarının ilk 3 karakterini gösterin (SUBSTRING).
SELECT 
* 
FROM products

--"Orders" tablosunda verilen siparişlerin yıl ve ay bazında kaç sipariş alındığını hesaplayın (YEAR ve MONTH fonksiyonları).
SELECT 
* 
FROM products

--"OrderDetails" tablosunda toplam sipariş değerini (UnitPrice * Quantity) hesaplayıp, bu değeri iki ondalık basamağa yuvarlayarak gösterin.
SELECT 
* 
FROM products

--"Products" tablosunda stokta olmayan (UnitsInStock = 0) ürünlerin fiyatlarını toplam fiyat olarak hesaplayın.
SELECT 
* 
FROM products
