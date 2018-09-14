#require 'pry'
#require 'rb-readline'

class ToyRobot
  COMMAND_MAP = {"PLACE" => [],
                 "MOVE" => nil,
                 "LEFT" => nil,
                 "RIGHT" => nil,
                 "REPORT" => nil}

  ORIENTATION = {"NORTH" => false, "SOUTH" => false, "EAST" => false, "WEST" => false}
  OIRENTATION_90_LEFT = {"NORTH" => "WEST", "SOUTH" => "EAST", "EAST" => "NORTH", "WEST" => "SOUTH"}
  OIRENTATION_90_RIGHT = {"NORTH" => "EAST", "SOUTH" => "WEST", "EAST" => "SOUTH", "WEST" => "NORTH"}

  MATRIX_MARKER = {"NORTH" => "\u21d1", "SOUTH" => "\u21d3", "EAST" => "\u21d2", "WEST" => "\u21d0"}

  INVALID_CMD_MSGS = {invalid: "Command is invalid.",
                      table: "Robot is not on table yet.",
                      place: "You must place the robot ON the table!",
                      move: "That move would have pushed the robot off the table!"}

  def initialize(x_axis_length=5,y_axis_length=5,current_x_val=nil,current_y_val=nil,orientation=nil)
    @x_axis_length = x_axis_length
    @y_axis_length = y_axis_length
    INVALID_CMD_MSGS[:place] += " (The table is #{@x_axis_length} units wide and #{@y_axis_length} units long)"

    @matrix = Array.new(@y_axis_length + 1).map { || Array.new(@x_axis_length + 1) }

    @current_x_val = current_x_val
    @current_y_val = current_y_val
    update_orientation(orientation)

    set_command_map

    ask_for_command
  end

  def set_command_map
    possible_x_values = (0..@x_axis_length).to_a
    possible_y_values = (0..@y_axis_length).to_a

    # COMMAND_MAP["PLACE"] is set to an array of all possible PLACE command strings
    # (e.g. "0,0,NORTH")
    COMMAND_MAP["PLACE"] = possible_x_values.map(&:to_s).flat_map do |n|
                             possible_y_values.map { |y_val| n + "," + y_val.to_s }
                           end.flat_map do |n|
                             ORIENTATION.keys.map { |orientation| n + "," + orientation }
                           end 
    # The other commands (e.g. MOVE, LEFT, RIGHT, REPORT) have no accompanying strings now,
    # but they would be set here
  end

  def ask_for_command
    command = ""
    while command.empty?
      puts "The Toy Robot is ready... What is your command?"
      puts "(for example... (PLACE 0,0,NORTH) (MOVE) (LEFT) (RIGHT) (REPORT))"
      command = $stdin.gets.chomp
    end
    process_command(command)
  end

  def process_command(command)
    command_base = command.split(" ")[0].upcase
    command_spec = command.split(" ")[1...command.split(" ").length].join("").upcase.split(",").map(&:strip).join(",")

    if (self.command_exists?(command_base) &&
         self.command_spec_exists?(command_base,command_spec) &&
           (self.robot_on_table? || !self.robot_on_table? && command_base == "PLACE"))

      case command_base
      when "PLACE"
        x_pos = command_spec.split(",")[0].to_i
        y_pos = command_spec.split(",")[1].to_i

        orientation = command_spec.split(",")[2]

        # the matrix needs to know what direction to place the arrow, so orientation should be updated first when PLACEing
        update_orientation(orientation)
        update_matrix(x_pos, y_pos)
      when "MOVE"
        case self.move_axis_val
        when "@current_x_val"
          if !valid_x_coord?(instance_eval("#{@current_x_val} #{self.move_operator} 1"))
            print_invalid_command(:move)
            ask_for_command
          else
            update_matrix(instance_eval("#{@current_x_val} #{self.move_operator} 1"), @current_y_val)
          end
        when "@current_y_val"
          if !valid_y_coord?(instance_eval("#{@current_y_val} #{self.move_operator} 1"))
            print_invalid_command(:move)
            ask_for_command
          else
            update_matrix(@current_x_val, instance_eval("#{@current_y_val} #{self.move_operator} 1"))
          end
        end
      when "LEFT"
        turn_left
      when "RIGHT"
        turn_right
      when "REPORT"
        puts ""
        puts "#{self.print_current_x_val},#{self.print_current_y_val},#{self.print_current_orientation}"
        puts ""
        print_matrix
        puts ""
      else
      end

      ask_for_command
    else
      if !self.robot_on_table? && command_base == "PLACE" && !self.command_spec_exists?(command_base,command_spec)
        msg_sym = :place
      elsif !self.command_exists?(command_base)
        msg_sym = :invalid
      elsif !self.robot_on_table?
        msg_sym = :table
      else
        msg_sym = :invalid
      end

      print_invalid_command(msg_sym)
      ask_for_command
    end

  end

  def command_exists?(command)
    COMMAND_MAP.keys.include?(command)
  end

  def command_spec_exists?(command,command_spec)
    if command_exists?(command)
      case command
      when "PLACE"
        COMMAND_MAP["PLACE"].include?(command_spec)
      else
        true
      end
    else
      false
    end
  end

  def update_matrix(x_pos, y_pos)
    @current_x_val = x_pos
    @current_y_val = y_pos

    clear_matrix
    orientation_key = ORIENTATION.find { |k,v| v == true } ? ORIENTATION.find { |k,v| v == true }[0] : "NORTH"
    @matrix[@current_y_val][@current_x_val] = MATRIX_MARKER[orientation_key].encode('utf-8')
  end

  def print_matrix
    # because we want the bottom left corner to be 0,0 instead of the top left corner we use reverse
    @matrix.reverse.each do |arr|
      p arr.map { |val| !val ? " " : val }
    end
  end

  def clear_matrix
    @matrix.map! { |arr| arr.map! { |val| nil } }
  end

  def valid_x_coord?(x_coord)
    return (x_coord <= @x_axis_length && x_coord >= 0)
  end

  def valid_y_coord?(y_coord)
    return (y_coord <= @y_axis_length && y_coord >= 0)
  end

  def move_operator
    orientation = ORIENTATION.find { |k,v| v == true }[0]
    ["NORTH","EAST"].include?(orientation) ? "+": "-"
  end

  def move_axis_val
    orientation = ORIENTATION.find { |k,v| v == true }[0]
    ["NORTH","SOUTH"].include?(orientation) ? "@current_y_val": "@current_x_val"
  end

  def update_orientation(orientation)
    ORIENTATION.each { |k,v| k == orientation ? ORIENTATION[k] = true : ORIENTATION[k] = false }
  end

  def turn_left
    orientation = ORIENTATION.find { |k,v| v == true }[0]
    update_orientation(OIRENTATION_90_LEFT[orientation])
    update_matrix(@current_x_val,@current_y_val)
  end

  def turn_right
    orientation = ORIENTATION.find { |k,v| v == true }[0]
    update_orientation(OIRENTATION_90_RIGHT[orientation])
    update_matrix(@current_x_val,@current_y_val)
  end

  def print_current_orientation
    ORIENTATION.find { |k,v| v == true } ? ORIENTATION.find { |k,v| v == true }[0] : "Orientation Not Set"
  end

  def print_current_x_val
    @current_x_val ? @current_x_val : "X value not set"
  end

  def print_current_y_val
    @current_y_val ? @current_y_val : "Y value not set"
  end

  def print_invalid_command(msg_key=:invalid)
    puts "-" * 11 + ">"
    puts "#{INVALID_CMD_MSGS[msg_key]} Try Again."
    puts "-" * 11 + ">"
  end

  def robot_on_table?
    (ORIENTATION.find { |k,v| v == true } && @current_x_val && @current_y_val) ?
      true : false
  end

end

@toy_robot = ToyRobot.new

