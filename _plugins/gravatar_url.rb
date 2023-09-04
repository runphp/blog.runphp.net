require 'digest/md5'
require "open-uri"

module Jekyll
  # Gravatar标签
  # 由于网络问题进行下载处理
  class GravatarUrl < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @attributes = text.scan(::Liquid::TagAttributes).to_h
    end

    def render(context)
      email = @attributes['email']
      if email !~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i and email =~ /([\w]+(\.[\w]+)*)/i
        email = look_up(context, $1)
      end
      hash = Digest::MD5.hexdigest(email.downcase.strip)
      extension = @attributes['extension']
      size = @attributes['size']
      gravatar_url = "https://gravatar.com/avatar/#{hash}.#{extension}?s=#{size}"
      save_path = "_site/avatar/#{hash}-#{size}.#{extension}"
      local_url = "/avatar/#{hash}-#{size}.#{extension}"
      return local_url if File.exist?(save_path)
      # download gravatar
      begin
        file = URI.open(gravatar_url)
      rescue => e
        Jekyll.logger.warn e
        return gravatar_url
      end
      FileUtils.mkdir_p(File.dirname(save_path))
      IO.copy_stream(file, save_path)
      local_url
    end

    def look_up(context, name)
      lookup = context
      name.split(".").each do |value|
        lookup = lookup[value]
      end
      lookup
    end

    Liquid::Template.register_tag('gravatar_url', self)
  end
end

