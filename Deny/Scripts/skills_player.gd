extends Node3D

@onready var skills: Node3D = $"."

const SKILL_1 = preload("res://Deny/Scenes/skill_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event):
	if event.is_action_pressed("Skill 1"):
		var temp_skill_1 = SKILL_1.instantiate()
		skills.add_child(temp_skill_1)
		Global.skill_1 = true
		print("PRess 1")
