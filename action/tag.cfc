<cfcomponent>
	<cffunction access="remote" name="addTag" returntype="void">
 		<cfargument name="moduleID" required="true" type="numeric">
		<cfargument name="tagID" required="true" type="numeric">
		<cfargument name="parent" default="0" type="numeric">
  		<cfargument name="name" default="tag" type="string">
		<cfargument name="lineNum" default="1" type="numeric">

		<cfset var module = entityLoadByPK("module", arguments.moduleID)>
		<cfset var tag = entityNew("tag")>

		<cfset tag.setModule(module)>
  		<cfset tag.setName(arguments.name)>
		<cfset tag.setParent(arguments.parent)>
  		<cfset tag.setLineNum(arguments.lineNum)>

		<cfset entitySave(tag)>
	</cffunction>


	<cffunction access="remote" name="addChild" returntype="void">
 		<cfargument name="moduleID" required="true" type="numeric">
		<cfargument name="tagID" required="true" type="numeric">
  		<cfargument name="name" default="tag" type="string">

		<cfset var thisTag = entityLoadByPK("tag", arguments.tagID)>

		<cfset addTag(moduleID=arguments.moduleID, tagID=arguments.tagID, name=arguments.name, parent=arguments.tagID, lineNum=thisTag.getLineNum()+1)>
	</cffunction>

	<cffunction access="remote" name="addSibling" returntype="void">
 		<cfargument name="moduleID" required="true" type="numeric">
		<cfargument name="tagID" required="true" type="numeric">
		<cfargument name="parent" required="true" type="numeric">
  		<cfargument name="name" default="tag" type="string">

		<cfset var thisTag = entityLoadByPK("tag", arguments.tagID)>

		<cfset addTag(moduleID=arguments.moduleID, tagID=arguments.tagID, name=arguments.name, parent=arguments.parent, lineNum=thisTag.getLineNum()+1)>
	</cffunction>

	<cffunction access="remote" name="insert" returntype="void">
		<cfargument name="moduleID" required="true" type="numeric">
		<cfargument name="tagID" required="true" type="numeric">
  		<cfargument name="name" required="true" type="string">

		<cfset var tag = "">
  		<cfset var module = entityLoadByPK("module", arguments.moduleID)>

		<cfset tag = entityNew("tag")>
  		<cfset tag.setModule(module)>
  		<cfset tag.setName(arguments.name)>

		<cfset entitySave(tag)>
	</cffunction>

	<cffunction access="remote" name="moveDown" returntype="void">
		<cfargument name="tagID" required="true" type="numeric">

  		<cfset var thisTag = entityLoadByPK("tag", arguments.tagID)>
		<cfset var thisLineNum = thisTag.getLineNum()>

		<cfset var nextLineNum = thisLineNum + 1>
		<cfset var nextTag = entityload("tag", {lineNum=nextLineNum}, true)>

		<cfif isDefined('nextTag')>
   			<cfset nextTag.setLineNum(thisLineNum)>
			<cfset entitySave(nextTag)>
		</cfif>

		<cfset thisTag.setLineNum(nextLineNum)>
		<cfset entitySave(thisTag)>
	</cffunction>

	<cffunction access="remote" name="moveUp" returntype="void">
		<cfargument name="tagID" required="true" type="numeric">

  		<cfset var thisTag = entityLoadByPK("tag", arguments.tagID)>
		<cfset var thisLineNum = thisTag.getLineNum()>

  		<cfset var prevLineNum = thisLineNum - 1>
		<cfset var prevTag = entityload("tag", {lineNum=prevLineNum})>

  		<cfif isDefined('prevTag')>
   			<cfset prevTag.setLineNum(thisLineNum)>
			<cfset entitySave(prevTag)>
		</cfif>

		<cfif prevLineNum gt 0>
			<cfset thisTag.setLineNum(prevLineNum)>
			<cfset entitySave(thisTag)>
		</cfif>
	</cffunction>

	<cffunction access="remote" name="update" returntype="void">
		<cfargument name="tagID" required="true" type="numeric">
  		<cfargument name="name" required="true" type="string">

		<cfif len(name)>
			<cfset var tag = "">

			<cfset tag = entityLoadByPK("tag", arguments.tagID)>
   			<cfset tag.setName(arguments.name)>

			<cfset entitySave(tag)>
		</cfif>
	</cffunction>
</cfcomponent>
