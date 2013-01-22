#= require jquery
#= require jquery_ujs
#= require foundation

jQuery ->
	$('.alert-box').hide().slideToggle().delay(6000).slideToggle()

	$('#player_search').on 'keyup', () ->
		query = $('#player_search').val()
		$.ajax({
			url: "/baseball/search",
			data:
				query: query
		})
		# Clear Position Box
		$('#position_search').val(0)

	$('#position_search').on 'change', () ->
		position = $('#position_search').val()
		if position == "POS"
			url = "/"
		else if $('.selected')[0]
			url = "?position=" + position + "&direction=" + $('.selected').data('direction') + "&sort=" + $('.selected').data('sort')
		else
			url = "?position=" + position
		window.location.href = url
		# Clear Search Box
		$('#player_search').val('')