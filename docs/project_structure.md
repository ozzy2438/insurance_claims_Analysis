# Project Structure

The project is organized into the following directories to ensure clean separation of code, data, and documentation:

## Directory Structure

```
insurance_claims_analysis/
├── notebooks/              # Jupyter notebooks for analysis
│   ├── auto_insurance.ipynb  # Main analysis notebook
│   └── data/               # Data used by notebooks
│       └── insurance_claim_updated.csv
│
├── sql/                    # SQL scripts for data extraction
│   └── insurance_claims_analysis.sql
│
├── dashboard/              # Interactive web dashboard
│   ├── index.html          # Main dashboard page
│   ├── dashboard_design_plan.js  # Dashboard functionality
│   └── insights_summary.md # Key findings and business impacts
│
├── docs/                   # Documentation
│   ├── user_guide.md       # User documentation
│   └── project_structure.md  # This file
│
└── README.md               # Project overview
```

## Purpose of Each Directory

- **notebooks/**: Contains all Jupyter notebook files for data analysis, modeling, and visualization.
- **sql/**: Stores SQL scripts used for data extraction, transformation and loading.
- **dashboard/**: Houses the web-based interactive dashboard files including HTML, CSS and JavaScript.
- **docs/**: Includes all documentation files such as user guides, project structure, etc.

This organized structure follows best practices for data science projects, making it easier for reviewers and collaborators to navigate and understand the project. 