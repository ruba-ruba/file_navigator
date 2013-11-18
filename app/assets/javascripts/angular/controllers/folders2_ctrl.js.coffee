`var module = typeof(module) === 'undefined' ? {} : module`
window.app = window.app || {}


module.exports = window.app.Folders2Ctrl = ($scope,  Folder2) ->
  $scope.folders = Folder2.query()

  $scope.destroy = (id) ->
    $scope.folders = $scope.folders.filter (folder) ->
      folder.$delete() if folder.id == id
      folder.id != id


module.exports = window.app.FolderNewCtrl = ($scope, $location, Folder2) ->
  $scope.save = ->
    Folder2.save $scope.folder, (folder) ->
      $location.path '/'


module.exports = window.app.FolderEditCtrl = ($scope, $location, $routeParams, Folder2) ->

  self = @

  Folder2.get {folder_id: $routeParams.folder_id}, (folder) ->
    self.original_folder = folder
    $scope.folder = new Folder2 self.original_folder

  $scope.save = ->
    window.folder = $scope.folder
    $scope.folder.$update ->
      $location.path '/'
