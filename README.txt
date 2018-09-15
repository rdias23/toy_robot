SOLUTION NOTES

Dependencies
1. Ruby - The solution was written with the Ruby programming language. This version: ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin17]
2. I used 'pry' for debugging, but the 'require' for it has been commented out in both files.
3. I used a module called PTY from the standard Ruby library that creates and manages pseudo terminals. I think this is the best way to automatically exercise and demonstrate the Toy Robot. Since it's from the Ruby stadard libary there should be no extra step for you to run it.

There are two files inside the folder containing this README.txt
1. toy_robot.rb -      This is the solution to the Code Challenge, with the exception of the test data component.
                       You can run this program from the command line with: $ ruby toy_robot.rb
2. test_toy_robot.rb - This file will automatically run the program via PTY (see above) and display the output to the terminal after each command is automatically entered.
                       Think of it like a slideshow.
                       By default, it runs each"slide" at 3 seconds, but you can pass a command line argument in when you run it to change the speed.
                       You can run the test program from the command line with: $ ruby test_toy_robot.rb
                       Or pass in an argument to make it faster, slower, or skip the wait altogether (e.g. 0): $ ruby test_toy_robot.rb 0

******************************************** ******************************************** ******************************************** ********************************************
Directions, supplied by Maestrano, copied and pasted below....
******************************************** ******************************************** ******************************************** ********************************************
Description:
The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units. There are no other obstructions on the table surface. The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.
Create an application that can read in commands of the following form - PLACE X,Y,F MOVE LEFT RIGHT REPORT
PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST. . The origin (0,0) can be considered to be the SOUTH WEST most corner.
The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
MOVE will move the toy robot one unit forward in the direction it is currently facing. . LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
REPORT will announce the X,Y and orientation of the robot.
A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands.
Provide test data to exercise the application.
Constraints: The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot. Any move that would cause the robot to fall must be ignored.
Example Input and Output: a) PLACE 0,0,NORTH MOVE REPORT Output: 0,1,NORTH b) PLACE 0,0,NORTH LEFT REPORT Output: 0,0,WEST
c) PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT Output: 3,3,NORTH Deliverables: The source files, the test data and any test code.
******************************************** ******************************************** ******************************************** ********************************************
