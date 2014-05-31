require 'rubygems'
require 'bundler/setup'
require 'find_keywords'
#require_relative './support/fake_pepperjam_api'

RSpec.configure do |config|
=begin
  config.before(:each) do
    stub_request(:any, /api.pepperjamnetwork.com/ ).to_rack( FakePepperjamApi )
  end
=end
end