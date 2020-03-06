#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---
class Album
  
  attr_reader :title
  
  def initialize(title)
    @title = title
    @photos = []
  end

  def add_photo(photo)
    @photos << photo
  end
  
  def each_photo
    @photos.each { |photo| yield photo }
  end
end
