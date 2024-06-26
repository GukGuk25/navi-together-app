# frozen_string_literal: true

require 'http'

module Cryal
  # Returns an authenticated user, or nil
  class CreateAccount
    class InvalidAccount < StandardError; end

    def initialize(config)
      @config = config
    end

    def call(email:, username:, password:)
      account = { email:, username:, password: }
      response = HTTP.post("#{@config.API_URL}/accounts/", json: SignedMessage.sign(account))

      raise InvalidAccount unless response.code == 201
    end
  end
end
