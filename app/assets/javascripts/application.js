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
var already_run = false;
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

	// Control the dropdown of the mobile menu
  $("#action-menu-button").click(function(e) {
    e.preventDefault();
  	$("#action-menu").slideDown(150);
  });

  $(document).click(function(e) {
  	if(($("#action-menu").height() > 100) && !$(e.target).closest("#action-menu").length) {
			$("#action-menu").slideUp(150);
  	}
  });

	$('#attendance-users-panel').on('shown.bs.collapse', function() {
		$('#attendance-users-link').text("Hide the full list.");
	});

	$('#attendance-users-panel').on('hidden.bs.collapse', function() {
		$('#attendance-users-link').text("Show the full list.");
	});

	var addReadMoreListener = function(e) {
    e.preventDefault()
		var that = $(this)[0];
		var parent = that.parentElement;

		new_link = that.cloneNode();
		new_link.classList = 'read-less-link';
		new_link.innerText = 'Read Less';
		parent.innerHTML = that.dataset.content + " " + new_link.outerHTML;

		parent.firstElementChild.addEventListener('click', addReadLessListener);
  };

	var addReadLessListener = function(e) {
		e.preventDefault()
		var that = $(this)[0];
		var parent = that.parentElement;

		new_link = that.cloneNode();
		new_link.classList = 'read-more-link';
		new_link.innerText = 'Read More';

		old_text = parent.innerText;
		new_text = old_text.substring(0, 97) + "...";

		parent.innerHTML = new_text + " " + new_link.outerHTML;
		parent.firstElementChild.addEventListener('click', addReadMoreListener);
	}

	$('.read-more-link').on('click', addReadMoreListener);

	$('.search-bar').keyup(debounce(function(e) {
    // If enter was pressed, navigate to first result
    if(e.which == 13) {
      window.location.href = $('[data-searchterm]:not(.hidden-item)')[0].children[0].children[0].href;
    }
    else {
      var search_string = $(this)[0].value;
  		var filter_string = search_string.toUpperCase();
  		var item_list = $('[data-searchterm]');

  		for(i = 0; i < item_list.length; i++) {
  			item_name = item_list[i].dataset.searchterm;
  			if(item_name.toUpperCase().indexOf(filter_string) > -1) {
  				item_list[i].classList.remove('hidden-item');
  			}
  			else {
  				item_list[i].classList.add('hidden-item');
  			}
  		}

  		if($('[data-searchterm]:not(.hidden-item)').length == 0) {
  			$('#list-empty-msg')[0].classList = 'list-group-item text-center';
  		}
  		else {
  			$('#list-empty-msg')[0].classList = 'list-group-item hidden-item';
  		}
    }
	}, 100));

	$('#attendance-search-bar').keyup(debounce(function(e) {
    var search_string = $(this)[0].value;
		var filter_string = search_string.toUpperCase();

		/*--- Search the Families first ---*/
		var object_list = $('[data-type=family-group]');

		for(i = 0; i < object_list.length; i++) {
			object_name = object_list[i].dataset.searchterm;
			if(object_name.toUpperCase().indexOf(filter_string) > -1) {
				object_list[i].classList.remove('hidden-item');
			}
			else {
				object_list[i].classList.add('hidden-item');
			}
		}

		if($('[data-type=family]:not(.hidden-item)').length == 0) {
			$('#list-empty-msg')[0].classList = 'text-center';
		}
		else {
			$('#list-empty-msg')[0].classList = 'hidden-item';
		}

		/*--- Also search individual Users ---*/
		var object_list = $('[data-type=user-group]');

		for(i = 0; i < object_list.length; i++) {
			object_name = object_list[i].dataset.searchterm.split(' ')[1];
			if(object_name.toUpperCase().indexOf(filter_string) > -1) {
				object_list[i].classList.remove('hidden-item');
			}
			else {
				object_list[i].classList.add('hidden-item');
			}
		}

		if($('[data-type=user]:not(.hidden-item)').length == 0) {
			$('#list-empty-msg')[0].classList = 'text-center';
		}
		else {
			$('#list-empty-msg')[0].classList = 'hidden-item';
		}
	}, 100));

	function post_checkbox(checkbox_element) {
		val = checkbox_element.checked;
		event_id = $(checkbox_element).data('event-id');
		url_segment = val ? 'mark' : 'unmark';
		user_id = $(checkbox_element).data('id');
		url = '/events/' + event_id + '/' + url_segment + '/' + user_id;

		$.ajax({
			type: 'POST',
			url: url,
			data: {}
		}).done(function() {
			$('[data-type=user][data-id=' + user_id + ']').each(function(index, check_box) {
				check_box.checked = val;
			});
		}).fail(function() {
			checkbox_element.checked = false;
			check_family_box(checkbox_element);
			alert('There was an error');
		});
	}

	function check_family_box(checkbox_element) {
		family_group = $(checkbox_element).closest('[data-type=family-group]');
		if($(family_group).length > 0) {
			family_box = $(family_group).find('input[data-type=family]')[0];
			all_checked = true;
			$(family_group).find('input[data-type=user]').each(function(index, check_item) {
				all_checked = all_checked && check_item.checked;
			});
			family_box.checked = all_checked;
		}
	}

	$('.unpadded-checkboxes input[type=checkbox]').change(function() {
		checkbox_type = $(this).data('type');
		event_id = $(this).data('event-id');
		checkbox_value = this.checked;

		if(checkbox_type == 'family') {
			family_group = $(this).closest('[data-type=family-group]');
			$(family_group).find('input[data-type=user]').each(function() {
				this.checked = checkbox_value;
				post_checkbox(this);
			});
		}
		else {
			post_checkbox(this);
			check_family_box(this);
		}
	});

	$('.search-bar.scroll').focus(function() {
		if($(window).width() < 768) {
			$('html, body').animate({
		    scrollTop: $(this).offset().top - 80
			}, 600);
		}
	});

	$('#grouping-button-group button').click(function() {
		operation = $(this).data('operation');
		if(operation == 'individual') {
			$('#family-view').addClass('hidden');
			$('#user-view').removeClass('hidden');
		}
		else {
			$('#family-view').removeClass('hidden');
			$('#user-view').addClass('hidden');
		}

		$(this).addClass('hidden');
		$(this).siblings().removeClass('hidden');
	});

	$('#filtering-button-group button').click(function() {
		operation = $(this).data('operation');
		if(operation == 'all') {
			$('[data-type=family-group].hidden-filter').each(function(index, panel) {
				$(panel).removeClass('hidden-filter');
			});
			$('.list-group-item.hidden-filter, [data-type=user-group].hidden-filter').each(function(index, checkbox) {
				$(checkbox).removeClass('hidden-filter');
			});
		}
		else {
			$('[data-expected]').each(function(index, checkbox) {
				if(!($(checkbox).data('expected'))) {
					$(checkbox).addClass('hidden-filter');
				}
			});

			$('[data-type=family-group]').each(function(index, panel) {
				if($(panel).find('.list-group-item:not(.hidden-filter)').length == 0) {
					$(panel).addClass('hidden-filter');
				}
			});
		}

		$(this).addClass('hidden');
		$(this).siblings().removeClass('hidden');
	});

	// Flash alerts dismiss after 10 seconds
	window.setTimeout(function() {
		$('.alert.fade.alert-timeout').alert('close');
	}, 10000);

	$('.alert.fade.alert-timeout').on('closed.bs.alert', function() {
		$('.page-header.tall-margin').removeClass('tall-margin');
	});

	already_run = true;
};

// $(document).ready(doc_ready);
$(document).on('turbolinks:load', doc_ready);
