# CharacterCreation.gd
extends Control

@onready var tab_container: TabContainer = $MarginContainer/TabContainer

# Step 1
@onready var agi_score: SpinBox = $MarginContainer/TabContainer/Step1RollStats/AttrGrid/AgiScore
@onready var app_score: SpinBox = $MarginContainer/TabContainer/Step1RollStats/AttrGrid/AppScore
@onready var brawn_score: SpinBox = $MarginContainer/TabContainer/Step1RollStats/AttrGrid/BrawnScore
@onready var con_score: SpinBox = $MarginContainer/TabContainer/Step1RollStats/AttrGrid/ConScore
@onready var int_score: SpinBox = $MarginContainer/TabContainer/Step1RollStats/AttrGrid/IntScore
@onready var mem_score: SpinBox = $MarginContainer/TabContainer/Step1RollStats/AttrGrid/MemScore

# Step 2
@onready var race_option: OptionButton = $MarginContainer/TabContainer/Step2RaceOrigin/RaceOption
@onready var general_perk_dropdown: OptionButton = $MarginContainer/TabContainer/Step2RaceOrigin/GeneralPerkDropdown
@onready var origin_option: OptionButton = $MarginContainer/TabContainer/Step2RaceOrigin/OriginOption
@onready var advanced_check: CheckBox = $MarginContainer/TabContainer/Step2RaceOrigin/AdvancedCheck

# Step 3
@onready var arche1_option: OptionButton = $MarginContainer/TabContainer/Step3Archetypes/Arche1Option
@onready var arche2_option: OptionButton = $MarginContainer/TabContainer/Step3Archetypes/Arche2Option

# Step 4
@onready var stats_summary: Label = $MarginContainer/TabContainer/Step4Review/StatsSummary
@onready var race_origin_summary: Label = $MarginContainer/TabContainer/Step4Review/RaceOriginSummary
@onready var archetypes_summary: Label = $MarginContainer/TabContainer/Step4Review/ArchetypesSummary
@onready var name_input: LineEdit = $MarginContainer/TabContainer/Step4Review/NameInput
@onready var confirm_button: Button = $MarginContainer/TabContainer/Step4Review/ConfirmButton

var character_data: Dictionary = {}

func _ready():
	tab_container.set_tab_title(0, "Step 1: Stats")
	tab_container.set_tab_title(1, "Step 2: Race & Origin")
	tab_container.set_tab_title(2, "Step 3: Archetypes")
	tab_container.set_tab_title(3, "Step 4: Review")
	tab_container.current_tab = 0

	# Connect buttons
	$MarginContainer/TabContainer/Step1RollStats/Buttons/RollButton.pressed.connect(_on_roll_stats)
	$MarginContainer/TabContainer/Step1RollStats/Buttons/ResetButton.pressed.connect(_on_reset_stats)
	$MarginContainer/TabContainer/Step1RollStats/NextButton.pressed.connect(func(): tab_container.current_tab = 1)

	race_option.item_selected.connect(_on_race_selected)
	advanced_check.toggled.connect(_on_advanced_toggled)

	$MarginContainer/TabContainer/Step2RaceOrigin/NextButton.pressed.connect(func(): tab_container.current_tab = 2)

	arche1_option.item_selected.connect(update_arche_options)
	arche2_option.item_selected.connect(update_arche_options)

	$MarginContainer/TabContainer/Step3Archetypes/NextButton.pressed.connect(func(): tab_container.current_tab = 3; _update_review())

	name_input.text_changed.connect(_on_name_changed)
	confirm_button.pressed.connect(_on_confirm)
	confirm_button.disabled = true  # Initial disable

	# Populate dropdowns
	for key in Data.RACES.keys():
		race_option.add_item(key)
	for key in Data.ARCHETYPES.keys():
		arche1_option.add_item(key)
		arche2_option.add_item(key)

	_on_race_selected(0)  # Initial

func _on_name_changed(text: String):
	confirm_button.disabled = text.strip_edges().is_empty()

