# Digital Marketing Platform Campaign Analysis using SQL
## Introduction:
<p>In this digital marketing campaign analysis, I have analyzed data from various campaigns across platforms such as Google Ads and Facebook Ads. The data used in this analysis belongs to an advertising platform and provides insights into the performance of these campaigns.The goal is to derive actionable insights from customer engagement data, including metrics like impressions, clicks, conversions, and ad spend.By leveraging SQL queries, we’ll evaluate campaign effectiveness, customer behavior, and platform performance, helping to optimize marketing strategies. The analysis will focus on key KPIs like cost-per-click (CPC), return on investment (ROI), and customer lifetime value.</p>

<img align="centre" alt="coding" width="1100" src="https://img.freepik.com/premium-vector/digital-marketing-hand-holding-megaphone-coming-out-from-computer-business-analysis-content-strategy-management-advertising-social-media-campaign-communication-seo_458444-1333.jpg?w=1380">

## Entity Relationship Diagram:

<img align="centre" alt="coding" width="800" src="https://github.com/CharishmaKondamuri/Digital-Marketing-Campaign-Analysis/blob/main/ERD.png"> 

## Datasets:
#### 1. Campaigns Table
<p>This table will store information about the marketing campaigns, such as the name, budget, and duration.</p>

| campaignid | campaignname          | startdate   | enddate     | budget | status     |
|------------|-----------------------|-------------|-------------|--------|------------|
| 1          | Summer Sale 2024       | 2024-06-01  | 2024-07-31  | 5000   | Active     |
| 2          | Winter Campaign 2023   | 2023-12-01  | 2024-01-31  | 3000   | Completed  |
| 3          | Black Friday 2023      | 2023-11-20  | 2023-11-30  | 10000  | Completed  |
| 4          | Spring Sale 2024       | 2024-04-01  | 2024-04-30  | 4000   | Planned    |
| 5          | New Year 2024          | 2024-01-01  | 2024-01-15  | 2000   | Planned    |
| 6          | Halloween 2023         | 2023-10-01  | 2023-10-31  | 3500   | Completed  |
| 7          | Cyber Monday 2023      | 2023-11-27  | 2023-11-30  | 8000   | Completed  |
| 8          | Christmas Special 2023 | 2023-12-15  | 2023-12-31  | 12000  | Active     |
| 9          | Easter 2024            | 2024-03-15  | 2024-03-31  | 3000   | Planned    |
| 10         | Valentine's Day 2024   | 2024-02-01  | 2024-02-14  | 2500   | Planned    |

#### 2. Platforms Table
<p>This table will hold information about the platforms used in the campaigns (e.g., Google Ads, Facebook Ads).</p>

| platformid | platformname  | costperclick | costperimpression |
|------------|---------------|--------------|-------------------|
| 1          | Google Ads     | 1.5          | 0.05              |
| 2          | Facebook Ads   | 1.2          | 0.03              |
| 3          | LinkedIn Ads   | 2            | 0.1               |
| 4          | Instagram Ads  | 1.4          | 0.04              |
| 5          | Twitter Ads    | 1.1          | 0.02              |
| 6          | TikTok Ads     | 1.25         | 0.06              |
| 7          | YouTube Ads    | 1.8          | 0.08              |
| 8          | Snapchat Ads   | 1.15         | 0.03              |
| 9          | Pinterest Ads  | 1            | 0.02              |
| 10         | Reddit Ads     | 1.05         | 0.02              |

#### 3. Customers Table
<p>This table will track customer information who interact with the campaigns.</p>

| customerid | firstname | lastname | email                    | dateregistered |
|------------|-----------|----------|--------------------------|----------------|
| 1          | John      | Doe      | john.doe@example.com      | 2023-01-15     |
| 2          | Jane      | Smith    | jane.smith@example.com    | 2023-05-20     |
| 3          | Mark      | Johnson  | mark.johnson@example.com  | 2023-07-11     |
| 4          | Emily     | Davis    | emily.davis@example.com   | 2023-02-22     |
| 5          | Michael   | Brown    | michael.brown@example.com | 2023-03-05     |
| 6          | Emma      | Jones    | emma.jones@example.com    | 2023-06-30     |
| 7          | Oliver    | Wilson   | oliver.wilson@example.com | 2023-04-10     |
| 8          | Sophia    | Taylor   | sophia.taylor@example.com | 2023-08-15     |
| 9          | Lucas     | Moore    | lucas.moore@example.com   | 2023-09-07     |
| 10         | Mia       | Anderson | mia.anderson@example.com  | 2023-10-01     |

