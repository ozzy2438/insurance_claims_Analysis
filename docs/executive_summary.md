# Insurance Fraud and Claims Analytics – Project Executive Summary

## 1. Project Objective

This project aims to identify fraud signals in auto insurance claim files and pinpoint operational and profitability metrics and segments that matter most. We also simulate business/product/pricing scenarios and outline a roadmap for productionizing model-based detection within claims operations.

## 2. Key Metrics Investigated

- **Severity & Fraud Rate**: Patterns of total and fraudulent claims by incident severity (e.g. major damage).
- **Regional Profitability and Payout (State, Segment)**: Average and total claims by state to spot risk and margin hotspots.
- **Event Type & Suspicious Behavior**: Impact of combinations such as collisions/theft, no-witness, and missing police report on fraud risk.
- **Customer & Claim Segmentation**: K-Means clustering to define "Low/Mid/High cost" segments, profitability matrices by segment and geography.
- **Fraud Model Performance**: ROC-AUC, F1, and SHAP-based model explainability for accuracy and transparency.
- **Business Model Simulation (ROI)**: Effect of a 20% deductible increase and 10% premium decrease scenario on overall gross profit.

## 3. Main Findings & Recommendations

- **High-value, no-witness, no-police-report claims**: These drastically elevate fraud risk. Enforce automated secondary review, documentation, or prioritized workflow for these combinations.
- **Major Damage & State Risk**: Indiana and Ohio are states with both high claim averages and suspicious activity concentration. Review product design and pricing in these pockets.
- **High-Cost Segments (K-Means identified)**: Consider higher deductibles, special product/policy offers, or retention campaigns for high-value clusters.
- **Fraud Model & SHAP Dashboard**: Move the fraud detection model into production with an integrated SHAP dashboard for transparency and regulatory compliance.
- **Scenario-Driven Product & Pricing Design**: Utilize ROI impact tables and dashboards to inform product managers and actuaries for optimal pricing/deductible design changes.

## 4. Financial Impact

- **Annual Cost Burden**: $578M in insurance claim payments
- **Fraud Rate**: 49.9% of claims show suspicious patterns
- **Projected Annual Savings**: $120M (20.8% reduction) through:
  - Improved fraud detection: $87M (15%)
  - Optimized claims processing: $46M (8%)
  - Premium adjustment: $69M (12%)
- **Customer Satisfaction**: 12% improvement through streamlined claims processing

## 5. Implementation Roadmap

1. **Phase 1: Detect** - Deploy fraud detection system targeting high-risk combinations
2. **Phase 2: Optimize** - Adjust premium structure based on risk segmentation
3. **Phase 3: Transform** - Redesign claims workflow for efficiency and cost control
4. **Phase 4: Scale** - Expand model to additional lines of business

This data-driven approach provides clear direction for immediate action while establishing a framework for continuous optimization of the claims process. 