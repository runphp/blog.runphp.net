require 'digest/md5'
require "open-uri"

module Jekyll
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
      "//gravatar.com/avatar/#{hash}.#{extension}?s=#{size}"
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

