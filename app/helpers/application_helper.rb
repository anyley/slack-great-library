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


  #
  # Кнопки => remote: true, method: [:post :get :patch :put :delete]
  #
  def merge_button_options options={}, options2={}
    new_opt = options.clone
    new_opt[:class] = "btn btn-medium btn-default #{new_opt[:class] || ''} #{options2[:class] || ''}"
    new_opt.merge! remote: true, method: options2[:method] || :get
  end

  def remote_button label, path, options={}
    link_to label, path, options.merge(remote: true)
  end

  def delete_button label, path, options={}
    new_opt = merge_button_options options, class: 'btn-danger', method: :delete
    remote_button label, path, new_opt
  end

  def get_button label, path, options={}
    new_opt = merge_button_options options, method: :get
    remote_button label, path, new_opt
  end

  def post_button label, path, options={}
    new_opt = merge_button_options options, method: :post
    remote_button label, path, new_opt
  end

  def put_button label, path, options={}
    new_opt = merge_button_options options, method: :put
    remote_button label, path, new_opt
  end

  def patch_button label, path, options={}
    new_opt = merge_button_options options, method: :patch
    remote_button label, path, new_opt
  end

  def primary_button label, path, options={}
    new_opt = merge_button_options options, class: 'btn-primary'
    remote_button label, path, new_opt
  end

  def danger_button label, path, options={}
    new_opt = merge_button_options options, class: 'btn-danger'
    remote_button label, path, new_opt
  end
end
