<cfparam name="group_id" default="1">
<cfparam name="column_count" default="4">

<cfset column_counter = "">

<!--- Get group details --->
<cfquery name="groups" datasource="people">
	select id, name, description
	from groups
	where id = '#group_id#';
</cfquery>

<cfset group_name = groups.name[1]>

<html>
  <head>
    <title><cfoutput>#group_name#</cfoutput></title>
    <link rel="stylesheet" href="styles.css">
  </head>
  <body>

<h2><cfoutput>#group_name#</cfoutput></h2>

<!--- Get people in the group --->
<cfquery name="people" datasource="people">
  select p.id as person_id, first_name, middle_names, last_name, 
    ifnull(p.known_name, p.first_name) as known_name, by_line,
    date_of_birth
  from people.group_people as g

  inner join people.people as p
  on p.id = g.person_id

  where g.group_id = #group_id#
  and p.date_of_death is null
  and g.removed_at is null

  order by ifnull(p.known_name, p.first_name), last_name
</cfquery>

<div class="div_table">
<div class="div_table_body">

  <!--- Table Header --->
  <div class="div_table_row">
    <div class="div_table_cell">
      <b>Name</b>
    </div>
    <div class="div_table_cell">
      <b>Email</b>
    </div>
    <div class="div_table_cell">
      <b>Address</b>
    </div>
  </div>

<cfloop query="people">
  <!--- Addresses for one person --->
  <cfquery name="addresses" datasource="people">
    select p.person_id, p.address_id,
      a.address_1, a.address_2, a.address_3, a.city,
      a.region, a.postal_code, c.title as country
    from people_addresses as p

    inner join addresses.addresses as a
    on p.address_id = a.id

    left outer join addresses.country_codes as c
    on c.id = a.country_id

    where p.person_id = #people.person_id#
      and closed_at is null
      and is_primary = 1;
  </cfquery>

  <!--- Phone numbers for one person --->
  <cfquery name="phones" datasource="people">
    select p.country_code, p.area_code, p.phone_number, t.phone_type
    from people_phones as p
	
    left outer join phone_types as t
    on p.phone_type_id = t.id

    where p.person_id = #people.person_id#
    and p.show = 1
    and p.closed_at is null;
  </cfquery>

  <!--- Email addresses for one person --->
  <cfquery name="emails" datasource="people">
    select e.email
    from people.people_email as e
    where e.person_id = #people.person_id#
    and e.primary = 1;
  </cfquery>

  <cfoutput>
  <div class="div_table_row">
    <div class="div_table_cell">
      <div>
        <b>#people.known_name# #people.last_name#</b>
      </div>
    </div>

    <div class="div_table_cell">
        <cfloop query="phones">
            <div>
              #phones.phone_type#: +#phones.country_code# #phones.area_code# #phones.phone_number#
            </div>
        </cfloop>
        <cfloop query="emails">
          <div>
            #emails.email#
          </div>
        </cfloop>
    </div>

    <div class="div_table_cell">
        <div>
            <cfloop query="addresses">
                <div>#addresses.address_1#</div>
                <cfif addresses.address_2 neq ""><div>#addresses.address_2#</div></cfif>
                <cfif addresses.address_3 neq ""><div>#addresses.address_3#</div></cfif>
                <cfif addresses.city neq ""><div>#addresses.city#</div></cfif>
                <cfif addresses.region neq ""><div>#addresses.region#</div></cfif>
                <cfif addresses.postal_code neq ""><div>#addresses.postal_code#</div></cfif>
                <cfif addresses.country neq ""><div>#addresses.country#</div></cfif>
            </cfloop>
        </div>
    </div>
  </div>
  </cfoutput>
</cfloop>

</div>
</div>
</div>