extends SpringArm3D


var mouse_sensetivity:=0.005

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y-=event.relative.x*mouse_sensetivity
		rotation.y=wrapf(rotation.y,0.0, TAU)
		
		rotation.x-=event.relative.y*mouse_sensetivity
		rotation.x=clamp(rotation.x, -PI/3, PI/4)
