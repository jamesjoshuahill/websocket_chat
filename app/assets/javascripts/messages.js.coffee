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

prepareNewMessageHandler = () ->
  form = $('#new_message form')
  form.submit (event) ->  
    form_data = form.serialize()
    $.post(form.attr('action'), form_data)
    
    notice
    if($.session)
      notice = $.session.get('notice')
    
    if(notice)
      flash = $("<div></div>").addClass('notice').html(notice)
      $(flash).appendTo('#flash').hide().slideDown(500).delay(2500).slideUp(500)
    event.preventDefault()

hideNoticeAndAlert = () ->
  $('.notice').delay(2500).slideUp(500)
  $('.alert').delay(2500).slideUp(500)

$ ->
  hideNoticeAndAlert()
  prepareNewMessageHandler()
