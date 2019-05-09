# frozen_string_literal: true

##
# PokuponPinger module
module Pinger
  ##
  # Class providing HTTP ping functionality
  class HTTPPing
    require 'net/http'

    ##
    # State of server true - available of false - unavailable
    attr_reader :state

    ##
    # Initialize pinger class for host
    def initialize(host)
      @host = URI(host)
      @status = 200
      @state = true
    end

    ##
    # Execute http request and return status
    def exec
      @status = Net::HTTP.get_response(@host).code.to_i
    rescue StandardError
      @status = 0
    ensure
      @state = (200..399).cover?(@status)
    end
  end
end
