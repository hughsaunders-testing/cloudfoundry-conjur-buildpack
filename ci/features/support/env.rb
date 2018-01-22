require 'rspec'
require 'tmpdir'
require 'conjur-api'

Conjur.configuration.appliance_url = ENV['CONJUR_APPLIANCE_URL'] || 'http://conjur'
Conjur.configuration.account = ENV['CONJUR_ACCOUNT'] || 'cucumber'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Before('@BUILD_DIR') do
  @BUILD_DIR = Dir.mktmpdir
end

After('@BUILD_DIR') do
  FileUtils.remove_entry_secure @BUILD_DIR
end

def reset_root_policy
  login = 'admin'
  password = 'admin'
  Conjur::API.new_from_key(
      login,
      Conjur::API.login(login, password)
  ).load_policy 'root', '--- []', method: Conjur::API::POLICY_METHOD_PUT
end

reset_root_policy
