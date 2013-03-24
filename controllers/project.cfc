<cfcomponent>
	<cffunction name="edit">
		<cfparam default="0" name="rc.projectID" type="integer">

		<cfif not rc.projectID>
  			<cfabort>
		</cfif>

  		<cfset rc.project = entityLoadByPK('project', rc.projectID)>
	</cffunction>
</cfcomponent>
