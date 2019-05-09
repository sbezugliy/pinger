# frozen_string_literal: true

module Pinger
  ##
  # Job scheduler and executor
  class Job

    # Hostname for this job
    attr_reader :host
    # Represents state from current ping
    attr_accessor :current_state
    # Represents state from previous ping
    attr_accessor :prev_state
    # Flag to output messages to STDOUT
    attr_accessor :verbose

    ##
    # Ping job initializer
    def initialize(host)
      @host = host
      @verbose = false
      @http_ping = HTTPPing.new(host)
      @prev_state = false
      @current_state = false
    end

    ##
    # Execute job
    def exec
      @prev_state = @http_ping.state
      @http_ping.exec
      @current_state = @http_ping.state
      send_mail if state_to_send
      debug if @verbose
    end

    ##
    # Get state to send mail from prvious and current server states
    def state_to_send
      return true if (@current_state || @prev_state) && \
                     !(@current_state && @prev_state)

      return false
    end

    private

    ##
    # Prepare body and send mail
    def send_mail
      msg = "\n=========================================================\n" \
            '  Server name: ' + @host + "\n" \
            '  Status:      ' + server_status + "\n" \
            "\n=========================================================\n"
      Mailer.send(msg)
    end

    ##
    # Get text value of server status
    def server_status
      @current_state ? 'Available' : 'Unavailable'
    end

    ##
    # Output debug messages to the STDOUT
    def debug
      STDOUT.puts "\n=========================================================\n" \
                  'Server name: ' + @host + "\n" \
                  '  Status:    ' + server_status + "\n" \
                  '  Mailer:    ' + "\n" \
                  '    from:    ' + Mailer.from + "\n" \
                  '    to:      ' + Mailer.to + "\n" \
                  '    subject: ' + Mailer.subject + "\n"
    end
  end
end
