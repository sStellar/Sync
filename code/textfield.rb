#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---
require 'fox16'

include Fox

class TextFieldExample < FXMainWindow
  
  def initialize(app)
    super(app, "Text Fields", :width => 300, :height => 75)

    p = FXMatrix.new(self, 2, :opts => MATRIX_BY_COLUMNS|LAYOUT_FILL)
    FXLabel.new(p, "Name: ")

    @name_target = FXDataTarget.new("Sophia")
    name_text = FXTextField.new(p, 25,
      :target => @name_target, :selector => FXDataTarget::ID_VALUE)
    @name_target.connect(SEL_COMMAND) do
      puts "The name is #{@name_target.value}"
    end

    FXLabel.new(p, "User ID: ")
    userid_text = FXTextField.new(p, 25)

    userid_text.connect(SEL_VERIFY) do |sender, sel, tentative|
      if tentative =~ /^[a-zA-Z][a-zA-Z0-9]*$/
        false
      else
        true
      end
    end

  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

end

if __FILE__ == $0
  
  FXApp.new do |app|
    TextFieldExample.new(app)
    app.create
    app.run
  end
  
end
