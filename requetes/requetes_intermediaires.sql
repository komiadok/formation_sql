USE AdventureWorks2022;
GO

/* EXERCICES - Requêtes intermédiaires et avancées */

/* Jointures simples et multiples */

-- Afficher les produits avec leurs modèles
SELECT 
	p.Name AS Product,
	pm.Name AS Model
FROM Production.Product p
	LEFT JOIN Production.ProductModel pm
		ON p.ProductModelID = pm.ProductModelID
ORDER BY p.Name, pm.Name;

-- Pour chaque produit, afficher son modèle et sa description
SELECT 
	p.Name AS Product,
	pm.Name AS Model,
	pd.Description,
	pmpdc.CultureID
FROM Production.Product p 
	LEFT JOIN Production.ProductModel pm 
		ON p.ProductModelID = pm.ProductModelID
	LEFT JOIN Production.ProductModelProductDescriptionCulture pmpdc
		ON pm.ProductModelID = pmpdc.ProductModelID
	LEFT JOIN Production.ProductDescription pd
		ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID
WHERE pmpdc.CultureID IS NULL
	OR pmpdc.CultureID = 'fr'
ORDER BY p.Name, pm.Name, pd.Description;


-- Afficher les produits, avec les sous-catégories et catégories auxquelles ils appartiennent
SELECT
	p.Name AS Product,
	ps.Name AS Subcategory,
	pc.Name AS Category
FROM Production.Product p 
	LEFT JOIN Production.ProductSubcategory ps
		ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	LEFT JOIN Production.ProductCategory pc
		ON ps.ProductCategoryID = pc.ProductCategoryID
ORDER BY p.Name, ps.Name, pc.Name;

-- Afficher les produits, les quantités disponibles en stock, le stock de sécurité et leur entrepôt de stockage
SELECT 
	p.Name AS Product,
	pi.Quantity AS Stock,
	p.SafetyStockLevel,
	l.Name AS Location
FROM Production.Product p
	LEFT JOIN Production.ProductInventory pi
		ON p.ProductID = pi.ProductID
	LEFT JOIN Production.Location l
		ON pi.LocationID = l.LocationID
WHERE p.SellEndDate IS NULL
ORDER BY p.Name, l.Name;

-- Afficher les produits assemblés et leurs composants
SELECT
	bom.ProductAssemblyID,
	p.Name AS ProductAssemblyName,
	p2.Name AS Components,
	bom.PerAssemblyQty 
FROM Production.BillOfMaterials bom
	LEFT JOIN Production.Product p
		ON bom.ProductAssemblyID = p.ProductID
	LEFT JOIN Production.Product p2
		ON bom.ComponentID = p2.ProductID
WHERE bom.ProductAssemblyID IS NOT NULL
ORDER BY bom.ProductAssemblyID, p.Name, p2.Name;

-- Afficher les clients, et le type de relation qui les lie avec les entreprises (B2B, B2C)
SELECT 
	c.CustomerID,
	p.BusinessEntityID AS PersonID,
	s.BusinessEntityID AS StoreID,
	CASE 
		WHEN p.BusinessEntityID IS NULL AND s.BusinessEntityID IS NOT NULL THEN s.Name
		ELSE CONCAT_WS(' ', p.FirstName, p.MiddleName, p.LastName)
	END AS Customer,
	s.Name AS Store,
	CASE 
		WHEN p.BusinessEntityID IS NOT NULL AND s.BusinessEntityID IS NULL THEN 'B2C'
		ELSE 'B2B'
	END AS RelationType
FROM Sales.Customer c
	LEFT JOIN Person.Person p
		ON c.PersonID = p.BusinessEntityID 
	LEFT JOIN Sales.Store s 
		ON c.StoreID = s.BusinessEntityID
ORDER BY c.CustomerID, p.BusinessEntityID, s.BusinessEntityID;

-- Lister les clients avec commandes associées
SELECT 
	c.CustomerID,
	c.Customer,
	soh.SalesOrderID,
	soh.OrderDate,
	soh.Status,
	soh.SalesPersonID,
	soh.TerritoryID,
	soh.TotalDue
