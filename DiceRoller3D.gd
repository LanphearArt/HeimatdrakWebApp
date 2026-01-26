extends Control

@onready var world: Node3D = $SubViewportContainer/SubViewport/World
@onready var result_label: Label = $ResultLabel
@onready var description_label: Label = $DescriptionLabel  # assuming you have this node

var active_dice: Array[RigidBody3D] = []
var values: Array[int] = []
var total: int = 0

signal roll_completed(values: Array[int], total: int, description: String)

func perform_roll(num_dice: int = 3, modifier: int = 0, description: String = "Test Roll") -> void:
	visible = true
	result_label.text = ""
	description_label.text = ""
	
	# Clear any previous dice
	for d in active_dice:
		d.queue_free()
	active_dice.clear()
	values.clear()
	total = 0
	
	# Spawn new dice
	for i in num_dice:
		var die: RigidBody3D = preload("res://Dice.tscn").instantiate()
		world.add_child(die)
		die.global_position = Vector3(randf_range(-3, 3), 8, randf_range(-3, 3))
		die.global_rotation_degrees = Vector3(randf_range(0, 360), randf_range(0, 360), randf_range(0, 360))
		die.freeze = false
		
		die.apply_central_impulse(Vector3(randf_range(-4, 4), randf_range(-8, -12), randf_range(-4, 4)))
		die.apply_torque_impulse(Vector3(randf_range(-15, 15), randf_range(-15, 15), randf_range(-15, 15)))
		
		active_dice.append(die)
	
	# Wait until all dice have settled
	await _wait_for_settlement()
	
	# Read results
	for die in active_dice:
		var val: int = die.get_face_value()
		values.append(val)
		total += val
	
	total += modifier
	
	# Display result
	var dice_text: String = ""
	for i in values.size():
		dice_text += str(values[i])
		if i < values.size() - 1:
			dice_text += " + "
	
	result_label.text = dice_text + " = " + str(total)
	if description != "":
		description_label.text = description
	
	emit_signal("roll_completed", values, total, description)
	
	# Pause to admire the result
	await get_tree().create_timer(1.5).timeout
	
	# Dissolve dice
	_dissolve_dice()
	
	# Hide overlay after dissolve
	await get_tree().create_timer(1.0).timeout
	visible = false


func _wait_for_settlement() -> void:
	while true:
		await get_tree().physics_frame
		var all_settled: bool = true
		for die in active_dice:
			if not die.settled:
				all_settled = false
				break
		if all_settled:
			break


func _dissolve_dice() -> void:
	for die in active_dice:
		var mesh: MeshInstance3D = die.get_node("MeshInstance3D")
		var mat: ShaderMaterial = mesh.get_surface_override_material(0) as ShaderMaterial
		if mat:
			var tween: Tween = create_tween()
			tween.tween_property(mat, "shader_parameter/dissolve_amount", 1.1, 0.8)
			tween.tween_callback(die.queue_free)
