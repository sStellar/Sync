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

class TextExample < FXMainWindow
  
  def initialize(app)
    super(app, "Text Widget Example", :width => 640, :height => 480)
    text_frame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X|FRAME_SUNKEN|FRAME_THICK)

    text = FXText.new(text_frame, :opts => TEXT_WORDWRAP|LAYOUT_FILL)
    text.text = "By default, the text buffer is empty."


    text.connect(SEL_INSERTED) do |sender, sel, change|
      puts "The string #{change.ins} was inserted at position #{change.pos}"
    end

    FXHorizontalSeparator.new(self, :opts => LAYOUT_FILL_X|SEPARATOR_GROOVE)

    cursor_pos_frame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    FXLabel.new(cursor_pos_frame, "Pos:")
    cursor_pos_text = FXTextField.new(cursor_pos_frame, 8)
    cursor_pos_text.connect(SEL_UPDATE) do |sender, sel, data|
      sender.text = text.cursorPos.to_s
    end
    
    word_pos_frame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    FXLabel.new(word_pos_frame, "Word Start:")
    word_start_text = FXTextField.new(word_pos_frame, 8)
    word_start_text.connect(SEL_UPDATE) do |sender, sel, data|
      sender.text = text.wordStart(text.cursorPos).to_s
    end
    FXLabel.new(word_pos_frame, "Word End:")
    word_end_text = FXTextField.new(word_pos_frame, 8)
    word_end_text.connect(SEL_UPDATE) do |sender, sel, data|
      sender.text = text.wordEnd(text.cursorPos).to_s
    end
    
    line_pos_frame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    FXLabel.new(line_pos_frame, "Line Start:")
    line_start_text = FXTextField.new(line_pos_frame, 8)
    line_start_text.connect(SEL_UPDATE) do |sender, sel, data|
      sender.text = text.lineStart(text.cursorPos).to_s
    end
    FXLabel.new(line_pos_frame, "Line End:")
    line_end_text = FXTextField.new(line_pos_frame, 8)
    line_end_text.connect(SEL_UPDATE) do |sender, sel, data|
      sender.text = text.lineEnd(text.cursorPos).to_s
    end
    
    append_frame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    FXLabel.new(append_frame, "Text:")
    append_text = FXTextField.new(append_frame, 30)
    append_button = FXButton.new(append_frame, "Append Text", :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
    append_button.connect(SEL_COMMAND) do
      additional_text = append_text.text

      text.appendText(additional_text, true)  # notify target of change

    end

    insert_frame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    FXLabel.new(insert_frame, "Text:")
    insert_text = FXTextField.new(insert_frame, 30)
    FXLabel.new(insert_frame, "Pos:")
    insert_pos_text = FXTextField.new(insert_frame, 6)
    insert_button = FXButton.new(insert_frame, "Insert Text", :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
    insert_button.connect(SEL_COMMAND) do
      pos = insert_pos_text.text.to_i
      inserted_text = insert_text.text

      text.insertText(pos, inserted_text)

    end

    replace_frame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    FXLabel.new(replace_frame, "Text:")
    replace_text = FXTextField.new(replace_frame, 30)
    FXLabel.new(replace_frame, "Pos:")
    replace_pos_text = FXTextField.new(replace_frame, 6)
    FXLabel.new(replace_frame, "Amount:")
    replace_amount_text = FXTextField.new(replace_frame, 6)
    replace_button = FXButton.new(replace_frame, "Replace Text", :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
    replace_button.connect(SEL_COMMAND) do
      pos = replace_pos_text.text.to_i
      amount = replace_amount_text.text.to_i
      replacement_text = replace_text.text

      text.replaceText(pos, amount, replacement_text)

    end

    remove_frame = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X)
    FXLabel.new(remove_frame, "Pos:")
    remove_pos_text = FXTextField.new(remove_frame, 6)
    FXLabel.new(remove_frame, "Amount:")
    remove_amount_text = FXTextField.new(remove_frame, 6)
    remove_button = FXButton.new(remove_frame, "Remove Text", :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
    remove_button.connect(SEL_COMMAND) do
      pos = remove_pos_text.text.to_i
      amount = remove_amount_text.text.to_i

      text.removeText(pos, amount)

    end

  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  
  FXApp.new do |app|
    TextExample.new(app)
    app.create
    app.run
  end
  
end
