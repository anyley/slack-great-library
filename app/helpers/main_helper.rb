module MainHelper

  def filter_buttons(filter)
    filter_list = {
        'claims'    => 'Мои заявки',
        'purchased' => 'Оплачены',
        'other'     => 'Прочие'
    }

    links = []

    links << if filter.size == filter_list.size
               link_to 'Все', set_user_filter_path('reset'),
                       remote: true,
                       class:  "btn btn-primary"
             else
               link_to 'Все', set_user_filter_path('all'),
                       remote: true,
                       class:  "btn btn-default"
             end

    links << filter_list.map do |key, label|
      link_to label,
              set_user_filter_path(key),
              remote: true,
              class:  "btn #{ session[:filter].include?(key) ? 'btn-primary' : 'btn-default' }"
    end
    links.join.html_safe
  end
end
