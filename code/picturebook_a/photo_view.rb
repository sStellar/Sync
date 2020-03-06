#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---



class PhotoView < FXImageFrame
  def initialize(p, photo)


    # We'll add code here soon...



    super(p, nil)

    load_image(photo.path)


  end


  

  def load_image(path)
    File.open(path, "rb") do |io|
      self.image = FXJPGImage.new(app, io.read)
    end
  end



end


