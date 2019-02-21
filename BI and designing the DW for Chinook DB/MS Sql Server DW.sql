

-- question 1
Select sum(UnitPrice*Quantity) as TotalSales from invoiceline;

-- question 2
select customer.Country, sum(UnitPrice*Quantity) as TotalSales from customer
inner join invoice on invoice.CustomerId= customer.CustomerId
inner join invoiceline on invoiceline.InvoiceId= invoice.InvoiceId
group by customer.Country
order by TotalSales desc;

-- question 3
select customer.Country,customer.City,
isnull(customer.City,
customer.State) as State,sum(UnitPrice*Quantity) as TotalSales
from customer inner join invoice on invoice.CustomerId= customer.CustomerId
inner join invoiceline on invoiceline.InvoiceId= invoice.InvoiceId
group by Customer.Country,Customer.State,customer.City with rollup
order by Customer.Country;

-- question 4
select CONCAT([LastName], ' ', [FirstName]) as CustomerName, sum(UnitPrice*Quantity) as TotalSales from customer
inner join invoice on invoice.CustomerId= customer.CustomerId
inner join invoiceline on invoiceline.InvoiceId= invoice.InvoiceId
group by CONCAT([LastName], ' ', [FirstName])
order by TotalSales desc;

-- question 5
select artist.Name, sum(invoiceline.UnitPrice*invoiceline.Quantity) as TotalSales from invoiceline
inner join track on track.TrackId= invoiceline.TrackId
inner join album on album.AlbumId =track.AlbumId
inner join artist on album.ArtistId=artist.ArtistId
group by artist.Name
order by TotalSales desc;

-- question 6
select artist.Name, album.Title,sum(invoiceline.UnitPrice*invoiceline.Quantity) as TotalSales from invoiceline
inner join track on track.TrackId= invoiceline.TrackId
inner join album on album.AlbumId =track.AlbumId
inner join artist on album.ArtistId=artist.ArtistId
group by artist.Name,album.Title
order by TotalSales desc;


-- question 7
select 
CONCAT(employee.LastName, ' ', employee.FirstName) as EmployeeName, sum(invoiceline.UnitPrice*invoiceline.Quantity) as TotalSales,
count(invoiceline.Quantity) as Quantity,
case
when (datediff(YEAR,employee.BirthDate,CURRENT_TIMESTAMP)) > 39 and (datediff(YEAR,employee.BirthDate,CURRENT_TIMESTAMP)) < 50 Then '47-49'
when (datediff(YEAR,employee.BirthDate,CURRENT_TIMESTAMP)) > 50 Then '50+'
end as AgeGroup from employee 
inner join Customer on customer.SupportRepId=employee.EmployeeId
inner join invoice on invoice.CustomerId=customer.CustomerId
inner join invoiceline on invoiceline.InvoiceId = invoice.InvoiceId
where employee.Title='Sales Support Agent'
group by CONCAT(employee.LastName, ' ', employee.FirstName),Employee.BirthDate
order by TotalSales desc;

-- question 8
select mediatype.Name, count(invoiceline.Quantity) as Quantity,sum(invoiceline.UnitPrice*invoiceline.Quantity) as TotalSales
from invoiceline inner join track on track.TrackId =invoiceline.TrackId
inner join mediatype on mediatype.MediaTypeId= track.MediaTypeId
group by mediatype.Name
order by mediatype.Name desc;

