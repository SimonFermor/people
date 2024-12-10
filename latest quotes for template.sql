select q.noted_at, p.first_name, p.last_name, q.quote
from quotes.quotes as q 
inner join people.people as p 
on q.person_id = p.id
where noted_at > '2018-12-31'
order by noted_at desc