@FoldersCtrl = ($scope,  $location, $http) ->

  loadPosts = ->
    $http.get('./ng_index.json').success( (data) ->
      $scope.data = data
      $scope.folders_sort = '-title';
      console.log('Successfully loaded posts.')
    ).error( ->
      console.error('Failed to load posts.')
    )

  loadPosts()
