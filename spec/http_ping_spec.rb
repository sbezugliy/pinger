# frozen_string_literal: true

RSpec.describe Pinger::HTTPPing do
  let!(:successful_ping) { Pinger::HTTPPing.new('https://google.com') }
  let!(:undef_ping) { Pinger::HTTPPing.new('https://arpa.net') }
  let!(:failed_ping) { Pinger::HTTPPing.new('https://google.com/asdasdadasd') }

  it 'should return status from 200 to 399 for successful example ' do
    expect(successful_ping.exec).to be_between(200, 399)
    expect(successful_ping.state).to be_truthy
  end

  it 'should return 404 for not resolvable host' do
    expect(failed_ping.exec).to be_between(400, 600)
    expect(failed_ping.state).to be_falsey
  end

  it 'should return 0 code for unresolvable host' do
    expect(undef_ping.exec).to be(0)
    expect(undef_ping.state).to be_falsey
  end
end
