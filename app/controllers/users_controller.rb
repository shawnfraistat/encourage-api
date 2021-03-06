# frozen_string_literal: true

class UsersController < ProtectedController
  skip_before_action :authenticate, only: %i[signup signin]

  # GET '/users/:id'
  def getuseradvices
    @advices = current_user.advices
    render json: @advices
  end

  # POST '/sign-up'
  def signup
    user = User.create(user_creds)
    if user.valid?
      render json: user, status: :created
    else
      render json: user.errors, status: :bad_request
    end
  end

  # POST '/sign-in'
  def signin
    creds = user_creds
    if (user = User.authenticate creds[:email],
                                 creds[:password])
      render json: user, serializer: UserLoginSerializer, root: 'user'
    else
      head :unauthorized
    end
  end

  # DELETE '/sign-out'
  def signout
    current_user.logout
    head :no_content
  end

  # PATCH '/change-password/:id'
  def changepw
    # if the the old password authenticates,
    # the new one is not blank,
    # and the model saves
    # then 204
    # else 400
    if current_user.authenticate(pw_creds[:old]) &&
       !(current_user.password = pw_creds[:new]).blank? &&
       current_user.save
      head :no_content
    else
      head :bad_request
    end
  end

  # PATCH 'change-tags'
  # updates the tags specifying the kinds of advice user wants to view
  def change_tags
    current_user.tags = params[:tags]
    if current_user.save
      head :no_content
    else
      head :bad_request
    end
  end

  private

  def user_creds
    params.require(:credentials)
          .permit(:email, :password, :password_confirmation, :tags, :first_name, :last_name, :admin)
  end

  def pw_creds
    params.require(:passwords)
          .permit(:old, :new)
  end
end
