require 'microsoft_kiota_abstractions'
require_relative 'oauth_access_token_provider'
module MicrosoftGraphCoreRights
    module Authentication
        class OAuthAuthenticationProvider < MicrosoftKiotaAbstractions::BaseBearerTokenAuthenticationProvider
            def initialize(token_request_context, allowed_hosts, scopes)
                super(MicrosoftGraphCoreRights::Authentication::OAuthAccessTokenProvider.new(token_request_context, allowed_hosts, scopes))
            end
        end
    end
end
