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
      save_path = "_site/css/fonts"
      FileUtils.mkdir_p(save_path) unless File.exist?(save_path)
      FileUtils.copy_entry "node_modules/bootstrap-icons/font/fonts", save_path
    end
  end
end