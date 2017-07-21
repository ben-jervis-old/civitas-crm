// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function () {
  $('[data-toggle="tooltip"]').tooltip();

  $("#action-menu-button").click(function(e) {
    e.preventDefault();
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

	$('#username-search-bar').keyup(function() {
		var search_string = $(this)[0].value;
		var filter_string = search_string.toUpperCase();
		var user_list = $('[data-username]');

		// console.log($('div.list-group-item.col-md-4:contains(' + filter_string + ')'));

		for(i = 0; i < user_list.length; i++) {
			user_name = user_list[i].dataset.username;
			if(user_name.toUpperCase().indexOf(filter_string) > -1) {
				user_list[i].style.display = "";
			}
			else {
				console.log(user_list[i]);
				user_list[i].style.display = "none";
			}
		}
	});

});
