<html>
<head>
	<title>Birthdays</title>
	<link rel="stylesheet" href="/recipes/styles.css">
</head>
<body>

<cfparam name="year" default = "#year(now()) + 1#">
<cfparam name="favorites" default=0>
<cfparam name="start_at" default = "#createdate(year, 1, 1)#">
<cfparam name="group_id" default = "17">

<!--- Birthdays --->
<cfquery name="birthdays" datasource="people">
  select p.id, p.first_name, p.last_name, ifnull(p.date_of_birth, 0) as date_of_birth, 
	ifnull(p.known_name, p.first_name) as known_name, month(p.date_of_birth) as month_number
	from group_people as g
	inner join people as p
	on g.person_id = p.id
	where (g.group_id = #group_id#)
	and p.id not in (190)
  order by month(p.date_of_birth), day(p.date_of_birth)
</cfquery>

<cfquery name="monthly_count" dbtype="query">
	select month_number, count(id) as birthday_count
	from birthdays
	group by month_number;
</cfquery>

<!---
<cfdump var="#monthly_count#">
--->

<cfoutput>
<h2><cfoutput>#year#</cfoutput> Birthdays</h2>
</cfoutput>

<cfset current_month_number = 0>

<table>
	<tr><th>Month</th><th>Day</th><th>Age</th><th>Name</th></tr>
  <cfoutput query = "birthdays">
  <cfset age = datediff("yyyy", birthdays.date_of_birth, start_at) + 1>
  <cfif month(birthdays.date_of_birth) neq current_month_number>
    <cfset current_month_number = month(birthdays.date_of_birth)>
	<cfloop query="monthly_count">
		<cfif monthly_count.month_number eq current_month_number>
			<cfset current_count = monthly_count.birthday_count>
		</cfif>
	</cfloop>
    <tr >
    	<td rowspan="#current_count#" class="table_heading">#dateformat(birthdays.date_of_birth, "mmmm")#</td>
  </cfif>

    <cfset day_this_year = createdate("#year#", "#month(date_of_birth)#", "#day(date_of_birth)#")>
    <td>#dateformat(day_this_year, "dddd")# #day(birthdays.date_of_birth)#</td>
    <td><cfif age lt 100>#age#</cfif></td>
    <td>#birthdays.known_name# #birthdays.last_name#</td>
  </tr>
</cfoutput>
</table>

<!---
<cfinclude template="include.inc">
--->
</body>

</html>
<!---
</cfcache>
--->
