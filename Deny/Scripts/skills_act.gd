extends Control

@onready var skill_1: Button = $"Skill 1"
@onready var skill_2: Button = $"Skill 2"
@onready var skill_3: Button = $"Skill 3"

var skill_slots: Array = []

func _ready() -> void:
	skill_slots.resize(3) # nr of skill slots change later
	for i in range(skill_slots.size()):
		skill_slots[i] = null

func equip_skill_to_slot():
	pass

func _process(delta: float) -> void:
	#MAKE MODULAR TOO
	if Global.skill_1:
		skill_1.add_theme_color_override("icon_normal_color", Color("#393939"))
		print("color dark")

func use_skill_1():
	pass
