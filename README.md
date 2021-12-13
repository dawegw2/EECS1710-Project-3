# EECS1720-Project-3

For this project, I decided to create a maze escape game. In order to escape the maze, you need to collect three keys and find the exit. 

Controls and Instructions: 

Right Click the mouse to move the character. 
Press 'z' near items to collect them.  
There are two items in the game, keys and batteries. Keys are represented using yellow circles, while batteries are green circles. Batteries aren't mandetory to collect, but increase the vision range of the character. Collect three keys and find the exit to escape. Retry to record a better time.
If you touch the white walls of the maze, you will be brought back to the entrance of the maze. 

Pixel Array: 

The pixel array is used to access the colors of the maze image and the maze spawn map found in the data folder
By comparing the image pixel brightness of the maze to the character dot, I was able to detect collision.
In the setup function, I use a pixel array to access the red and blue pixels from a color map I made, which indicates where on the maze each item can spawn at depening on the color.
The flashlight effect is done by manipulating the pixel array as well.

Assets:

The maze was generated using: https://keesiemeijer.github.io/maze-generator/

References:

For maze wall collisions: https://github.com/eecs17xx/eecs1710-2021f/tree/main/Week10/PixelExample06
For mapping spawn points: https://github.com/eecs17xx/eecs1710-2021f/tree/main/Week10/ClockCreature02
