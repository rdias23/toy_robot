#require 'pry'
#require 'rb-readline'
require 'pty'

def print_divider_line(space="top")
  puts "" if space == "top"
  puts "*" * 99
  puts "" if space == "bottom"
end

def count_down(num = (ARGV[0] ? ARGV[0].to_i : 3))
  (num).downto(1) do |n|
    #print "...#{n}"
    sleep(1)
  end
end

PTY.spawn('ruby ./toy_robot.rb') do |stdout, stdin, pid|
  print_divider_line

  puts `echo "We are running our toy_robot.rb with a class from Ruby's standard library called PTY. LINK: https://goo.gl/pp3STc PTY allows you to spawn an external process and then interact with that process by using puts to write to it's stdin and gets to read from it's stdout."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  puts stdout.gets
  puts stdout.gets

  print_divider_line

  command_1 = "MOVE"
  puts `echo "This is what happens when we try to use the #{command_1} command before placing the robot on the table..."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_1

  6.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line

  command_2 = "PLACE 0,0,WEST"
  puts `echo "Let's use the PLACE command to place the Toy Robot in the Bottom Left corner of the table with #{command_2}."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_2

  3.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line

  command_3 = "REPORT"
  puts `echo "Let's use the #{command_3} command to check that the Toy Robot is now in the Bottom Left corner of the table."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_3

  13.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line

  command_4 = "MOVE"
  puts `echo "Take Note: The Robot is facing the WEST side of the table, right on the edge. Let's use the #{command_4} command to push the Toy Robot off of the table edge."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_4

  6.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line

  command_5 = "RIGHT"
  puts `echo "Let's turn away from the edge of the table by using the #{command_5} command now...."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_5

  3.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line

  command_6 = "REPORT"
  puts `echo "Let's use the #{command_6} command to check that the Toy Robot is no longer facing the WEST side  of the table."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_6

  13.times do |n|
    puts stdout.gets
  end


  count_down
  ###########################################
  print_divider_line

  command_6b = "MOVE"
  puts `echo "Now let's #{command_6b} NORTH by 1 unit..."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_6b

  3.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line

  command_6c = "REPORT"
  puts `echo "Let's use the #{command_6c} command to check that the Toy Robot is no longer in the SOUTH-WEST corner of the table."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_6c

  13.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line

  command_7 = "RIGHT"
  puts `echo "Let's turn toward the center of the table by using the #{command_7} command now...."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_7

  3.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line

  command_7a = "MOVE"
  puts `echo "Now let's #{command_7a} EAST by 1 unit..."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_7a

  3.times do |n|
    puts stdout.gets
  end

  count_down

  count_down
  ###########################################
  print_divider_line

  command_8 = "REPORT"
  puts `echo "Let's use the #{command_8} command to check that the Toy Robot is now closer to the center of the table."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_8

  13.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line
  
  command_9 = "LEFT"
  puts `echo "And then we will use the #{command_9} command, just because it's the only one not used yet."`
  
  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_9

  3.times do |n|
    puts stdout.gets
  end

  count_down
  ###########################################
  print_divider_line
  
  command_10 = "REPORT"
  puts `echo "And we can check out our final position with the #{command_10} command."`

  print_divider_line("bottom")
  #######################################################################################
  count_down

  stdin.puts command_10

  13.times do |n|
    puts stdout.gets
  end

end 

