/*
11 -- 5
Create an OUT OF STOCK LIST showing the Supplier... 
for all products that are out of stock
*/
select nwSuppliers.CompanyName, ContactName, CategoryName, Description as 'Category Description',
ProductName, UnitsOnOrder from nwSuppliers, nwProducts, nwCategories
where UnitsInStock = 0 and nwSuppliers.SupplierID = nwProducts.SupplierID and nwProducts.CategoryID = nwCategories.CategoryID
order by ProductName;