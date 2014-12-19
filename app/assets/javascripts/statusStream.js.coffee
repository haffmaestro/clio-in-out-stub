class StatusStream
  constructor: (sourceUrl) ->
    @source = new EventSource(sourceUrl)
    @source.addEventListener 'users.in', (e) ->
      userId = $.parseJSON(e.data).userId
      $status = $(".user-status[data-id='#{userId}']")
      $status.removeClass('is-out')
      $status.addClass('is-in')
      $status.find('.status').text('in')

    @source.addEventListener 'users.out', (e) ->
      userId = $.parseJSON(e.data).userId
      $status = $(".user-status[data-id='#{userId}']")
      $status.removeClass('is-in')
      $status.addClass('is-out')
      $status.find('.status').text('out')

window.StatusStream = StatusStream
