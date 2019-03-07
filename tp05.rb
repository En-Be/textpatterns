
@starting_time = Time.now
@current_time = Time.now
@elapsed_time = 0
interval = 0.02

def ticker(interval)
  @current_time = Time.now
  @elapsed_time = @current_time - @starting_time
  if @elapsed_time >= interval
    puts @elapsed_time
    @starting_time = Time.now
  end
end

while true
  ticker(interval)
end
