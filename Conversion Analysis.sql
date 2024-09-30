CREATE DATABASE Digital_Marketing;

CREATE TABLE Campaigns (
    CampaignID SERIAL PRIMARY KEY,
    CampaignName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Budget DECIMAL(12, 2) NOT NULL,
    Status VARCHAR(50) NOT NULL
);

CREATE TABLE Platforms (
    PlatformID SERIAL PRIMARY KEY,
    PlatformName VARCHAR(100) NOT NULL,
    CostPerClick DECIMAL(10, 2) NOT NULL,
    CostPerImpression DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DateRegistered DATE NOT NULL
);

CREATE TABLE Performance (
    PerformanceID SERIAL PRIMARY KEY,
    CampaignID INT NOT NULL,
    PlatformID INT NOT NULL,
    CustomerID INT NOT NULL,
    Impressions INT NOT NULL,
    Clicks INT NOT NULL,
    Conversions INT NOT NULL,
    Spend DECIMAL(12, 2) NOT NULL,
    DateRecorded DATE NOT NULL,
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID),
    FOREIGN KEY (PlatformID) REFERENCES Platforms(PlatformID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Campaigns (CampaignName, StartDate, EndDate, Budget, Status)
VALUES 
('Summer Sale 2024', '2024-06-01', '2024-07-31', 5000.00, 'Active'),
('Winter Campaign 2023', '2023-12-01', '2024-01-31', 3000.00, 'Completed'),
('Black Friday 2023', '2023-11-20', '2023-11-30', 10000.00, 'Completed'),
('Spring Sale 2024', '2024-04-01', '2024-04-30', 4000.00, 'Planned'),
('New Year 2024', '2024-01-01', '2024-01-15', 2000.00, 'Planned'),
('Halloween 2023', '2023-10-01', '2023-10-31', 3500.00, 'Completed'),
('Cyber Monday 2023', '2023-11-27', '2023-11-30', 8000.00, 'Completed'),
('Christmas Special 2023', '2023-12-15', '2023-12-31', 12000.00, 'Active'),
('Easter 2024', '2024-03-15', '2024-03-31', 3000.00, 'Planned'),
('Valentine’s Day 2024', '2024-02-01', '2024-02-14', 2500.00, 'Planned');


INSERT INTO Platforms (PlatformName, CostPerClick, CostPerImpression)
VALUES
('Google Ads', 1.50, 0.05),
('Facebook Ads', 1.20, 0.03),
('LinkedIn Ads', 2.00, 0.10),
('Instagram Ads', 1.40, 0.04),
('Twitter Ads', 1.10, 0.02),
('TikTok Ads', 1.25, 0.06),
('YouTube Ads', 1.80, 0.08),
('Snapchat Ads', 1.15, 0.03),
('Pinterest Ads', 1.00, 0.02),
('Reddit Ads', 1.05, 0.02);

INSERT INTO Customers (FirstName, LastName, Email, DateRegistered)
VALUES
('John', 'Doe', 'john.doe@example.com', '2023-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', '2023-05-20'),
('Mark', 'Johnson', 'mark.johnson@example.com', '2023-07-11'),
('Emily', 'Davis', 'emily.davis@example.com', '2023-02-22'),
('Michael', 'Brown', 'michael.brown@example.com', '2023-03-05'),
('Emma', 'Jones', 'emma.jones@example.com', '2023-06-30'),
('Oliver', 'Wilson', 'oliver.wilson@example.com', '2023-04-10'),
('Sophia', 'Taylor', 'sophia.taylor@example.com', '2023-08-15'),
('Lucas', 'Moore', 'lucas.moore@example.com', '2023-09-07'),
('Mia', 'Anderson', 'mia.anderson@example.com', '2023-10-01');



INSERT INTO Performance (CampaignID, PlatformID, CustomerID, Impressions, Clicks, Conversions, Spend, DateRecorded)
VALUES
(1, 1, 1, 10000, 150, 20, 500.00, '2024-06-15'),
(2, 2, 2, 12000, 180, 30, 750.00, '2023-12-20'),
(3, 3, 3, 15000, 200, 40, 1000.00, '2023-11-25'),
(4, 4, 4, 5000, 80, 10, 300.00, '2024-04-10'),
(5, 5, 5, 8000, 110, 25, 600.00, '2024-01-05'),
(6, 6, 6, 11000, 170, 35, 850.00, '2023-10-25'),
(7, 7, 7, 14000, 210, 50, 1200.00, '2023-11-28'),
(8, 8, 8, 13000, 190, 45, 1050.00, '2023-12-22'),
(9, 9, 9, 6000, 90, 15, 400.00, '2024-03-20'),
(10, 10, 10, 7000, 100, 20, 450.00, '2024-02-10');


SELECT * FROM Campaigns;

SELECT * FROM Platforms;

SELECT * FROM Customers;

SELECT * FROM Performance;

--1. Campaign incurring the highest total spend
SELECT c.CampaignName, SUM(p.Spend) AS TotalSpend
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
GROUP BY c.CampaignName
ORDER BY TotalSpend DESC
LIMIT 1;

--2. Total Impressions, Clicks, and Conversions by Platform
SELECT pl.PlatformName, 
       SUM(p.Impressions) AS TotalImpressions, 
       SUM(p.Clicks) AS TotalClicks, 
       SUM(p.Conversions) AS TotalConversions
FROM Performance p
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
GROUP BY pl.PlatformName;

--3. Customer with the Most Conversions
SELECT cu.FirstName, cu.LastName, SUM(p.Conversions) AS TotalConversions
FROM Performance p
JOIN Customers cu ON p.CustomerID = cu.CustomerID
GROUP BY cu.FirstName, cu.LastName
ORDER BY TotalConversions DESC
LIMIT 1;

--4. Average Cost Per Click (CPC) for Each Campaign
SELECT c.CampaignName, ROUND(AVG(pl.CostPerClick), 2) AS AvgCPC
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
GROUP BY c.CampaignName;

--5. Most Effective Platform for the 'Summer Sale 2024' Campaign
SELECT pl.PlatformName, SUM(p.Clicks) AS TotalClicks
FROM Performance p
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
JOIN Campaigns c ON p.CampaignID = c.CampaignID
WHERE c.CampaignName = 'Summer Sale 2024'
GROUP BY pl.PlatformName
ORDER BY TotalClicks DESC;

--6. Total Spend Per Platform Across All Campaigns
SELECT pl.PlatformName, SUM(p.Spend) AS TotalSpend
FROM Performance p
JOIN Platforms pl ON p.PlatformID = pl.PlatformID
GROUP BY pl.PlatformName
ORDER BY TotalSpend DESC;

--7. Conversion Rate for Each Campaign
SELECT c.CampaignName, 
       ROUND(SUM(p.Conversions) * 1.0 / SUM(p.Clicks), 2) AS ConversionRate
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
GROUP BY c.CampaignName;

--8. Customers Engaging with the Most Campaigns
SELECT cu.FirstName, cu.LastName, COUNT(DISTINCT p.CampaignID) AS CampaignCount
FROM Performance p
JOIN Customers cu ON p.CustomerID = cu.CustomerID
GROUP BY cu.FirstName, cu.LastName
ORDER BY CampaignCount DESC;

--9. Platform with the Lowest Cost Per Impression (CPI)
SELECT pl.PlatformName, 
       ROUND(AVG(pl.CostPerImpression), 2) AS AvgCPI
FROM Platforms pl
JOIN Performance p ON p.PlatformID = pl.PlatformID
GROUP BY pl.PlatformName
ORDER BY AvgCPI ASC
LIMIT 1;

--10. Active Campaign with the Most Impressions
SELECT c.CampaignName, SUM(p.Impressions) AS TotalImpressions
FROM Performance p
JOIN Campaigns c ON p.CampaignID = c.CampaignID
WHERE c.Status = 'Active'
GROUP BY c.CampaignName
ORDER BY TotalImpressions DESC
LIMIT 1;

