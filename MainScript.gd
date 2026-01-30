# MainScript.gd
extends Control

@onready var tab_container: TabContainer = $MarginContainer/MainVBox/TabContainer
@onready var character_tab: VBoxContainer = $MarginContainer/MainVBox/TabContainer/Main
@onready var gear_tab: VBoxContainer = $MarginContainer/MainVBox/TabContainer/Gear
@onready var actions_tab: VBoxContainer = $MarginContainer/MainVBox/TabContainer/Actions
@onready var perks_tab: VBoxContainer = $MarginContainer/MainVBox/TabContainer/Perks
@onready var save_button: Button = $MarginContainer/MainVBox/TabContainer/Main/ActionContainer/ActionHBox/SaveSheet
@onready var load_button: Button = $MarginContainer/MainVBox/TabContainer/Main/ActionContainer/ActionHBox/LoadSheet

func _ready() -> void:
	tab_container.current_tab = 0
	
	if not Global.character_creation_data.is_empty():
		character_tab.load_data(Global.character_creation_data)
		Global.clear_creation_data()
	
	character_tab.race_origin_changed.connect(perks_tab.update_header_perks)
	character_tab.archetype_changed.connect(perks_tab.update_archetype_perks)
	# Initial call in case of defaults
	perks_tab.update_archetype_perks("None", "None", 1)
	gear_tab.equipped_changed.connect(func(main: String, off: String):
		actions_tab.current_main_hand = main
		actions_tab.current_off_hand = off
		actions_tab.update_weapon_actions()
	)
	
	character_tab.stats_updated.connect(func(stats):
		Global.character_data["mcb"] = stats["mcb"]
	)
	
	save_button.pressed.connect(_save_all)
	load_button.pressed.connect(_load_all)
	
	character_tab.archetype_changed.connect(perks_tab.update_archetype_perks)
	var current_arche1 = "None"
	var current_arche2 = "None"
	var current_rank = 1
	perks_tab.update_archetype_perks(current_arche1, current_arche2, current_rank)

func _save_all() -> void:
	var character_data = character_tab.get_save_data()
	var gear_data = gear_tab.get_save_data()
	var full_data = character_data.duplicate()
	full_data.merge(gear_data)
	
	if OS.get_name() == "Web":
		var _json = JSON.new()
		var json_string = JSON.stringify(full_data)
		JavaScriptBridge.eval("localStorage.setItem('heimatdrak_sheet', '%s');" % json_string)
		print("Full sheet saved to browser storage!")

func _load_all() -> void:
	if OS.get_name() != "Web":
		return
	
	var data_str = JavaScriptBridge.eval("localStorage.getItem('heimatdrak_sheet');", true)
	if not data_str or data_str == "null":
		return
	
	var json = JSON.new()
	var error = json.parse(data_str)
	if error != OK:
		print("JSON parse error: ", json.get_error_message())
		return
	
	var data = json.data
	if data:
		character_tab.load_data(data)
		gear_tab.load_data(data)
		actions_tab.current_main_hand = data.get("main_hand", "None")
		actions_tab.current_off_hand = data.get("off_hand", "None")
		actions_tab.update_weapon_actions()
		print("Full sheet loaded!")
