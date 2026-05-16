## 🔍 Data Analytics & Business Intelligence

With the clean data models established in the Gold Layer (from the previous Engineering Project), the project executes an end-to-end analytical phase divided into **Exploratory Data Analysis (EDA)** and **Advanced Business Analytics** to uncover actionable insights.

---

### 1. Exploratory Data Analysis (EDA)
Before building strategic models, a comprehensive data exploration phase was conducted to understand the fundamental characteristics, distributions, and baseline health of the datasets:

* **Database & Dimension Exploration:** Investigating table granularities, primary-to-foreign key relationships, and mapping unique dimensional attributes (e.g., product lines, customer segments).
* **Date & Timeline Exploration:** Analysis of the data's historical boundaries to determine the exact start, end, and density of transactional records across the timeline.
* **Measures & Magnitude Analysis:** Profiling high-level organizational metrics—such as total revenue, order volumes, and item counts—to understand overall business scale and identify statistical outliers.
* **Ranking & Segmentation:** Isolating top-performing and bottom-performing products, regions, and customer cohorts to detect immediate operational risks or opportunities.

---

### 2. Advanced Analytics & Core Business Metrics
Moving beyond basic summaries, advanced analytical logic was engineered using complex SQL features (including **Window Functions**, **CTEs**, and **Conditional Aggregations**) to deliver deep business insights:

* **Cumulative & Trend Analysis:** Developing month-over-month rolling totals and running averages to track sales momentum and smooth out seasonal fluctuations.
* **Change-Over-Time (YoY / MoM):** Utilizing positioning functions like `LAG()` and `LEAD` to compare current performance directly against historical baselines, providing true Year-over-Year growth tracking.
* **Performance Analysis:** Benchmarking specific product categories and regional sales metrics against corporate averages to pinpoint underperforming business units.
* **Part-to-Whole (Proportional) Analysis:** Calculating percentage-of-total contributions across product segments to understand what core drivers dominate total business revenue.
* **Data Segmentation:** Writing dynamic segmentation logic to bucket customers by behavioral attributes (e.g., age demographics, purchase frequency) to optimize targeted operational reporting.

---

### 📈 Core Business Insights Derived
* **Sales Concentration (Part-to-Whole):** Discovered an extreme revenue concentration in the product catalog, with **Bikes** dominating the business at **96.46%** of total revenue ($28.3M out of $29.3M). 
* **Long-Tail Categories:** Identified that **Accessories** and **Clothing** combine for less than 4% of total organizational sales, highlighting a massive dependency on a single product line and signaling an opportunity to re-evaluate cross-selling or marketing strategies (decision could be make like getting rid if these less sellable products while focusing on 'Bikes' or reviewing the structure of these two products, something must be weak in order to have such statistics).
