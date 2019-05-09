# frozen_string_literal: true

##
# Pinger module
module Pinger
  require 'net/smtp'
  require 'singleton'
  ##
  # Email sender class. Singleton.
  class Mailer
    include Singleton
    class << self
      # Parameters of SMTP server
      attr_reader :smtp_config
      # Email address from
      attr_reader :from
      # Email address to
      attr_reader :to
      # Subject
      attr_reader :subject

      ##
      # Configure mailer parameters
      def config(config)
        creds = config['credentials']
        @from = creds['from']
        @to = creds['to']
        @subject = creds['subject']
        @smtp_config = config['smtp']
      end

      ##
      # Send mail
      def send(message)
        Net::SMTP.start(
          @smtp_config['hostname'],
          @smtp_config['port'],
          @smtp_config['hostname'],
          @smtp_config['username'],
          @smtp_config['password'],
          @smtp_config['auth'].to_sym
        ) {|smtp| smtp.send_message message, @from, @to}
      end
    end
  end
end
