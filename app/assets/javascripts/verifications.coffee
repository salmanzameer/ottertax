# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$(document).on 'turbolinks:load', ->
		$(".user-verify-code-form-btn").click (e) ->
			_this = this
			e.preventDefault()
			
			if $(".user-verification-ssn").val() == ''
				$('.user-verification-ssn-error').text('This field is required').show()
			else if $(".user-verification-code").val() == '' 
				$('.user-verification-code-error').text('This field is required').show()
			else if (grecaptcha.getResponse().length == 0)
				$('.user-verification-captcha-error').text('Please select the checkbox.').show()
				return false
			else if ($('.user-verification-ssn-error, .user-verification-code-error').is(':visible'))
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
		        	$('#modal-verification-errors').modal('show')
		        	$('.verrification-error-message-p').show().text(data.message)
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

		$(".user-verification-ssn").on 'blur', (e) ->
			regx = /^\d+$/
			if ($(this).val() == '')
				$('.user-verification-ssn-error').text('This field is required').show()
			else if !(regx.test($(this).val()))
				$('.user-verification-ssn-error').text('Please enter digits only').show()
			else if ($(this).val().length != 4)
				$('.user-verification-ssn-error').text('Please enter last 4 SSN').show()
			else
				$('.user-verification-ssn-error').hide()
				
		$(".user-verification-code").on 'blur', (e) ->
			regx = /^[a-zA-Z()]+$/
			if ($(this).val() == '')
				$('.user-verification-code-error').text('This field is required').show()
			else if !(regx.test($(this).val()))
				$('.user-verification-code-error').text('Please enter alphabets only').show()
			else if ($(this).val().length != 5)
				$('.user-verification-code-error').text('Please enter your access code').show()
			else
				$('.user-verification-code-error').hide()