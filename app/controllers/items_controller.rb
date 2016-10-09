class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :image]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item  = Item.new
    @users = User.all
  end

  # GET /items/1/edit
  def edit
    @users = User.all
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to our_items_path, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    # p item_params
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to our_items_path, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to our_items_path, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def image
    if @item.data
      send_data @item.data,
                :type        => @item.mime_type,
                :filename    => "#{@item.filename}.jpg",
                :disposition => "inline"
    else
      redirect_to '/images/empty.png'
    end
  end


  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    if params[:item][:image]
      image_params = if params[:item][:image]
                       {
                           data:      params[:item][:image].read,
                           filename:  params[:item][:image].original_filename,
                           mime_type: params[:item][:image].content_type
                       }
                     end
    end

    params
        .require(:item)
        .permit(:description, :url, :price, :itemtype)
        .merge(image_params || {})
        .merge({ offered_by: current_user.id })
  end
end
