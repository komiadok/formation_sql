USE AdventureWorks2022;
GO

/* EXERCICES - Exploration de base (niveau débutant) */

/* Clients */

-- Lister les clients dans la base
SELECT * FROM Sales.Customer;
-- 19 820

-- Lister les clients individuels (B2C)
SELECT * FROM Sales.Customer WHERE PersonID IS NOT NULL AND StoreID IS NULL;
-- 18 484

-- Lister les clients qui sont des personnes morales (B2B)
SELECT * FROM Sales.Customer WHERE PersonID IS NULL AND StoreID IS NOT NULL;
-- 701

-- Lister les clients individuels (propriétaires) qui sont associés à une organisation (B2B)
SELECT * FROM Sales.Customer WHERE PersonID IS NOT NULL AND StoreID IS NOT NULL;
-- 635

/* Produits */

-- Lister les produits vendus
SELECT * FROM Production.Product;
-- 504

-- Lister les produits par nom, numéro, prix standard et prix de vente
SELECT 
	Name,
	ProductNumber,
	StandardCost,
	ListPrice
FROM Production.Product;

-- Afficher les produits sans prix de vente
SELECT 
	Name,
	ProductNumber,
	StandardCost,
	ListPrice
FROM Production.Product
WHERE ListPrice = 0;

-- Lister les produits actifs (encore vendus)
SELECT 
	Name,
	ProductNumber,
	StandardCost,
	ListPrice
FROM Production.Product
WHERE SellEndDate IS NULL;

-- Trouver les 10 produits actifs les plus chers
SELECT TOP 10
	Name,
	ProductNumber,
	StandardCost,
	ListPrice
FROM Production.Product 
WHERE SellEndDate IS NULL
	AND ListPrice > 0
ORDER BY ListPrice DESC;

-- Afficher les catégories de produits
SELECT * FROM Production.ProductCategory;
-- 4

-- Afficher les sous-catégories de produits et leurs catégories
SELECT * FROM Production.ProductSubcategory;
-- 37

/* Les commandes  */

-- Lister toutes les commandes 
SELECT * FROM Sales.SalesOrderHeader;
-- 31 465

-- Lister les détails de la commande 43659
SELECT * FROM Sales.SalesOrderDetail WHERE SalesOrderID = 43659;

-- Trouver les 5 dernières commandes passées par des clients
SELECT TOP 5
	SalesOrderNumber,
	OrderDate,
	CustomerID,
	SalesPersonID,
	TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC;

-- Lister les commandes pour le client 30107
SELECT
	SalesOrderNumber,
	OrderDate,
	AccountNumber,
	SalesPersonID,
	TotalDue
FROM Sales.SalesOrderHeader
WHERE CustomerID = 30107;

/* Les employés */
-- Lister les employés dans la base
SELECT * FROM HumanResources.Employee;
-- 290

/* Localisation */
-- Identifier toutes les adresses dans la base
SELECT * FROM Person.Address;
-- 19 614
