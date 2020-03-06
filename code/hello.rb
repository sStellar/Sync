#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---

require 'fox16'



app = Fox::FXApp.new


main = Fox::FXMainWindow.new(app, "Hello, World!",
  :width => 200, :height => 100)


app.create


main.show(Fox::PLACEMENT_SCREEN)

app.run
