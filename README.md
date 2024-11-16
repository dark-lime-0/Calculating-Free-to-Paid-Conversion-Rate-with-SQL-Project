# Calculating-Free-to-Paid-Conversion-Rate-with-SQL-Project
Calculating the Fraction of Students Who Convert to Paying Ones after Starting a Course free
# Data Source

The data used in this project was obtained from the **365 Data Science platform**.  
This data includes three tables storing information about:

- **Students' registration dates.**
- **Engagement dates.**
- **Subscription purchase dates.**

---

## About 365 Data Science

**365 Data Science** is an online platform offering courses and resources for individuals looking to build skills in data science.  
They provide a comprehensive curriculum covering:

- **Statistics**
- **Programming**
- **Machine Learning**
- **Data Visualization** (e.g., Tableau, Power BI), and more.

---

## Tasks and Objectives

### **Task 1: Data Retrieval and Preparation**
1. **Select columns** to retrieve information on students’ engagement.
2. **Calculate the following:**
   - The difference in days between the registration and first watch dates.
   - The difference in days between the first watch date and the first purchase date.
3. **Left join** the `student_purchases` table to include each student's purchase data (if available).
4. **Filter out records where:**
   - A purchase was never made.
   - Content was watched on or before the first purchase date.

---

### **Task 2: Engagement and Purchasing Metrics**
1. **Conversion Rate:**  
   Calculate the percentage of students who watched content and made a purchase.

2. **Engagement Duration:**  
   Calculate the average number of days between:
   - A student’s registration and their first content watch.
   - A student’s first content watch and their first purchase.

3. **Data Joining:**  
   - Use **left joins** on the `student_purchases` table to retrieve data (if it exists).
   - Alias the subquery as `a` for use in the main query.

---
---
## Interpretation of Results

### **Conversion Rate**
- **Finding:** About **11%** of students who watched lectures made a purchase.
- **Analysis:**
  - Many students register out of curiosity but may not pursue a subscription.
  - Beginner audiences often lack clarity on where to start their data science journey.
  - Customized onboarding introduced in **August 2023** improved user guidance and engagement.

---

### **Average Duration Between Registration and First Engagement**
- **Finding:** It takes students **3–4 days on average** to start watching lectures after registering.
- **Ideal Scenario:** Engagement should ideally start on the **first day**.

---

### **Average Duration Between First Engagement and First Purchase**
- **Finding:** It takes students approximately **24 days on average** to purchase a subscription after their first engagement.
- **Consideration:**
  - Some users may lack time or prefer alternative platforms for their data science learning.
