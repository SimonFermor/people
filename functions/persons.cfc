<cfcomponent>
<cffunction name="people" access="remote">
<cfquery name="people" datasource="people">
  select g2.*, p.id as person_id, ifnull(p.known_name, p.first_name) as first_name, p.last_name, p.known_name, p.date_of_birth
  from groups as g1
  inner join group_people as g2
  on g1.id = g2.group_id
  inner join people as p 
  on p.id = g2.person_id
  where g1.id = 9
  order by first_name, last_name
</cfquery>

<style type="text/css">
  table{
    border-collapse: collapse;
    border: 1px solid black;
  }
  table td{
    border: 1px solid black;
  }
</style>

<body style="font-family: sans-serif;">
<table>

<cfoutput query="people">
<tr>
  <td>#first_name#</td>
  <cfquery name="phones" datasource="people">
    select *
    from people_phones as p
    inner join phone_types as t
    on p.phone_type_id = t.id
    where person_id = '#people.person_id#'
    order by t.phone_type
  </cfquery>
  <td>
  <cfif phones.recordCount gt 0>
    <cfloop query="phones">
      <cfif phones.currentRow gt 1><br></cfif>
      #phones.phone_type#: +#phones.country_code# #phones.area_code# #phones.phone_number#
    </cfloop>
  </cfif>
  </td>
</tr>
</cfoutput>
</table>
</body>

</cffunction>
</cfcomponent>