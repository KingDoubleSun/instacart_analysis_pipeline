# Instacart Products Analysis Pipeline
Analysis of products performance for Instacart. The data warehouse is used in Amazon Redshift with granularity of each sell record of a single product. And a simple sample dashboard created by Tableau with Redshift as the data source, it is published in Tableau public.

Source Data link: https://www.kaggle.com/c/instacart-market-basket-analysis/rules

Public Sample Dashboard link: https://public.tableau.com/app/profile/shawn2408/viz/Instacartanalysis_16392026230670/InstacartAnalysis?publish=yes

## Architecture
![alt text](https://github.com/KingDoubleSun/instacart_analysis_pipeline/blob/main/images/architechture.png)
1. Data is sourced from Kaggle and uploaded into S3 bucket. 
2. Then python script with Redshift connector moves files from S3 to Redshift raw_data schema.
3. SQL scripts are ran to transform data from raw_data schema to prod (production) schema.
4. Since the node number limitation and the huge amount of records, Tableau uses some SQL queries to fetch aggregated results and visulize them. Otherwise, Tableau could run on top of all data and do aggregate analysis.


## Data Model
![alt text](https://github.com/KingDoubleSun/instacart_analysis_pipeline/blob/main/images/insta_analysis.png)

The Star shema is used as data model.
