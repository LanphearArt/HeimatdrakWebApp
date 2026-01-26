# PerksTab.gd
extends VBoxContainer

# Header
@onready var race_perk_label: Label = $Header/RacePerkLabel
@onready var race_perk_dropdown: OptionButton = $Header/RacePerkDropdown
@onready var origin_perk_label: Label = $Header/OriginPerkLabel

# General Perks Section
@onready var general_perks_label: Label = $GeneralPerksSection/GeneralPerksLabel
@onready var general_perks_dropdown: OptionButton = $GeneralPerksSection/GeneralPerksDropdown
@onready var add_general_perk_button: Button = $GeneralPerksSection/AddPerkButton

# Selected Perks
@onready var selected_perks_container: VBoxContainer = $SelectedPerksSection/ScrollContainer/SelectedPerksContainer

# Perk Actions
@onready var perk_actions_header: Label = $PerksActionsSection/PerkActionsHeader
@onready var perk_actions_grid: GridContainer = $PerksActionsSection/PerkActionsGrid

var current_race: String = ""
var current_origin: String = ""
var selected_perks: Array = []

func _ready():
	# Safety: hide sections if nodes missing
	if race_perk_label == null: push_warning("RacePerkLabel not found")
	if race_perk_dropdown == null: push_warning("RacePerkDropdown not found")
	if origin_perk_label == null: push_warning("OriginPerkLabel not found")

	if general_perks_label == null: push_warning("GeneralPerksLabel not found")
	if general_perks_dropdown == null: push_warning("GeneralPerksDropdown not found")
	if add_general_perk_button == null: push_warning("AddPerkButton not found")

	if selected_perks_container == null: push_warning("SelectedPerksContainer not found")

	if perk_actions_header == null: push_warning("PerkActionsHeader not found")
	if perk_actions_grid == null: push_warning("PerkActionsGrid not found")

	# Connect button
	if add_general_perk_button:
		add_general_perk_button.pressed.connect(_on_add_general_perk)

	# Initial empty state
	update_header_perks("", "")
	update_general_perks_dropdown(false)

func update_header_perks(race: String, origin: String):
	print("PerksTab received: Race=", race, " Origin=", origin)  # Debug
	current_race = race
	current_origin = origin

	# Origin Perk
	if origin_perk_label:
		var origin_perk_name = Data.ORIGIN_DATA.get(origin, {}).get("perk", "None")
		origin_perk_label.text = "Origin Perk: " + origin_perk_name

	# Race Perk & Dropdown
	if race_perk_label and race_perk_dropdown:
		race_perk_dropdown.visible = false
		if race in Data.RACE_DATA:
			var rd = Data.RACE_DATA[race]
			if rd["type"] == "standard":
				race_perk_label.text = "Race Perk: " + rd.get("perk", "None")
			elif rd["type"] == "choose_general":
				race_perk_label.text = "Race Perk: Choose One General Perk"
				race_perk_dropdown.visible = true
				_populate_general_dropdown()
			elif rd["type"] == "unique":
				race_perk_label.text = "Race Perk: Choose Drakken Perk"
				race_perk_dropdown.visible = true
				race_perk_dropdown.clear()
				for p in rd["perks"]:
					race_perk_dropdown.add_item(p)
			elif rd["type"] == "none":
				race_perk_label.text = "Race Perk: None (Orc)"
		else:
			race_perk_label.text = "Race Perk: None"

	update_general_perks_dropdown(race == "Human")

func update_general_perks_dropdown(is_human: bool):
	if general_perks_label and general_perks_dropdown and add_general_perk_button:
		general_perks_label.visible = is_human
		general_perks_dropdown.visible = is_human
		add_general_perk_button.visible = is_human
		if is_human:
			_populate_general_dropdown()

func _populate_general_dropdown():
	if general_perks_dropdown:
		general_perks_dropdown.clear()
		for perk_name in Data.GENERAL_PERKS.keys():
			if not selected_perks.has(perk_name):
				general_perks_dropdown.add_item(perk_name)
				

func _on_add_general_perk():
	if general_perks_dropdown and general_perks_dropdown.selected != -1:
		var selected = general_perks_dropdown.get_item_text(general_perks_dropdown.selected)
		if selected != "" and not selected_perks.has(selected):
			selected_perks.append(selected)
			_add_selected_perk(selected)
			_populate_general_dropdown()

func _add_selected_perk(perk_name: String):
	if selected_perks_container == null:
		push_warning("Cannot add perk - SelectedPerksContainer missing")
		return

	var panel = PanelContainer.new()
	var vbox = VBoxContainer.new()

	var name_label = Label.new()
	name_label.text = perk_name
	name_label.add_theme_font_size_override("font_size", 16)

	var desc_label = Label.new()
	desc_label.text = Data.GENERAL_PERKS[perk_name].get("desc", "No description")
	desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD

	vbox.add_child(name_label)
	vbox.add_child(desc_label)

	panel.add_child(vbox)
	selected_perks_container.add_child(panel)

	# If it's an action perk, add to actions grid (future)
	if Data.GENERAL_PERKS[perk_name].get("is_action", false) and perk_actions_grid:
		var button = Button.new()
		button.text = perk_name + " (Perk Action)"
		perk_actions_grid.add_child(button)
