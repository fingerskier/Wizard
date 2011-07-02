<cfif thisTag.executionMode is 'start'>
	<!doctype html>
	<html>
		<head>
			<link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.13/themes/humanity/jquery-ui.css" rel="stylesheet" type="text/css">

			<script language="JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="application/javascript"></script>
			<script language="JavaScript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.js" type="application/javascript"></script>
			<script language="JavaScript" src="https://raw.github.com/malsup/form/master/jquery.form.js" type="application/javascript"></script>
			<script language="JavaScript" src="application.js" type="application/javascript"></script>
		</head>

		<body>
<cfelseif thisTag.executionMode is 'end'>
		</body>
	</html>
</cfif>
