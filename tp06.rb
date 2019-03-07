
@starting_time = Time.now
@current_time = Time.now
@elapsed_time = 0
@interval = 0.08

def ticker(interval)
  @current_time = Time.now
  @elapsed_time = @current_time - @starting_time
  if @elapsed_time >= @interval
    @starting_time = Time.now
    return true
  end
end


width = (0..100)
length = 100
current_line = 0

def character_picker
  i = rand(3)
  if i == 0
    char = "."
  elsif i == 1
    char = "|"
  else
    char = "o"
  end
end

def main_loop(columns, rows, current_line)
  while current_line < rows
    if ticker(@interval)
      columns.each {|c| print character_picker}
      print "\n"
      current_line += 1
    end
  end
end

#this starts the main_loop
if current_line == 0
  main_loop(width, length, current_line)
end
