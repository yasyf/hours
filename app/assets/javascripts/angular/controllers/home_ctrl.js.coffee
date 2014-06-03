App.controller 'HomeCtrl', ['$scope', 'Restangular', ($scope, Restangular) ->
	$scope.addDates = (entry) ->
		entry.start = new Date(entry.start)
		entry.end = new Date(entry.end)
		entry
	$scope.addEntry = ->
		e = Restangular.all('entries')
		e.post($scope.entry).then (entry) ->
			$scope.entries.push $scope.addDates(entry)
	$scope.sumHours = ->
		$scope.hours = $scope.entries?.reduce (t, n) ->
			t + (n.end.getHours() - n.start.getHours())
		, 0
	$scope.updateInputs = ->
		$scope.entry.description = $scope.entry.start.toLocaleString 'en-us', weekday: 'long', month: "long", day: 'numeric'
	init = ->
		$scope.tab = 0
		Restangular.all('entries').getList().then (entries) ->
			$scope.entries = entries.map (entry) ->
				$scope.addDates(entry)
		start = new Date()
		start.setHours(11, 0, 0, 0)
		end = new Date()
		end.setHours(20, 0, 0, 0)
		$scope.entry =
			start: start
			end: end
			description: null
	init()

]