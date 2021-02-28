create table departments(
	dept_number VARCHAR(10) NOT NULL,
	dept_employee VARCHAR(40) NOT NULL
);


create table dept_emp (
	employee_number INT NOT NULL,
	dept_number VARCHAR(10) NOT NULL
);

create table dept_manager (
	dept_number VARCHAR(10) NOT NULL,
	employee_number INT NOT NULL
);

create table employees (
	employee_number INT PRIMARY KEY,
	employee_title_id VARCHAR(10) NOT NULL,
	birth_date VARCHAR(15) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(4) NOT NULL,
	hire_date VARCHAR(15) NOT NULL
);

create table salaries (
	employee_number INT NOT NULL,
	salary INT NOT NULL
);

create table titles (
	title_id VARCHAR(10) NOT NULL,
	title VARCHAR(40) NOT NULL
);

copy departments(dept_number, dept_employee) FROM '/data/departments.csv' DELIMITER ',' CSV HEADER;
copy dept_emp(employee_number, dept_number) FROM '/data/dept_emp.csv' DELIMITER ',' CSV HEADER;
copy dept_manager(dept_number, employee_number) FROM '/data/dept_manager.csv' DELIMITER ',' CSV HEADER;
copy employees(employee_number, employee_title_id, birth_date, first_name, last_name, sex, hire_date) FROM '/data/employees.csv' DELIMITER ',' CSV HEADER;
copy salaries(employee_number, salary) FROM '/data/salaries.csv' DELIMITER ',' CSV HEADER;
copy titles(title_id, title) FROM '/data/titles.csv' DELIMITER ',' CSV HEADER;

--Step 1:
select employees.employee_number, employees.last_name, employees.first_name, employees.sex, salaries.salary from employees left outer join salaries on employees.employee_number = salaries.employee_number

--Step 2:
select * from employees where right(hire_date, 4) = '1986';

--Step 3:
select employees.last_name, employees.first_name, salaries.salary, titles.title from employees left outer join salaries on employees.employee_number = salaries.employee_number left outer join titles on titles.title_id = employees.employee_title_id where title = 'Manager'

--Step 4:
select employees.employee_number, employees.last_name, employees.first_name, departments.dept_employee from employees left outer join dept_emp on employees.employee_number = dept_emp.employee_number left outer join departments on dept_emp.dept_number = departments.dept_number

--Step 5:
select first_name, last_name, sex from employees where first_name = 'Hercules' and left(last_name, 1) = 'B'

--Step 6:
select employees.employee_number, employees.first_name, employees.last_name, departments.dept_employee from employees left outer join dept_emp on employees.employee_number = dept_emp.employee_number left outer join departments on dept_emp.dept_number = departments.dept_number where dept_employee = 'Sales'

--Step 7:
select employees.employee_number, employees.first_name, employees.last_name, departments.dept_employee from employees left outer join dept_emp on employees.employee_number = dept_emp.employee_number left outer join departments on dept_emp.dept_number = departments.dept_number where dept_employee in ('Sales', 'Development')

--Step 8:
select last_name, count(last_name) as surname_count from employees group by last_name order by surname_count desc