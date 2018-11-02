# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$(document).on 'change', ':file', ->
	  input = $(this)
	  numFiles = if input.get(0).files then input.get(0).files.length else 1
	  label = input.val().replace(/\\/g, '/').replace(/.*\//, '')
	  input.trigger 'fileselect', [
	    numFiles
	    label
	  ]


	$(document).on 'turbolinks:load', ->
		$('#dtBasicExample').DataTable
			searching: false
			paging: false
			bInfo: false
			bSortable: true

	  $(':file').on 'fileselect', (event, numFiles, label) ->
	    input = $(this).parents('.input-group').find(':text')
	    log = if numFiles > 1 then numFiles + ' files selected' else label
	    if input.length
	      input.val log
	    else
	      if log
	        alert log

	  $('.send-email-document-link').on 'click', (e) ->
	  	e.preventDefault()

	  	$('.error-email').hide()
	  	$('.send-emai-document-id').val($(this).data('id'))
	  	$('#modal-send-email').modal('show')

	 	$('.send-document-email-btn').on 'click', (e) ->
	 		e.preventDefault()
	 		email_regex = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/
	 		_value = $('.send-email-document-email').val()
	 		
	 		if _value == '' 
	 			$('.error-email').show().text("This field is required")
	 		else if !email_regex.test(_value)
	 			$('.error-email').show().text("Please enter correct email")
	 		else
	 			$('.error-email').hide()
	 			$('.send-document-email-form').submit()

	 	$('.user-update-form :input').change ->
  		$('.update-user-btn').prop("disabled", false);