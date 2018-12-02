class AdvicesController < ProtectedController
  before_action :set_advice, only: [:show, :update, :unapprove, :destroy]

  # GET /advices
  def index
    @advices = Advice.all

    render json: @advices
  end

  # GET /advices/1
  def show
    source_user = User.find(@advice.user_id)
    @advice.first_name = source_user.first_name
    @advice.last_name = source_user.last_name.chr + '.'
    render json: @advice
  end

  # GET /random-advice
  # this method returns a random piece of advice to the client
  # it filters all the available advice and only returns advice that is tagged
  # with one of the categories the user is interested in
  # it also filters out advice that hasn't been approved
  # finally, the advice is selected from a filtered array with a weighted random
  # pieces of advice are added to the array twice if they've been liked two
  # times more than the average, and thrice if liked three times more
  def getrandom
    advice_list = []
    final_list = []
    user_tags = current_user.tags.split(' ')
    user_tags.each do |tag|
      advice_list << Advice.all.select { |advice| advice.tags.split(' ').include?(tag) && advice.approved == "true"}
    end
    advice_list.flatten!
    upvote_avg = Like.all.length / advice_list.length
    advice_list.each do |advice|
      final_list << advice
      final_list << advice if advice.likes.length >= (upvote_avg * 3)
      final_list << advice if advice.likes.length >= (upvote_avg * 2)
    end
    @advice = final_list.sample
    source_user = User.find(@advice.user_id)
    @advice.first_name = source_user.first_name
    @advice.last_name = source_user.last_name.chr + '.'
    render json: @advice
  end

  # POST /advices
  def create
    @advice = current_user.advices.build(advice_params)

    if @advice.save
      render json: @advice, status: :created, location: @advice
    else
      render json: @advice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /advices/1
  def update
    @advice.approved = 'true'
    if @advice.save
      render json: @advice
    else
      render json: @advice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /advices/unapprove/1
  def unapprove
    @advice.approved = 'false'
    if @advice.save
      render json: @advice
    else
      render json: @advice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /advices/1
  def destroy
    @advice.destroy
  end

  # GET /get-favorites
  # returns favorited advices belonging to current user
  def getfavorites
    favorite_advice_ids = []
    current_user.favorites.each { |favorite| favorite_advice_ids << favorite.advice_id }
    @favorite_advices = Advice.all.select { |element| favorite_advice_ids.include? element.id }
    render json: @favorite_advices
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advice
      @advice = Advice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def advice_params
      params.require(:advice).permit(:content, :tags, :likes, :approved, :user_id)
    end
end
