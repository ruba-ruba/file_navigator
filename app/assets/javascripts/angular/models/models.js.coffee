window.app = window.app || {}

window.angular.module('ActiveRecord', ['ngResource'])
  .factory 'Folder', ($resource) ->
    $resource '/folders2/:folder_id', { folder_id: '@id' },
      index:  { method: 'GET', isArray: true},
      create: { method: 'POST' }

  .factory 'Folder2', ($resource) ->
    Folder2 = $resource '/folders2/:folder_id', { folder_id: '@id'},
      index:  { method: 'GET', isArray: true},
      new:    { method: 'GET' },
      create: { method: 'POST' },
      show:   { method: 'GET' },
      edit:   { method: 'GET' },
      update: { method: 'PUT' },
      destroy:{ method: 'DELETE' }