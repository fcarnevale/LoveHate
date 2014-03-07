VCR.configure do |config|
  config.cassette_library_dir = "fixtures/cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<GOOGLE API KEY>") { ENV["GOOGLE_API_KEY"] }
end