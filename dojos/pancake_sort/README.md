# Pancake sort!
This is a bit of a silly problem but I thought I would try to do it as a kata for myself.

I took the idea from [the following site](http://austingwalters.com/everyday-algorithms-pancake-sort/). The challenge is to come up with an algorithm that solve the issue and make sure it abides by the conditions.

## The problem!

You have a stack of "pancakes" that need to be sorted by size so that the largest are at the bottom and smallest at the top. However you can only perform one action on the stack of pancakes and that is "flipping" it from a point using a spatula.

When you flip at a point all of the pancakes above are reversed in order.


Algorithm thoughts:

Find the largest pancake
Flip from it's level so it's on top
Flip entire stack

From then on you operate with the bottom as 0 + i where is i is iterations through

Find next largest pancake in remaining stack
Flip to top
Flip "entire stack" 
add 1 to i
