# frozen_string_literal: true

RSpec.describe Pinger do
  let!(:pinger) { Pinger::Pinger.new('spec/fixtures/config.yml') }

  it 'has a version number' do
    expect(Pinger::VERSION).not_to be nil
  end

  it 'should have correct hosts config' do
    expect(pinger.hosts).to eq([
                                 'https://google.com',
                                 'http://localhost',
                                 'https://arpa.net'
                               ])
  end

  it 'should have correct smtp config' do
    expect(pinger.mail['smtp']['hostname']).to eq('smtp.mailtrap.io')
    expect(pinger.mail['smtp']['port']).to be(2525)
    expect(pinger.mail['smtp']['username']).to eq('41e2c570cb356c')
    expect(pinger.mail['smtp']['password']).to eq('9f7b8910f78c68')
    expect(pinger.mail['smtp']['auth'].to_sym).to be(:cram_md5)
  end

  it 'should have correct credentials config' do
    expect(pinger.mail['credentials']['from']).to  \
      eq('Pinger Sender <from@smtp.mailtrap.io>')
    expect(pinger.mail['credentials']['to']).to \
      eq('Pinger Receiver <to@smtp.mailtrap.io>')
    expect(pinger.mail['credentials']['subject']).to \
      eq('Servers state!')
  end

  it 'should have read delay config' do
    expect(pinger.delay).to eq(60)
  end

  it 'should have read verbosity config' do
    expect(pinger.verbose).to be_falsy
  end
end
