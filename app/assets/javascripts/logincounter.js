$(document).ready(function() {
	$('#login').click(function() {
		var form_data = {
			username: $('#username').val(),
			password: $('#password').val()
		};
		$.ajax({
			type: 'post',
			url: '/login',
			dataType: 'json',
			data: form_data,
			success: function(response) {
				if(response.error_code == -4) {
					$('#login_message').html('Invalid username and password combination. Please try again.');
				} else {
					//TODO
				}
			}
		});
	});
	$('#add_user').click(function() {
		var form_data = {
			username: $('#username').val(),
			password: $('#password').val()
		};
		$.ajax({
			type: 'post',
			url: '/signup',
			dataType: 'json',
			data: form_data,
			success: function(response) {
				if(response.error_code == -1) {
					$('#login_message').text='The user name should be 5~20 characters long. Please try again.';
				} else if(response.error_code == -2) {
					$('#login_message').text='The password should be 8~20 characters long. Please try again.';
				} else if(response.error_code == -3) {
					$('#login_message').text='This user name already exists. Please try again.';
				} else {
					//TODO
				}
			}
		});
	});
});
