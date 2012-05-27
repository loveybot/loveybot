module Loveybot
  class Loveybot
    GIST_URL = "https://api.github.com/gists"

    attr_accessor :gists

    def initialize
      parse_gists
    end

    def lonely_gists_by_language(language)
      @gists.select do |gist|
        gist.is_language?(language) && gist.is_lonely?
      end
    end

    def raw_data
      JSON.parse(HTTParty.get(GIST_URL).body)
    end

    def parse_gists
      @gists = raw_data.collect do |hash|
        Gist.new(hash)
      end
    end

    def yay(language = "Ruby")
      if gist = lonely_gists_by_language(language).first
        post_comment_on(gist, language)
        return "Loving on #{gist.url}"
      else
        return "Sorry, no lonely #{language} gists found. Try again later!"
      end
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
