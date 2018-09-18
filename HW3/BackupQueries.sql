use northwinds;
/*
1
*/
select LastName, FirstName, HireDate, Country from nwEmployees
where HireDate <= '%2013-07-04%'
AND Country <> 'USA' order by LastName asc;
/*
+-----------+-----------+---------------------+---------+
| LastName  | FirstName | HireDate            | Country |
+-----------+-----------+---------------------+---------+
| Dodsworth | Anne      | 2004-11-15 00:00:00 | UK      |
| King      | Robert    | 2012-09-02 00:00:00 | UK      |
| Suyama    | Michael   | 2011-10-17 00:00:00 | UK      |
+-----------+-----------+---------------------+---------+
*/

/*
2
*/
select ProductName, UnitPrice, UnitsInStock from nwProducts
where UnitsInStock < ReorderLevel;

/*
3
*/
SELECT ProductName, UnitPrice     FROM nwProducts
INNER JOIN (SELECT MAX(UnitPrice) AS MaxPrice
FROM nwProducts  GROUP BY UnitPrice) q ON UnitPrice = UnitPrice
AND UnitPrice = q.MaxPrice order by UnitPrice desc limit 1;

/*
4
*/
select ProductID, ProductName, UnitsInStock * UnitPrice as "Inventory Value"
  from nwProducts
    where UnitsInStock * UnitPrice > 2000
  order by UnitsInStock * UnitPrice desc;
/*
+-----------+------------------------------+-----------------+
| ProductID | ProductName                  | Inventory Value |
+-----------+------------------------------+-----------------+
|        38 | Côte de Blaye                |         4479.50 |
|        59 | Raclette Courdavault         |         4345.00 |
|        12 | Queso Manchego La Pastora    |         3268.00 |
|        20 | Sir Rodney's Marmalade       |         3240.00 |
|        61 | Sirop d'érable               |         3220.50 |
|         6 | Grandma's Boysenberry Spread |         3000.00 |
|         9 | Mishi Kobe Niku              |         2813.00 |
|        55 | Pâté chinois                 |         2760.00 |
|        18 | Carnarvon Tigers             |         2625.00 |
|        40 | Boston Crab Meat             |         2263.20 |
|        22 | Gustaf's Knäckebröd          |         2184.00 |
|        27 | Schoggi Schokolade           |         2151.10 |
|        36 | Inlagd Sill                  |         2128.00 |
+-----------+------------------------------+-----------------+
13 rows in set (0.00 sec)

*/

/*
5
*/
select ShipCountry,COUNT(*) as Orders from nwOrders
where ShipCountry <> 'USA' group by ShipCountry order by ShipCountry asc;

/*
6
*/
select nwOrders.CustomerID, CompanyName, COUNT(nwOrders.CustomerID)
as Orders from nwCustomers, nwOrders
where nwOrders.CustomerID = nwCustomers.CustomerID
group by nwCustomers.CustomerID
having Orders > 20
order by Orders desc;

/*
7
*/
select LastName, FirstName, Title, Extension, COUNT(nwOrders.EmployeeID)
as Orders from nwEmployees, nwOrders
where nwOrders.EmployeeID = nwEmployees.EmployeeID
group by nwEmployees.EmployeeID
having Orders > 100
order by LastName, FirstName asc;

/*
8
*/
select CompanyName, ProductName, UnitPrice
from nwSuppliers left join nwProducts on nwProducts.SupplierID = nwSuppliers.SupplierID
where nwSuppliers.Country like '%USA%'
order by UnitPrice desc;

/*
9
*/
select LastName, FirstName, Title, Extension, COUNT(nwOrders.EmployeeID)
as Orders from nwEmployees, nwOrders
where nwOrders.EmployeeID = nwEmployees.EmployeeID
group by nwEmployees.EmployeeID
having Orders > 100
order by LastName, FirstName asc;

/*
11
*/
select CompanyName, ContactName, CategoryName, Description,
ProductName, UnitsOnOrder from nwSuppliers, nwProducts, nwCategories
where UnitsInStock = 0
order by ProductName;

/*
12
*/

/*
13
*/
create table Top_Items (
	ItemID Int NOT NULL,
    ItemCode int NOT NULL,
    ItemName varchar(40) default NULL,
    InventoryDate datetime NULL,
    SupplierID int default NULL,
    ItemQuantity int default NULL,
    ItemPrice decimal (9,2) default '0.00',
    PRIMARY KEY(ItemID)
    )
    CHARACTER SET utf8 COLLATE utf8_general_ci;
    
/*
17
*/
update Top_Items set InventoryV


/*
15 
*/

delete Top_Items from Top_Items left join nwSuppliers on nwSuppliers.SupplierID = Top_Items.SupplierID 
where nwSuppliers.Country = 'Canada';

delete nwSuppliers, Top_Items from nwSuppliers right join Top_Items on nwSuppliers.SupplierID=Top_Items.SupplierID 
where nwSuppliers.Country like '%Canada%';
/*
14

Populate the new table “Top_Items” using these columns from the nwProducts table.
ProductID  ItemID
CategoryID  ItemCode
ProductName  ItemName
Today’s date  Inventory Date
UnitsInStock  ItemQuantity
UnitPrice  ItemPrice
SupplierID  SupplierID
for those products whose inventory value is greater than $2,500. (No answer set needed.)
(HINT: the inventory value of an Item is ItemPrice times ItemQuantity. )
*/

insert into Top_Items (ItemID, ItemCode, ItemName, InventoryDate, ItemQuantity, ItemPrice, SupplierID)
select ProductID, CategoryID, ProductName, date(now()), UnitsInStock, UnitPrice, SupplierID from nwProducts
where nwProducts.UnitsInStock * nwProducts.UnitPrice > 2500;

/*
Add a new column to the Top_Items table called InventoryValue ((decimal (9,2))) after the
inventory date. No answer set needed.
*/

alter table Top_Items 
add column InventoryValue decimal(9,2) NOT NULL AFTER InventoryDate;

/*
List the productname, suppliername, supplier country and UnitsInStock for all the
products that come in a bottle or bottles. (11 or 12 depending on your assumptions…)
*/

select nwProducts.ProductName, nwProducts.UnitsInStock ,nwSuppliers.CompanyName, nwSuppliers.Country
from nwSuppliers left join nwProducts on nwProducts.SupplierID = nwSuppliers.SupplierID
where nwProducts.QuantityPerUnit like '%bottles%';

/*
2 -- 17
Prepare a ReorderList for products currently in stock. (Products in stock have at least one unit in 
inventory). Show ProductID, Name, Quantity in Stock and Unit Price for products whose inventory
level is at or below the reorder level.
*/
select * from nwProducts
where ProductID in (
select ProductID from nwProducts
where UnitsInStock > 0);

select ProductID, ProductName, UnitsInStock, UnitPrice from nwProducts
where UnitsInStock > 0 and UnitsInStock < ReorderLevel;


/*
5 -- 9
This gives 10 but the answer should be 9

List the country and a count of Orders for all the orders that shipped outside the USA 
during September 2013 in ascending country sequence.
*/
select ShipCountry, COUNT(*) as Orders from nwOrders
where ShipCountry <> 'USA' and OrderDate BETWEEN '2013-09-01' and '2013-09-30' 
group by ShipCountry 
order by ShipCountry asc;