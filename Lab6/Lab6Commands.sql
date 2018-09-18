#1
	SELECT * 
	FROM store
	ORDER BY sname ASC;

#2
	SELECT *
	FROM store
	ORDER BY sname ASC
	LIMIT 3;

#3 
	SELECT * 
	FROM (SELECT * 
		FROM store 
		ORDER BY sname DESC 
		LIMIT 3) as data1
		ORDER BY sname ASC;
#4
	SELECT *
	FROM store
	WHERE price > 1;

#5
	SELECT sname, ROUND(qty * price, 2) AS 'extprice'
	FROM store;

#6
	SELECT SUM(price)
	FROM store;

#7
	SELECT COUNT(DISTINCT sname)
	FROM store;

#8
	SELECT *
	FROM course
	WHERE department_id = 1;

#9
	SELECT SUM(count)
	FROM enrollment;

#10
	SELECT COUNT(DISTINCT cname)
	FROM course;

#11
	SELECT COUNT(DISTINCT name)
	FROM department;

#12
	SELECT CONCAT(department.name, course.cname) as fullname
	FROM department
		INNER JOIN
		course
		ON department.id=course.department_id
		WHERE department.name='CSC';

#13
	SELECT GROUP_CONCAT(department.name, course.cname) as fullname
	FROM department
		INNER JOIN
		course
		ON department.id=course.department_id;

#14
	SELECT department.name as department, course.cname as course, enrollment.count as enrollment
	FROM department
		INNER JOIN
		course
		ON department.id=course.department_id
		INNER JOIN
		enrollment
		ON department.id=enrollment.id;

