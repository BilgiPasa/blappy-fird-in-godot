# blappy-fird-in-godot

This is a Flappy Bird clone that is made by me for to learn the Godot game engine.

I made a game named Blappy Fird long time ago using the Unity game engine. This is the Godot implementation of that game using Godot 4.6.

This game is open source and licensed with the MIT licence.

The code of the Unity game that I mentioned is here: https://github.com/BilgiPasa/ScriptsOfBlappyFird

This game has a bug that I encountered. If you change the width of the Walls's Area2D's CollisionShape2D as 100 and when you play the game, if you go through the walls while moving up very fast, you can get 2 scores instead of 1. I tried to fix this bug by closing the monitoring when the signal runs. But it did not solve the issue. When I made the CollisionShape2D's width as 20, reproducing the bug became harder. So, I made the width as 20.
