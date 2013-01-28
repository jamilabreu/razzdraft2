#= require jquery
#= require jquery_ujs
#= require foundation

jQuery ->
	$('.alert-box').hide().slideToggle().delay(6000).slideToggle()

	$('#player_search').on 'keyup', () ->
		query = $('#player_search').val()
		league_type = $('#player_search').data('league-type')
		$.ajax({
			url: "/baseball/search?league_type=" + league_type,
			data:
				query: query
		})
		# Clear Position Box
		$('#position_search').val(0)

	$('#position_search').on 'change', () ->
		position = $('#position_search').val()
		league_type = $('#position_search').data('league-type')
		if position == "POS"
			url = "/?league_type=" + league_type
		else if $('.selected')[0]
			url = "?league_type=" + league_type + "&position=" + position + "&direction=" + $('.selected').data('direction') + "&sort=" + $('.selected').data('sort')
		else
			url = "?league_type=" + league_type + "&position=" + position
		window.location.href = url
		# Clear Search Box
		$('#player_search').val('')

	$('#position_eligibility').on 'change', () ->
		league_type = $('#position_eligibility').val()
		url = "?league_type=" + league_type
		window.location.href = url


	$('#show_custom_league').on 'click', () ->
		$('#new_baseball_team').show()