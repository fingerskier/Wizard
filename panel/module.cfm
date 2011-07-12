<cfset thisModule = entityLoadByPK("module", context.ID)>

<cfoutput>
	<cfform method="post">
		<input name="wizard_action" type="hidden" value="action.module|update">
		<input name="moduleID" type="hidden" value="#thisModule.getID()#">
		<input name="name" type="text" value="#thisModule.getName()#">
		<br>
		<input type="submit" value="Update Module">
	</cfform>
</cfoutput>
