select e.FirstName
		,e.LastName
		,o.Name as Organization
from Employee e
left join Organization o on o.OrganizationID = e.OrganizationID
--
select e.FirstName
		,e.LastName
		,o.Name as Organization
from Employee e
inner join Organization o on o.OrganizationID = e.OrganizationID
--
select o.Name as Organization
		,a.City
		,a.ZipCode
		,a.StreetAddress
from Organization o
right join Address a on a.OrganizationID = o.OrganizationID
--
select e.FirstName
		,e.LastName
		,p.ProjectName
from Employee e
left join EmployeeProject ep on ep.EmployeeID = e.EmployeeID
left join Project p on p.ProjectID = ep.ProjectID
--
select e.FirstName
		,e.LastName
		,p.ProjectName
from Employee e
cross join Project p