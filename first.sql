create table gaps (id integer primary key);
insert into gaps (id) select x from generate_series(1, 10000) x;
delete from gaps where id between 102 and 105;
delete from gaps where id between 134 and 176;

with cte as (
select id curval,
       lead(id) over (order by id) nxtval
from gaps
    )
select curval + 1 as from, nxtval - 1 as to
from cte
where (nxtval - curval) > 1 ;

