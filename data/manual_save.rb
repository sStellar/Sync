require_relative "../FileOb.rb"
x = FileOb.new("/home/peter/Sync")

x.logic_func
save_data = {
  "inv_data": x.file_inv,
  "new_data": [],
  "edited_data": [],
  "del_data": []
}
File.open("data.yaml", "w") { |file| file.write(save_data.to_yaml) }
