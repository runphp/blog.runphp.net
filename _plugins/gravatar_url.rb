require 'digest/md5'

module Jekyll
  class GravatarUrl < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @attributes = text.scan(::Liquid::TagAttributes).to_h
    end

    def render(context)
      email = @attributes['email']
      if email !~  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i and email =~ /([\w]+(\.[\w]+)*)/i
        email = look_up(context, $1)
      end
      hash = Digest::MD5.hexdigest(email.downcase.strip)
      extension = @attributes['extension']
      size = @attributes['size']
      return "//gravatar.com/avatar/#{hash}.#{extension}?s=#{size}"
    end

    def look_up(context, name)
      lookup = context
      name.split(".").each do |value|
        lookup = lookup[value]
      end
      lookup
    end
  end
end

Liquid::Template.register_tag('gravatar_url', Jekyll::GravatarUrl)