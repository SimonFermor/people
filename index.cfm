<cfparam name="scope" default="persons">
<cfparam name="view" default="all_persons">

<cfinclude template="includes/layout/html_start.inc">
<cfinclude template="includes/layout/head.inc">
<cfinclude template="includes/layout/body_start.inc">

<main>
  <div class="container">

    <cfswitch expression="#scope#">

      <cfcase value="addresses">
        <cfparam name="view" default="all_addresses">
        <cfif listFindNoCase("all_addresses,one_address", view)>
          <cfinclude template="includes/addresses/#view#.inc">
        </cfif>
      </cfcase>

      <cfcase value="organizations">
        <cfparam name="view" default="all_organizations">
        <cfif listFindNoCase("all_organzations,one_organization", view)>
          <cfinclude template="includes/organzations/#view#.inc">
        </cfif>
      </cfcase>

      <cfcase value="persons">
        <cfparam name="view" default="all_persons">
        <cfif listFindNoCase("all_persons,one_person", view)>
          <cfinclude template="includes/persons/#view#.inc">
        </cfif>
      </cfcase>

      <cfcase value="quotes">
        <cfparam name="view" default="all_quotes">
        <cfif listFindNoCase("all_quotes,one_quote", view)>
          <cfinclude template="includes/quotes/#view#.inc">
        </cfif>
      </cfcase>

      <cfdefaultcase>
        No page found
      </cfdefaultcase>
    </cfswitch>

  </div>
</main>

<script src="public/scripts/scripts.js"></script>

<cfinclude template="includes/layout/footer.inc">
<cfinclude template="includes/layout/body_end.inc">
<cfinclude template="includes/layout/html_end.inc">
