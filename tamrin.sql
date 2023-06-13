use test1
--tamrin1
select sum(unitprice)
from saletable
--tamrin2
select COUNT(distinct customer)
from saletable
--tamrin3
select product ,sum(unitprice)
from saletable
group by product
--tamrin4
select customer,sum(unitprice),count(salesid),sum(quantity)
from saletable
where unitprice>1500
group by customer
GO
--tamrin5
with cte
as
(select saletable.product,saleprofit.profitratio,sum((quantity*unitprice)) as s1,sum((quantity*unitprice)*(saleprofit.profitratio/100)) as s2
from saletable
inner join saleprofit
on saletable.product=saleprofit.product
group by saletable.product,saleprofit.profitratio
)
select sum(s1),SUM(s2)
from cte
GO
--tamrin6
select SUM(f) from(
select date,customer, COUNT(distinct customer) as f
from saletable
group by date,customer)as t
--tamrin2
with cte as (
SELECT id,name,manager,manager.managerid,1 as managerlevel
from manager
where managerid is null
      UNION ALL

      SELECT manager.id, manager.managerid,manager.name, cte.managerlevel+1 as managerlevel
from manager join cte
on manager.managerid=cte.id)
select cte.name,cte.managerlevel
from cte
order by cte.managerlevel