FROM Person.vCustomers c
	LEFT JOIN Sales.SalesOrderHeader soh
		ON c.CustomerID = soh.CustomerID;

-- Lister les employés avec leur nom et département
SELECT 
	e.BusinessEntityID,
	e.Gender,
	CONCAT_WS(' ', p.FirstName, p.MiddleName, p.LastName) AS Employee,
	e.BirthDate,
	e.JobTitle,
	e.HireDate,
	d.Name AS Department
FROM HumanResources.Employee e
	LEFT JOIN Person.Person p
		ON e.BusinessEntityID = p.BusinessEntityID
	LEFT JOIN HumanResources.EmployeeDepartmentHistory edh
		ON e.BusinessEntityID = edh.BusinessEntityID
	LEFT JOIN HumanResources.Department d
		ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL;

-- Lister les managers et leurs employés, ainsi que leurs départements
SELECT 
	e1.BusinessEntityID AS ManagerID,
	CONCAT_WS(' ', p.FirstName, p.MiddleName, p.LastName) AS Manager,
	e1.JobTitle AS JobTitleManager,
	e2.BusinessEntityID AS SubordinateID,
	CONCAT_WS(' ', p2.FirstName, p2.MiddleName, p2.LastName) AS Subordinate,
	e2.JobTitle AS JobTitleSubordinate,
	d.Name AS Department,
	d.GroupName
FROM HumanResources.Employee e1
	LEFT JOIN Person.Person p
		ON e1.BusinessEntityID = p.BusinessEntityID
	JOIN HumanResources.Employee e2
		ON e2.OrganizationNode.GetAncestor(1) = e1.OrganizationNode
	LEFT JOIN Person.Person p2
		ON e2.BusinessEntityID = p2.BusinessEntityID
	LEFT JOIN HumanResources.EmployeeDepartmentHistory edh
		ON e1.BusinessEntityID = edh.BusinessEntityID
	LEFT JOIN HumanResources.Department d
		ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL
ORDER BY e1.BusinessEntityID;
-- Get Ancestor(1) retourne le niveau supérieur direct de l'employé

-- Afficher l'historique de poste
SELECT 
	e.BusinessEntityID,
	e.Gender,
	CONCAT_WS(' ', p.FirstName, p.MiddleName, p.LastName) AS Employee,
	e.BirthDate,
	e.JobTitle,
	e.HireDate,
	s.Name AS Shift,
	d.Name AS Department,
	edh.StartDate,
	edh.EndDate
FROM HumanResources.Employee e
	LEFT JOIN Person.Person p
		ON e.BusinessEntityID = p.BusinessEntityID
	LEFT JOIN HumanResources.EmployeeDepartmentHistory edh
		ON e.BusinessEntityID = edh.BusinessEntityID
	LEFT JOIN HumanResources.Department d
		ON edh.DepartmentID = d.DepartmentID
	LEFT JOIN HumanResources.Shift s
		ON edh.ShiftID = s.ShiftID
ORDER BY e.BusinessEntityID, edh.StartDate;

-- Lister les commerciaux avec leur territoire et objectif 
SELECT 
	p.FirstName,
	p.MiddleName,
	p.LastName,
	sp.SalesQuota,
	st.Name AS Territory,
	m.Manager
FROM Sales.SalesPerson sp 
	LEFT JOIN Sales.SalesTerritory st
		ON sp.TerritoryID = st.TerritoryID
	LEFT JOIN Person.Person p 
		ON sp.BusinessEntityID = p.BusinessEntityID
	LEFT JOIN HumanResources.vManagement m
		ON sp.BusinessEntityID = m.SubordinateID
WHERE sp.SalesQuota IS NOT NULL;

-- Associer à chaque produit son fournisseur
SELECT 
	p.ProductID,
	p.Name AS Product,
	v.Name AS Vendor,
	pv.AverageLeadTime
FROM Production.Product p 
	LEFT JOIN Purchasing.ProductVendor pv 
		ON p.ProductID = pv.ProductID
	LEFT JOIN Purchasing.Vendor v
		ON pv.BusinessEntityID = v.BusinessEntityID
