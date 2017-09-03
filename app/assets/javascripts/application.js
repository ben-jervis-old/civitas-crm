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
//= require vue
//= require_tree .
//= stub 'tasks'

var doc_ready;
doc_ready = function () {

  // Debounce function to limit excessive cycles
  function debounce(func, wait, immediate) {
    var timeout;
    return function() {
      var context = this, args = arguments;
      var later = function() {
        timeout = null;
        if(!immediate) func.apply(context, args);
      };
      var callNow = immediate && !timeout;
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
      if(callNow) func.apply(context, args);
    };
  };

  // Trigger various Bootstrap elements
  $('[data-toggle="tooltip"]').tooltip();
	$('[data-toggle="popover"]').popover();

  $("#action-menu-button").click(function(e) {
    e.preventDefault();
  	$("#action-menu").slideDown(150);
  });

  $(document).click(function(e) {
  	if(($("#action-menu").height() > 100) && !$(e.target).closest("#action-menu").length) {
			$("#action-menu").slideUp(150);
  	}
  });

	$('.read-more-link').on('click', function(e) {
    e.preventDefault()
    $(this).parent().text($(this).data('content'));
    
  });

	$('#groups-search-bar').keyup(function() {
		var search_string = $(this)[0].value;
		var filter_string = search_string.toUpperCase();
		var group_list = $('[data-groupname]');

		for(i = 0; i < group_list.length; i++) {
			group_name = group_list[i].dataset.groupname;
			if(group_name.toUpperCase().indexOf(filter_string) > -1) {
				group_list[i].classList.remove('hidden-item');
			}
			else {
				group_list[i].classList.add('hidden-item');
			}
		}

		console.log($('[data-groupname]:not(.hidden-item)'));

		if($('[data-groupname]:not(.hidden-item)').length == 0) {
			console.log('Tested');
			console.log($('#list-empty-msg'));
			$('#list-empty-msg')[0].classList = 'list-group-item';
		}
		else {
			console.log('Not Tested');
			$('#list-empty-msg')[0].classList = 'list-group-item hidden-item';
		}
	});

	$('#username-search-bar').keyup(debounce(function(e) {
    // If enter was pressed, navigate to first result
    if(e.which == 13) {
      window.location.href = $('[data-username]:not(.hidden-item)')[0].children[0].children[0].href;
    }
    else {
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

  		if($('[data-username]:not(.hidden-item)').length == 0) {
  			$('#list-empty-msg')[0].classList = 'list-group-item text-center';
  		}
  		else {
  			$('#list-empty-msg')[0].classList = 'list-group-item hidden-item';
  		}
    }
	}, 100));

	// Flash alerts dismiss after 10 seconds
	window.setTimeout(function() {
		$('.alert.fade.alert-timeout').alert('close');
	}, 10000);

	$('.alert.fade.alert-timeout').on('closed.bs.alert', function() {
		$('.page-header.tall-margin').removeClass('tall-margin');
	});
};

$(document).ready(doc_ready);
$(document).on('turbolinks:load', doc_ready);
