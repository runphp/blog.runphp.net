module Jekyll
  # 用于修复未找到bootstrap字体文件
  #
  # /css/fonts/bootstrap-icons.woff
  # /css/fonts/bootstrap-icons.woff2
  #
  class GenFonts < Jekyll::Generator
    safe true
    priority :lowest

    def generate(site)
      @site = site
      FileUtils.copy_entry "node_modules/bootstrap-icons/font/fonts", "_site/css/fonts"
    end
  end
end