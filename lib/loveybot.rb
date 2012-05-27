require 'httparty'
require 'json'
require 'hashie'
require 'loveybot/loveybot'
require 'loveybot/gist'

module Loveybot
  def self.yay(language = "Ruby")
    Loveybot.new.yay(language)
  end
end