# frozen_string_literal: true

RSpec.describe Pinger::Job do
  let!(:pinger) { Pinger::Pinger.new('spec/fixtures/config.yml') }
  let!(:job) do
    job = Pinger::Job.new(pinger.hosts.first)
    job.verbose = true
    job
  end

  it 'should have read verbosity config' do
    expect(job).to be_instance_of(Pinger::Job)
  end

  it 'should have correct attributes' do
    expect(job.host).to be(pinger.hosts.first)
    expect(job.verbose).to be_truthy
    expect(job.prev_state).to be_falsy
  end

  it 'should have falsy state_to_send if previous and current state is Available' do
    job.prev_state = true
    job.current_state = true
    expect(job.state_to_send).to be_falsy
  end

  it 'should have falsy state_to_send if previous and current state is Unavailable' do
    job.prev_state = false
    job.current_state = false
    expect(job.state_to_send).to be_falsy
  end

  it 'should have truthy state_to_send if previous state is Available and current Unavailable' do
    job.prev_state = true
    job.current_state = false
    expect(job.state_to_send).to be_truthy
  end

  it 'should have truthy state_to_send if previous state is Unavailable and current Available' do
    job.prev_state = false
    job.current_state = true
    expect(job.state_to_send).to be_truthy
  end
end
