# 📊 Statistical Analysis

This phase dives deeper into the data using statistical methods to test hypotheses and uncover relationships that were only suggested during the exploratory phase.

We applied **frequentist and Bayesian statistical tests**, as well as **interaction-based regression analysis**, to evaluate the impact of holidays, store type, CPI, and departments on weekly sales.

---

## 🧪 T-Test: Holiday vs Non-Holiday Sales

A Welch Two-Sample T-Test was performed to evaluate if weekly sales differ significantly between holidays and non-holidays.

```data: Weekly_Sales by IsHoliday
t = -7.0007, df = 32752, p-value = 2.595e-12
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
-1451.9763 -816.7799
sample estimates:
mean in group FALSE mean in group TRUE
15901.45 17035.82
```

This result is **statistically significant** and aligns with retail expectations — holidays drive sales.

---

## 🧬 Two-Way ANOVA: Store Type * Holiday

Two-way ANOVA to examine the individual and interaction effects of **Store Type** and **Holiday** on sales.
Both **Store Type** and **Holiday** independently influence sales, and there’s a **significant interaction** effect — meaning holiday impact **depends on the store type**.

---

## 🧠 Bayesian T-Test

To strengthen the conclusions from the t-test, a Bayesian t-test was run using the `BayesFactor` package.
```
Bayes Factor ≈ 5.88e+12
```
The Bayes Factor offers **overwhelming evidence** in favor of a difference between holiday and non-holiday sales. This supports the t-test findings from a Bayesian perspective.

---

## 📈 Posterior Distribution: Mean Difference

A posterior distribution was sampled to estimate the mean difference in weekly sales.

The plot showed a **high-density region** above 15,000, indicating strong confidence that **holiday sales are higher**, with most of the posterior mass lying far from zero.

---

## 🔁 Regression Interaction Plots

Two regression interaction plots were generated to explore how variable interactions influence sales.

### 🏪 CPI × Store Type

![CPI vs Store Type](https://github.com/temidataspot/project-smartsell/blob/main/Statistical%20Analysis/RegresnAnalysisInteractn_CPIStoreType_DeptHoliday.png)

- **Store A:** Weekly Sales ≈ 19,500 @ CPI 225  
- **Store B:** ≈ 15,500 @ CPI 225  
- **Store C:** ≈ 7,000 @ CPI 224  

Higher CPI values affect all store types, but large stores (like Store A) are better at **absorbing inflationary pressure**, possibly due to scale and inventory flexibility.

---

### 🛒 Department × Holiday

- **Holiday:** Weekly Sales ≈ 4,000 @ Department 100  
- **Non-Holiday:** ≈ 2,000 @ Department 100  

Holidays double the weekly sales in some departments, showing **strong seasonality effects**. This is crucial for **inventory, staffing, and promotional strategies**.

---

## 📂 Files Included

- [`stat_analysis.R`](https://github.com/temidataspot/project-smartsell/blob/main/Statistical%20Analysis/stat%20analysis.R): R script with all statistical analysis code.
---

## 🧩 Summary

- Holidays significantly and positively impact weekly sales — across store types and departments.
- Store type **moderates** how external factors like CPI affect performance.
- Bayesian and frequentist results agree, increasing confidence in our conclusions.
- Interaction effects matter — and should be carefully modeled going forward.

These findings are essential for **forecasting**, **strategy**, and **resource planning**.

---






