$root = File.expand_path('../../', __FILE__)
require "#{$root}/spec/spec_helper"

describe Rawscsi do   
  it 'can register multiple models' do
    Rawscsi.register 'Song' do |config|
      config.domain_name = 'good_songs'
      config.domain_id = 'akldfjakljf3894fjeaf9df'
      config.region = 'us-east-1'
      config.api_version = '2011-02-01'
    end
    song_config = Rawscsi.registered_models['Song']

    Rawscsi.register 'Book' do |config|
      config.domain_name = 'good_books'
      config.domain_id = 'dj43g6i77dof86lk34fsf2s'
      config.region = 'us-east-1'
      config.api_version = '2011-02-01'
    end
    book_config = Rawscsi.registered_models['Book']

    expect(song_config.domain_name).to eq('good_songs')
    expect(song_config.domain_id).to eq('akldfjakljf3894fjeaf9df')
    expect(song_config.region).to eq('us-east-1')
    expect(song_config.api_version).to eq('2011-02-01')

    expect(book_config.domain_name).to eq('good_books')
    expect(book_config.domain_id).to eq('dj43g6i77dof86lk34fsf2s')
    expect(book_config.region).to eq('us-east-1')
    expect(book_config.api_version).to eq('2011-02-01')
  end

  it 'http_options parameter must be an instance of Hash' do
    expect {
      Rawscsi.register 'Song' do |config|
        config.domain_name = 'good_songs'
        config.domain_id = 'akldfjakljf3894fjeaf9df'
        config.region = 'us-east-1'
        config.api_version = '2011-02-01'
        config.http_options = ''
      end
    }.to raise_error RuntimeError, 'The http_options parameter must be an instance of Hash'
  end

  it 'http_options parameter default value is {}' do
    Rawscsi.register 'Song' do |config|
      config.domain_name = 'good_songs'
      config.domain_id = 'akldfjakljf3894fjeaf9df'
      config.region = 'us-east-1'
      config.api_version = '2011-02-01'
    end
    song_config = Rawscsi.registered_models['Song']
    expect(song_config.http_options).to eq({})
  end

  it 'http_options parameter value is correct' do
     Rawscsi.register 'Song' do |config|
      config.domain_name = 'good_songs'
      config.domain_id = 'akldfjakljf3894fjeaf9df'
      config.region = 'us-east-1'
      config.api_version = '2011-02-01'
      config.http_options = { http_proxyaddr: 'proxy.com' }
    end
    song_config = Rawscsi.registered_models['Song']
    expect(song_config.http_options).to eq({ http_proxyaddr: 'proxy.com' })
  end
end

