window.App = angular.module('Hours', ['restangular', 'ui.bootstrap.datetimepicker'])

window.App.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]