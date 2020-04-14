# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication 
      flash[:notice] = 'Please fillup other fields by clicking your email on top right' 
    else
      flash.alert = 'There was a problem signing you in through Google.Please register or try signin later.'
      redirect_to new_user_registration_url
    end
  end

  def github
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      flash[:notice] = 'Please fillup other fields by clicking your email on top right' if is_navigational_format?
    else
      flash.alert = 'There was a problem signing you in through github.Please register or try signin later.'
      redirect_to new_user_registration_url
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  def failure
    super
  end

  protected

  # The path used when OmniAuth fails
  def after_omniauth_failure_path_for(scope)
    super(scope)
  end
end
