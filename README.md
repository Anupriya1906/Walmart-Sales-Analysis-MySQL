
# Walmart Sales Data Analysis Project

## Overview:
This project dives into Walmart's sales data, aiming to grasp how different branches and products perform, understand sales trends, and analyze customer behaviour. The goal is to find ways to enhance and optimize sales strategies. The dataset used comes from the Kaggle Walmart Sales Forecasting Competition.

## Project Objectives:
The main purpose is to extract insights from Walmart's sales data, shedding light on the factors influencing sales across different branches.

## Data Source:
The dataset used in this project is sourced from the Kaggle Walmart Sales Forecasting Competition. It encompasses sales transactions from three distinct Walmart branches situated in Mandalay, Yangon, and Naypyitaw. In total, the dataset comprises 17 columns and 1000 rows.

| Column | Description | Data Type |
| invoice_id | Invoice of the sales made | VARCHAR (30) |
branch|Branch at which sales were made|VARCHAR (5)
city|The location of the branch|VARCHAR (30)
customer_type|The type of the customer|VARCHAR (30)
gender|Gender of the customer making purchase|VARCHAR (10)
product_line	Product line of the product sold	VARCHAR (100)
unit_price|The price of each product|DECIMAL (10, 2)
quantity|The amount of the product sold|INT
VAT|The amount of tax on the purchase|FLOAT (6, 4)
total|The total cost of the purchase|DECIMAL (12, 4)
date|The date on which the purchase was made|DATETIME
time|The time at which the purchase was made|TIME
payment_method|The total amount paid|VARCHAR (15)
cogs|Cost Of Goods sold|DECIMAL (10, 2)
gross_margin_pct|Gross margin percentage|FLOAT (11, 9)
gross_income|Gross Income|DECIMAL (12, 4)
rating|Rating|FLOAT (2, 1)


##Analysis Overview:

###Product Analysis:
Examine the data to comprehend various product lines, identify top-performing product lines, and pinpoint areas for improvement within product lines.

###Sales Analysis:
This analysis focuses on understanding the trends in product sales. The outcomes assist in gauging the effectiveness of applied sales strategies and determining necessary modifications to boost sales.

###Customer Analysis:
Uncover diverse customer segments, analyze purchase trends, and assess the profitability of each customer segment through this analysis.

##Methodology Employed:

###Data Wrangling:
Initial data inspection to detect and handle NULL or missing values.
Database creation, table building, and data insertion.
Implementation of NOT NULL constraints during table creation to eliminate null values.

###Feature Engineering:
Introduction of new columns derived from existing data.
Inclusion of a "time_of_day" column providing insights into sales during Morning, Afternoon, and Evening, addressing the peak sales time question.
Addition of a "day_name" column indicating the day of the week for each transaction (Mon, Tue, Wed, Thurs, Fri) to understand branch activity throughout the week.
Incorporation of a "month_name" column reflecting the month of each transaction (Jan, Feb, Mar) to identify the highest sales and profit months.

###Exploratory Data Analysis (EDA):
Conducted to address the project's objectives and questions, utilizing the generated features and structured data.

##Key Business Queries:

###Generic Question
1.	How many unique cities does the data have?
2.	In which city is each branch?

###Product
1.	How many unique product lines does the data have?
2.	What is the most common payment method?
3.	What is the most selling product line?
4.	What is the total revenue by month?
5.	What month had the largest COGS?
6.	What product line had the largest revenue?
7.	What is the city with the largest revenue?
8.	What product line had the largest VAT?
9.	Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
10.	Which branch sold more products than average product sold?
11.	What is the most common product line by gender?
12.	What is the average rating of each product line?

###Sales
1.	Number of sales made in each time of the day per weekday
2.	Which of the customer types brings the most revenue?
3.	Which city has the largest tax percent/ VAT (Value Added Tax)?
4.	Which customer type pays the most in VAT?

###Customer
1.	How many unique customer types does the data have?
2.	How many unique payment methods does the data have?
3.	What is the most common customer type?
4.	What is the gender of most of the customers?
5.	What is the gender distribution per branch?
6.	Which time of the day do customers give most ratings?
7.	Which time of the day do customers give most ratings per branch?
8.	Which day of the week has the best average ratings?
9.	Which day of the week has the best average ratings per branch?
