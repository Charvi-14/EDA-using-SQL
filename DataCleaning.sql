-- Data Cleaning
select * 
from layoffs;

-- 1. Remove duplicates (if any)
-- 2. Standardize data
-- 3. Null values/ Blanks 
-- 4. Remove any Columns

-- Creating a copy of data to make chnages
Create table layoffs_staging
like layoffs;

insert layoffs_staging
select * from layoffs;

select * from layoffs_staging;

-- 1. Remove Duplicates

-- A. Idneitfy rows
WITH duplicate_cte as(
	select * ,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,
funds_raised_millions) as row_num
from layoffs_staging)
select * 
from duplicate_cte 
where row_num>1;
#cant update a cte
-- B. Delete Rows

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;

insert into layoffs_staging2
select * ,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,
funds_raised_millions) as row_num
from layoffs_staging;

select * 
from layoffs_staging2
where row_num>1;

SET SQL_SAFE_UPDATES = 0;
delete 
from layoffs_staging2
where row_num>1;

select *
from layoffs_staging2;


-- 2. Standardizing Data
select distinct(trim(company))
from layoffs_staging2;

update layoffs_staging2
set company=trim(company);

-- Industry
select distinct(industry)
from layoffs_staging2
order by 1;
-- crypto, crypto currency= same 
select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry='Crypto'
where industry like 'Crypto%';


select distinct(location) from layoffs_staging2 order by 1;
select distinct(country) from layoffs_staging2 order by 1;
-- United states and United States.

select *
from layoffs_staging2
where country like 'United States%'
order by 1;

select distinct country , trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

-- update col datatypes
select `date`
from layoffs_staging2;
-- converting text to diff format not date
update layoffs_staging2
set `date`= str_to_date(`date`,'%m/%d/%Y');

-- altering datatype
alter table layoffs_staging2
modify column `date` DATE;

select * from layoffs_staging2;



-- 3. NULL and Blanks 

select * 
from layoffs_staging2
where total_laid_off is NULL 
and percentage_laid_off is NULL;

update layoffs_staging2
set industry=NULL
where industry='';
select *
from layoffs_staging2
where industry is NULL 
or industry='';

select * 
from layoffs_staging
where company= 'Airbnb';
-- Trying to populate
-- join
-- check 
select t1.industry,t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
    and t1.location=t2.location
where (t1.industry is Null or t1.industry='') and  t2.industry is not null;

-- update
update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is Null  and  t2.industry is not null;

-- check 
select * 
from layoffs_staging
where company= 'Airbnb';

-- for others
select *
from layoffs_staging2
where industry is NULL 
or industry='';

select * 
from layoffs_staging
where company like 'Bally%';
#Ballys has no other populated row 

select * from layoffs_staging2;

-- 4. Removing Cols and Rows ..if any
select *
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

delete
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

-- drop row_num
alter table layoffs_staging2
drop column row_num;

-- final cleaned data

select * from layoffs_staging2;