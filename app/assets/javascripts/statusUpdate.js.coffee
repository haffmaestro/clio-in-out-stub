$ ->
  $("#users-container a.update-link").click ->
    block = $(this).parent("p")
    debugger
    $.get $(this).attr("href"), (data) ->
      debugger
      $("a.name", block).html data["full_name"]
      $("span.status", block).removeClass("status-in status-out").addClass("status-" + data["status"]).html data["status"]
      return

    false

window.app.realtime = connect: ->
  window.app.socket = io.connect("http://0.0.0.0:5001")
  window.app.socket.on "rt-change", (message) ->
    
    # publish the change on the client side, the channel == the resource
    window.app.trigger message.resource, message
    return

  return
