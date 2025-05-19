-- Insurance Claims Analysis SQL
-- This file contains all SQL queries to:
-- 1. Create and load the insurance claims data
-- 2. Analyze factors increasing claim costs
-- 3. Develop a fraud detection scorecard
-- 4. Calculate potential cost reductions

-- =======================================
-- DATABASE SETUP
-- =======================================

-- Create database
CREATE DATABASE insurance_claims;
USE insurance_claims;

-- Create main claims table
CREATE TABLE claims (
    claim_id INT PRIMARY KEY AUTO_INCREMENT,
    policy_id VARCHAR(20),
    policy_state CHAR(2),
    incident_date DATE,
    incident_type VARCHAR(50),
    incident_severity VARCHAR(20),
    damage_description TEXT,
    claim_amount DECIMAL(12,2),
    claim_status VARCHAR(20),
    settlement_date DATE,
    police_report_available CHAR(3),
    witness_count INT,
    vehicle_age INT,
    vehicle_make VARCHAR(30),
    vehicle_model VARCHAR(30),
    high_claim CHAR(3), -- 'YES' if claim amount is above threshold
    fraud_flag CHAR(3)  -- 'YES' if fraud detected, 'NO' otherwise
);

-- Load data from CSV (example syntax - adjust according to your system)
-- LOAD DATA INFILE '/path/to/claims_data.csv' 
-- INTO TABLE claims
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- =======================================
-- DATA EXPLORATION & CLEANING
-- =======================================

-- Set high_claim flag based on threshold
UPDATE claims 
SET high_claim = 'YES' 
WHERE claim_amount > 71840;  -- Upper boundary of Mid cost segment

-- Check for missing values
SELECT 
    SUM(CASE WHEN policy_id IS NULL THEN 1 ELSE 0 END) AS missing_policy_id,
    SUM(CASE WHEN incident_type IS NULL THEN 1 ELSE 0 END) AS missing_incident_type,
    SUM(CASE WHEN claim_amount IS NULL THEN 1 ELSE 0 END) AS missing_claim_amount,
    SUM(CASE WHEN fraud_flag IS NULL THEN 1 ELSE 0 END) AS missing_fraud_flag
FROM claims;

-- =======================================
-- 1. BASIC STATISTICS FOR KPI CARDS
-- =======================================

-- Total claim count
SELECT 
    COUNT(*) AS total_claims
FROM claims;

-- Total payment amount
SELECT 
    SUM(claim_amount) AS total_payment_amount
FROM claims;

-- Average claim amount
SELECT 
    AVG(claim_amount) AS average_claim_amount
FROM claims;

-- Fraud rate
SELECT 
    SUM(CASE WHEN fraud_flag = 'YES' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS fraud_rate
FROM claims;

-- =======================================
-- 2. ANALYSIS BY STATE
-- =======================================

-- Claims by state
SELECT 
    policy_state,
    COUNT(*) AS total_claims,
    SUM(claim_amount) AS total_claim_amount,
    AVG(claim_amount) AS avg_claim_amount
FROM claims
GROUP BY policy_state
ORDER BY total_claims DESC;

-- =======================================
-- 3. ANALYSIS BY DAMAGE SEVERITY
-- =======================================

-- Fraud rate by damage severity
SELECT 
    incident_severity,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_flag = 'YES' THEN 1 ELSE 0 END) AS fraud_count,
    SUM(CASE WHEN fraud_flag = 'YES' THEN 1 ELSE 0 END) / COUNT(*) AS fraud_rate
FROM claims
GROUP BY incident_severity
ORDER BY fraud_rate DESC;

-- =======================================
-- 4. ANALYSIS BY INCIDENT TYPE
-- =======================================

-- Average claim amount by incident type
SELECT 
    incident_type,
    AVG(claim_amount) AS avg_claim_amount,
    COUNT(*) AS claim_count
FROM claims
GROUP BY incident_type
ORDER BY avg_claim_amount DESC;

-- =======================================
-- 5. COST SEGMENTATION
-- =======================================

