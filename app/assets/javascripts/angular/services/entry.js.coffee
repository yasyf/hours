App.factory 'Entry', ['$resource', ($resource) ->
	$resource '/entries/:id', id: '@id'
]