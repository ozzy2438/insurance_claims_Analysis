// Dashboard Design Plan
// Insurance Claims Analysis Dashboard

// 1. GENERAL LAYOUT
// ---------------
// The dashboard will consist of the following sections:
// - Top section: Title, filters, and KPI cards
// - Middle section: Core visualizations focused on cost factors and fraud detection
// - Bottom section: Detailed analysis and actionable insights

// 2. COLOR SCHEME
// --------------
// Main colors:
// - Blue shades (#1f77b4, #7fcdbb, #c7e9b4) - Trust and professionalism
// - Green shades (#41b6c4, #a1dab4) - Financial health and optimization
// - Neutral tones (#f7f7f7, #eeeeee, #333333) - Backgrounds and text
// - Accent colors: Red (#d73027) - Warnings and risks

// 3. SECTIONS AND CONTENT
// -------------------------

// 3.1 TOP SECTION
// -------------
// Title: "Insurance Claims Analysis Dashboard"
// Stakeholder Focus Banner: "Claim Cost Reduction & Fraud Prevention"
// Filters:
//   - Date range selection
//   - State filter (OH, IL, IN)
//   - Incident type filter (Single Vehicle Collision, Multi-vehicle Collision, etc.)
//   - Damage severity filter (Major Damage, Minor Damage, Total Loss, Trivial Damage)

// KPI Cards (4 cards):
//   - Total Claims: 10,211
//   - Total Payment Amount: $578,033,830
//   - Average Claim Amount: $56,609
//   - Fraud Rate: 49.9%

// 3.2 MIDDLE SECTION
// --------------
// Top Left: Cost Factors Analysis
//   - Visualization: Multi-variable bar chart showing cost impact by factor
//   - Data: cost_impact_factors.json
//   - Goal: Addressing stakeholder question #1 - "What factors increase total claim costs?"

// Top Right: Fraud Detection Scorecard
//   - Visualization: Heatmap/matrix showing fraud probability by key factor combinations
//   - Data: fraud_detection_factors.json
//   - Goal: Addressing stakeholder question #2 - "Can we develop a reliable scorecard to detect fraudulent claims early?"

// Bottom Left: Cost Reduction Opportunity by Segment
//   - Visualization: Horizontal bar chart showing potential savings by segment
//   - Data: cost_reduction_opportunities.json
//   - Goal: Supporting stakeholder question #3 - "I want to reduce annual paid claims by X%"

// Bottom Right: Premium Optimization Model
//   - Visualization: Line chart showing current vs. optimized premium models
//   - Data: premium_optimization.json
//   - Goal: Supporting stakeholder question #3 - "optimize premium pricing"

// 3.3 BOTTOM SECTION
// -------------
// Detailed Table: Fraud Factors Analysis
//   - Visualization: Interactive table with risk scoring
//   - Data: fraud_factors.json
//   - Goal: Actionable insights for early fraud detection

// Potential Savings Summary:
//   - Visualization: Key metrics with projections
//   - Data: savings_projections.json
//   - Goal: Quantifying potential annual savings from insights

// 4. INTERACTIVE FEATURES
// ------------------------
// - All charts responsive to filters
// - Click functionality for detailed views
// - Hover for detailed information
// - Drill-down capability (e.g., clicking on a state shows detailed analysis)
// - Chart resize option
// - Data table download option
// - What-if scenario modeling for cost reduction

// 5. RESPONSIVE DESIGN
// --------------------
// - Desktop: Full layout (3x2 grid)
// - Tablet: 2x3 grid layout
// - Mobile: 1x6 single column layout

// 6. PERFORMANCE OPTIMIZATION
// --------------------------
// - Data preloading
// - Lazy loading charts
// - Client-side filtering
// - Pagination for large datasets
