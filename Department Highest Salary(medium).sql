SELECT d.Name as Department, c.Name as Employee, c.salary as Salary FROM
Department as d, (SELECT a.* 
from employee as a, 
(SELECT MAX(Salary) as salary, DepartmentId FROM Employee Group By DepartmentId) as b
WHERE a.salary = b.salary and a.DepartmentId = b.DepartmentId) as c
WHERE c.DepartmentId = d.Id;