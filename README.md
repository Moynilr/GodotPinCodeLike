# Pin Code Godot Tool
This tool allow you to make a pin code like in a phone.


## Usage

You can chose if the pattern has to close with the boolean has_to_close, and the number of lines it should have with drawing_lenght, the color of the line with color.
When the lenght of the drawing defined is match, the drawing will end. You can restart it with the restart_drawing function.

To use the pattern, you can compare the list checkbox_list to the pattern you want.

By default here, a line follow your mouse while drawing. I had problems with it when inserting it into bigger scenes. You can turn it off by commenting the lines 56 and 58 of the attached script.
I hope it is of use to someone.

