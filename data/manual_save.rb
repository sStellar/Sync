require_relative "../FileOb.rb"
x = FileOb.new("/home/peter/Sync")

while true
  x.logic_func
  x.save_yaml("/home/peter/Sync/data/data.yaml")
  p x.edited_files
  sleep(3)
end
