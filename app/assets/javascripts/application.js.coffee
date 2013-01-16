#= require jquery
#= require jquery_ujs
#= require foundation
#= require_tree .

jQuery ->
	$('#player_search').on 'keyup', () ->
		query = $('#player_search').val()
		$('#position_search').val(0)
		playerSearch(query)

	playerSearch = (query)->
		$.ajax({
			url: "/baseball/search",
			data:
				query: query
		})

	$('#position_search').on 'change', () ->
		position = $('#position_search').val()
		$('#player_search').val('')
		positionSearch(position)

	positionSearch = (position)->
		$.ajax({
			url: "/baseball/search",
			data:
				position: position
		})