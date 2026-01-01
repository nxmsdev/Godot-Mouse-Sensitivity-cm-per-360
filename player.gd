extends CharacterBody3D

@export_category("Mouse Movement")
@export var mouse_sensitivity: float = 12.192

@export var head_rotation_limit: float = 90.0
@export var base_dpi := 1600.0

const CM_PER_INCH := 2.54

var deg_per_mouse_count: float = 0.0
var head_rotation: Vector3

func body_rotation(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotation.y -= event.relative.x * deg_to_rad(deg_per_mouse_count)

		self.rotation.y = wrapf(self.rotation.y, deg_to_rad(0.0), deg_to_rad(360.0))


func camera_rotation(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		%Camera3D.rotation.x -= event.relative.y * deg_to_rad(deg_per_mouse_count)

		%Camera3D.rotation.x = clampf(%Camera3D.rotation.x, -deg_to_rad(head_rotation_limit), deg_to_rad(head_rotation_limit))
	
func _ready():
	var counts_per_cm := base_dpi / CM_PER_INCH

	# rotation degrees per 1 mouse count
	deg_per_mouse_count = 360.0 / (mouse_sensitivity * counts_per_cm)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)	

func _input(event: InputEvent) -> void:
	body_rotation(event)
	camera_rotation(event)