#### 4. Performance Table
<p>This table will track the performance of each campaign by storing metrics like clicks, impressions, and spend.</p>

| performanceid | campaignid | platformid | customerid | impressions | clicks | conversions | spend | daterecorded |
|---------------|------------|------------|------------|-------------|--------|-------------|-------|--------------|
| 1             | 1          | 1          | 1          | 10000       | 150    | 20          | 500   | 2024-06-15   |
| 2             | 2          | 2          | 2          | 12000       | 180    | 30          | 750   | 2023-12-20   |
| 3             | 3          | 3          | 3          | 15000       | 200    | 40          | 1000  | 2023-11-25   |
| 4             | 4          | 4          | 4          | 5000        | 80     | 10          | 300   | 2024-04-10   |
| 5             | 5          | 5          | 5          | 8000        | 110    | 25          | 600   | 2024-01-05   |
| 6             | 6          | 6          | 6          | 11000       | 170    | 35          | 850   | 2023-10-25   |
| 7             | 7          | 7          | 7          | 14000       | 210    | 50          | 1200  | 2023-11-28   |
| 8             | 8          | 8          | 8          | 13000       | 190    | 45          | 1050  | 2023-12-22   |
| 9             | 9          | 9          | 9          | 6000        | 90     | 15          | 400   | 2024-03-20   |
| 10            | 10         | 10         | 10         | 7000        | 100    | 20          | 450   | 2024-02-10   |

## Case Study Questions:
#### 1.Which campaign has the highest spend?
#### Query:

```sql
SELECT c.CampaignName, SUM(p.Spend) AS TotalSpend
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
GROUP BY c.CampaignName
ORDER BY TotalSpend DESC
LIMIT 1;
```
#### Output:
| campaignname       | totalspend |
|--------------------|------------|
| Cyber Monday 2023   | 1200       |

#### 2. What is the total number of impressions, clicks, and conversions for each platform?
#### Query:

```sql
SELECT pl.PlatformName, 
       SUM(p.Impressions) AS TotalImpressions, 
       SUM(p.Clicks) AS TotalClicks, 
       SUM(p.Conversions) AS TotalConversions
FROM Performance p
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
GROUP BY pl.PlatformName;
```
#### Output:
| platformname  | totalimpressions | totalclicks | totalconversions |
|---------------|------------------|-------------|------------------|
| TikTok Ads    | 11000            | 170         | 35               |
| Google Ads    | 10000            | 150         | 20               |
| Reddit Ads    | 7000             | 100         | 20               |
| Twitter Ads   | 8000             | 110         | 25               |
| Instagram Ads | 5000             | 80          | 10               |
| YouTube Ads   | 14000            | 210         | 50               |
| LinkedIn Ads  | 15000            | 200         | 40               |
| Pinterest Ads | 6000             | 90          | 15               |
| Facebook Ads  | 12000            | 180         | 30               |
| Snapchat Ads  | 13000            | 190         | 45               |

#### 3. Which customer has the highest number of conversions across all campaigns?
#### Query:

```sql
SELECT cu.FirstName, cu.LastName, SUM(p.Conversions) AS TotalConversions
FROM Performance p
JOIN Customers cu ON p.CustomerID = cu.CustomerID
GROUP BY cu.FirstName, cu.LastName
ORDER BY TotalConversions DESC
LIMIT 1;
```
#### Output:
| firstname | lastname | totalconversions |
|-----------|----------|------------------|
| Oliver    | Wilson   | 50               |

#### 4. What is the average cost per click (CPC) for each campaign?
#### Query:

```sql
SELECT c.CampaignName, ROUND(AVG(pl.CostPerClick), 2) AS AvgCPC
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
GROUP BY c.CampaignName;
```
#### Output:
| campaignname          | avgcpc |
|-----------------------|--------|
| New Year 2024         | 1.1    |
| Black Friday 2023     | 2      |
| Cyber Monday 2023     | 1.8    |
| Spring Sale 2024      | 1.4    |
| Halloween 2023        | 1.25   |
| Christmas Special 2023| 1.15   |
| Winter Campaign 2023  | 1.2    |
| Valentine's Day 2024  | 1.05   |
| Easter 2024           | 1      |
| Summer Sale 2024      | 1.5    |

#### 5. Which platform generated the most clicks for a given campaign (e.g., 'Summer Sale 2024')?
#### Query:

