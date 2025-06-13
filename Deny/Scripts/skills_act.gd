extends Control

@onready var skill_1: Button = $"Skill 1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func use_skill_1():
	if Global.skill_1:
		skill_1.theme_override_colors["icon_normal_color"] = Color("#393939")
