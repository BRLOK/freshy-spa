# encoding: utf-8

I18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
I18n.default_locale = "pt-BR"
