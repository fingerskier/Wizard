$(document).ready(function() {
	selectFirstInput();
	
	$('.tagLink').live('click', function() {
		var my = $(this),
			URL = my.attr('href'),
			containerName = my.attr('container');
		
		$(containerName).load(URL);
		
		return false;
	});
});

selectFirstInput = function() {
	$('form:not(.ui-state-disabled) :input:visible:first').focus();
}
