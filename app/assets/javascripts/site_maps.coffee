# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

runReload = ->
  setInterval (->
    makeRequest (data)->
      if data.rendered == true
        location.reload()
  ), 1000

makeRequest = (f)->
  url = location.href+'.json'
  $.ajax(
    url: url
  ).done f




$('.site_maps-show').ready ->
  makeRequest (data)->
    if data.rendered != true
      runReload()
