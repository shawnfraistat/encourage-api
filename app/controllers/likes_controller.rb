class LikesController < ProtectedController
  # POST /likes/1
  # the [:id] refers to the advice_id of the like that is being created--
  # it's not the id of the like itself.
  # this method returns the new like
  def create
    @like = Like.new(user_id: current_user.id, advice_id: params[:id])

    if @like.save
      render json: @like, status: :created
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  # the [:id] refers to the advice_id of the like that is being destroyed--
  # it's not the id of the like itself.
  # this method returns the advice object after the like has been destroyed
  def destroy
    @like = Like.where("advice_id = ? AND user_id = ?", params[:id], current_user.id)
    @like.destroy(@like.ids)
    @advice = Advice.find(params[:id])
    render json: @advice
  end
end
