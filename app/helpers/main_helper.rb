module MainHelper

  def filter_buttons
    filter_list = {
        'all'       => 'Все',
        'claims'    => 'Мои заявки',
        'purchased' => 'Оплачены',
        'other'     => 'Прочие'
    }

    links = filter_list.map do |key, label|
      link_to label,
              set_user_filter_path(key),
              remote: true,
              class:  "btn #{ session[:filter].include?(key) ? 'btn-primary' : 'btn-default' }"
    end
    links.join.html_safe
  end
end
