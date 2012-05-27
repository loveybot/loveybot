module Loveybot
  class Loveybot
    GIST_URL = "https://api.github.com/gists"

    attr_accessor :gists, :raw_data

    def initialize
      obtain_raw_data
      @gists = collect_gists
    end

    def lonely_gists_by_language(language)
      @gists.select do |gist|
        gist.is_language?(language) && gist.is_lonely?
      end
    end

    def obtain_raw_data
      @raw_data = JSON.parse(HTTParty.get(GIST_URL).body)
    end

    def collect_gists
      @raw_data.collect do |hash|
        Gist.new(hash)
      end
    end

    def yay(language = "Ruby")
      lonely_gists_by_language(language).each do |gist| 
        post_comment_on(gist, language)
        return "Loving on #{gist.url}"
      end
      return "Sorry, no lonely #{language} gists found. Try again later!"
    end

    def post_comment_on(gist, language)
      HTTParty.post("https://api.github.com/gists/#{gist.id}/comments", options_for_post(language))
    end

    def options_for_post(language)
      { basic_auth: { username: ENV["LOVEY_USERNAME"], password: ENV["LOVEY_PASSWORD"] },          
      body: {"body" => "Yay #{language}!!"}.to_json }
    end 
  end
end
