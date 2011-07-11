<cfcomponent>
    <cffunction name="getNodes" returnType="array" output="no" access="remote">
        <cfargument name="nodeID" required="true">
        <cfargument name="nodePath" required="true">

		<cfset var ID = 0>
		<cfset var mode = ''>
        <cfset var nodeArray = ArrayNew(1)>

 		<cfset mode = listFirst(arguments.nodeID, '|')>
 		<cfset ID = listLast(arguments.nodeID, '|')>

		<cfswitch expression="#mode#">
  			<cfcase value="">
				<cfset var node = structNew()>
				<cfset node.value = 'root|0'>
				<cfset node.display = 'All Projects'>
				<cfset arrayAppend(nodeArray, node)>
			</cfcase>

  			<cfcase value="root">
  				<cfset nodeArray = projectNodes()>
  			</cfcase>

			<cfcase value="project">
   				<cfset nodeArray = moduleNodes(ID)>
			</cfcase>

			<cfcase value="module">
   				<cfset nodeArray = rootTagNodes(ID)>
			</cfcase>

			<cfcase value="tag">
   				<cfset nodeArray = subTagNodes(ID)>
			</cfcase>
		</cfswitch>

        <cfreturn nodeArray>
    </cffunction>

    <cffunction name="projectNodes" returntype="Array">
		<cfset var node = ''>
  		<cfset var nodes = arrayNew(1)>
		<cfset var project = ''>
		<cfset var projects = entityload("project")>

  		<cfloop array="#projects#" index="project">
  			<cfset node = structNew()>
	 		<cfset node.value = 'project|' & project.getID()>
			<cfset node.display = project.getName()>
   			<cfset arrayAppend(nodes, node)>
  		</cfloop>

		<cfreturn nodes>
    </cffunction>

    <cffunction name="moduleNodes" returntype="Array">
        <cfargument name="ID" required="true" type="numeric">

		<cfset var thisProject = entityLoadByPK("project", arguments.ID)>
  		<cfset var nodes = arrayNew(1)>

		<cfif isDefined('thisProject')>
	  		<cfset var IDprefix = ''>
			<cfset var module = ''>
			<cfset var modules = entityload("module", {project=thisProject})>
	  		<cfset var node = ''>

			<cfloop array="#modules#" index="module">
		  		<cfset var node = structNew()>

				<cfif module.isFolder()>
					<cfset IDprefix = 'project|'>
				<cfelse>
					<cfset IDprefix = 'module|'>
				</cfif>

				<cfset node.value = IDprefix & module.getID()>
	   			<cfset node.display = module.getName()>
		  		<cfset arrayAppend(nodes, node)>
			</cfloop>
		<cfelse>
  			<cfset var node = structNew()>
			<cfset node.value = 'project|0'>
   			<cfset node.display = 'All Projects'>
	  		<cfset arrayAppend(nodes, node)>
		</cfif>

		<cfreturn nodes>
    </cffunction>

    <cffunction name="rootTagNodes" returntype="Array">
        <cfargument name="ID" required="true" type="numeric">

  		<cfset var node = ''>
  		<cfset var nodes = arrayNew(1)>
		<cfset var thisModule = entityLoadByPK("module", arguments.ID)>
  		<cfset var tag = ''>
  		<cfset var tags = entityload("tag", {module=thisModule, parent=0}, 'lineNum')>

		<cfloop array="#tags#" index="tag">
			<cfset var node = structNew()>
   			<cfset node.value = 'tag|' & tag.getID()>
	  		<cfset node.display = tag.getName() & ' ' & nameAttribute(tag)>
	 		<cfset arrayAppend(nodes, node)>
		</cfloop>

		<cfreturn nodes>
    </cffunction>

    <cffunction name="subTagNodes" returntype="Array">
        <cfargument name="ID" required="true" type="numeric">

		<cfset var node = ''>
  		<cfset var nodes = arrayNew(1)>
		<cfset var thisTag = entityLoadByPK("tag", arguments.ID)>

		<cfset var tag = ''>
  		<cfset var thisModule = thisTag.getModule()>

  		<cfset var tags = entityload("tag", {module=thisModule, parent=thisTag.getID()}, 'lineNum')>

		<cfloop array="#tags#" index="tag">
			<cfset node = structNew()>
   			<cfset node.value = 'tag|' & tag.getID()>
	  		<cfset node.display = tag.getName() & ' ' & nameAttribute(tag)>
	 		<cfset arrayAppend(nodes, node)>
		</cfloop>

		<cfreturn nodes>
    </cffunction>

    <cffunction name="attrNodes" returntype="Array">
        <cfargument name="ID" required="true" type="numeric">

		<cfset var node = ''>
  		<cfset var nodes = arrayNew(1)>
		<cfset var thisTag = entityLoadByPK("tag", arguments.ID)>
  		<cfset var attr = ''>
		<cfset var attrs = entityload("attr", {tag=thisTag})>

  		<cfloop array="#attrs#" index="attr">
  			<cfset var node = structNew()>
	 		<cfset node.value = 'attr|' & attr.getID()>
			<cfset node.name = attr.getName()>
  		</cfloop>

		<cfreturn nodes>
    </cffunction>

    <cffunction name="nameAttribute" returntype="String">
    	<cfargument name="tag" required="true" type="model.tag">

	 	<cfset var attr = entityload("attr", {tag=arguments.tag, name='name'})>

   		<cfif arraylen(attr)>
			<cfreturn attr[1].getValue()>
   		<cfelse>
	 		<cfreturn ''>
		</cfif>
    </cffunction>
</cfcomponent>
