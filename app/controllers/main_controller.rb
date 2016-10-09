class MainController < ApplicationController
  FILTER_ALL = ['claims', 'purchased', 'other']
  # before_action :set_current_user
  before_action :set_session_filter

  def index
    case session[:active_tab]
      when nil, our_items_path
        redirect_to our_items_path
      when our_users_path
        redirect_to our_users_path
      when our_finances_path
        redirect_to our_finances_path
    end
  end

  def our_items
    session[:active_tab] = our_items_path
    set_items
    render :index
  end

  def our_users
    session[:active_tab] = our_users_path
    @users               = User.all
    render :index
  end

  def our_finances
    session[:active_tab] = our_finances_path
    render :index
  end

  def claim
    item = Item.find(params[:item_id])

    set_items
    unless item.claimers.exists? current_user.id
      item.claimers << current_user
      item.reload
      current_user.reload
    end

    respond_to do |format|
      format.js do
        @result      = render_to_string partial: 'items/item', locals: { item: item, current_user: current_user }
        @replace_tag = "#item_#{item.id}"
        render 'replace_item'
      end
      format.html { render :index }
    end
  end

  def unclaim
    item = Item.find(params[:item_id])

    set_items
    if item.claimers.exists? current_user.id
      item.claimers.delete current_user
      item.reload
      current_user.reload
    end

    respond_to do |format|
      format.js do
        @result      = render_to_string partial: 'items/item', locals: { item: item, current_user: current_user }
        @replace_tag = "#item_#{item.id}"
        render 'replace_item'
      end
      format.html { render :index }
    end
  end

  def set_user_filter
    user_filter = params[:filter].split /[\+\-]/

    case user_filter

      when 'all'
        session[:filter] = Set.new FILTER_ALL
      when 'reset'
        session[:filter] = Set.new []
      when 'claims', 'purchased', 'other'
        session[:filter] = session[:filter].to_set ^ [user_filter]
    end

    respond_to do |format|
      format.js do
        set_items
        @result = render_to_string partial: 'main/items'
        render 'replace_main'
      end
      format.html do
        set_items
        render :index
      end
    end
  end

  def start_crowdfunding
    respond_to do |format|
      format.js do
        @uuid   = SecureRandom.uuid
        @result = render_to_string partial: 'main/items'
        render 'replace_main'
      end
    end
  end


  private
    def set_items
      user   = current_user
      @items = []
      if session[:filter].size == FILTER_ALL.size
        @items = Item.all
      else
        @items += user.claim_items - user.purchase_items if session[:filter].include?('claims')
        @items += user.purchase_items if session[:filter].include?('purchased')
        @items += user.other_items if session[:filter].include?('other')
      end
    end

    def set_session_filter
      session[:filter] ||= Set.new FILTER_ALL
    end
end
