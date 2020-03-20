list = ["alex", "rasmus", "valdemar", "wiggo", "peter"]
last = []
while true
  r = rand(5)
  if last != list[r]
    puts list[r]
    if r != 2
      puts "sorry asså inget fika"
    end
    gets
  end
  last = list[r]
end
