@width = (0..100)
@length = 500
@current_line = 0

def main_loop
  while @current_line <= @length
    @width.each {|column| print character_picker}
    print "\n"
    @current_line += 1
    main_loop
  end
end

def character_picker
  i = rand(2)
  if i == 0
    char = "."
  else
    char = "|"
  end
end


if @current_line == 0
  main_loop
end
