require 'httparty'
require 'hashie'
require 'json'
COMMENT = "Yay Ruby!!"

  class Gist
    attr_accessor :id, :comment_count, :files, :url
    def initialize(gist)
      @files = gist["files"]
      @id = gist["id"]
      @comment_count = gist["comments"].to_i
      @url = gist["html_url"]
    end

    def skip_comment?
      comment_count >= 1
    end

    def is_ruby?
      results = false
      @files.keys.each do |key|
        results = true if @files[key]["language"] == "Ruby"
      end
      results
    end
  end

  class Loveybot
    attr_accessor :gists

    def initialize
      @gists = snag_gists
    end

    def filter_by_ruby_language
      results = []
      @gists.each do |gist|
        results << gist if gist.is_ruby?
      end
      results
    end

    def snag_gists
      response = HTTParty.get "https://api.github.com/gists"
      results = []
      gists = JSON.parse(response.body).each do |hash|
        results << Gist.new(hash)
      end
      results
    end

    def yay
      filter_by_ruby_language.each do |gist| 
        next if gist.skip_comment?   
        options =  {
           basic_auth: { username: ENV["LOVEY_USERNAME"], password: ENV["LOVEY_PASSWORD"] },          
           body: {"body" => "Yay Ruby!!"}.to_json
          }
          print "Commenting on #{gist.url}"
          puts HTTParty.post("https://api.github.com/gists/#{gist.id}/comments", options)
          raise "DONE"
      end
    end

  end

  lb = Loveybot.new
  lb.yay