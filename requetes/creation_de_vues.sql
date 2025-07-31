USE AdventureWorks2022;
GO

/* EXERCICES - Création de vues */

-- Créer une vue vCustomers qui contient les informations sur les clients  

CREATE VIEW Person.vCustomers AS
	SELECT 
		c.CustomerID,
		p.BusinessEntityID AS PersonID,
		s.BusinessEntityID AS StoreID,
		CASE 
			WHEN p.BusinessEntityID IS NULL AND s.BusinessEntityID IS NOT NULL THEN s.Name
			ELSE CONCAT_WS(' ', p.FirstName, p.MiddleName, p.LastName)
		END AS Customer,
		s.Name AS Store,
		a.AddressLine1,
		a.AddressLine2,
		a.City,
		sp.Name AS StateProvince,
		a.PostalCode,
		cr.Name AS CountryRegion,
		e.EmailAddress,
		pp.PhoneNumber,
		CASE 
			WHEN p.BusinessEntityID IS NOT NULL AND s.BusinessEntityID IS NULL THEN 'B2C'
			ELSE 'B2B'
		END AS RelationType
	FROM Sales.Customer c
		LEFT JOIN Person.Person p
			ON c.PersonID = p.BusinessEntityID 
		LEFT JOIN Sales.Store s 
			ON c.StoreID = s.BusinessEntityID
		LEFT JOIN Person.BusinessEntityAddress bea
			ON c.PersonID = bea.BusinessEntityID
				OR c.StoreID = bea.BusinessEntityID
		LEFT JOIN Person.Address a
			ON bea.AddressID = a.AddressID
		LEFT JOIN Person.StateProvince sp
			ON a.StateProvinceID = sp.StateProvinceID
		LEFT JOIN Person.CountryRegion cr
			ON sp.CountryRegionCode = cr.CountryRegionCode
		LEFT JOIN Person.EmailAddress e 
			ON c.PersonID = e.BusinessEntityID 
		LEFT JOIN Person.PersonPhone pp
			ON c.PersonID = pp.BusinessEntityID
	WHERE bea.AddressTypeID IN (2,3);




