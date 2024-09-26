# Digital Marketing Campaign Case Study – PostgreSQL
<h2>Introduction:</h2>
<p></p>In this digital marketing case study, we will analysis is performed from various marketing campaigns across multiple platforms like Google Ads and Facebook Ads. The goal is to derive actionable insights from customer engagement data, including metrics like impressions, clicks, conversions, and ad spend. 
By leveraging SQL queries, we’ll evaluate campaign effectiveness, customer behavior, and platform performance, helping to optimize marketing strategies. The analysis will focus on key KPIs like cost-per-click (CPC), return on investment (ROI), and customer lifetime value.</p>

<img align="centre" alt="coding" width="1100" src="https://img.freepik.com/premium-vector/digital-marketing-hand-holding-megaphone-coming-out-from-computer-business-analysis-content-strategy-management-advertising-social-media-campaign-communication-seo_458444-1333.jpg?w=1380">

## Entity Relationship Diagram:

![image](https://github.com/user-attachments/assets/bf68677e-c3fb-4e54-9c79-bfa55e34bf4e)

## Datasets:
<h4>1. Campaigns Table</h4>
<p>This table will store information about the marketing campaigns, such as the name, budget, and duration.</p>

![image](https://github.com/user-attachments/assets/4b06d547-fa20-4451-864a-f85d5a75ddeb)

<h4>2. Platforms Table</h4>
<p>This table will hold information about the platforms used in the campaigns (e.g., Google Ads, Facebook Ads).</p>

![image](https://github.com/user-attachments/assets/bc648f81-5fd1-4e7c-8042-f92f62497a42)

<h4>3. Customers Table</h4>
<p>This table will track customer information who interact with the campaigns.</p>

![image](https://github.com/user-attachments/assets/22fea999-6393-4022-aaaa-0fcca143463e)

<h4>4. Performance Table</h4>
<p>This table will track the performance of each campaign by storing metrics like clicks, impressions, and spend.</p>

![image](https://github.com/user-attachments/assets/8ea50070-3701-4725-ab2c-c3d8096e4d62)

## Case Study Questions:
<h4>1.Which campaign has the highest spend?</h4>
<h4>Query:</h4>

```sql
SELECT c.CampaignName, SUM(p.Spend) AS TotalSpend
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
GROUP BY c.CampaignName
ORDER BY TotalSpend DESC
LIMIT 1;
```
#### Output:

![image](https://github.com/user-attachments/assets/68975601-d31c-44dc-bc9c-4cb48cbf46c7)

<h4>2. What is the total number of impressions, clicks, and conversions for each platform?</h4>
<h4>Query:</h4>

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

![image](https://github.com/user-attachments/assets/0f824b36-1bcf-4b88-9e28-c0d911725e06)

<h4>3. Which customer has the highest number of conversions across all campaigns?</h4>
<h4>Query:</h4>

```sql
SELECT cu.FirstName, cu.LastName, SUM(p.Conversions) AS TotalConversions
FROM Performance p
JOIN Customers cu ON p.CustomerID = cu.CustomerID
GROUP BY cu.FirstName, cu.LastName
ORDER BY TotalConversions DESC
LIMIT 1;
```
#### Output:
![image](https://github.com/user-attachments/assets/98fed4fd-6b23-4e55-9a52-1f73c1401428)


<h4>4. What is the average cost per click (CPC) for each campaign?</h4>
<h4>Query:</h4>

```sql
SELECT c.CampaignName, AVG(pl.CostPerClick) AS AvgCPC
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
GROUP BY c.CampaignName;
```
#### Output:
![image](https://github.com/user-attachments/assets/02c727e7-0bf4-4368-83ce-5a377747f263)


<h4>5. Which platform generated the most clicks for a given campaign (e.g., 'Summer Sale 2024')?</h4>
<h4>Query:</h4>

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
![image](https://github.com/user-attachments/assets/a7e0b265-bbaf-4c3d-80fa-c881ef1411ee)


<h4>6. How much has been spent per platform across all campaigns?</h4>
<h4>Query:</h4>

```sql
SELECT pl.PlatformName, SUM(p.Spend) AS TotalSpend
FROM Performance p
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
GROUP BY pl.PlatformName
ORDER BY TotalSpend DESC;
```
#### Output:

![image](https://github.com/user-attachments/assets/06bcb93c-ad18-455f-882e-a2be4a470b2f)


<h4>7. What is the conversion rate (Conversions/Clicks) for each campaign?</h4>
<h4>Query:</h4>

```sql
SELECT c.CampaignName, 
       SUM(p.Conversions) * 1.0 / SUM(p.Clicks) AS ConversionRate
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
GROUP BY c.CampaignName;
```
#### Output:
![image](https://github.com/user-attachments/assets/42c3cae0-af58-4380-8518-842e203259f1)


<h4>8. Which customers engaged with the most campaigns?</h4>
<h4>Query:</h4>

```sql
SELECT cu.FirstName, cu.LastName, COUNT(DISTINCT p.CampaignID) AS CampaignCount
FROM Performance p
JOIN Customers cu ON p.CustomerID = cu.CustomerID
GROUP BY cu.FirstName, cu.LastName
ORDER BY CampaignCount DESC;
```
#### Output:

![image](https://github.com/user-attachments/assets/0f371121-e1b9-4a16-afb8-9341d75dce88)

<h4>9. Which platform has the lowest cost per impression (CPI) across all campaigns?</h4>
<h4>Query:</h4>

```sql
SELECT pl.PlatformName, AVG(pl.CostPerImpression) AS AvgCPI
FROM Platforms pl
JOIN Performance p ON p.PlatformID = pl.PlatformID
GROUP BY pl.PlatformName
ORDER BY AvgCPI ASC
LIMIT 1;
```
#### Output:

![image](https://github.com/user-attachments/assets/779d62d7-4e52-4488-987f-ed98ef887e5d)

<h4>10. Which campaign is currently active and has the highest total impressions?</h4>
<h4>Query:</h4>

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

![image](https://github.com/user-attachments/assets/f3fb52a0-90a0-4801-9600-cba4e6505eaa)

<h4>Insights and Recommendations:</h4>


1.	Optimize Budget Allocation: Reallocate more budget to platforms that convert better, such as Facebook Ads.
2.	Leverage High Conversion Campaign Types: Time-limited offers like Black Friday and Cyber Monday campaigns have high conversion rates, so these types of campaigns should be repeated and enhanced.
3.	Increase Engagement on Cost-Effective Platforms: Pinterest Ads can be used for brand awareness at a low cost per impression.
4.	Target Loyal Customers: Customers like Emma Jones, who engage with multiple campaigns, could be included in loyalty or rewards programs to further increase conversions.









