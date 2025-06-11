extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var run_speed=1

var target : Node3D
var targeting=false

var ignore_targets=[]

@onready var camera_3d: Camera3D = %Camera3D

@onready var right_hand: Node3D = %right_hand

@onready var left_hand: Node3D = %left_hand

@onready var right_weapon=right_hand.get_child(0)
@onready var left_weapon=left_hand.get_child(0)

func _physics_process(delta: float) -> void:
	if targeting:
		if target!=null:
			
			
			
			var target_pos = target.global_transform.origin
			target_pos.y = $all_da_shit.global_transform.origin.y
			$SpringArm3D.look_at(target_pos, Vector3.UP)
			$all_da_shit.look_at(target_pos, Vector3.UP)

		else:
			ignore_targets.clear()
			get_nearest_target()
	if Input.is_action_pressed("run"):
		run_speed=2
	else:
		run_speed=1
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, %Camera3D.global_rotation.y)

	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED*run_speed
		velocity.z = direction.z * SPEED*run_speed
		if not target:
			var look_target = global_transform.origin + Vector3(direction.x, 0, direction.z)
			$all_da_shit.look_at(look_target, Vector3.UP)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED*run_speed)
		velocity.z = move_toward(velocity.z, 0, SPEED*run_speed)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if target!=null:
		if event.is_action_pressed("change_target"):
			
			print(ignore_targets)
			get_nearest_target()
	
	
	if event.is_action_pressed("toggle_lock"):
		ignore_targets.clear()
		targeting=false
		if target:
			target=null
			return
		get_nearest_target()
	
	
	
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if not right_weapon==null:
				if Input.is_action_pressed("up") and right_weapon.has_method("up_attack"):
					print("up_attack")
					right_weapon.up_attack()
				elif right_weapon.has_method("idle_attack"):
					print("attac")
					right_weapon.idle_attack()
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not left_weapon==null:
				
				if Input.is_action_pressed("up") and left_weapon.has_method("up_attack"):
					print("up_attack")
					left_weapon.up_attack()
				elif left_weapon.has_method("idle_attack"):
					print("attac")
					left_weapon.idle_attack()


func get_nearest_target():
	targeting=true
	var nearest_target : Node3D = null
	var shortest_distance = INF
	
	
	var valid_enemy_found=false

	
	
	for enemy in get_tree().get_nodes_in_group("enemy"):
		if not enemy.is_inside_tree():
			continue
		if ignore_targets.has(enemy):
			continue
		valid_enemy_found=true
	# Only consider enemies within a certain range (optional)
		var distance = global_transform.origin.distance_to(enemy.global_transform.origin)
		if distance < shortest_distance:
			shortest_distance = distance
			nearest_target = enemy

			if nearest_target:
				target = nearest_target
				ignore_targets.append(target)
				print("Locked on to: ", target.name)
			else:
				print("No enemies in range.")
	if not valid_enemy_found and get_tree().get_nodes_in_group("enemy").size()>=2:
		
		if target!=null:
			ignore_targets.clear()
			ignore_targets.append(target)
			get_nearest_target()
