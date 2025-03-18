-- Найти всех сотрудников, подчиняющихся Ивану Иванову с EmployeeID = 1, включая их подчиненных и подчиненных подчиненных.
-- Для каждого сотрудника вывести следующую информацию:

WITH RECURSIVE employee_hierarchy AS (
    SELECT  e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
    FROM Employees e
    WHERE e.EmployeeID = 1

    UNION ALL

    SELECT  e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
    FROM Employees e
             INNER JOIN employee_hierarchy eh ON e.ManagerID = eh.EmployeeID
)

SELECT  eh.EmployeeID, eh.Name AS EmployeeName, eh.ManagerID, d.DepartmentName, r.RoleName,
        string_agg(DISTINCT p.ProjectName, ', ') AS ProjectsNames,
        string_agg(DISTINCT t.TaskName, ', ') AS TasksNames,
        COUNT(DISTINCT t.TaskID) AS TotalTasks,
        COUNT(DISTINCT sub.EmployeeID) AS TotalSubordinates
FROM employee_hierarchy eh
         LEFT JOIN Departments d ON eh.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON eh.RoleID = r.RoleID
         LEFT JOIN Projects p ON p.DepartmentID = eh.DepartmentID
         LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
         LEFT JOIN Employees sub ON eh.EmployeeID = sub.ManagerID
GROUP BY eh.EmployeeID, eh.Name, eh.ManagerID, d.DepartmentName, r.RoleName
ORDER BY eh.Name;