<cfparam name="group_id" default="1">
<cfparam name="column_count" default="4">

<cfset column_counter = "">

<!--- Get group details --->
<cfset group = new people.functions.queries.groups().group(group_id)>
<cfset group_name = group.name[1]>

<h2><cfoutput>#group_name#</cfoutput></h2>

<!--- Get people in the group --->
<cfset group_people = new people.functions.queries.groups().group_people(group_id)>

<div class="div_table">
<div class="div_table_body">

  <!--- Table Header --->
  <div class="div_table_row">
    <div class="div_table_cell">
    </div>
    <div class="div_table_cell">
      <b>Name</b>
    </div>
    <div class="div_table_cell">
      <b>Cell &amp;Email</b>
    </div>
    <div class="div_table_cell">
      <b>Label Heading</b>
    </div>   
    <div class="div_table_cell">
    </div>
    <div class="div_table_cell">
      <b>Address</b>
    </div>
  </div>

<cfloop query="group_people">
  <!--- Addresses for one people --->
  <cfset addresses = new people.functions.queries.person().addresses(group_people.people_id)>

  <!--- Phone numbers for one people --->
  <cfset phones = new people.functions.queries.person().phone_numbers(group_people.people_id)>

  <!--- Email addresses for one people --->
  <cfset emails = new people.functions.queries.person().email_addresses(group_people.people_id)>

  <cfoutput>
  <div class="div_table_row">
    <!--- Output name --->
    <div class="div_table_cell">
      <div>
        <b>#group_people.people_id#</b>
      </div>
    </div>    
    <div class="div_table_cell">
      <div>
        <b>#group_people.known_name# #group_people.last_name#</b>
      </div>
    </div>

    <!--- Output phone numbers --->
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

    <!--- Output label heading --->
    <div class="div_table_cell">
      <div>
          <div>#group_people.mailing_label_name#</div>
      </div>
    </div>

    <!--- Output address --->
    <div class="div_table_cell">
      <div>
          <div>#addresses.address_id#</div>
      </div>
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
