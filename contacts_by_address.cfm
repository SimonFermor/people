<cfparam name="group_id" default="1">

<cfquery name="groups" datasource="people">
	select *
	from groups
	where id = '#group_id#';
</cfquery>

<cfset group_name = groups.name[1]>

<html>
<head>
	<title><cfoutput>#group_name#</cfoutput></title>
	<link rel="stylesheet" href="/recipes/styles.css">
</head>
<body>

<cfquery name="address_groups" datasource="people">
	select p2.address_id, min(ifnull(p.known_name, p.first_name)) as contact_name
	from group_people as g

	inner join people as p
	on g.person_id = p.id

	left outer join people_addresses as p2 
	on p.id = p2.person_id

	where g.group_id = '#group_id#'
	group by p2.address_id
	order by contact_name;
</cfquery>

<!---
<cfdump var="#address_groups#">
--->

<cfoutput>
<h2><cfoutput>#group_name#</cfoutput></h2>
</cfoutput>

<cfloop query="address_groups">
<cfquery name="address" datasource="people">
	select *
	from places.addresses
	where id = '#address_groups.address_id#';
</cfquery>

<cfquery name="address_people" datasource="people">
  select x.address_id,
		p.id, p.first_name, p.last_name, ifnull(p.date_of_birth, 0) as date_of_birth,
		ifnull(p.known_name, p.first_name) as known_name, month(p.date_of_birth) as month_number
	from people_addresses as x

	inner join people as p
	on x.person_id = p.id

	where (x.address_id ='#address_groups.address_id#')
  order by ifnull(p.known_name, p.first_name)
</cfquery>

<div>
<cfoutput>
<b>#valuelist(address_people.known_name,', ')#</b>

<div>
	<cfquery name="address" datasource="people">
		select *
		from places.addresses
		where id = '#address_people.address_id#';
	</cfquery>
<div>

<div>
	#address.address_1#
</div>

<cfif address.address_2 neq "">
<div>
	#address.address_2#
</div>
</cfif>

<cfif address.address_3 neq "">
<div>
	#address.address_3#
</div>
</cfif>

<cfif address.city neq "">
<div>
	#address.city#
</div>
</cfif>

<cfif address.postal_code neq "">
<div>
	#address.postal_code#
</div>
</cfif>

</cfoutput>
<div>

<hr>

</cfloop>

<!---
<cfinclude template="include.inc">
--->
</body>

</html>
