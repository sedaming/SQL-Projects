--**********************************************************************
---************************ Data Cleaning Project************************
---**********************************************************************



-- 1. standardize data format
-- DATE

select saledate, convert (date, saledate) as convertedDate from NashvilleHousingData

-- two ways to update the column values:
--1. using UPDATE (it directly updates the data)
--Update NashvilleHousingData
--set saledate = convert (date, saledate)
-- 2. Using ALTER TABLE (2.1 add a column 2.2 copy the new data into it)
--alter table NashvilleHousingData
--add convertedDate date;
--Update NashvilleHousingData
--set convertedDate = convert (date, saledate)
-- 1. Because the data format was already ok, when we enter them into the table, this section is not really necessary.
-- 2. The first step of data cleaning starts in data entry process.

alter table nashvillehousingdata
drop column convertedDate

-- Binary data
select SoldAsVacant, count(SoldAsVacant) from NashvilleHousingData
group by SoldAsVacant
order by 2 desc

-- creating the column first
alter table nashvillehousingdata
add standardizedSoldVacant varchar (20)
-- now insert data into it:
update nashvillehousingdata
set standardizedSoldVacant = 
-- case is like if clause in SQL
case
    when SoldAsVacant = 'N' then 'No'
    when SoldAsVacant = 'Y' then 'Yes'
    else SoldAsVacant
end 

-- another less attractive solution is with replace:
alter table nashvillehousingdata
add standardizedSoldVacant2 varchar (20)
UPDATE nashvillehousingdata
SET standardizedSoldVacant2 = 
    REPLACE(
        REPLACE(SoldAsVacant, 'N', 'No'),
    'Y', 'Yes');

select * from NashvilleHousingData
--*****************************************************************************************************
--2. Fixing null values
-- Technique1: fixing nulls by using a value from table and use it for a null in the same table
-- variable type: text (string)
-- situation: 
        -- here we have parcelid which is connected to addresses
        -- parcelid is unique for each address
        -- parcelid is no null
        -- we have the same parcelid for two same address including the null one and the one is not null (same addresses)
-- solution:
        -- we join the table with itself on parcelid (and not the same uniqueid)
        -- we copy the address from value and paste it into null address

-- PROPERTY ADDRESS
-- see the nulls:
SELECT a.uniqueid, a.parcelid,  a.PropertyAddress, b.ParcelID, b.PropertyAddress, b.UniqueID
FROM NashvilleHousingData a
JOIN NashvilleHousingData b
    ON a.ParcelID = b.ParcelID
   AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL
  AND b.PropertyAddress IS NOT NULL;
  -- after one time using this code, the nulls are gone.
  -- fix the nulls:

update a
set propertyaddress = isnull (a.propertyaddress, b.propertyaddress)
FROM NashvilleHousingData a
JOIN NashvilleHousingData b
    ON a.ParcelID = b.ParcelID
   AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL
  AND b.PropertyAddress IS NOT NULL;

  --*****************************************************************************************************
  --3. Separate values (more than one for each cell)
  -- PropertyAddress
  select * from NashvilleHousingData

  select propertyaddress, substring (propertyaddress, 1, charindex (',', propertyaddress) -1) as Address,
  substring (propertyaddress, charindex (',', propertyaddress)+1, len(PropertyAddress)) as City
  from NashvilleHousingData

  alter table NashvilleHousingData
  add PropertyJustAddress varchar (255)

  update NashvilleHousingData
  set propertyJustAddress = substring (propertyaddress, 1, charindex (',', propertyaddress) -1)

  alter table NashvilleHousingData
  add PropertyCity varchar (255)

  update NashvilleHousingData
  set PropertyCity = substring (propertyaddress, charindex (',', propertyaddress)+1, len(PropertyAddress))

  select Propertycity, propertyjustaddress from NashvilleHousingData

  -- OwnerAddress 
  -- This time we do it with an easier command
  -- This command only works if text is separated by '.'
  select owneraddress,
  parsename (replace(owneraddress,',','.'), 3) as ownerJustAddress,
  parsename (replace(owneraddress,',','.'), 2) as ownerCity,
  parsename (replace(owneraddress,',','.'), 1) as ownerState
  
    from NashvilleHousingData


  alter table NashvilleHousingData
  add HomeOwnerPropertyJustAddress varchar (255)

  update NashvilleHousingData
  set HomeOwnerPropertyJustAddress = parsename (replace(owneraddress,',','.'), 3)

  alter table NashvilleHousingData
  add HomeOwnerPropertyCity varchar (255)

  update NashvilleHousingData
  set HomeOwnerPropertyCity =  parsename (replace(owneraddress,',','.'), 2)


   alter table NashvilleHousingData
  add HomeOwnerPropertyState varchar (255)

    update NashvilleHousingData
  set HomeOwnerPropertyState =  parsename (replace(owneraddress,',','.'), 1)

  select owneraddress, HomeOwnerPropertyJustAddress, HomeOwnerPropertyCity, HomeOwnerPropertyState
  from NashvilleHousingData


--*****************************************************************************************************************
-- 4- remove duplicates
-- idea: we create row numbers 
-- then we partition based on changes in those rows.
-- if row_num is over 1 means we have duplicates
-- to see row_num over 1, we need to create CTE

-- identify duplicates
with Duptable  as ( 
select *, ROW_NUMBER () over (partition by parcelID, propertyAddress, saledate, saleprice, legalreference
order by UniqueID)  
row_num
from NashvilleHousingData
)
select * from duptable
where row_num > 1
order by propertyAddress

-- deleting duplicates
with Duptable  as ( 
select *, ROW_NUMBER () over (partition by parcelID, propertyAddress, saledate, saleprice, legalreference
order by UniqueID)  
row_num
from NashvilleHousingData
)

delete
from duptable
where row_num > 1

--**************************************************************************
--5  Delete unwanted columns

select * from NashvilleHousingData

alter table NashvilleHousingData
drop column standardizedsoldvacant2

alter table NashvilleHousingData
drop column taxdistict


-- FINISH
-- DONE BY AMIN AMIRKHALILI
-- LINKEDIN: https://www.linkedin.com/in/sedamin/


SELECT SaleDate,
       TRY_CONVERT(date, SaleDate) AS CleanSaleDate
FROM NashvilleHousingData;
