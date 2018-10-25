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
		        	alert data.code_id
		        	$(".user-ssn-code-id").val(data.code_id)
		        	$(".user-verify-code-form").submit()