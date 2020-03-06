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

class HelloWindow < FXMainWindow
  def initialize(app)
    super(app, "Hello, World!", :width => 200, :height => 100)
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

app = FXApp.new
HelloWindow.new(app)
app.create
app.run
