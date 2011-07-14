<cfcomponent>
	<cffunction access="remote" name="autosuggest" returntype="Array">
 		<cfargument name="partial" required="true" type="string">

		<cfset var result = arrayNew(1)>
  		<cfset var temp = ''>
  		<cfset var test = entityNew("term")>

		<cfset test.setText(arguments.partial)>
 		<cfquery dbtype="hql" name="temp">
 			select * from term
			where text like '%#arguments.partial#%'
 		</cfquery>

 		<cfloop query="temp">
 			<cfset arrayAppend(result, text)>
 		</cfloop>

  		<cfreturn result>
	</cffunction>

	<cffunction access="remote" name="addTag" returntype="void">
 		<cfargument name="moduleID" required="true" type="numeric">
		<cfargument name="tagID" required="true" type="numeric">
		<cfargument name="parent" default="0" type="numeric">
  		<cfargument name="tagName" default="tag" type="string">
		<cfargument name="lineNum" default="1" type="numeric">
  		<cfargument name="nameAttr" default="" type="string">

		<cfset var module = entityLoadByPK("module", arguments.moduleID)>
		<cfset var tag = entityNew("tag")>

		<cfset tag.setModule(module)>
  		<cfset tag.setName(arguments.name)>
		<cfset tag.setParent(arguments.parent)>
  		<cfset tag.setLineNum(arguments.lineNum)>
		<cfset entitySave(tag)>

		<cfif len(arguments.nameAttr)>
			<cfset var nameAttribute = entityNew("attr")>
   			<cfset nameAttribute.setName('name')>
	  		<cfset nameAttribute.setValue(arguments.nameAttr)>
	 		<cfset entitySave(nameAttribute)>
		</cfif>
	</cffunction>

	<cffunction access="remote" name="addChild" returntype="void">
 		<cfargument name="moduleID" required="true" type="numeric">
		<cfargument name="tagID" required="true" type="numeric">
  		<cfargument name="tagName" default="tag" type="string">
  		<cfargument name="nameAttr" default="" type="string">

		<cfset var thisTag = entityLoadByPK("tag", arguments.tagID)>

		<cfset addTag(moduleID=arguments.moduleID, tagID=arguments.tagID, name=arguments.tagName, parent=arguments.tagID, lineNum=thisTag.getLineNum()+1, nameAttr=arguments.nameAttr)>
	</cffunction>

	<cffunction access="remote" name="addSibling" returntype="void">
 		<cfargument name="moduleID" required="true" type="numeric">
		<cfargument name="tagID" required="true" type="numeric">
		<cfargument name="parent" required="true" type="numeric">
  		<cfargument name="tagName" default="tag" type="string">
  		<cfargument name="nameAttr" default="" type="string">

		<cfset var thisTag = entityLoadByPK("tag", arguments.tagID)>

		<cfset addTag(moduleID=arguments.moduleID, tagID=arguments.tagID, name=arguments.tagName, parent=arguments.parent, lineNum=thisTag.getLineNum()+1, nameAttr=arguments.nameAttr)>
	</cffunction>

	<cffunction access="remote" name="delete" returntype="void">
		<cfargument name="tagID" required="true" type="numeric">

  		<cfset var thisTag = entityLoadByPK("tag", arguments.tagID)>

		<cfset entityDelete(thisTag)>
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
