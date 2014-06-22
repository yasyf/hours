App.controller 'HomeCtrl', ['$scope', '$location', 'Restangular', ($scope, $location, Restangular) ->
	$scope.addDates = (entry) ->
		entry.start = new Date(entry.start)
		entry.end = new Date(entry.end)
		entry
	$scope.addEntry = ->
		entries = Restangular.all('entries')
		entries.post($scope.entry).then (entry) ->
			$scope.entries.push $scope.addDates(entry)
	$scope.downloadCSV = ->
		url = Restangular.all('export').getRequestedUrl() + '.csv?'
		_.forOwn $scope.export, (v, k) ->
			url += k + '=' + Number(v) + '&'
		url

	$scope.sumHours = ->
		$scope.hours = $scope.entries?.reduce (t, n) ->
			t + Math.abs(n.end.getHours() - n.start.getHours())
		, 0
	$scope.updateInputs = ->
		$scope.entry.description = $scope.entry.start.toLocaleString 'en-us', weekday: 'long', month: "long", day: 'numeric'
	$scope.togglePaid = (e) ->
		entry = Restangular.one('entries', e.id)
		entry.paid = !e.paid
		entry.patch()
		e.paid = entry.paid
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
		start = new Date()
		start.setDate(start.getDate() - 5);
		end = new Date()
		$scope.export = 
			start: start
			end: end
			offset: -start.getTimezoneOffset()
	init()

]
