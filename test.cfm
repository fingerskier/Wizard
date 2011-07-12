 		<cfquery dbtype="hql" name="temp">
 			select * from term
			where text like '%fun%'
 		</cfquery>

 		<cfdump var="#temp#">