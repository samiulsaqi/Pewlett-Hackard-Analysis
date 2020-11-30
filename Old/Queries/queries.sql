--updated retirement info with emp no, first & lsat name, hire date and birth date
Select emp_no, first_name, last_name, hire_date,birth_date
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31') 
and (hire_date between '1985-01-01' and '1988-12-31');


--practice with joins
-- Joining departments and dept_manager tables
select d.dept_name,
		dm.emp_no,
		dm.from_date,
		dm.from_date
from departments as d
inner join dept_manager as dm
on d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
select ri.emp_no,
	   ri.first_name,
	   ri.last_name,
	   de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no
where to_date=('9999-01-01');

-- Employee count by department number
select count(ce.emp_no), de.dept_no
into retirement_by_dept_current
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;

select* from retirement_by_dept_current;


--creating new tables for presentation

SELECT * FROM salaries
ORDER BY to_date DESC;


SELECT e.emp_no,e.first_name,e.last_name, e.gender, s.salary,de.to_date
into emp_info
from employees as e
inner join salaries as s
on (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
where (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
and (de.to_date='9999-01-01');


--list of manager per department
select dm.dept_no,
	   d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
into manager_info
from dept_manager as dm
inner join departments as d
	on (dm.dept_no = d.dept_no)
inner join current_emp as ce
	on (dm.emp_no = ce.emp_no)
	
-- update current_emp table
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
--into dept_info
from current_emp as ce
inner join dept_emp as de
	on (ce.emp_no = de.emp_no)
inner join departments as d
	on (de.dept_no = d.dept_no);
	
	
-- Sales retiring
select ce.emp_no, ce.first_name, ce.last_name, d.dept_name
into sales_retiring
from current_emp as ce
inner join dept_emp as de
	on (ce.emp_no = de.emp_no)
inner join departments as d
	on (de.dept_no = d.dept_no)
where d.dept_no = 'd007';

--mentorship

select ce.emp_no, ce.first_name, ce.last_name, d.dept_name
into sales_development_mentorship
from current_emp as ce
inner join dept_emp as de
	on (ce.emp_no = de.emp_no)
inner join departments as d
	on (de.dept_no = d.dept_no)
where d.dept_no in ('d007','d005');