#!/usr/bin/env ruby
#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---

require 'fox16'
require 'soap/rpc/driver'

include Fox

TRANSLATIONS = {
  "English to French" => "en_fr",
  "English to German" => "en_de",
  "English to Italian" => "en_it",
  "English to Japanese" => "en_jp",
  "English to Korean" => "en_kr",
  "English to Portugese" => "en_pt",
  "English to Spanish" => "en_es",
  "French to English" => "fr_en",
  "German to English" => "de_en",
  "Italian to English" => "it_en",
  "Japanese to English" => "jp_en",
  "Korean to English" => "kr_en",
  "Portugese to English" => "pt_en",
  "Spanish to English" => "es_en",
  "Russian to English" => "ru_en",
  "German to French" => "de_fr",
  "French to German" => "fr_de"
}

class TranslatorWindow < FXMainWindow

  def initialize(app)
    super(app, "Translator", :opts => DECOR_ALL, :width => 600, :height => 400)

    frame = FXVerticalFrame.new(self, :opts => LAYOUT_FILL)
    FXLabel.new(frame, "Source Text:", :opts => LAYOUT_FILL_X)
    source_text = FXText.new(frame, :opts => LAYOUT_FILL)
    FXLabel.new(frame, "Translated text:", :opts => LAYOUT_FILL_X)
    translated_text = FXText.new(frame, :opts => TEXT_READONLY|LAYOUT_FILL)
    controls = FXHorizontalFrame.new(frame, :opts => LAYOUT_FILL_X)
    FXLabel.new(controls, "Translate from:")
    translations = FXComboBox.new(controls, 15,
      :opts => COMBOBOX_STATIC|FRAME_SUNKEN|FRAME_THICK)
    translate_button = FXButton.new(controls, "Translate",
      :opts => BUTTON_NORMAL|LAYOUT_RIGHT)

    translations.numVisible = 6
    TRANSLATIONS.keys.each do |key|
      translations.appendItem(key, TRANSLATIONS[key])
    end
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    TranslatorWindow.new(app)
    app.create
    app.run
  end
end
