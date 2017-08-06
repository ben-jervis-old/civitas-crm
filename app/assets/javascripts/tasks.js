// Vue app to add users to tasks

var users = new Vue({
	el: "#manage-users",
	data: {
		current_users: [],
		all_users: []
	},
	mounted: function() {
		var that = this;
		$.ajax({
			url: '/users.json',
			success: function(res) {
				that.all_users = res;
			}
		});
		$.ajax({
			url: '/tasks/' + that.lender.id + '/users.json',
			success: function(res) {
				that.current_users = res;
			}
		})
	}
})
