class LikesController < ProtectedController
  before_action :set_like, only: [:show, :update]

  # GET /likes
  def index
    @likes = Like.all

    render json: @likes
  end

  # GET /likes/1
  def show
    render json: @like
  end

  # POST /likes
  def create
    @like = Like.new(user_id: current_user.id, advice_id: params[:id])

    if @like.save
      render json: @like, status: :created
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /likes/1
  def update
    if @like.update(like_params)
      render json: @like
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:advice_id, :user_id)
    end
end
