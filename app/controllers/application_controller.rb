class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def default_serializer_options
    {root: false}
  end

  protected

    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        @current_user = User.find_by(token: token)
      end
    end
end
