
# Every time the ticker ticks, print the next line.
# Each line is a collection of instances, mirrored halfway to create
# symmetry.
# The instances are from a class that randomly chooses its character.
# The line is copied for the next one, and wether the characters
# change or not creates patterns.


#- TICKER -#

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

@width = 100
@length = 100
@current_line = 0


#- PRINTS THE LINE -#

def main_loop
  #need to change the pattern line to be created, then edited,
  #instead of creating a new one every time
  while @current_line < @length
    pattern_line = Line.new(@width)
    if ticker(@interval)
      pattern_line.publish
      @current_line += 1
    end
  end

end


#- MAKES THE LINE -#

class Line

  def initialize(width)
    @width = width
    @line = []
    populate_line
  end

  def populate_line
    (@width / 2).times{
      @line.push(Character.new)
    }
  end

  def line_symmetry
    mirrored = @line.clone
    mirrored.reverse!
    @line = @line + mirrored
  end

  def publish

    @line.each{|char|
      char.choose
    }
    line_symmetry
    @line.each{|char|
      char.publish
    }
    print "\n"
  end

end


#- MAKES THE CHARACTERS THAT FILL THE LINES -#

class Character
  def initialize
    @character = "."
  end

  def choose
    likelihood = Random.rand(0..100)
    case likelihood
    when 95..100
      grow
    end
  end

  def grow
    case @character
    when "."
      @character = "o"
    when "o"
      @character = "O"
    when "O"
      @character = "|"
    end
  end

  def publish
    print @character
  end
end

#- STARTS THE MAIN LOOP

main_loop
