angular.module('ActiveRecord', ['ngResource'])
  .factory 'Folder', ($resource) ->
    Folder = $resource '/folders/:folder_id', { folder_id: '@id'},
    index: { method: 'GET', isArray: true},
    new: { method: 'GET' },
    create: {  method: 'POST' },
    show: { method: 'GET' },
    edit: { metthod: 'GET' },
    update: { method: 'PUT' },
    destroy: { method: 'DELETE' }