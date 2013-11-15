angular.module('ActiveRecord', ['ngResource'])
  .factory 'Folders2', ($resource) ->
    $resource '/folders2/:id', { id: '@id' },
      index:  { method: 'GET', isArray: true},
      create: { method: 'POST' }

  .factory 'Folder2', ($resource) ->
    Folder2 = $resource '/folders2/:id', { id: '@id'},
    index:  { method: 'GET', isArray: true},
    new:    { method: 'GET' },
    create: { method: 'POST' },
    show:   { method: 'GET' },
    edit:   { method: 'GET' },
    update: { method: 'PUT' },
    destroy:{ method: 'DELETE' }