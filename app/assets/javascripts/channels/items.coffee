App.items = App.cable.subscriptions.create "ItemsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
#    switch data.action
#      when 'processing'
#        $("#claim_#{data.item_id}").removeClass('btn-danger btn-primary').addClass('btn-warning').val('В процессе...')
#      when 'unclaimed'
#        $("#item_#{data.item_id}").replaceWith data.html
#      when 'claimed'
#        $("#item_#{data.item_id}").replaceWith data.html

  toggle_claim: (user_id, item_id) ->
#    @perform 'toggle_claim', {user_id: user_id, item_id: item_id}

