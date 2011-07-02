<cfcomponent>
	<cffunction access="remote" name="upsert" returntype="Numeric">
		<cfargument name="moduleID" required="true" type="numeric">
		<cfargument name="tagID" required="true" type="numeric">
  		<cfargument name="name" required="true" type="string">

		<cfset var result = 0>

		<cfset var tag = "">
  		<cfset var module = entityLoadByPK("module", arguments.moduleID)>

		<cfset tag = entityNew("tag")>
  		<cfset tag.setModule(module)>
  		<cfset tag.setName(arguments.name)>

		<cfset entitySave(tag)>
		<cfset result = tag.getID()>

		<cfreturn result>
	</cffunction>

	<cffunction access="remote" name="update" returntype="void">
		<cfargument name="moduleID" required="true" type="numeric">
		<cfargument name="tagID" required="true" type="numeric">
  		<cfargument name="name" required="true" type="string">

		<cfif len(name)>
			<cfset var tag = "">
	  		<cfset var module = entityLoadByPK("module", arguments.moduleID)>

			<cfset tag = entityLoadByPK("module", arguments.tagID)>
   			<cfset tag.setName(arguments.name)>

			<cfset entitySave(tag)>
		</cfif>
	</cffunction>

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
