require 'travis/services/vault/keys'
require 'travis/services/vault/connect'
require 'travis/services/vault/build_paths'

module Vault
  class ConnectionError < StandardError; end
end