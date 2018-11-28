class FavoritesController < ProtectedController
  # before_action :set_favorite, only: [:show, :update, :destroy]

  # # GET /favorites
  # def index
  #   @favorites = Favorite.all
  #
  #   render json: @favorites
  # end
  #
  # # GET /favorites/1
  # def show
  #   render json: @favorite
  # end

  # POST /favorites
  # the [:id] refers to the advice_id of the favorite that is being created--
  # it's not the id of the like itself.
  # this method returns the new favorite
  def create
    @favorite = Favorite.new(user_id: current_user.id, advice_id: params[:id])

    if @favorite.save
      render json: @favorite, status: :created
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /favorites/1
  # def update
  #   if @favorite.update(favorite_params)
  #     render json: @favorite
  #   else
  #     render json: @favorite.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /favorites/1
  # the [:id] refers to the advice_id of the like that is being destroyed--
  # it's not the id of the like itself.
  # this method returns the advice object after the like has been destroyed
  def destroy
    @favorite = Favorite.where("advice_id = ? AND user_id = ?", params[:id], current_user.id)
    @favorite.destroy(@favorite.ids)
    @advice = Advice.find(params[:id])
    render json: @advice
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_favorite
  #     @favorite = Favorite.find(params[:id])
  #   end
  #
  #   # Only allow a trusted parameter "white list" through.
  #   def favorite_params
  #     params.require(:favorite).permit(:user_id, :advice_id)
  #   end
end
