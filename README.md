# GAFinal--Battlechat

This is a multiplayer real-time chat and battle application built in Ruby on Rails 5 using ActionCable.
NOTE: Will not start the game unless there are 2 players!
Live at: http://104.131.48.188/

#Features
It has game matchmaking, login/logout/signup/user profiles and the ability to edit them. The chatroom messages are also saved to a database, so it is persistent across sessions. The game also has sound, animations, and a text box to describe attacks and effects

#Tech
 Built in Ruby on Rails 5, featuring Action Cable, Coffeescript, Postgesql, and Redis. 

#How to Play
You will either be Red or Blue. Red is the Pikachu facing away toward the bottom left, Blue is the Pikachu facing towards the screen toward the top right.

Each Pikachu starts with 100 HP, whoever has their hp reduced to 0 loses.
There are 4 actions: 
/n
1.Attack - Default hits opponent for 10 HP. 
/n
2.Charge - Increases your attack by 5 points.
/n
3.Heal - Heals your Pikachu by 7 HP, to maximum 100 HP.
/n
4.Growl - Reduce opponent's attack by 5 points.
/n

Each action takes a different amount of time! Attack is longest, then Growl, followed by Charge, and fastest is Heal.
