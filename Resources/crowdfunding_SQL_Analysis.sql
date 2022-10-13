-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT sum(backer_count), cf_id
FROM campaign
where outcome = 'live'
group by cf_id
ORDER BY sum(backer_count) DESC


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT distinct(count(backer_id)), cf_id
from backers
group by cf_id
ORDER BY count(backer_id) DESC


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT ct.first_name, ct.last_name, ct.email, (c.goal-c.pledged) as Remaining_Goal_Amount
INTO email_contacts_remaining_goal_amount
FROM contacts as ct
LEFT JOIN campaign as c
on ct.contact_id = c.contact_id
where c.outcome='live'
order by Remaining_Goal_Amount DESC



-- Check the table
select * from email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT b.email, b.first_name, b.last_name,b.cf_id,c.company_name, c.description,
	c.end_date, (c.goal-c.pledged) AS Left_of_Goal
INTO email_backers_remaining_goal_amount
FROM backers as b
LEFT JOIN campaign as c
ON b.cf_id = c.cf_id
WHERE c.outcome='live'
ORDER BY b.last_name, b.email

drop table email_backers_remaining_goal_amount
-- Check the table
SELECT * FROM email_backers_remaining_goal_amount