-- Create cost segments
SELECT 
    CASE 
        WHEN claim_amount < 37460 THEN 'Low'
        WHEN claim_amount < 71840 THEN 'Mid'
        ELSE 'High'
    END AS cost_segment_label,
    COUNT(*) AS segment_size,
    AVG(claim_amount) AS avg_claim,
    MIN(claim_amount) AS min_claim,
    MAX(claim_amount) AS max_claim
FROM claims
GROUP BY 
    CASE 
        WHEN claim_amount < 37460 THEN 'Low'
        WHEN claim_amount < 71840 THEN 'Mid'
        ELSE 'High'
    END
ORDER BY min_claim;

-- =======================================
-- 6. FRAUD DETECTION ANALYSIS
-- =======================================

-- Fraud crosstab analysis
SELECT 
    CASE WHEN witness_count = 0 THEN '0' ELSE '1+' END AS witnesses,
    police_report_available,
    high_claim,
    SUM(CASE WHEN fraud_flag = 'NO' THEN 1 ELSE 0 END) AS 'false',
    SUM(CASE WHEN fraud_flag = 'YES' THEN 1 ELSE 0 END) AS 'true',
    COUNT(*) AS 'All'
FROM claims
GROUP BY 
    CASE WHEN witness_count = 0 THEN '0' ELSE '1+' END,
    police_report_available,
    high_claim
ORDER BY 
    witnesses,
    police_report_available,
    high_claim;

-- =======================================
-- 7. COST FACTORS ANALYSIS
-- =======================================

-- Impact of incident type on claim cost
SELECT 
    CONCAT('Incident Type: ', incident_type) AS factor,
    AVG(claim_amount) AS cost_impact,
    AVG(claim_amount) / (SELECT AVG(claim_amount) FROM claims) AS relative_impact
FROM claims
GROUP BY incident_type
ORDER BY cost_impact DESC;

-- Impact of damage severity on claim cost
SELECT 
    CONCAT('Damage: ', incident_severity) AS factor,
    AVG(claim_amount) AS cost_impact,
    AVG(claim_amount) / (SELECT AVG(claim_amount) FROM claims) AS relative_impact
FROM claims
GROUP BY incident_severity
ORDER BY cost_impact DESC;

-- Impact of police report on claim cost
SELECT 
    'No Police Report' AS factor,
    AVG(claim_amount) AS cost_impact,
    AVG(claim_amount) / (SELECT AVG(claim_amount) FROM claims) AS relative_impact
FROM claims
WHERE police_report_available = 'NO';

-- Impact of witness presence on claim cost
SELECT 
    'No Witnesses' AS factor,
    AVG(claim_amount) AS cost_impact,
    AVG(claim_amount) / (SELECT AVG(claim_amount) FROM claims) AS relative_impact
FROM claims
WHERE witness_count = 0;

-- =======================================
-- 8. FRAUD SCORECARD CALCULATION
-- =======================================

