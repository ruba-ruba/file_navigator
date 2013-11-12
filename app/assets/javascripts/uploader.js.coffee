app = angular.module("Uploader", ["ngResource"])

app.factory "Item", ["$resource", ($resource) ->
  $resource("/folders/ng_show"})
]