WHERE v.ActiveFlag = 1
ORDER BY p.ProductID, p.Name;

/* Agrégations */

-- Nombre de produits par catégorie
SELECT
	pc.Name AS Category,
	COUNT(p.ProductID) AS TotalProducts
FROM Production.Product p 
	LEFT JOIN Production.ProductSubcategory ps
		ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	LEFT JOIN Production.ProductCategory pc
		ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
ORDER BY pc.Name;

-- Nombre de clients par territoire
SELECT 
	st.Name AS Territory,
	COUNT(c.CustomerID) AS TotalCustomers
FROM Sales.Customer c
	LEFT JOIN Sales.SalesTerritory st
		ON c.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY st.Name;

-- TOP 10 des clients ayant passé le plus de commandes
SELECT TOP 10
	c.Customer,
	COUNT(soh.SalesOrderID) AS TotalSales
FROM Person.vCustomers c
	LEFT JOIN Sales.SalesOrderHeader soh
		ON c.CustomerID = soh.CustomerID
WHERE soh.CustomerID IS NOT NULL
GROUP BY c.Customer
ORDER BY COUNT(soh.SalesOrderID) DESC;

-- TOP 10 des clients par montant total d'achats
SELECT TOP 10
	c.Customer,
	ROUND(SUM(soh.TotalDue), 2) AS SalesAmount
FROM Person.vCustomers c
	LEFT JOIN Sales.SalesOrderHeader soh
		ON c.CustomerID = soh.CustomerID
WHERE soh.CustomerID IS NOT NULL
GROUP BY c.Customer
ORDER BY ROUND(SUM(soh.TotalDue), 2) DESC;

-- Répartition des clients par type de relation
SELECT 
	RelationType,
	COUNT(CustomerID) AS TotalCustomers
FROM Person.vCustomers
GROUP BY RelationType;

-- Nombre de commandes par mois
SELECT 
	FORMAT(OrderDate, 'MMMM') AS Month,
	DATEPART(MONTH, OrderDate) AS MonthNum,
	COUNT(SalesOrderID) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY FORMAT(OrderDate, 'MMMM'), DATEPART(MONTH, OrderDate)
ORDER BY DATEPART(MONTH, OrderDate);

-- Chiffre d'affaires mensuel
SELECT 
	YEAR(OrderDate) AS Year,
	FORMAT(OrderDate, 'MMMM') AS Month,
	MONTH(OrderDate) AS MonthNum,
	ROUND(SUM(TotalDue), 2) AS SalesAmount
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate),FORMAT(OrderDate, 'MMMM'), MONTH(OrderDate)
ORDER BY YEAR(OrderDate), DATEPART(MONTH, OrderDate);

-- Nombre de commandes par territoire pour l'année 2014
SELECT 
	st.Name AS Territory,
	COUNT(soh.SalesOrderID) AS TotalOrders
FROM Sales.SalesOrderHeader soh
	LEFT JOIN Sales.SalesTerritory st
		ON soh.TerritoryID = st.TerritoryID
WHERE YEAR(soh.OrderDate) = 2014
GROUP BY st.Name
ORDER BY COUNT(soh.SalesOrderID) DESC;

-- TOP 10 des produits générant le plus de revenus 
SELECT TOP 10
	p.ProductID,
	p.Name AS Product,
	ROUND(SUM(sod.LineTotal), 2) AS TotalSales
FROM Production.Product p
	LEFT JOIN Sales.SalesOrderDetail sod
		ON p.ProductID = sod.ProductID
WHERE p.SellEndDate IS NULL
	AND sod.LineTotal IS NOT NULL
GROUP BY p.ProductID, p.Name
ORDER BY ROUND(SUM(sod.LineTotal), 2) ASC;

-- Nombre d'employés par département
SELECT 
	d.Name AS Department,
	COUNT(e.BusinessEntityID) AS TotalEmployees
