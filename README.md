# NHS Prescription Cost Analysis (2022-2025)

[![R](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)](https://www.r-project.org/)
[![ggplot2](https://img.shields.io/badge/ggplot2-Data_Visualization-blue)](https://ggplot2.tidyverse.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Comprehensive analysis of NHS prescription spending patterns across England, examining over 2.3 million prescription records from 2022-2025 to identify cost drivers, regional disparities, and growth trends.

## 📊 Project Overview

This project analyzes three financial years of NHS prescription data (2022/23, 2023/24, 2024/25) from the NHS Business Services Authority to understand spending patterns, identify major cost drivers, and reveal regional variations in healthcare expenditure.

**Key Questions Addressed:**
- Which therapeutic areas drive the highest prescription costs?
- How have costs evolved across different medical categories?
- What regional disparities exist in prescription spending?
- Which individual medications account for the largest expenditure?

## 🔍 Key Findings

- **Endocrine System** dominates spending at **£5.8 billion** over three years, driven by diabetes treatments
- **Regional disparities**: Midlands highest (£6.0B), South West lowest (£3.5B) - £2.5B variation
- **Medical appliances** showing **15%+ annual growth**, driven by continuous glucose monitoring technology
- **Cardiovascular costs declining 5%**, potentially reflecting preventive care success
- **Top medications**: Forxiga 10mg (£600M) and FreeStyle Libre sensors (£550M)

## 📈 Visualizations

### 1. Cost Trends Over Time (2022-2025)
![Trends Over Time](visualizations/Viz1_Trends_Over_Time.png)
*Top 5 therapeutic areas showing cost evolution. Endocrine System demonstrates consistent growth while Cardiovascular costs decline.*

### 2. Top 10 Therapeutic Areas
![Top 10 Chapters](visualizations/Viz2_Top10_Chapters.png)
*Combined costs across three years. Major categories account for over £19 billion in spending.*

### 3. Regional Cost Variations
![Regional Costs](visualizations/Viz3_Regional_Costs.png)
*Geographical variation reveals significant disparities across English regions.*

### 4. Top 15 Most Expensive Drugs
![Top Drugs](visualizations/Viz4_Top15_Drugs.png)
*Individual medication analysis highlighting diabetes treatment dominance.*

### 5. Volume vs Cost Relationship
![Volume vs Cost](visualizations/Viz5_Items_vs_Cost.png)
*Scatter plot revealing relationship between prescription volume and total expenditure.*

### 6. Year-over-Year Growth Rates
![Growth Rates](visualizations/Viz6_Growth_Rates.png)
*Annual percentage changes showing divergent trends across therapeutic categories.*

## 🛠️ Technical Implementation

### Tools & Technologies
- **Language**: R (version 4.5.2+)
- **Key Packages**:
  - `dplyr` - Data manipulation and aggregation
  - `ggplot2` - Professional data visualization
  - `readr` - Efficient CSV reading
  - `tidyr` - Data tidying and reshaping
  - `scales` - Axis formatting and labeling
  - `viridis` - Color palettes
  - `gridExtra` - Multiple plot arrangements

### Data Processing
- Loaded and combined 2.3M+ records from three separate CSV files
- Aggregated data by therapeutic area, region, and financial year
- Calculated growth rates, cost per item metrics, and regional totals
- Created summary tables for efficient visualization

### Analysis Approach
1. **Temporal Analysis**: Year-over-year trends and growth patterns
2. **Categorical Analysis**: Spending by therapeutic area (BNF chapters)
3. **Geographic Analysis**: Regional cost variations across England
4. **Drug-Specific Analysis**: Individual medication expenditure
5. **Efficiency Analysis**: Volume vs cost relationships

## 📁 Repository Structure
```
├── code/
│   └── NHS_Analysis.R          # Main analysis script
├── visualizations/              # All generated charts (PNG, 300 DPI)
├── data/
│   └── README.md               # Data source information
└── README.md                   # Project documentation
```

## 🚀 Getting Started

### Prerequisites
```r
# Install required packages
install.packages(c("readr", "dplyr", "ggplot2", "tidyr", 
                   "scales", "viridis", "gridExtra"))
```

### Running the Analysis

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/NHS-Prescription-Cost-Analysis.git
cd NHS-Prescription-Cost-Analysis
```

2. **Download the data**
- Visit [NHS BSA Open Data Portal](https://opendata.nhsbsa.net/dataset/prescription-cost-analysis-pca-annual-statistics)
- Download PCA Annual Statistics for 2022/23, 2023/24, 2024/25
- Place CSV files in a folder named "nhs data" on your Desktop

3. **Run the analysis**
```r
source("code/NHS_Analysis.R")
```

4. **View outputs**
- Visualizations saved to `~/Desktop/NHS_Visualizations/`
- Review generated PNG files

## 📊 Data Source

**Dataset**: Prescription Cost Analysis (PCA) Annual Statistics  
**Provider**: NHS Business Services Authority (NHSBSA)  
**Portal**: [NHSBSA Open Data Portal](https://opendata.nhsbsa.net/)  
**Time Period**: Financial Years 2022/23, 2023/24, 2024/25  
**Records**: 2.3 million+ prescription records  
**Geography**: England (Regional and ICB level)  

**Data Structure**:
- BNF Chapter (Therapeutic area classification)
- Region and ICB (Integrated Care Board)
- Drug presentation details
- Cost metrics (NIC - Net Ingredient Cost)
- Volume metrics (Items, Quantity)

## 💡 Key Insights & Implications

### Healthcare Trends
- **Shift toward chronic disease management**: Rising diabetes treatment costs
- **Technology adoption**: Continuous glucose monitoring driving appliance growth
- **Preventive care success**: Declining cardiovascular medication costs

### Policy Implications
- **Regional equity**: Significant spending variations suggest resource allocation opportunities
- **Cost containment**: Generic substitution strategies showing impact in cardiovascular area
- **Future planning**: Anticipate continued growth in monitoring technology expenditure

## 📝 Methodology

### Data Preparation
1. Combined three annual CSV files using `bind_rows()`
2. Filtered and cleaned data for consistency
3. Aggregated by multiple dimensions (therapeutic area, region, year)

### Visualization Strategy
- **Trend analysis**: Line charts for temporal patterns
- **Comparison**: Horizontal bar charts for categorical data
- **Relationships**: Scatter plots for volume vs cost
- **Growth**: Grouped bar charts for year-over-year changes

### Quality Assurance
- Verified data totals against official NHS publications
- Cross-checked regional aggregations
- Validated year-over-year calculations

## 🎓 Skills Demonstrated

- Large-scale data processing (2.3M+ records)
- Data cleaning and transformation
- Statistical analysis and trend identification
- Professional data visualization
- Healthcare data interpretation
- R programming and package ecosystem
- Git version control
- Technical documentation and reproducibility

## 📧 Contact

**Vihara**  
BSc Data Science and Analytics, University of Westminster  
[LinkedIn](https://linkedin.com/in/YOUR_PROFILE) | [GitHub](https://github.com/YOUR_USERNAME)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- NHS Business Services Authority for providing open data
- R Core Team and package developers
- University of Westminster - School of Computer Science and Engineering

---

**Note**: This analysis was completed as part of the Data Visualisation and Dashboarding module (5DATA006W) at the University of Westminster.