-- Calculate fraud probability for each combination of factors
SELECT 
    CASE WHEN witness_count = 0 THEN 'No Witnesses' ELSE 'Has Witnesses' END AS witness_factor,
    CASE WHEN police_report_available = 'YES' THEN 'Has Police Report' ELSE 'No Police Report' END AS police_report_factor,
    CASE WHEN high_claim = 'YES' THEN 'High Claim Amount' ELSE 'Low Claim Amount' END AS claim_amount_factor,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_flag = 'YES' THEN 1 ELSE 0 END) AS fraud_claims,
    SUM(CASE WHEN fraud_flag = 'YES' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS fraud_probability
FROM claims
GROUP BY 
    CASE WHEN witness_count = 0 THEN 'No Witnesses' ELSE 'Has Witnesses' END,
    CASE WHEN police_report_available = 'YES' THEN 'Has Police Report' ELSE 'No Police Report' END,
    CASE WHEN high_claim = 'YES' THEN 'High Claim Amount' ELSE 'Low Claim Amount' END
ORDER BY 
    fraud_probability DESC;

-- Create a fraud score model
CREATE VIEW fraud_score_model AS
WITH fraud_factors AS (
    SELECT
        claim_id,
        (CASE WHEN witness_count = 0 THEN 40 ELSE 0 END) +
        (CASE WHEN police_report_available = 'NO' THEN 30 ELSE 0 END) +
        (CASE WHEN high_claim = 'YES' THEN 20 ELSE 0 END) +
        (CASE WHEN incident_severity = 'Major Damage' THEN 10 ELSE 0 END) AS fraud_score
    FROM claims
)
SELECT
    f.fraud_score,
    COUNT(*) AS claim_count,
    SUM(CASE WHEN c.fraud_flag = 'YES' THEN 1 ELSE 0 END) AS fraud_count,
    SUM(CASE WHEN c.fraud_flag = 'YES' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS fraud_probability
FROM
    fraud_factors f
JOIN
    claims c ON f.claim_id = c.claim_id
GROUP BY
    f.fraud_score
ORDER BY
    f.fraud_score DESC;

-- =======================================
-- 9. COST REDUCTION OPPORTUNITY ANALYSIS
-- =======================================

-- Calculate potential savings from fraud detection
SELECT
    'Improved Fraud Detection' AS category,
    15 AS savings_percent,
    (SELECT SUM(claim_amount) FROM claims WHERE fraud_flag = 'YES') * 0.15 AS savings_amount;

-- Calculate potential savings from optimized claims processing
SELECT
    'Optimized Claims Processing' AS category,
    8 AS savings_percent,
    (SELECT SUM(claim_amount) FROM claims) * 0.08 AS savings_amount;

-- Calculate potential improvement from premium adjustment
SELECT
    'Premium Adjustment' AS category,
    12 AS improvement_percent,
    (SELECT SUM(claim_amount) FROM claims) * 0.12 AS improvement_amount;

-- Calculate total impact
SELECT
    'Total Impact' AS category,
    (15 * (SELECT SUM(claim_amount) FROM claims WHERE fraud_flag = 'YES') / (SELECT SUM(claim_amount) FROM claims)) +
    8 +
    12 AS total_impact_percent,
    (SELECT SUM(claim_amount) FROM claims WHERE fraud_flag = 'YES') * 0.15 +
    (SELECT SUM(claim_amount) FROM claims) * 0.08 +
    (SELECT SUM(claim_amount) FROM claims) * 0.12 AS total_impact_amount;

-- =======================================
-- 10. PREMIUM OPTIMIZATION MODEL
-- =======================================

-- Create risk segments
CREATE TEMPORARY TABLE risk_segments AS
SELECT
    NTILE(5) OVER (ORDER BY 
        CASE WHEN fraud_flag = 'YES' THEN 1 ELSE 0 END DESC,
        incident_severity = 'Major Damage' DESC,
        incident_severity = 'Total Loss' DESC,
        high_claim = 'YES' DESC
    ) AS risk_level,
    claim_id,
    claim_amount
FROM claims;

-- Calculate current vs. optimized premiums by risk level
SELECT
    CASE 
        WHEN risk_level = 1 THEN 'Very High'
        WHEN risk_level = 2 THEN 'High'
        WHEN risk_level = 3 THEN 'Medium'
        WHEN risk_level = 4 THEN 'Low'
        WHEN risk_level = 5 THEN 'Very Low'
    END AS risk_level_label,
    COUNT(*) AS claim_count,
    AVG(claim_amount) AS avg_claim_amount,
    -- Current premium model (simplified example)
    CASE 
        WHEN risk_level = 1 THEN 3200
        WHEN risk_level = 2 THEN 2400
        WHEN risk_level = 3 THEN 1800
        WHEN risk_level = 4 THEN 1200
        WHEN risk_level = 5 THEN 800
    END AS current_premium,
    -- Optimized premium model
    CASE 
        WHEN risk_level = 1 THEN 3600
        WHEN risk_level = 2 THEN 2700
        WHEN risk_level = 3 THEN 1900
        WHEN risk_level = 4 THEN 1100
        WHEN risk_level = 5 THEN 600
    END AS optimized_premium,
    -- Claim frequency (simplified)
    CASE 
        WHEN risk_level = 1 THEN 0.14
        WHEN risk_level = 2 THEN 0.09
        WHEN risk_level = 3 THEN 0.06
        WHEN risk_level = 4 THEN 0.04
        WHEN risk_level = 5 THEN 0.02
    END AS claim_frequency
FROM risk_segments
GROUP BY risk_level
ORDER BY risk_level; 