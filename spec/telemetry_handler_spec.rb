require 'faraday'
# frozen_string_literal: true
RSpec.describe MicrosoftGraphCoreRights do
    it "adds a client id" do
		handler = MicrosoftGraphCoreRights::Middleware::TelemetryHandler.new
		env = {
			url: URI.parse("https://graph.microsoft.com/v1.0/users"),
			request_headers: Faraday::Utils::Headers.new
		}
		handler.call(env)
		expect(env[:request_headers]["client-request-id"]).to include("-") #guids have dashes
	end

	it "adds a service info" do
		options = MicrosoftGraphCoreRights::GraphClientOptions.new
		options.graph_service_library_version = "1.0.0"
		options.graph_service_version = "v1.0"
		handler = MicrosoftGraphCoreRights::Middleware::TelemetryHandler.new
		env = {
			url: URI.parse("https://graph.microsoft.com/v1.0/users"),
			request_headers: Faraday::Utils::Headers.new,
			request: {
				context: {
					options.get_key => options
				}
			}
		}
		handler.call(env)
		expect(env[:request_headers]["SdkVersion"]).to include("graph-ruby-v1.0")
		expect(env[:request_headers]["SdkVersion"]).to include("/1.0.0")
		expect(env[:request_headers]["SdkVersion"]).to include("hostOS=")
		expect(env[:request_headers]["SdkVersion"]).to include("hostArch=")
		expect(env[:request_headers]["SdkVersion"]).to include("runtimeEnvironment=")
		expect(env[:request_headers]["SdkVersion"]).to include("graph-ruby-core")
	end
end
