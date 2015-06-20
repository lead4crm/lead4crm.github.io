require 'date'
require 'i18n'

# LOCALE = 'ru' # set your locale
path = File.expand_path("../../_locales/ru.yml", __FILE__)
I18n.load_path = Dir[path]
I18n.locale = :ru

# Create folder "_locales" and put some locale file from https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale
module Jekyll
  module I18nFilter
    # Example:
    #   {{ post.date | localize: "%d.%m.%Y" }}
    #   {{ post.date | localize: ":short" }}
    def localize(input, format=nil)
      # load_translations
      format = (format =~ /^:(\w+)/) ? $1.to_sym : format

      if input.is_a?(String)
        input = DateTime.parse(input)
      end

      I18n.l input, :format => format
    end

    def translate(key)
      I18n.t key
    end

    def load_translations
      if I18n.backend.send(:translations).empty?
        I18n.backend.load_translations Dir[File.join(File.dirname(__FILE__),'../_locales/*.yml')]
        I18n.locale = LOCALE
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::I18nFilter)