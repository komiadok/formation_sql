# 🗃️ **Structure générale de la base AdventureWorks**

Elle est relativement riche et comprend des tables couvrant plusieurs domaines métier :

## 1. **Ventes (Sales)**

* **SalesOrderHeader / SalesOrderDetail** : Commandes clients.
* **Customer** : Informations clients (entreprises ou particuliers).
* **SalesPerson / SalesTerritory** : Représentants commerciaux et territoires de vente.
* **Store** : Magasins clients (revendeurs).

## 2. **Production (Production)**

* **Product / ProductCategory / ProductSubcategory** : Produits vendus, avec leur hiérarchie.
* **BillOfMaterials** : Liste des composants pour fabriquer un produit.
* **WorkOrder / ScrapReason** : Ordres de fabrication et causes de rebut.
* **TransactionHistory** : Mouvements de stock.

## 3. **Achats / Fournisseurs (Purchasing)**

* **Vendor** : Fournisseurs.
* **PurchaseOrderHeader / PurchaseOrderDetail** : Bons de commande fournisseurs.
* **ProductVendor** : Produits par fournisseur.

## 4. **Ressources humaines (HumanResources)**

* **Employee** : Informations RH sur les employés.
* **Department / Shift / JobCandidate** : Départements, horaires, candidats.
* **EmployeePayHistory** : Historique des salaires.

## 5. **Comptabilité et finance (Finance)**

* **Currency / CurrencyRate** : Devises et taux de change.
* **SalesTaxRate** : Taxes de vente.
* **CreditCard / Transaction / Account** : Moyens de paiement et mouvements financiers.

## 6. **Logistique / Emplacements (Inventory & Locations)**

* **Location / ProductInventory** : Quantité de stock par emplacement.
* **ShipMethod / Address / CountryRegion** : Méthodes de livraison et adresses.

## 7. **Personnes et contacts (Person)**

* **Person** : Données personnelles centralisées (clients, employés, etc.).
* **EmailAddress / PhoneNumber / BusinessEntityContact** : Coordonnées.
