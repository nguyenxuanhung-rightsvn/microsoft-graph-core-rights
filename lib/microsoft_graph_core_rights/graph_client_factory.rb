require 'microsoft_kiota_faraday'
require_relative 'graph_client_options'
require_relative 'middleware/telemetry_handler'
module MicrosoftGraphCoreRights
	class GraphClientFactory
		def self.get_default_middleware()
			middleware = MicrosoftKiotaFaraday::KiotaClientFactory.get_default_middleware
			middleware << MicrosoftGraphCoreRights::Middleware::TelemetryHandler
			return middleware
		end
		def self.get_default_http_client(middleware=nil, default_options = [MicrosoftGraphCoreRights::GraphClientOptions.new])
			if middleware.nil? then #empty is fine in case the user doesn't want to use any middleware
				middleware = get_default_middleware
			end
			client = MicrosoftKiotaFaraday::KiotaClientFactory.get_default_http_client(middleware, default_options)
			return client
		end
	end
end
