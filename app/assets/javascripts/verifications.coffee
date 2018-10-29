# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$(document).on 'turbolinks:load', ->
		$(".user-verify-code-form-btn").click (e) ->
			_this = this
			e.preventDefault()
			if (grecaptcha.getResponse().length == 0)
				return false
			else
				$.ajax
		      type: 'GET'
		      url:  $(_this).data('path')
		      data: $(".user-verify-code-form").serialize()
		      beforeSend: ->
		      error: (xhr, ajaxOptions, thrownError) ->
		        er = JSON.parse(xhr.responseText)
		        console.log er
		      success: (data) ->
		        if (data.status == 404)
		        	alert(data.message)
		        else
		        	$(".user-verifiction-auth-token").val(data.token)
		        	$(".user-ssn-code-id").val(data.code_id)
		        	$(".user-verify-code-form").submit()

		$(".login-button-check-email").on "click", (e) ->
			e.preventDefault()
			email = $('.set-email')
			confirm_email = $('.set-email-confirmation')
			email_regex = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/	
			if ($(email).val().length == 0) || ($(confirm_email).val().lenght == 0)
				$(".mismatch-error-email").text("Please enter email.").show()
			else if !email_regex.test($(email).val())
				$(".mismatch-error-email").text("Please enter correct email.").show()
			else if ($(email).val() != $(confirm_email).val())
				$(".mismatch-error-email").text("Email doesn't match.").show()
			else
				$('.user-invite-form').submit()	