func _on_roll_stats():
	var attributes = [agi_score, app_score, brawn_score, con_score, int_score, mem_score]
	var scores = []
	for i in range(6):
		var dice = []
		for d in range(3):
			var roll = randi() % 6 + 1
			if roll <= 2:
				roll = randi() % 6 + 1
			dice.append(roll)
		scores.append(dice[0] + dice[1] + dice[2])

	var total = scores.reduce(func(acc, val): return acc + val, 0)

	if total < 55:
		scores.sort()
		scores.reverse()
		var diff = 55 - total
		scores[0] += diff / 2
		scores[1] += diff - (diff / 2)

	for i in range(6):
		attributes[i].value = scores[i]

func _on_reset_stats():
	var attributes = [agi_score, app_score, brawn_score, con_score, int_score, mem_score]
	for spin in attributes:
		spin.value = 1

func _on_race_selected(idx: int):
	var race = race_option.get_item_text(idx)
	general_perk_dropdown.visible = (race == "Human")
	origin_option.clear()
	if advanced_check.button_pressed:
		for key in Data.ORIGINS.keys():
			origin_option.add_item(key)
	else:
		if race == "Construct":
			origin_option.add_item("Warteruhe")
			origin_option.selected = 0
			return
		if race == "Faeblen":
			origin_option.add_item("Court of Fables")
			origin_option.selected = 0
			return
		if race == "Orc":
			origin_option.add_item("Muthir")
			origin_option.add_item("Ahjitar")
			return
		# Default all
		for key in Data.ORIGINS.keys():
			origin_option.add_item(key)

func _on_advanced_toggled(_toggled: bool):
	_on_race_selected(race_option.selected)

func update_arche_options(_idx: int = 0):
	var arche1_selected = arche1_option.selected
	var arche2_selected = arche2_option.selected

	arche1_option.clear()
	arche2_option.clear()

	for key in Data.ARCHETYPES.keys():
		arche1_option.add_item(key)
		arche2_option.add_item(key)

	if arche2_selected != -1 and arche2_selected < arche1_option.item_count:
		arche1_option.set_item_disabled(arche2_selected, true)

	if arche1_selected != -1 and arche1_selected < arche2_option.item_count:
		arche2_option.set_item_disabled(arche1_selected, true)

	arche1_option.selected = arche1_selected
	arche2_option.selected = arche2_selected

func _update_review():
	var stats_str = "Stats:\nAgi: " + str(agi_score.value) + "\nApp: " + str(app_score.value) + "\nBrawn: " + str(brawn_score.value) + "\nCon: " + str(con_score.value) + "\nInt: " + str(int_score.value) + "\nMem: " + str(mem_score.value)
	stats_summary.text = stats_str

	var race_origin_str = "Race: " + race_option.get_item_text(race_option.selected) + "\nOrigin: " + origin_option.get_item_text(origin_option.selected)
	if general_perk_dropdown.visible:
		race_origin_str += "\nGeneral Perk: " + general_perk_dropdown.get_item_text(general_perk_dropdown.selected)
	race_origin_summary.text = race_origin_str

	var arche_str = "Primary Archetype: " + arche1_option.get_item_text(arche1_option.selected) + "\nSecondary Archetype: " + arche2_option.get_item_text(arche2_option.selected)
	archetypes_summary.text = arche_str

func _on_confirm():
	var new_character_data: Dictionary = {  # ← Renamed
		"name": name_input.text.strip_edges(),
		"agi": agi_score.value,
		"app": app_score.value,
		"brawn": brawn_score.value,
		"con": con_score.value,
		"intu": int_score.value,
		"mem": mem_score.value,
		"race": race_option.selected,
		"origin": origin_option.selected,
		"arche1": arche1_option.selected,
		"arche2": arche2_option.selected,
		"general_perk": general_perk_dropdown.selected if general_perk_dropdown.visible else -1
	}

	Global.clear_creation_data()
	Global.character_creation_data = new_character_data
	get_tree().change_scene_to_file("res://main.tscn")
