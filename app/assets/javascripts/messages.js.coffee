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
  $('#messages tr:last').hide().fadeIn(1000)

prepareNewMessageHandler = () ->
  form = $('#new_message_form form')
  form.submit (event) ->  
    form_data = form.serialize()
    $.post(form.attr('action'), form_data)
    $('.notice').html('Message posted.').show()
    hideNoticeAndAlert()
    event.preventDefault()

hideNoticeAndAlert = () ->
  $('.notice').delay(2500).fadeOut(500)
  $('.alert').delay(2500).fadeOut(500)

$ ->
  hideNoticeAndAlert()
  prepareNewMessageHandler()
