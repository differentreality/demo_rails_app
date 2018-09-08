module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token
    skip_authorization_check

    User.omniauth_providers.each do |provider|
      define_method(provider) { handle(provider) }
    end

    private

    def handle(provider)
      auth_hash = request.env['omniauth.auth']
      uid = auth_hash[:uid]
      openid = Openid.find_for_oauth(auth_hash) # Get or create openid
      # If openid exists and is associated with a user, sign in with associated user,
      # even if the email of the associated user and the email of the provided openid are different
      unless (user = openid.user)
        user = User.find_for_auth(auth_hash, current_user) # Get or create users
      end

      begin
        user.skip_confirmation!
        user.save!(validate: false)
        openid.user = user if openid.user != user
        openid.save!

        sign_in user
        flash[:notice] = "User with email #{user.email} successfully added #{provider} provider (#{openid.email})."
        redirect_to after_sign_in_path_for(user) # edit_user_registration_path
      rescue => e
        flash[:error] = e.message
        redirect_to new_user_registration_path
      end
    end
  end
end
