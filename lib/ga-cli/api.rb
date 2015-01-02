require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'google/api_client/auth/file_storage'
require 'json'

module GACli
  class Api
    class InexpectantResponse < StandardError; end

    #
    # [param] String store
    #
    def initialize(store)
      @client    = nil
      @analytics = nil
      @last_request = nil

      init_and_auth_analytics(store)
    end
    attr_reader :client, :analytics, :last_request

    #
    # [param] String store
    #
    def init_and_auth_analytics(store)
      @client = ::Google::APIClient.new(
                                    :application_name    => :gacli,
                                    :application_version => Version)

      credential = ::Google::APIClient::FileStorage.new(store)
      secrets    = ::Google::APIClient::ClientSecrets.load(File.dirname(store))

      if credential.authorization.nil?
        flow = ::Google::APIClient::InstalledAppFlow.new(
          :client_id     => secrets.client_id,
          :client_secret => secrets.client_secret,
          :scope         => ['https://www.googleapis.com/auth/analytics',
                             'https://www.googleapis.com/auth/analytics.edit'])

        client.authorization = flow.authorize
        credential.write_credentials(client.authorization)
      else
        client.authorization = credential.authorization
      end

      @analytics = client.discovered_api('analytics', 'v3')
    end

    #
    # [param]  Object method
    # [return] Hash
    #
    def execute(method, params = {})
      @last_request = client.execute(
                        :api_method => method,
                        :parameters => params)

      result = JSON.parse(last_request.response.body)
      if result['error']
        raise InexpectantResponse, result['error']
      else
        result
      end
    end
  end
end
