extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var hp=1



func take_damage():
	hp-=1
	if hp<0:
		queue_free()
