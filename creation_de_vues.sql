/* Créer une vue qui contient les informations sur les clients personne morale */

CREATE VIEW Person.vClientsEntreprises AS 
	SELECT DISTINCT
		s.BusinessEntityID,
		s.Name,
		a.AddressLine1,
		a.AddressLine2,
		a.City,
		sp.Name AS StateProvince,
		a.PostalCode,
		cr.Name AS CountryRegion
	FROM Sales.Store s
		JOIN Person.BusinessEntityAddress bea
			ON s.BusinessEntityID = bea.BusinessEntityID
		JOIN Person.Address a
			ON bea.AddressID = a.AddressID
		JOIN Person.StateProvince sp
			ON a.StateProvinceID = sp.StateProvinceID
		JOIN Person.CountryRegion cr 
			ON sp.CountryRegionCode = cr.CountryRegionCode
	WHERE bea.AddressTypeID = 3;

/* Créer une vue qui contient les informations sur les clients personne physique */
CREATE VIEW Person.vCLientsIndividus AS 
	SELECT 
		c.PersonID ,
		p.Title,
		p.FirstName,
		p.MiddleName,
		p.LastName,
		ea.EmailAddress,
		pp.PhoneNumber,
		a.AddressLine1,
		a.AddressLine2,
		a.City,
		sp.Name AS StateProvince,
		a.PostalCode,
		cr.Name AS CountryRegion
	FROM Sales.Customer c
		JOIN Person.Person p 
			ON c.PersonID = p.BusinessEntityID
		JOIN Person.EmailAddress ea
			ON p.BusinessEntityID = ea.BusinessEntityID
		JOIN Person.PersonPhone pp
			ON ea.BusinessEntityID = pp.BusinessEntityID
		JOIN Person.BusinessEntityAddress bea
			ON pp.BusinessEntityID = bea.BusinessEntityID
		JOIN Person.Address a
			ON bea.AddressID = a.AddressID
		JOIN Person.StateProvince sp
			ON a.StateProvinceID = sp.StateProvinceID
		JOIN Person.CountryRegion cr
			ON sp.CountryRegionCode = cr.CountryRegionCode
	WHERE p.PersonType = 'IN'
		AND bea.AddressTypeID = 2;

/* Créer une vue qui contient les informations de localisation des personnes */
CREATE VIEW Person.vAddress AS 
	SELECT 
		a.AddressID,
		a.AddressLine1,
		a.AddressLine2,
		a.City,
		sp.Name AS StateProvince,
		a.PostalCode,
		cr.Name AS CountryRegion
	FROM Person.Address a
		JOIN Person.StateProvince sp
			ON a.StateProvinceID = sp.StateProvinceID
		JOIN Person.CountryRegion cr 
			ON sp.CountryRegionCode = cr.CountryRegionCode;