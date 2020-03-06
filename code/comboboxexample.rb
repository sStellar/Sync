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

$state_names  = %w{Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii}
$state_names += %w{Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan}
$state_names += %w{Minnesota Mississippi Missouri Montana Nebraska Nevada New\ Hampshire New\ Jersey New\ York}
$state_names += %w{North\ Carolina North\ Dakota Ohio Oklahoma Oregon Pennsylvania Rhode\ Island South\ Carolina}
$state_names += %w{Tennessee Texas Utah Vermont Washington West\ Virginia Wisconsin Wyoming}

class ComboBoxExample < FXMainWindow
  def initialize(app)
    super(app, "Expense Report", :width => 400, :height => 200)
    matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL)

    FXLabel.new(matrix, "Payee:")
    FXTextField.new(matrix, 20)

    FXLabel.new(matrix, "Amount:")
    FXTextField.new(matrix, 20)

    FXLabel.new(matrix, "State:")

    states = FXListBox.new(matrix,
      :opts => LISTBOX_NORMAL|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X)

    states.numVisible = 6

    $state_names.each { |name| states.appendItem(name) }


    FXLabel.new(matrix, "Account:")

    accounts = FXComboBox.new(matrix, 20,
      :opts => COMBOBOX_NO_REPLACE|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X)

    accounts.numVisible = 6
    accounts.appendItem("Dunder-Mifflin")
    accounts.appendItem("Initech")
    accounts.appendItem("Vandelay Industries")
    accounts.appendItem("Wayne Enterprises")

    accounts.connect(SEL_COMMAND) do |sender, sel, data|
      assign_expense_account(sender.text)
    end


    FXLabel.new(matrix, "Expense Category:")
    categories = FXComboBox.new(matrix, 20,
      :opts => COMBOBOX_INSERT_AFTER|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X)
    categories.numVisible = 6
    categories.appendItem("Wining")
    categories.appendItem("Dining")
    categories.appendItem("Outright Bribery")

    categories.connect(SEL_COMMAND) do |sender, sel, data|
      assign_expense_category(sender.text)
      sender.sortItems
    end

  end
  
  def assign_expense_account(account)
  end

  def assign_expense_category(category)
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    ComboBoxExample.new(app)
    app.create
    app.run
  end
end