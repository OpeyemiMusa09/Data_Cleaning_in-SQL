---- Data Cleaning----
;
select*
from layoffs
;
Create table stagging_layoffs
like layoffs;
select*
from stagging_layoffs;

Insert stagging_layoffs
select*
from layoffs;

select*,
row_number () over ( 
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date',
stage, country, funds_raised_millions
) AS row_num
from stagging_layoffs;

With duplicate_cte AS
(
select*,
row_number () over ( 
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date',
stage, country, funds_raised_millions
) AS row_num
from stagging_layoffs
)
select* 
From duplicate_cte
Where row_num > 1;

CREATE TABLE `stagging_layoffs2` (
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

Select*
from stagging_layoffs2
Where row_num >1;

insert into stagging_layoffs2
select*,
row_number () over ( 
partition by company, location, industry, total_laid_off, percentage_laid_off, 'date',
stage, country, funds_raised_millions
) AS row_num
from stagging_layoffs;

delete
from stagging_layoffs2
Where row_num >1;

Select*
from stagging_layoffs2;

Update stagging_layoffs2
Set company = trim(company);

Select industry
from stagging_layoffs2
where industry like 'crypto%';

update stagging_layoffs2
set industry = 'crypto'
where industry like 'crypto%';

select distinct country, trim(trailing '.' from country)
from stagging_layoffs2
order by 1;

update stagging_layoffs2
set country = trim(trailing '.' from country)
where country  like 'United States%';

Select `date`,
str_to_date(`date`,  '%m/%d/%Y')
from stagging_layoffs2;

update stagging_layoffs2
set `date` = str_to_date(`date`,  '%m/%d/%Y');

Alter table stagging_layoffs2
modify column `date` Date;

select*
from stagging_layoffs2
where total_laid_off is NULL
and percentage_laid_off is Null;

update stagging_layoffs2
set industry = NULL 
where industry = '';

Select*
from stagging_layoffs2
where Industry is NULL
or industry = '' ;

Select*
from stagging_layoffs2
where company ='airbnb';

Select*
from stagging_layoffs2 t1
Join stagging_layoffs2 t2
	ON t1.industry = t2.industry 
Where (t1.industry is NULL OR  t1.industry = '')
and t2.industry is NOT NULL

;
Update stagging_layoffs2 t1
join stagging_layoffs2 t2
	ON t1.company = t2.company 
Set t1.industry = t2.industry 
Where t1.industry is NULL 
and t2.industry is NOT NULL
;

select*
from stagging_layoffs2
where total_laid_off is NULL
and percentage_laid_off is Null;

delete
from stagging_layoffs2
where total_laid_off is NULL
and percentage_laid_off is Null;

select*
from stagging_layoffs2;

alter table stagging_layoffs2
drop column row_num;

