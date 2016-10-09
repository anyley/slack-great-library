# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ItemsChannel < ApplicationCable::Channel
  def subscribed
    # stream_for "items"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def toggle_claim(data)
    ActionCable.server.broadcast('items:items', data.merge({ 'action' => 'processing' }))
    user = User.find(data['user_id'])
    item = Item.find(data['item_id'])

    if item.claimers.exists? user
      user.claim_items.delete item
      item.reload
      ActionCable.server.broadcast('items:items',
                                   data.merge({ 'action' => 'unclaimed',
                                                html:    ItemsController.renderer.render(
                                                    partial:  'item',
                                                    locals:   { item: item, current_user: user }
                                                )
                                              }))
    else
      user.claim_items << item
      item.reload
      ActionCable.server.broadcast('items:items',
                                   data.merge({ 'action' => 'unclaimed',
                                                html:    ItemsController.renderer.render(
                                                    partial: 'item',
                                                    locals:  { item: item, current_user: user }
                                                )
                                              }))

    end
  end
end
