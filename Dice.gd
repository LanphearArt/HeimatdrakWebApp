extends RigidBody3D

var settled := false
var stable_frames := 0
const STABLE_THRESHOLD := 0.01
const MIN_STABLE_FRAMES := 30

var last_transform: Transform3D

func _ready() -> void:
	last_transform = global_transform
	# Optional: start frozen until thrown
	freeze = true

func _process(_delta: float) -> void:
	if settled:
		return
	
	var delta_transform = global_transform.origin - last_transform.origin
	var delta_rotation = (global_transform.basis.get_rotation_quaternion() - last_transform.basis.get_rotation_quaternion()).length()
	
	if delta_transform.length() < STABLE_THRESHOLD and delta_rotation < STABLE_THRESHOLD:
		stable_frames += 1
	else:
		stable_frames = 0
	
	if stable_frames >= MIN_STABLE_FRAMES:
		settled = true
	
	last_transform = global_transform

func get_face_value() -> int:
	if not settled:
		return 0
	
	var top_marker: Marker3D = null
	var max_y := -INF
	
	for marker in get_tree().get_nodes_in_group("dice_faces"):
		if marker.get_parent() == self:  # only own markers
			if marker.global_position.y > max_y:
				max_y = marker.global_position.y
				top_marker = marker
	
	return top_marker.get_meta("value") if top_marker else 1
