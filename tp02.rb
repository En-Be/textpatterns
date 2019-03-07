
width = (0..100)
length = 500
current_line = 0

def main_loop(columns, rows, current_line)
  while current_line < rows
    columns.each {|c| print "."}
    print "\n"
    current_line += 1
  end
end

#this starts the main_loop
if current_line == 0
  main_loop(width, length, current_line)
end
