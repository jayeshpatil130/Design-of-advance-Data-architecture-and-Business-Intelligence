--question 1
select sum(total) as Total_Sales 
from invoice;

--question 2
select customer.Country, sum(UnitPrice*Quantity) as TotalSales from customer
inner join invoice on invoice.CustomerId= customer.CustomerId
inner join invoiceline on invoiceline.InvoiceId= invoice.InvoiceId
group by customer.Country
order by TotalSales desc;
--question 3
select customer.Country,NVL(customer.City,
customer.State) as State,customer.City,sum(UnitPrice*Quantity) as TotalSales
from customer inner join invoice on invoice.CustomerId= customer.CustomerId
inner join invoiceline on invoiceline.InvoiceId= invoice.InvoiceId
group by rollup (customer.Country,customer.State,customer.City) 
order by customer.Country;

--question 4
select  Customer.LastName||','||Customer.FirstName as CustomerName, sum(total) as total_sales
from Customer 
inner join Invoice on Customer.CustomerId = Invoice.CustomerId 
group by  Customer.LastName||','||Customer.FirstName
order by total_sales desc;

--question 5
select artist.artistid,artist.name,sum(quantity*invoiceline.unitprice)as unitprice
from artist 
inner join album on artist.artistid=album.artistid
inner join track on album.albumid=track.albumid
inner join invoiceline on track.trackid=invoiceline.trackid
inner join invoice on invoiceline.invoiceid=invoice.invoiceid
group by artist.artistid,artist.name
order by unitprice desc;


--question 6
select album.title,sum(quantity*invoiceline.unitprice)as unitprice
from artist
inner join album on artist.artistid=album.artistid
inner join track on album.albumid=track.albumid
inner join invoiceline on track.trackid=invoiceline.trackid
group by album.title
order by unitprice desc;

--question 7
with t1 as(select employee.employeeid,
case 
when 
floor(months_between(current_date,employee.birthdate)/12)>39 and floor(months_between(current_date,employee.birthdate)/12)<50
then '40-49'
when floor(months_between(current_date,employee.birthdate)/12)>49 then '50+'
end as agegroup from employee),
t2 as
(select e.employeeid,e.firstname,e.lastname,sum(l.unitprice)as sales,count(l.invoicelineid)as invcount
from employee e
join customer c on e.employeeid=c.supportrepid 
join invoice i on i.customerid=c.customerid
join invoiceline l on l.invoiceid=i.invoiceid
group by e.employeeid,e.firstname,e.lastname)
select t2.firstname,t2.lastname,t2.sales,t2.invcount,t1.agegroup
from t1 join t2 on t1.employeeid=t2.employeeid
group by t2.firstname,t2.lastname,t2.sales,t2.invcount,t1.agegroup
order by sales desc;

--qusetion 8

select MediaType.Name, sum(Quantity*InvoiceLine.UnitPrice) as total_sales 
from MediaType 
left join Track on MediaType.MediaTypeId = Track.MediaTypeId
join InvoiceLine on Track.TrackId = InvoiceLine.TrackId 
group by MediaType.Name
ORDER BY MediaType.Name; 


