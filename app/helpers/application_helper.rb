module ApplicationHelper
  def menuitem(name, url, active)
    content_tag :li, class: active ? 'active' : '' do
      link_to name, url
    end
  end

  def menu_items
    [
        { name: 'Покупки', url: our_items_path },
        { name: 'Люди', url: our_users_path },
        { name: 'Финансы', url: our_finances_path }
    ]
  end

  def map_link_to(list, prop)
    array = list.map do |item|
      link_to item.send(prop), our_users_path
    end
    array.join(', ').html_safe
  end
end
