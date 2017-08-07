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
//= require bootstrap-datepicker
//= require vue
//= require_tree .
//= stub 'tasks'

var doc_ready;
doc_ready = function () {
  $('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle="popover"]').popover();

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

		for(i = 0; i < user_list.length; i++) {
			user_name = user_list[i].dataset.username;
			if(user_name.toUpperCase().indexOf(filter_string) > -1) {
				user_list[i].classList.remove('hidden-item');
			}
			else {
				user_list[i].classList.add('hidden-item');
			}
		}

		console.log($('[data-username]:not(.hidden-item)'));

		if($('[data-username]:not(.hidden-item)').length == 0) {
			console.log('Tested');
			console.log($('#list-empty-msg'));
			$('#list-empty-msg')[0].classList = 'list-group-item';
		}
		else {
			console.log('Not Tested');
			$('#list-empty-msg')[0].classList = 'list-group-item hidden-item';
		}
	});

	// Flash alerts dismiss after 10 seconds
	window.setTimeout(function() {
		$('.alert.fade.alert-timeout').alert('close');
		$('.page-header.tall-margin').removeClass('tall-margin');
	}, 10000);


	$('.input-daterange input').datepicker({
    format: "dd/mm/yyyy",
    todayBtn: "linked",
    todayHighlight: true,
		defaultViewDate: 'today'
	});

};

$(document).ready(doc_ready);
$(document).on('turbolinks:load', doc_ready);
