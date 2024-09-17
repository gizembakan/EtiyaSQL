--Tedarikçi ID'si 1 ile 5 arasındaki ürünler:
SELECT 
	productname 
FROM products 
WHERE supplierid BETWEEN 1 AND 5

--Tedarikçi ID'si 1, 2, 3, 4 veya 5 olan ürünleri listeleyin.
SELECT 
	productname 
FROM products 
WHERE supplierid IN (1, 2, 3, 4, 5)

--Ürün adı 'Chang' veya 'Aniseed Syrup' olan ürünler:
SELECT 
	productname 
FROM products 
WHERE productname IN ('Chang', 'Aniseed Syrup')

--Tedarikçi ID'si 3 olan veya birim fiyatı 10'dan büyük ürünler:
SELECT 
	productname 
FROM products 
WHERE supplierid = 3  OR unitprice > 10

--Ürün adı ve birim fiyatını içeren listeyi getirin.
SELECT 
	productname || ' ' ||  unitprice 
FROM products

--Ürün adlarını büyük harfe dönüştürdükten sonra 'c' harfi içeren ürünleri listeleyin. (örneğin: 'Chai', 'Chocolate', vs.)
SELECT 
	UPPER(productname) 
FROM products 
WHERE productname LIKE '%c%'

--Ürün adı 'n' harfi ile başlayan ve içerisinde tek karakterli bir harf içeren ürünleri listeleyin. (örneğin: 'Naan', 'Nectar', vs.)
--: 'n' ile başlayan ve tek n karakterli bir kelime içeren ürünler
SELECT 
	productname 
FROM products 
WHERE 
	productname LIKE 'n%' AND (LENGTH(productname) - LENGTH(REPLACE(productname, 'n', '')) = 1)

--Stok miktarı 50'den fazla olan ürünler:
SELECT productname FROM products WHERE unitsinstock > 50

--En yüksek ve en düşük birim fiyatına sahip ürünleri listeleyin.
SELECT 
	productname
FROM products 
WHERE unitprice = (SELECT MAX(unitprice) FROM products)
   OR unitprice = (SELECT MIN(unitprice) FROM products)

--Ürün adında 'Spice' kelimesi geçen ürünleri listeleyin.
SELECT productname FROM products WHERE productname LIKE '%spice%'
