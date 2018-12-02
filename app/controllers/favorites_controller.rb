class FavoritesController < ProtectedController
  # POST /favorites/1
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
end
