-- Select the database to use
USE db_course_conversions;

-- Main Query: Calculate conversion rate, average registration-to-watch duration, 
-- and average watch-to-purchase duration
SELECT 
    -- Calculate the conversion rate as the percentage of students who made a purchase
    ROUND(
        COUNT(DISTINCT CASE WHEN first_date_purchased IS NOT NULL THEN student_id END) /
        COUNT(DISTINCT student_id) * 100,  -- Conversion formula: (students who purchased / total students) * 100
        2
    ) AS conversion_rate,
    
    -- Calculate the average number of days between registration and first content watch
    ROUND(
        SUM(date_diff_reg_watch) /  -- Sum of all registration-to-watch durations
        COUNT(DISTINCT student_id), -- Total number of students
        2
    ) AS av_reg_watch,
    
    -- Calculate the average number of days between first content watch and first purchase
    ROUND(
        SUM(date_diff_watch_purch) / -- Sum of all watch-to-purchase durations
        COUNT(date_diff_watch_purch), -- Count only records where watch-to-purchase duration exists
        2
    ) AS av_watch_purch
FROM (
    -- Subquery: Gather data on registration, engagement, and purchase dates for each student
    SELECT 
        i.student_id, -- Unique identifier for each student
        i.date_registered, -- Registration date for the student
        MIN(e.date_watched) AS first_date_watched, -- First content watch date
        COALESCE(MIN(p.date_purchased), NULL) AS first_date_purchased, -- First purchase date (or NULL if none exists)
        
        -- Calculate the number of days between registration and first content watch
        ABS(DATEDIFF(i.date_registered, MIN(e.date_watched))) AS date_diff_reg_watch,
        
        -- Calculate the number of days between first content watch and first purchase
        ABS(DATEDIFF(MIN(e.date_watched), COALESCE(MIN(p.date_purchased), NULL))) AS date_diff_watch_purch
    FROM
        student_info AS i -- Main student information table
        JOIN
        student_engagement AS e ON i.student_id = e.student_id -- Join to engagement data
        LEFT JOIN
        student_purchases AS p ON i.student_id = p.student_id -- Left join to purchase data (optional)
    GROUP BY 
        i.student_id, i.date_registered -- Group by student ID and registration date
    HAVING
        -- Ensure the first watch date is on or before the first purchase date
        MIN(e.date_watched) <= COALESCE(MIN(p.date_purchased), MIN(e.date_watched))
) T; -- End of subquery

-- Additional Query: Retrieve the first watched and purchased dates for a specific student
SELECT 
    MIN(student_engagement.date_watched) AS first_date_watched, -- First date the student watched content
    MIN(student_purchases.date_purchased) AS first_date_purchased -- First date the student made a purchase
FROM 
    student_engagement
LEFT JOIN 
    student_purchases ON student_engagement.student_id = student_purchases.student_id -- Join engagement and purchase data
WHERE 
    student_engagement.student_id = 268727; -- Filter for a specific student by ID
