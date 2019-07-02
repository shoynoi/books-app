# frozen_string_literal: true

module OmniAuthHelper
  def set_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      provider: "github",
      uid: "12345",
      info: {
        name: "github_oauth_user",
        email: "github_oauth_user@example.com"
      }
    )
  end
end
