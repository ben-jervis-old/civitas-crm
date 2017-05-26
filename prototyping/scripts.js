$(function () {
  $('[data-toggle="tooltip"]').tooltip()
});

$("#action-menu-button").click(function() {
	$("#action-menu").slideToggle();
});

$(document).click(function(e) {
	if(!$(e.target).closest("#action-menu").length) {
		if($("#action-menu").height() > 100) {
			$("#action-menu").slideUp();
			// console.log($("#action-menu").height());
		}
	}
});
