$ ->
  $("#users-container a.update-link").click ->
    block = $(this).parent("p")
    $.get $(this).attr("href"), (data) ->
      $("a.name", block).html data["full_name"]
      $(block).removeClass("is-in is-out").addClass("is-" + data["status"])
      $('span.status', block).html data["status"]
      return

    false
