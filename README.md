# Project-house
This repository holds my data analysis work in R, python and SQL. These projects are built as a result of my learnings in the past days. It took number of hours,days and months to learn, practice and implement those skills as a project. I'm going to give a glimpse of my project in this repository. These projects are my early career works (ie.,Version_1 of my skills) and I'm going to built version_2 and 3 soon.

## PROJECT_1: El-Nino prediction Data Analysis in Python. 
The rainfall dataset was downloaded from [https://data.gov.in/](https://data.gov.in/), a Open Government Data (OGD) Platform of India under National Data Sharing and Accessibility Policy (NDSAP) and GDP dataset was downloaded from the world bank.

Tool used to analyze data:  <img width="78" height="78" src="https://img.icons8.com/fluency/48/jupyter.png" alt="jupyter"/>    Language used: <img width="48" height="48" src="https://img.icons8.com/color/48/python--v1.png" alt="python--v1"/>

- In this project, I analyzed the relationship between SW monsoon and GDP of India.
- I conducted data wrangling and manipulation using *Pandas* and *NumPy* libraries.
- I performed Exploratory Data Analysis (EDA) to understand rainfall-GDP fluctuations over time.
- *Matplotlib* and *Seaborn* have been used for data visualization.

There are few objectives i need to meet during this projects. As a result of it, I just wanna visualize samples.

### FINDINGS:

1) In July month, i observed that all the elnino years received average to below average rainfall(<283mm).
2) The months of july and august receives the most rain of monsoon. During the elnino years, monthly rainfall is average to below average. The interesting point to note is,the previous year of a elnino years is a year of average to above average receiving year which is a la-nino years.
3) notice that most of the red color plot is below the average line. These are the El-nino years which causes the world to crumble. It repeats itself every 2 to 7 years. As we see there is no clear pattern formation like every 2 year, every 5 year...
4) From the graph, it's clear that 1st 9 elnino years leads to decrease in the GDP of the country. The last 5 elnino years, after the year 2000, it looks like exceptional. This may be due to the India's fast forward growth.

<img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Rainfall_analysis/Images/output_36_1.png"/>   <img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Rainfall_analysis/Images/output_30_1.png"/>   <img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Rainfall_analysis/Images/output_54_0.png"/>   <img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Rainfall_analysis/Images/output_39_1.png"/>

## PROJECT_2:  Export Data Analysis using SQL Server. 
This project aims to analyze the export data of India for the year 2022 and 2023 and to forecast the export for upcoming years. The dataset of export is officially downloaded from the [https://data.gov.in/](https://data.gov.in/), a Open Government Data (OGD) Platform of India under National Data Sharing and Accessibility Policy (NDSAP). It consist of two different tables 'export22' and 'export23'

Tools used to analyse data: 
<img width="78" height="78" src="https://img.icons8.com/color/48/microsoft-sql-server.png" alt="microsoft-sql-server"/>
Language used: 
<img width="64" height="64" src="https://img.icons8.com/external-bearicons-blue-bearicons/64/external-SQL-file-extension-bearicons-blue-bearicons.png" alt="external-SQL-file-extension-bearicons-blue-bearicons"/>

- I analyzed export data of India for 2022 and 2023 using *Microsoft SQL Server*. 
- I performed basic data cleansing activities such as handling missing values, removing duplicates, standardizing data formats, merging data and handling other outliers. . 
- I met project objectives through comprehensive data analysis. 
- I created data visualizations and reports using *Tableau*.

### FINDINGS:

1) Almost 2/3rd of the countries remained positive in trade with India. But nearly 95 countries slipped to the negative trade. External Affairs ministry or Foreign trade ministry has to step into the issue with these countries and rectify them ASAP.
2)  By the way, we can export more to other countries from 10% to 25%. Trade deficit of India will remains positive. So, we can add extra foreign reserves to our treasury.
3) These are the countries with diversified portfolio with India. Includes UNITED ARAB EMTS, U S A, NEPAL, GERMANY, BHUTAN, SINGAPORE, TURKEY, U K, ITALY and CANADA.
UAE remains top importer of Indian goods.
4) Out of 265 countries, 98 countries were performing below_average_export with India.

<img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Export_analysis/Images/Countries%20with%20highest%20export%20value.png"/>   <img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Export_analysis/Images/Top_10_items_export.png"/>    <img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Export_analysis/Images/No%20of%20items%20per%20country.png"/>

## PROJECT_3: Bike-lending Analysis in R

This prooject is part of *Google Data Analytics Professional certificate*'s Capstone project module. The dataset contains millions of rows of data but I sliced the dataset for my opertional purpose. 

Tools used to analyze data: 
<img width="78" height="78" src="https://img.icons8.com/fluency/48/rstudio.png" alt="rstudio"/>
Languages used:
<img width="48" height="48" src="https://img.icons8.com/fluency/48/r-project.png" alt="r-project"/>

- I used *Tidyverse* package for data wrangling and manipulation. 
- I'm Proficient in data visualization using *ggplot()* for static plots and *leaflet()* for interactive maps. 
- I generated reports using *R Markdown*. 

### FINDINGS: 
1) Among 594 stations, these 7 stations are the mostly used docking stations and mostly used route. Nearly 25% of the entire customer using these stations. It's necessary to take much care on these stations because of the profitability.
2) There are nearly 160 stations that're least used(<25). I would recommend to increase the focus on these stations to make more profit.
3) most of the customers were membership holders. A very few are casual riders (~1/10).
4) We can see that there are 4 drops(<2000) in the graph. 1st drop on Jan 4th and 5th, 2nd drop on Jan 11th and 12th, 3rd drop on 18th and 19th and the 4th drop on 25th and 26th of january 2020. These dates that I mentioned are saturday and sunday's of the week where there was less riding takes place. Remaining 5 days of the week outperformed the weekends. So the customers, who mostly uses the bike might be the working professionals

<img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Bike_analysis/Images/map.jpeg"/>   <img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Bike_analysis/Images/new_mem_cas.png"/>   <img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Bike_analysis/Images/day_mem.png"/>   <img width="350" height="250" src="https://github.com/Ajithkumar-M16/Project_house/blob/main/Bike_analysis/Images/member%26count.png"/>
