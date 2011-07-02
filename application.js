$(document).ready(function() {
	selectFirstInput();
	
	$('.tagLink').live('click', function() {
		var my = $(this),
			URL = my.attr('href');
		
		my.next('div.tagAttributes').load(URL);
		
		return false;
	});
});

selectFirstInput = function() {
	$('form:not(.ui-state-disabled) :input:visible:first').focus();
}