FROM HumanResources.Employee e
	LEFT JOIN Person.Person p
		ON e.BusinessEntityID = p.BusinessEntityID
	LEFT JOIN HumanResources.EmployeeDepartmentHistory edh
		ON e.BusinessEntityID = edh.BusinessEntityID
	LEFT JOIN HumanResources.Department d
		ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL
GROUP BY d.Name
ORDER BY COUNT(e.BusinessEntityID);

/* Sous-requêtes */

-- Lister les produits jamais commandés.
SELECT 
	p.ProductID,
	p.Name AS Product,
	p.StandardCost,
	p.ListPrice
FROM Production.Product p
	LEFT JOIN Sales.SalesOrderDetail sod
		ON p.ProductID = sod.ProductID
WHERE p.SellEndDate IS NULL
	AND p.ListPrice > 0
	AND sod.ProductID IS NULL; 

-- Trouver les produits dont le prix est supérieur à la moyenne (Sous-requêtes)
SELECT 
	ProductID,
	Name AS Product,
	ListPrice AS ProductPrice
FROM Production.Product
WHERE ListPrice > 0 
	AND sellEndDate > 0
	AND ListPrice > ( SELECT AVG(ListPrice)
					  FROM Production.Product)
ORDER BY ListPrice DESC;

/* CTE et Window Functions */

-- Classement des vendeurs par ventes 
WITH Person AS (
	SELECT 
		BusinessEntityID,
		CONCAT_WS(' ',FirstName, MiddleName, LastName) AS Name
	FROM Person.Person
)
SELECT 
	sp.BusinessEntityID,
	p.Name AS SalesPerson,
	SUM(sp.SalesYTD) AS TotalSales,
	RANK() OVER (ORDER BY SUM(sp.SalesYTD) DESC) AS Rank
FROM Sales.SalesPerson sp
	LEFT JOIN Person p
		ON sp.BusinessEntityID = p.BusinessEntityID
GROUP BY sp.BusinessEntityID, p.Name
ORDER BY RANK() OVER (ORDER BY SUM(sp.SalesYTD) DESC);

-- Détecter les employés en doublons (personnes avec même prénom, nom et date de naissance)
WITH duplicated_employee AS (
	SELECT 
		p.FirstName, 
		p.MiddleName, 
		p.LastName,
		e.BirthDate,
		COUNT(*) OVER (PARTITION BY p.FirstName, p.MiddleName, p.LastName, e.BirthDate) AS CountDuplicates
	FROM HumanResources.Employee e
		LEFT JOIN Person.Person p 
			ON e.BusinessEntityID = p.BusinessEntityID
)
SELECT *
FROM duplicated_employee
WHERE CountDuplicates > 1;

/* Fonctions analytiques */

-- Suivre l'évolution des ventes par mois 
SELECT 
	YEAR(OrderDate) AS Year, 
	MONTH(OrderDate) AS MonthNum, 
	FORMAT(OrderDate, 'MMMM') AS Month,
	ROUND(SUM(TotalDue), 2) AS MonthlySales,
	LAG(ROUND(SUM(TotalDue), 2)) OVER (ORDER BY YEAR(OrderDate), MONTH(OrderDate)) AS PreviousMonthSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate), FORMAT(OrderDate, 'MMMM')
ORDER BY YEAR(OrderDate), MONTH(OrderDate);

-- Calculer une moyenne mobile des ventes sur 3 mois 
WITH VentesMensuelles AS (
    SELECT 
        CAST(DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1) AS DATE) AS MoisDate,
        SUM(TotalDue) AS TotalVentes
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
),
VentesAvecMoyenne AS (
    SELECT 
        MoisDate,
        TotalVentes,
        COUNT(*) OVER (ORDER BY MoisDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS FenetreTaille,
        AVG(TotalVentes) OVER (ORDER BY MoisDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MoyenneBrute
    FROM VentesMensuelles
)
SELECT 
    MoisDate,
    TotalVentes,
    CASE 
        WHEN FenetreTaille < 3 THEN NULL
        ELSE ROUND(MoyenneBrute, 2)
    END AS MoyenneMobile3Mois
FROM VentesAvecMoyenne
ORDER BY MoisDate;
