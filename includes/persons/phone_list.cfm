<cfparam name="group_id" default="1">
<cfparam name="incomplete_only" default="1">

<cfquery name="groups" datasource="people">
	select id, name, description
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

<cfoutput>
<h2><cfoutput>#group_name#</cfoutput></h2>
</cfoutput>

<cfquery name="people" datasource="people">
	select p.id as person_id, 
    p.by_line,
    p.first_name, 
    p.known_name, 
    p.last_name,
    p2.area_code as landline_area_code, 
    p2.country_code as landline_country_code, 
    p2.phone_number as landline_phone_number,
    p3.area_code as cell_area_code, 
    p3.country_code as cell_country_code, 
    p3.phone_number as cell_phone_number,
    e.email
	from group_people as g

  inner join people as p
  on g.person_id = p.id

  left join 
  (select *
  from people_phones
  where phone_type_id = 1
  and closed_at is null) as p2
  on p.id = p2.person_id

  left join 
  (select person_id, phone_number, country_code, area_code
  from people_phones
  where phone_type_id = 2
  and closed_at is null) as p3
  on p.id = p3.person_id

  left join (select person_id, email from people_email where `primary` = 1) as e
  on p.id = e.person_id

	where g.group_id = '#group_id#'
  and (p.date_of_birth < '2006-08-01' or p.date_of_birth is null)

  order by ifnull(known_name, first_name), last_name;
</cfquery>

<table>
  <tr>
    <td><b>ID #</b></td>
    <td><b>Name</b></td>
    <td><b>Mobile</b></td>
    <td><b>Landline</b></td>
    <td><b>Email</b></td>
    <td><b>Connection</b></td>    
  </tr>
  <cfoutput query="people">
    <cfif (incomplete_only eq "1" and people.email eq "") or incomplete_only neq "1">
      <tr>
        <td>#people.person_id#</td>
        <td><cfif people.known_name neq "">#people.known_name#<cfelse>#people.first_name#</cfif> #people.last_name#</td>
        <td><cfif people.cell_phone_number eq "">None<cfelse>+#people.cell_country_code# #people.cell_area_code# #people.cell_phone_number#</cfif></td>
        <td><cfif people.landline_phone_number eq "">None<cfelse>+#people.landline_country_code# #people.landline_area_code# #people.landline_phone_number#</cfif></td>
        <td>#people.email#</td>
        <td>#people.by_line#</td>
      </tr>
</cfif>
  </cfoutput>
</table>

<hr>
</body>

</html>
