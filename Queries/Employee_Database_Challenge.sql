-- Select Employees born between 1952 and 1955
select e.emp_no, 
	e.first_name, 
	e.last_name, 
	t.title, 
	t.from_date, 
	t.to_date
into retirement_titles
from employees as e
inner join titles as t
    on (e.emp_no = t.emp_no)
where (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

--retrieve the number of employees by their most recent job title who are about to retire.
select count(ut.title), ut.title
into retiring_titles
from unique_titles as ut
group by ut.title
order by count desc

--- Select employees from retirement eligible table for mentorship opportunity 
select distinct on (e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name, 
	e.birth_date, 
	de.from_date,
	de.to_date,
	t.title
into mentorship_eligibilty
from employees as e
inner join dept_emp as de
	on (e.emp_no = de.emp_no)
inner join titles as t
	on (e.emp_no = t.emp_no)
where (e.birth_date between '1965-01-01' and '1965-12-31')
and (de.to_date = '9999-01-01')
order by e.emp_no;

