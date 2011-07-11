<cfcomponent>
	<cffunction access="remote" name="setAttr">
		<cfargument name="tagID" required="true" type="numeric">
		<cfargument name="name" required="true" type="string">
		<cfargument name="value" required="true" type="string">

		<cfif len(arguments.name)>
			<cfset var tag = entityLoadByPK("tag", arguments.tagID)>
			<cfset var attr = entityload("attr", {
				tag = tag,
				name = arguments.name
			})>

			<cfif arraylen(attr) ge 1>
   				<cfset attr = attr[1]>
				<cfset attr.setValue(arguments.value)>
	  		<cfelse>
				<cfset attr = entityNew("attr")>
				<cfset attr.setTag(tag)>
		 		<cfset attr.setName(arguments.name)>
				<cfset attr.setValue(arguments.value)>
			</cfif>

			<cfset entitySave(attr)>
		</cfif>
	</cffunction>
</cfcomponent>
