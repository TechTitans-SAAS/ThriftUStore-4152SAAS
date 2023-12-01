class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy]
  before_action :authenticate_user!

  # GET /items or /items.json
  def index
    @items = Item.all

    # Search logic
    if params[:search].present?
      search_term = params[:search]
      @items = @items.where("title LIKE :search OR detail LIKE :search OR CAST(price AS TEXT) LIKE :search", search: "%#{search_term}%")
    end

    # Sorting logic
    if params[:sort].present?
      sort_direction = params[:direction] == 'desc' ? 'desc' : 'asc'

      if params[:sort] == 'owner_rating'
        # Here, we need a more complex query
        @items = Item.joins(:user)
                     .select('items.*, (SELECT AVG(rating) FROM items i WHERE i.user_id = users.id AND rating IS NOT NULL) as avg_rating')
                     .order("avg_rating #{sort_direction}, items.id")
      else
        @items = @items.order(params[:sort] => sort_direction)
      end
    end
  end


  # GET /items/1 or /items/1.json
  def show
    @item = Item.find(params[:id])
    @comments = @item.comments.order(created_at: :desc)
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  def mark_as_sold
    @item = Item.find(params[:id])
    buyer_email = params[:item][:buyer_email]
    user = User.find_by(email: buyer_email)

    if not buyer_email.present?
      flash[:alert] = "You should input an Email!"
      redirect_to item_path(@item) and return
    end

    if not user.present?
      flash[:alert] = "Invalid Email address!"
      redirect_to item_path(@item) and return
    end

    if not (@item.update(item_params) && @item.save)
      flash[:alert] = "Failed to mark item as sold."
    end
    redirect_to item_path(@item)
  end

  def update_rating
    @item = Item.find(params[:id])
    @item.update(rating: params[:rating])
    redirect_to item_path(@item)
  end


  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    @item.user = current_user
    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.wish_list_pairs.destroy_all

    @item.destroy

    respond_to do |format|
      format.html { redirect_to user_my_items_path(current_user), notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      # This will print the contents of params to your server log.
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:title, :detail, :price, :image, :user_id, :buyer_email)
    end
end
