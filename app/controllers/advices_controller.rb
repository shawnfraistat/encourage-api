class AdvicesController < ProtectedController
  before_action :set_advice, only: [:show, :update, :destroy]

  # GET /advices
  def index
    @advices = current_user.advices

    render json: @advices
  end

  # GET /advices/1
  def show
    render json: @advice
  end

  # GET /random-advice
  def getrandom
    user_tags = current_user.tags.split(' ')
    advice_list = []
    user_tags.each do |tag|
      advice_list << Advice.where(current_user.tags.split(' ').include?(tag))
    end
    @advice = advice_list.sample
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
    if @advice.update(advice_params)
      render json: @advice
    else
      render json: @advice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /advices/1
  def destroy
    @advice.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advice
      @advice = Advice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def advice_params
      params.require(:advice).permit(:content, :tags, :upvotes, :approved, :user_id)
    end
end
