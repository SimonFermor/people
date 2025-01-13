<cfscript>
  cfparam(name="scope", default="menu");
  cfparam(name="view", default="menu");

  include "includes/layout/html_start.inc";
  include "includes/layout/head.inc";
  include "includes/layout/body_start.inc";

  menu = {
    "addresses": { 
      "default": "all_addresses", 
      "views": "all_addresses,one_address", 
      "folder": "addresses"},
    "organizations": {
      "default": "all_organizations",
      "views": "all_organizations, one_organization",
      "folder": "organizations"},
    "persons": {
      "default": "all_persons",
      "views": "all_persons,one_person,birthdays,contact_sheet,phone_list",
      "folder": "persons"},
    "quotes": {
      "default": "all_quotes",
      "views": "all_quotes,one_quote",
      "folder": "quotes"}
};

if (scope != "menu") {
  selected_menu = menu["#scope#"];
}

</cfscript>

<main>
  <div class="container">

    <cfif scope eq "menu">
      People
      <ul>
        <li><a href="/people/index.cfm?scope=persons&view=all_persons">All people</a></li>
        <li><a href="/people/index.cfm?scope=persons&view=birthdays">Birthdays</a></li>
        <li><a href="/people/index.cfm?scope=persons&view=phone_list">Phone List</a></li>
        <li><a href="/people/index.cfm?scope=persons&view=contact_sheet">Contact Sheet</a></li>
      </ul>
    <cfelse>
      <cfif listFindNoCase(selected_menu["views"], view)>
        <cfinclude template="includes/#selected_menu["folder"]#/#view#.inc">
      </cfif>      
    </cfif>

  </div>
</main>

<script src="public/scripts/scripts.js"></script>

<cfinclude template="includes/layout/footer.inc">
<cfinclude template="includes/layout/body_end.inc">
<cfinclude template="includes/layout/html_end.inc">
