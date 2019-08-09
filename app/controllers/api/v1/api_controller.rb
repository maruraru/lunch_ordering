module Api::V1
  class ApiController < ActionController::API
    before_action :authenticate_user

    private
    def authenticate_user
      user_token = request.headers['X-USER-TOKEN']
      if user_token
        @user = User.find_by(authentication_token: user_token)
        if @user.nil?
          unauthorize
        end
      else
        unauthorize
      end
    end

    def unauthorize
      self.status = :unauthorized
      self.response_body = { error: 'Access denied' }.to_json
    end
  end
end
