# -*- coding: utf-8 -*-
require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'google/api_client/auth/file_storage'
require 'json'

module GAShikomi
  class Api
    class InexpectantResponse < StandardError; end

    GOOGLE_API_KEYS = %w(GOOGLE_API_CREDENTIAL GOOGLE_API_SECRETS)

    #
    # [param] String store
    #
    def initialize(store)
      @client       = nil
      @analytics    = nil
      @last_request = nil

      init_and_auth_analytics(store)
    end
    attr_reader :client, :analytics, :last_request

    def init_and_auth_analytics(store)
      init_client

      if GOOGLE_API_KEYS.all? {|e| ENV.has_key? e}
        init_and_auth_with_env
      else
        init_and_auth_with_file_storage(store)
      end

      @analytics = client.discovered_api('analytics', 'v3')
    end

    def init_and_auth_with_env
      credential = ::Google::APIClient::Storage.new(EnvStore.new(ENV))
      credential.authorize
      secrets    = ::Google::APIClient::ClientSecrets.new(JSON.parse(ENV['GOOGLE_API_SECRETS']))

      client.authorization = credential.authorization
    end

    #
    # [param] String store
    #
    def init_and_auth_with_file_storage(store)
      credential = ::Google::APIClient::FileStorage.new(store)
      secrets    = ::Google::APIClient::ClientSecrets.load(File.dirname(store))

      if credential.authorization.nil?
        flow = flow(secrets)

        client.authorization = flow.authorize
        credential.write_credentials(client.authorization)
      else
        client.authorization = credential.authorization
      end
    end

    def init_client
      @client = ::Google::APIClient.new(
                                    :application_name    => :gacli,
                                    :application_version => VERSION)
    end

    #
    # [param]  Google::APIClient::ClientSecrets
    # [return] Google::APIClient::InstalledAppFlow
    #
    def flow(secrets)
      ::Google::APIClient::InstalledAppFlow.new(
          :client_id     => secrets.client_id,
          :client_secret => secrets.client_secret,
          :scope         => ['https://www.googleapis.com/auth/analytics',
                             'https://www.googleapis.com/auth/analytics.edit'])
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
