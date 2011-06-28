$(document).ready(function() {
	$('body').append('<div class="ui-widget"></div>').load('projects.cfm');
	
	$('.projectLink').live('click', function() {
		var url = $(this).attr('href');
		
		$('body').append('<div class="ui-widget"></div>').load(url);
	});
});
