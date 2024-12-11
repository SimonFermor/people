<cfselect name="year">
  <cfoutput>
  <cfloop from="#year(now())#" to="2000" index="option_year" step="-1">
    <option value=#option_year# <cfif form.year eq option_year> selected </cfif>
      > #option_year#</option>
  </cfloop>
  </cfoutput>
</cfselect>

<cfselect name="month">
  <option value="1" <cfif form.month eq 1> selected </cfif> >January</option>
  <option value="2" <cfif form.month eq 2> selected </cfif> >February</option>
  <option value="3" <cfif form.month eq 3> selected </cfif> >March</option>
  <option value="4" <cfif form.month eq 4> selected </cfif> >April</option>
  <option value="5" <cfif form.month eq 5> selected </cfif> >May</option>
  <option value="6" <cfif form.month eq 6> selected </cfif> >June</option>
  <option value="7" <cfif form.month eq 7> selected </cfif> >July</option>
  <option value="8" <cfif form.month eq 8> selected </cfif> >August</option>
  <option value="9" <cfif form.month eq 9> selected </cfif> >September</option>
  <option value="10" <cfif form.month eq 10> selected </cfif> >October</option>
  <option value="11" <cfif form.month eq 11> selected </cfif> >November</option>
  <option value="12" <cfif form.month eq 12> selected </cfif> >December</option>
</cfselect>
