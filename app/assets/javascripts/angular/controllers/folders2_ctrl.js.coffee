@Folders2Ctrl = ($scope,  Folder2) ->
  $scope.folders = Folder2.query()

  $scope.destroy = (id) ->
    $scope.folders = $scope.folders.filter (folder) ->
      folder.$delete() if folder.id == id
      folder.id != id


@FolderEditCtrl = ($scope, $location, $routeParams, Folder2) ->
  $scope.save = ->
    console.log '2'
