
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
@interval = 0.00005

def ticker(interval)
  @current_time = Time.now
  @elapsed_time = @current_time - @starting_time
  if @elapsed_time >= @interval
    @starting_time = Time.now
    return true
  end
end

@width = 260 # must be divisible by portions
@length = 10000
@current_line = 0
@portions = 10 # can be 2, 4, 8, 10, 20

#- PRINTS THE LINE -#

def main_loop
  $pattern_line = Line.new(@width, @portions)
  while @current_line < @length
    if ticker(@interval)
      $pattern_line.publish
      @current_line += 1
      #puts @current_line
    end
  end

end


#- MAKES THE LINE -#

class Line
  def initialize(width, portions)
    @width = width
    @portions = portions
    @portion_length = width/@portions
    #puts "portion length = #{@portion_length}"
    @line = []
    @current_char = 0
    populate_line
  end

  def populate_line
    i = 0
    @portion_length.times{
      c = Character.new(i)
      @line.push(c)
      i += 1
    }
    #puts "after populate #{@line.length}"
    line_symmetry
  end

  def publish
    @line.each{|char|
      char.publish
    }
    print "\n"
    grow
  end

  def grow
    remove_mirrors
    @line.each{|char|
      char.choose
    }
    line_symmetry
  end

  def spread(index)

    l = index - 1
    r = index + 1

    if l > -1 && @line[l].check_age
      @line[l].assign("O")
    end

    if r <= @portion_length - 1 && @line[r].check_age
      @line[r].assign("O")
    end

  end

  def remove_mirrors
    m_length = (@portion_length * (@portions - 1))
    m_length.times{@line.pop}
    #puts "after remove #{@line.length}"
  end

  def line_symmetry
    mirrored = @line.clone
    mirrored.reverse!
    @line = @line + mirrored
    mirrored = @line.clone
    mirrored.reverse!
    until @line.length == @width
      @line = @line + mirrored
      #puts "after symmetry #{@line.length}"
    end
  end

end


#- MAKES THE CHARACTERS THAT FILL THE LINES -#

class Character
  def initialize(position)
    @age = 0
    @character = "."
    @position = position
    #puts @position
  end

  def assign(value)
    @character = value
  end

  def check_age
    @age < 6
  end

  def choose
    likelihood = Random.rand(0..100)
    case likelihood
    when 99..100
      grow
    end
  end

  def grow
    @age += 1
    case @character
    when "."
      likelihood = Random.rand(0..100)
      if likelihood > 90
        @character = "'"
      else
        @age -= 1
      end
    when "'"
      @character = ":"
    when ":"
      @character = "|"
    when "|"
      @character = "Y"
    when "Y"
      @character = "v"
    when "v"
      @character = "V"
    when "V"
      @character = "o"
    when "o"
      @character = "O"
      spread
    when "O"
      @character = "*"
    when "*"
      @character = "."
      @age = 0
    end
  end


  def spread
    likelihood = Random.rand(0..100)
    if likelihood > 25
      $pattern_line.spread(@position)
    end
  end

  def publish
    print @character
  end
end

#- STARTS THE MAIN LOOP

main_loop
