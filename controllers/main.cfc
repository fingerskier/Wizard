<cfcomponent>
	<cffunction name="default">
		<cfset rc.projects = entityload('project')>
	</cffunction>
</cfcomponent>