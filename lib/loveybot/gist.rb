  class Gist
    attr_accessor :id, :comment_count, :files, :url
    def initialize(gist)
      @files = gist["files"]
      @id = gist["id"]
      @comment_count = gist["comments"].to_i
      @url = gist["html_url"]
    end

    def is_lonely?
      comment_count == 0
    end

    def is_language?(language)
      @files.keys.collect do |key|
        true if @files[key]["language"] == language
      end.any?
    end
  end

