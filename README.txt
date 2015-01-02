Floating Filters README
==================================================================


For this project I wanted to make a mirror that would be interactive with the mouse. I thought it would be cool if the user had the option to pick which filter they wanted for the video feed. I also thought it would be cool for the user to make combinations of filters.

Primary Screen

The primary screen actually consist of two layers.The first layer is the actual video feed. The second layer consist of enlarged pixels or rectangles with the same color as the pixel at that location. The opacity of the rectangles are low, so you can still see the details of the first layer. This creates a pretty cool effect, where the primary screen still looks pixelated but you can still see details of the video feed. I did this using nested for loops that iterated over the pixels of the original video feed. 

The opacity of the enlarged pixels increases until it reaches an upper limit, in which case it decreases until it reaches a lower limit. So as the user decides which filter they want to use, the primary screen will be dynamically changing its opacity.

Floating Filters

There are four sections floating around the screen with four different filters. If the user wants the whole video feed to have a particular filter, they would have to click on the section with the filter. For example, if a section had a THRESHOLD filter and I want it for the whole feed, I would click it. And if I wanted to make combinations of filters, I would click on another filter. 

In addition, every time a section would hit a wall, it will have a different filter. I got this idea from a class demonstration a long time ago, where we tried to replicate the moving dvd box from The Office.

Once you grow tired of a filter or a certain combination of filters, you can return back to the primary screen by pressing the SPACE bar.

You can change the size of the sections by pressing the UP or DOWN keys. And you can change the speed of the sections by using your LEFT or RIGHT keys.

With all this, the video feed runs at best in 320 x 240, but still it was fun manipulating the video feed and creating a cool little mirror like this. You can check out a video demonstration of the mirror below!