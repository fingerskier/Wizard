<cfset context.mode = listFirst(context.node, '|')>
<cfset context.ID = listLast(context.node, '|')>

<cfswitch expression="#context.mode#">
	<cfcase value="root">
 		<cfinclude template="panel/projects.cfm">
	</cfcase>

	<cfcase value="project">
 		<cfinclude template="panel/project.cfm">
	</cfcase>

]	<cfcase value="module">
 		<cfinclude template="panel/module.cfm">
	</cfcase>

	<cfcase value="tag">
 		<cfinclude template="panel/tag.cfm">
	</cfcase>

	<cfcase value="attr">
 		<cfinclude template="panel/tag.cfm">
	</cfcase>
</cfswitch>
