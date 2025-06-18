extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D
@onready var collision_shape_3d_2: CollisionShape3D = $Area3D/CollisionShape3D2


func _ready() -> void:
	collision_shape_3d.disabled = true
	collision_shape_3d_2.disabled = true
	animation_player.play("PlaneAction")
	print("animation skill 1 play")
	await get_tree().create_timer(0.3).timeout
	_on_timer_timeout()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()

func _on_timer_timeout() -> void:
	print("Timer timeout triggered!")
	collision_shape_3d.disabled = false
	collision_shape_3d_2.disabled = false
