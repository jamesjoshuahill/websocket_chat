# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

dispatcher = new WebSocketRails 'localhost:3000/websocket'

channel = dispatcher.subscribe 'chat'
channel.bind 'new', (message) ->
  new_message_html = "<tr>"
  new_message_html += "<td>" + message.name + "</td>"
  new_message_html += "<td>" + message.content + "</td>"
  new_message_html += "<td><a data-confirm='You are sure.' data-method='delete' href='/messages/" + message.id + "' rel='nofollow'>Eviscerate</a></td>"
  new_message_html += "</tr>"
  $('#messages').append $(new_message_html)