<cfset thisModule = entityLoadByPK("module", context.ID)>

<cfoutput>
	<cfform action="action/module.cfc?method=update" method="post">
		<input name="moduleID" type="hidden" value="#thisModule.getID()#">
		<input name="name" type="text" value="#thisModule.getName()#">
		<br>
		<input type="submit" value="Update Module">
	</cfform>
</cfoutput>
