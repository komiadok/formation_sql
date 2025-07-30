USE AdventureWorks2022;
GO

/* EXERCICES - Exploration de base (niveau débutant) */

-- Afficher les types d'adresse d'une personne dans la base
SELECT DISTINCT AddressTypeID, Name FROM Person.AddressType;

-- Afficher les rôles ou types d'entité des personnes dans la base
SELECT DISTINCT PersonType FROM Person.Person;

-- Calculer le nombre total de relations clients dans la base
SELECT COUNT(*) AS TotalRealtionsClient FROM Sales.Customer;
-- 19 820

-- Calculer le nombre de clients qui ne sont des personnes morales
SELECT COUNT(DISTINCT PersonID) AS ClientsNonEntreprises FROM Sales.Customer WHERE PersonID IS NOT NULL;
-- 19 119

-- Calculer le nombre de clients qui sont des personnes morales
SELECT COUNT(DISTINCT StoreID) AS ClientsEntreprises FROM Sales.Customer WHERE StoreID IS NOT NULL;
-- 701

-- Calculer le nombre de clients qui sont des personnes physiques
SELECT COUNT(DISTINCT c.PersonID) AS ClientsIndividus
FROM Sales.Customer c
	JOIN Person.Person p 
		ON c.PersonID = p.BusinessEntityID
WHERE p.PersonType = 'IN';
-- 18 484

-- Afficher les 10 premiers clients de la vue vClientsIndividus
SELECT TOP 10* FROM Person.vCLientsIndividus;

-- Afficher les 10 premières entreprises clientes dans la vie vClientsEntreprises
SELECT TOP 10* FROM Person.vClientsEntreprises;

-- Calculer le nombre de produits distincts vendus
SELECT COUNT(ProductID) AS TotalProducts FROM Production.Product;
-- 504

-- Lister les produits par nom, numéro et prix standard
SELECT 
	ProductNumber,
	Name,
	StandardCost
FROM Production.Product;

-- Lister les catégories de produits et leurs sous-catégories
SELECT
	pc.Name AS Category,
	ps.Name AS Subcategory
FROM Production.ProductCategory pc
	JOIN Production.ProductSubcategory ps
		ON pc.ProductCategoryID = ps.ProductCategoryID
ORDER BY pc.Name, ps.Name;

-- Lister les produits de la catégorie Bikes
SELECT 
	p.Name AS Product,
	pc.Name AS Category
FROM Production.Product p 
	LEFT JOIN Production.ProductSubcategory ps
		ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	LEFT JOIN Production.ProductCategory pc
		ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Bikes'
ORDER BY p.Name;

-- Trouver les 10 produits les plus chers
SELECT TOP 10
	Name AS Product,
	ListPrice
FROM Production.Product 
ORDER BY ListPrice DESC;

-- Calculer le nombre de commandes passées par les clients 
SELECT COUNT(*) AS TotalSales FROM Sales.SalesOrderHeader;
-- 31 465

-- Calculer le chiffre d'affaires réalisé 
SELECT SUM(TotalDue) AS CA FROM Sales.SalesOrderHeader;
-- 123 216 786.1159 $

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

-- Calculer le nombre d'adresses différentes dans la base
SELECT COUNT(DISTINCT AddressID) AS TotalAdresses FROM Person.Address;
-- 19 614

-- Afficher les 10 premières adresses avec ville, état et pays
SELECT TOP 10* FROM Person.vAddress;

-- Calculer le nombre d'employés dans la base
SELECT COUNT(BusinessEntityID) AS TotalEmployee FROM HumanResources.Employee;
-- 290

-- Lister les employés et leur département
SELECT 
	e.NationalIDNumber,
	e.JobTitle,
	e.BirthDate,
	e.MaritalStatus,
	e.Gender,
	e.HireDate,
	d.Name AS Department
FROM HumanResources.Employee e 
	JOIN HumanResources.EmployeeDepartmentHistory edh 
		ON e.BusinessEntityID = edh.BusinessEntityID
	JOIN HumanResources.Department d
		ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL
ORDER BY e.NationalIDNumber;

-- Lister les vendeurs actifs avec leur nom et leur territoire
SELECT 
	p.FirstName,
	p.MiddleName,
	p.LastName,
	st.Name AS Territory
FROM Sales.SalesPerson sp 
	JOIN Sales.SalesTerritory st
		ON sp.TerritoryID = st.TerritoryID
	JOIN Person.Person p 
		ON sp.BusinessEntityID = p.BusinessEntityID
WHERE sp.SalesQuota IS NOT NULL;