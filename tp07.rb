
@starting_time = Time.now
@current_time = Time.now
@elapsed_time = 0
@interval = 0.1

def ticker(interval)
  @current_time = Time.now
  @elapsed_time = @current_time - @starting_time
  if @elapsed_time >= @interval
    @starting_time = Time.now
    return true
  end
end


@width = (0..100)
@length = 40
@current_line = 0

@character_set = [".", "o", "O", "*", "|", "/", "\\", "-", "_", "<", ">", " "]
@character_picks = [" ", " ", " ", " ", " "]

def character_setter
  i = @character_set.sample
  x = rand(5)
  @character_picks[x] = i
end

def character_picker
  i = rand(5)
  if i == 0
    char = @character_picks[0]
  elsif i == 1
    char = @character_picks[1]
  elsif i == 2
    char = @character_picks[2]
  elsif i == 3
    char = @character_picks[3]
  else
    char = @character_picks[4]
  end
end

characters = []

def main_loop
  while @current_line < @length
    if ticker(@interval)
      @width.each {|c| print character_picker}
      print "\n"
      @current_line += 1
    end
  end

  if @current_line = @length
    character_setter
    @current_line = 0
    main_loop
  end
end


#this starts the main_loop
if @current_line == 0
  main_loop
end
