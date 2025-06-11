extends Node3D


func up_attack():
	$AnimationPlayer.play("idle_attack")

func down_attack():
	$AnimationPlayer.play("idle_attack")

func right_attack():
	$AnimationPlayer.play("idle_attack")

func left_attack():
	$AnimationPlayer.play("idle_attack")

func idle_attack():
	$AnimationPlayer.play("idle_attack")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
