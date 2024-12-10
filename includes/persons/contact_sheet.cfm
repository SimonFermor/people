<cfparam name="group_id" default="1">
<cfparam name="column_count" default="4">

<cfset column_counter = "">

<!--- Get group details --->
<cfquery name="groups" datasource="people">
	select *
	from groups
	where id = '#group_id#';
</cfquery>

<cfset group_name = groups.name[1]>

<html>
  <head>
    <title><cfoutput>#group_name#</cfoutput></title>
    <link rel="stylesheet" href="/recipes/styles.css?test">
  </head>
  <body>

<h2><cfoutput>#group_name#</cfoutput></h2>

<!--- Get group people --->
<cfquery name="people" datasource="people">
  select p.id as person_id, first_name, middle_names, last_name, 
    ifnull(p.known_name, p.first_name) as known_name, by_line,
    date_of_birth
  from people.people as p
  inner join people.group_people as g
  on p.id = g.person_id
  where g.group_id = '#group_id#'
  order by ifnull(p.known_name, p.first_name), last_name
</cfquery>

<div class="div_table">
<div class="div_table_body">

<cfloop query="people">
  <cfquery name="addresses" datasource="people">
    select p.person_id, p.address_id,
      a.address_1, a.address_2, a.address_3, a.city,
      a.postal_code, c.title as country
    from people_addresses as p

    inner join addresses.addresses as a
    on p.address_id = a.id

    left outer join addresses.country_codes as c
    on c.id = a.country_id

    where p.person_id = #people.person_id#
      and closed_at is null
      and is_primary = 1;
  </cfquery>

  <cfquery name="phones" datasource="people">
    select p.country_code, p.area_code, p.phone_number, t.phone_type
    from people_phones as p
	
    left outer join phone_types as t
    on p.phone_type_id = t.id

    where p.person_id = #people.person_id#
    and p.show = 1;
  </cfquery>

  <cfquery name="emails" datasource="people">
    select e.email
    from people.people_email as e
    where e.person_id = #people.person_id#
    and e.primary = 1;
  </cfquery>

  <cfoutput>
    <cfif column_counter eq "#column_count#">
      </div>
      <div class="div_table_row">
    </cfif>

    <cfif column_counter eq "">
      <div class="div_table_row">
      <cfset column_counter = "1">
    <cfelse>
      <cfif column_counter eq "#column_count#">
        <cfset column_counter = "1">
      <cfelse>
        <cfset column_counter = column_counter + 1>
      </cfif>
  </cfif>

    <div class="div_table_cell">
      <div><!---#people.person_id#---><b>#people.known_name# #people.last_name#</b></div>
      <!---<div>#people.by_line#</div>
      <div>Birthday: #dateformat(people.date_of_birth, "d mmmm")#</div>--->
      <cfloop query="phones">
        <div>#phones.phone_type#: +#phones.country_code# #phones.area_code# #phones.phone_number#</div>
      </cfloop>
      <!---<cfloop query="emails">
        <div>#emails.email#</div>
      </cfloop>--->
      <div>&nbsp;</div>
      <div>
        <cfloop query="addresses">
          <div>#addresses.address_1#</div>
          <cfif addresses.address_2 neq ""><div>#addresses.address_2#</div></cfif>
          <cfif addresses.address_3 neq ""><div>#addresses.address_3#</div></cfif>
          <cfif addresses.city neq ""><div>#addresses.city#</div></cfif>
          <cfif addresses.postal_code neq ""><div>#addresses.postal_code#</div></cfif>
          <cfif addresses.country neq ""><div>#addresses.country#</div></cfif>
        </cfloop>
      </div>
    </div>
  </cfoutput>
</cfloop>

</div>
</div>
</div>

<h2>Birthdays</h2>
<cfquery name="birthdays" datasource="recipes">
    select p.id as person_id, first_name, middle_names, last_name, 
    ifnull(p.known_name, p.first_name) as known_name, by_line,
    date_of_birth, month(date_of_birth) as birth_month, 
    day(date_of_birth) as birth_day
  from people.people as p
  inner join people.group_people as g
  on p.id = g.person_id
  where g.group_id = '#group_id#'
  and date_of_birth is not null
  order by month(date_of_birth), day(date_of_birth);
</cfquery>

<br />
<!--- <cfdump var="#birthdays#"> --->
<table style="width: 100%;">
  <tr>
    <th style="width: 16.5%;">January</th>
    <th style="width: 16.5%;">February</th>
    <th style="width: 16.5%;">March</th>
    <th style="width: 16.5%;">April</th>
    <th style="width: 16.5%;">May</th>
    <th style="width: 16.5%;">June</th>
  </tr>
  <cfloop from="1" to="12" step="1" index="current_month">
    <cfif current_month eq "7">
    </tr>
    <tr>
      <th>July</th>
      <th>August</th>
      <th>September</th>
      <th>October</th>
      <th>November</th>
      <th>December</th>
    </tr>
    <tr>
    </cfif>
    <td>
      <cfoutput query="birthdays">
        <cfif birthdays.birth_month eq current_month>
          #birthdays.birth_day#: #birthdays.known_name#<br>
        </cfif>
      </cfoutput>
    </td>
  </cfloop>
</table>
<cfoutput>Group ID: #group_id#</cfoutput>
<!--- <cfinclude template="include.inc"> --->
</body>

</html>
