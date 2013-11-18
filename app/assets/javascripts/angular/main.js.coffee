window.app = window.app || {}

Uploader = window.angular.module('Uploader',  ['ngSanitize', 'ActiveRecord', 'ngRoute' ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: "../../assets/templates/folders2/index.html"
        controller: window.app.Folders2Ctrl
      .when '/edit/:folder_id',
        templateUrl: "../../assets/templates/folders2/form.html"
        controller: window.app.FolderEditCtrl
      .when '/new',
          controller: window.app.FolderNewCtrl
          templateUrl: "../../assets/templates/folders2/form.html"

  .config [ "$httpProvider", (provider) ->
    provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  ]














Uploader.directive 'icon', ->
  link: (scope, element, attrs) ->
    raw = scope.$eval(attrs.key)
    fileExt = raw.split(".")[1]
    if fileExt == "txt" || fileExt == "docx" || fileExt == "doc"
      element.replaceWith("<i class='silk-page_word'></i> ")
    else if fileExt == 'jpg'
       element.replaceWith("<i class='silk-images'></i> ")
    else if fileExt == 'exe'
      element.replaceWith("<i class='silk-cog'></i> ")
    else
      element.replaceWith("<i class='silk-attach'></i> ")

Uploader.filter 'icon', ->
  (text) ->
    fileExt = text.split(".")[1]
    if fileExt == 'jpg'
      "<i class='silk-images'></i> "
    else if fileExt == 'doc' || fileExt == 'docx'
      "<i class='silk-page_word'></i> "
    else if fileExt == 'exe'
      "<i class='silk-cog'></i> "
    else
      "<i class='silk-attach'></i> "

Uploader.filter 'truncate', ->
  (text) ->
    if text.length < 20
      text
    else
      String(text).substring(0, 21) + '...'


Uploader.filter 'bytes', ->
  (size) ->
    units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB']
    number = Math.floor(Math.log(size) / Math.log(1024))  
    (size / Math.pow(1024, Math.floor(number))).toPrecision(3) + ' ' + units[number]