```sql
SELECT pl.PlatformName, SUM(p.Clicks) AS TotalClicks
FROM Performance p
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
JOIN Campaigns c ON p.CampaignID = c.CampaignID
WHERE c.CampaignName = 'Summer Sale 2024'
GROUP BY pl.PlatformName
ORDER BY TotalClicks DESC;
```
#### Output:
| platformname | totalclicks |
|--------------|-------------|
| Google Ads   | 150         |

#### 6. How much has been spent per platform across all campaigns?
#### Query:</h4>

```sql
SELECT pl.PlatformName, SUM(p.Spend) AS TotalSpend
FROM Performance p
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
GROUP BY pl.PlatformName
ORDER BY TotalSpend DESC;
```
#### Output:
| platformname  | totalspend |
|---------------|------------|
| YouTube Ads   | 1200       |
| Snapchat Ads  | 1050       |
| LinkedIn Ads  | 1000       |
| TikTok Ads    | 850        |
| Facebook Ads  | 750        |
| Twitter Ads   | 600        |
| Google Ads    | 500        |
| Reddit Ads    | 450        |
| Pinterest Ads | 400        |
| Instagram Ads | 300        |

#### 7. What is the conversion rate (Conversions/Clicks) for each campaign?
#### Query:

```sql
SELECT c.CampaignName, 
       ROUND(SUM(p.Conversions) * 1.0 / SUM(p.Clicks), 2) AS ConversionRate
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
GROUP BY c.CampaignName;
```
#### Output:
| campaignname          | conversionrate |
|-----------------------|----------------|
| New Year 2024         | 0.23           |
| Black Friday 2023     | 0.2            |
| Cyber Monday 2023     | 0.24           |
| Spring Sale 2024      | 0.13           |
| Halloween 2023        | 0.21           |
| Christmas Special 2023| 0.24           |
| Winter Campaign 2023  | 0.17           |
| Valentine's Day 2024  | 0.2            |
| Easter 2024           | 0.17           |
| Summer Sale 2024      | 0.13           |

#### 8. Which customers engaged with the most campaigns?
#### Query:

```sql
SELECT cu.FirstName, cu.LastName, COUNT(DISTINCT p.CampaignID) AS CampaignCount
FROM Performance p
JOIN Customers cu ON p.CustomerID = cu.CustomerID
GROUP BY cu.FirstName, cu.LastName
ORDER BY CampaignCount DESC;
```
#### Output:
| firstname | lastname | campaigncount |
|-----------|----------|---------------|
| Emily     | Davis    | 1             |
| Emma      | Jones    | 1             |
| Jane      | Smith    | 1             |
| John      | Doe      | 1             |
| Lucas     | Moore    | 1             |
| Mark      | Johnson  | 1             |
| Mia       | Anderson | 1             |
| Michael   | Brown    | 1             |
| Oliver    | Wilson   | 1             |
| Sophia    | Taylor   | 1             |

#### 9. Which platform has the lowest cost per impression (CPI) across all campaigns?
#### Query:

```sql
SELECT pl.PlatformName, 
       ROUND(AVG(pl.CostPerImpression), 2) AS AvgCPI
FROM Platforms pl
JOIN Performance p ON p.PlatformID = pl.PlatformID
GROUP BY pl.PlatformName
ORDER BY AvgCPI ASC
LIMIT 1;
```
#### Output:
| platformname | avgcpi |
|--------------|--------|
| Reddit Ads   | 0.02   |

#### 10. Which campaign is currently active and has the highest total impressions?
#### Query:

```sql
SELECT c.CampaignName, SUM(p.Impressions) AS TotalImpressions
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
WHERE c.Status = 'Active'
GROUP BY c.CampaignName
ORDER BY TotalImpressions DESC
LIMIT 1;
```
#### Output:
| campaignname          | totalimpressions |
|-----------------------|------------------|
| Christmas Special 2023| 13000            |

#### Insights and Recommendations:

1.	<b>Optimize Budget Allocation:</b> Reallocate more budget to platforms that convert better, such as Facebook Ads.
2.	<b>Leverage High Conversion Campaign Types:</b> Time-limited offers like Black Friday and Cyber Monday campaigns have high conversion rates, so these types of campaigns should be repeated and enhanced.
3.	<b>Increase Engagement on Cost-Effective Platforms:</b> Pinterest Ads can be used for brand awareness at a low cost per impression.
4.	<b>Target Loyal Customers:</b> Customers like Emma Jones, who engage with multiple campaigns, could be included in loyalty or rewards programs to further increase conversions.









