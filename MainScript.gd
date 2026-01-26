# MainScript.gd
extends Control

@onready var tab_container: TabContainer = $MarginContainer/MainVBox/TabContainer
@onready var character_tab: VBoxContainer = $MarginContainer/MainVBox/TabContainer/Main
@onready var gear_tab: VBoxContainer = $MarginContainer/MainVBox/TabContainer/Gear
@onready var actions_tab: VBoxContainer = $MarginContainer/MainVBox/TabContainer/Actions
@onready var perks_tab = $MarginContainer/MainVBox/TabContainer/Perks
@onready var save_button: Button = $MarginContainer/MainVBox/TabContainer/Main/ActionContainer/ActionHBox/SaveSheet
@onready var load_button: Button = $MarginContainer/MainVBox/TabContainer/Main/ActionContainer/ActionHBox/LoadSheet
@onready var test_roll: Button = $MarginContainer/MainVBox/TabContainer/Main/ActionContainer/ActionHBox/test_roll
@onready var test_roll_button: Button = $MarginContainer/MainVBox/TabContainer/Main/ActionContainer/ActionHBox/TestRoll
@onready var history_container := $RollHistory/ScrollContainer/HistoryContainer
@onready var dice_roller = $DiceRoller3D  # instanced

func _ready():
	tab_container.current_tab = 0
	dice_roller.roll_completed.connect(_add_to_history)
	if not Global.character_creation_data.is_empty():
		character_tab.load_data(Global.character_creation_data)
		Global.clear_creation_data()  # Prevent re-loading

	
	character_tab.race_origin_changed.connect(perks_tab.update_header_perks)
	# Connect GearTab changes to ActionsTab
	gear_tab.equipped_changed.connect(func(main: String, off: String):
		actions_tab.current_main_hand = main
		actions_tab.current_off_hand = off
		actions_tab.update_weapon_actions()
	)
	character_tab.stats_updated.connect(func(stats):
		Global.character_data["mcb"] = stats["mcb"]
		# You can also update ActionsTab directly if needed
	)
	save_button.pressed.connect(_save_all)
	load_button.pressed.connect(_load_all)
	
	# Connect the button if it exists (safe if you're adding this early)
	if test_roll_button:
		test_roll_button.pressed.connect(_on_test_roll_pressed)

func _save_all():
	var character_data = character_tab.get_save_data()
	var gear_data = gear_tab.get_save_data()

	var full_data = character_data
	full_data.merge(gear_data)

	if OS.get_name() == "Web":
		JavaScriptBridge.eval("localStorage.setItem('heimatdrak_sheet', JSON.stringify(" + JSON.stringify(full_data) + "));")

	print("Full sheet saved!")

func _load_all():
	if OS.get_name() == "Web":
		var data_str = JavaScriptBridge.eval("localStorage.getItem('heimatdrak_sheet');", true)
		if data_str and data_str != "null":
			var data = JSON.parse_string(data_str)
			if data:
				character_tab.load_data(data)
				gear_tab.load_data(data)
				print("Full sheet loaded!")
			if data:
				character_tab.load_data(data)
				gear_tab.load_data(data)
		
				# Update Actions tab with loaded equipped items
				actions_tab.current_main_hand = data.get("main_hand", "None")
				actions_tab.current_off_hand = data.get("off_hand", "None")
				actions_tab.update_weapon_actions()

func _on_test_roll_pressed() -> void:
	# Basic 3d6 roll with no modifier, just to see physics + dissolve + result
	dice_roller.perform_roll()

func _add_to_history(values: Array, total: int, desc: String) -> void:
	var entry := Label.new()
	var dice_text: String = ""
	for i in values.size():
		dice_text += str(values[i])
		if i < values.size() - 1:
			dice_text += "+"
	
	entry.text = "[%s] %s: %s = %d" % [
		Time.get_time_string_from_system(),
		desc,
		dice_text,
		total
	]
	# Future: color crits, add outcome vs target, etc.
	history_container.add_child(entry)
	# Auto-scroll
	await get_tree().process_frame
	history_container.get_parent().scroll_vertical = history_container.size.y
