# frozen_string_literal: true

require 'pinger/version'

##
# PokuponPinger module
module Pinger
  require 'yaml'

  require 'pinger/http_ping'
  require 'pinger/mailer'
  require 'pinger/job'
  ##
  # Pinger class
  class Pinger
    ##
    # Array of hosts to create ping job
    attr_reader :hosts
    # Mail server parameters
    attr_reader :mail
    # Delay between pings
    attr_reader :delay
    # Verbose output to STDOUT
    attr_reader :verbose
    # Array of Threads with jobs
    attr_accessor :jobs
    
    ##
    # Pinger object constructor
    def initialize(config_file = '/config/config.yml')
      @config_file = File.open(File.join(__dir__, '..', config_file))
      read_config
      Mailer.config(@mail)
      @jobs = []
    end

    ##
    # Start job execution
    def exec
      hosts.each do |h|
        job = Job.new(h)
        job.verbose = @verbose
        @jobs << Thread.new do
          loop do
            job.exec
            sleep(@delay)
          end
        end
      end
      @jobs.each(&:join)
    end

    private

    ##
    # Read configuration YAML file
    def read_config
      cfg = YAML.safe_load(@config_file)
      @hosts = cfg['pinger']['hosts']
      @mail = cfg['pinger']['mail']
      @delay = cfg['pinger']['delay']
      @verbose = cfg['pinger']['verbose']
    end
  end
end
