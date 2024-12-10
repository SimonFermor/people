<cfparam name="keyword_id" default="1">

<!--- Get group details --->
<cfquery name="keywords" datasource="organizations">
	select *
	from keywords
	where id = '#keyword_id#';
</cfquery>

<cfset keyword_name = keywords.name[1]>

<!--- Get group people --->
<cfquery name="organizations" datasource="organizations">
  select o.id, o.name
  from organizations as o
  order by o.name;
</cfquery>

<html>
<head>
	<title>Organizations</title>
	<link rel="stylesheet" href="/recipes/styles.css">
</head>
<body>

<h2><cfoutput>group_name</cfoutput></h2>

<cfoutput query="organizations">
  <div>
    <hr>

    <div style="float: left;">#name#</div>

    <cfquery name="phone_numbers" datasource="organizations">
      select *
      from phones
      where organization_id = '#organizations.id#'
    </cfquery>

    <div style="float: left;">
      <cfloop query="phone_numbers">
        <div>#name# #phone_number#</div>
      </cfloop>
    </div>

    <cfquery name="addresses" datasource="organizations">
      select *
      from addresses as a1
      inner join addresses.addresses as a2
      on a1.address_id = a2.id
      where organization_id = '#organizations.id#';
    </cfquery>

    <div style="float: right;">
      <div>#addresses.address_1#<cfif addresses.address_2 neq "">,
        #addresses.address_2#</cfif><cfif addresses.address_3 neq "">,
        #addresses.address_3#</cfif><cfif addresses.city neq "">,
        #addresses.city#</cfif><cfif addresses.region neq "">,
        #addresses.region#</cfif>
        #addresses.postal_code#</div>
    </div>
  </div>
  <br style="clear: left;"
</cfoutput>

<!--- <cfinclude template="include.inc"> --->
</body>

</html>
