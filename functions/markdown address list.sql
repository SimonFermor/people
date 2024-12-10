  select  
    CONCAT('| ',ifnull(p.known_name, p.first_name), ' ',IFNULL(p.last_name, ''), ' | ',
    ifnull(b.address_1, ''), ' <br /> ', ifnull(b.address_2,''), ' ',ifnull(b.address_3,''), '<br />',
	 ifnull(b.city,''), ' <br />', ifnull(b.region, ''), '<br />',ifnull(b.postal_code,''), ifnull(b.country, ''), ' |') AS details
  from people.group_people as g

  inner join people.people as p
  on p.id = g.person_id

 inner join
 (SELECT p2.person_id, p2.address_id,
      a.address_1, a.address_2, a.address_3, a.city,
      a.region, a.postal_code, c.title as country
    from people.people_addresses AS p2

    inner join addresses.addresses as a
    ON p2.address_id = a.id

    left outer join addresses.country_codes as c
    on c.id = a.country_id
	 WHERE p2.closed_at IS null
	 AND p2.is_primary =1) AS b

   on p.id = b.person_id

  where g.group_id = 1
  and p.date_of_death is null
  and g.departed_at is null

  order by ifnull(p.known_name, p.first_name), last_name
  