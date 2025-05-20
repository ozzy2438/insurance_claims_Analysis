# Interactive Dashboard Usage Guide

## Overview

This document provides instructions for using the fully interactive Insurance Claims Analysis Dashboard. The dashboard has been completely redesigned to ensure all charts and KPIs update dynamically when filters are changed.

## Key Features

1. **Fully Interactive Filtering**: All charts and KPIs now update in real-time when you change any filter
2. **English Interface**: Complete English language interface
3. **Dynamic Data Processing**: Client-side data filtering for immediate visual feedback
4. **Responsive Design**: Works on both desktop and mobile devices

## How to Use the Filters

The dashboard includes four main filters that can be used in combination:

1. **State**: Filter data by policy state (Ohio, Illinois, Indiana)
2. **Incident Type**: Filter by incident type (Single Vehicle Collision, Multi-vehicle Collision, Vehicle Theft, Parked Car)
3. **Damage Severity**: Filter by severity level (Major Damage, Minor Damage, Total Loss, Trivial Damage)
4. **Cost Segment**: Filter by cost segment (High, Medium, Low)

When you change any filter, all dashboard elements will automatically update to reflect your selection:
- KPI cards will recalculate with filtered data
- All charts will redraw with the filtered dataset
- The fraud analysis table will update with filtered results

## Dashboard Sections

### 1. KPI Cards
Four key performance indicators that summarize the filtered data:
- Total Claims: Number of claims matching your filter criteria
- Total Claim Amount: Sum of all claim amounts in the filtered dataset
- Average Claim Amount: Average claim value in the filtered dataset
- Fraud Rate: Percentage of claims flagged as fraud in the filtered dataset

### 2. Charts
Four interactive visualizations that update with filter changes:
- Claims by State: Bar and line chart showing claim counts and average amounts by state
- Fraud Rates by Severity: Bar and line chart showing fraud rates and claim counts by severity
- Average Claim by Incident Type: Horizontal bar chart showing average claim amounts by incident type
- Claims by Cost Segment: Pie chart showing distribution of claims across cost segments

### 3. Fraud Analysis Matrix
Detailed table showing fraud probabilities across different combinations of risk factors:
- Witnesses (0 or 1+)
- Police Report (Yes or No)
- High Claim (Yes or No)

## Technical Implementation

The dashboard uses client-side JavaScript to filter data and update visualizations in real-time:
1. All data is loaded when the dashboard initializes
2. When filters change, the data is filtered in memory
3. Charts and KPIs are recalculated and redrawn with the filtered dataset
4. No server requests are needed for filtering, ensuring immediate updates

## Deployment Instructions

To deploy this dashboard on your own server:
1. Copy the `interactive_dashboard.html` file to your web server
2. Create a `processed_data` directory in the same location
3. Copy all JSON files from the `processed_data` directory to your server's `processed_data` directory
4. Access the dashboard through your web browser

## Troubleshooting

If charts are not updating when changing filters:
1. Check browser console for any JavaScript errors
2. Verify that all JSON data files are properly loaded
3. Try clearing your browser cache and reloading the page

For any other issues, please contact technical support.
