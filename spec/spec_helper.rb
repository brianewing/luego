$:.unshift File.expand_path("../lib", __FILE__)
require 'luego'

RSpec.configure do |config|
  config.color_enabled = true
end
