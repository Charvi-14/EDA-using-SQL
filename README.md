Dataset: Layoffs [2362 rows x 9 cols]

The dataset provides detailed information about various companies that have recently undergone layoffs. 
Columns Description:
-Company:The name of the company that experienced layoffs.
-Location:The primary city where the company is based.
-Industry:The sector in which the company operates (e.g., Media, Retail, Technology).
-Total_Laid_Off:The number of employees laid off during the reported event. Some entries are missing this data (represented as NULL).
-Percentage_Laid_Off:The proportion of the workforce that was laid off, expressed as a decimal. For example, 0.05 indicates 5% of the employees were laid off. This data is not available for all companies (represented as NULL).
-Date:The date when the layoff event occurred, formatted as MM/DD/YYYY.
-Stage:The company's financial or developmental stage, such as Post-IPO, Series A, Series B, etc. This indicates whether the company is publicly traded, at a specific round of private funding, or if it has been acquired by another company.
-Country:The country where the company's main office is located.
-Funds_Raised_Millions:The total amount of funds the company has raised, in millions of dollars. This includes venture capital funding or other investment rounds. Some entries have missing data (represented as NULL).

The dataset highlights the amount of funding companies have raised, showcasing that even well-funded companies are not immune to layoffs.
Step 1 : Data Cleaning
-- 1. Remove duplicates (if any)
-- 2. Standardize data
-- 3. Null values/ Blanks 
-- 4. Remove any Columns

Step 2 : EDA
-- 1. Find max layoffs by industry, country, post 
-- 2. Rolling sum- progression of layoffs based off of month
-- 3. Rolling sum- progression of month on month progression for years
-- 4. Company layoffs per year
-- 5: Rank which year they let go of max (year-wise layoffs) get top 5

*Created a copy of data to make chnages*

