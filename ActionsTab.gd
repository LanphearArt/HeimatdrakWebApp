# ActionsTab.gd
extends VBoxContainer

@onready var main_hand_header: Label = $ActionsHeader/MainHandHeader
@onready var main_action1_button: Button = $ActionsHeader/MainHandGrid/Action1Button
@onready var main_action2_button: Button = $ActionsHeader/MainHandGrid/Action2Button

@onready var off_hand_header: Label = $ActionsHeader/OffHandHeader
@onready var off_action1_button: Button = $ActionsHeader/OffHandGrid/Action1Button
@onready var off_action2_button: Button = $ActionsHeader/OffHandGrid/Action2Button

# Perks Placeholder
@onready var perks_header: Label = $PerksSection/PerksHeader
@onready var perks_container: VBoxContainer = $PerksSection/ScrollContainer/PerksContainer

var current_main_hand: String = "None"
var current_off_hand: String = "None"

var roll_popup: Window = null

func _ready():
	# Connect action buttons

	# Perk placeholders
	perks_header.text = "Perk Actions (Unlocked at Rank Milestones)"
	_add_perk_placeholder("Rank 1 Perk Slot")
	_add_perk_placeholder("Rank 3 Perk Slot")
	_add_perk_placeholder("Rank 5 Perk Slot")
	_add_perk_placeholder("Rank 7 Perk Slot")
	_add_perk_placeholder("Rank 10 Perk Slot")

	# Initial update
	update_weapon_actions()

func update_from_gear(main_item: String, off_item: String):
	current_main_hand = main_item
	current_off_hand = off_item
	update_weapon_actions()

func update_weapon_actions():
	_update_main_hand_actions(current_main_hand)
	_update_off_hand_actions(current_off_hand)

func _update_main_hand_actions(item: String):
	if item == "None" or not Data.WEAPONS.has(item):
		main_hand_header.text = "Main Hand: None"
		main_action1_button.text = "-"
		main_action2_button.text = "-"
		main_action1_button.disabled = true
		main_action2_button.disabled = true
		return

	var w = Data.WEAPONS[item]
	main_hand_header.text = "Main Hand: " + item
	main_action1_button.text = w.get("action1", "-")
	main_action2_button.text = w.get("action2", "-")
	main_action1_button.disabled = false
	main_action2_button.disabled = false

func _update_off_hand_actions(item: String):
	if item == "None":
		off_hand_header.text = "Off Hand: None"
		off_action1_button.text = "-"
		off_action2_button.text = "-"
		off_action1_button.disabled = true
		off_action2_button.disabled = true
		return

	if Data.WEAPONS.has(item):
		var w = Data.WEAPONS[item]
		off_hand_header.text = "Off Hand: " + item
		off_action1_button.text = w.get("action1", "-")
		off_action2_button.text = w.get("action2", "-")
		off_action1_button.disabled = false
		off_action2_button.disabled = false
	elif Data.ARMOR.has(item) and Data.ARMOR[item].get("is_shield", false):
		off_hand_header.text = "Off Hand: Shield"
		off_action1_button.text = Data.ARMOR[item].get("shield_action", "Block")
		off_action2_button.text = "-"
		off_action1_button.disabled = false
		off_action2_button.disabled = true

func _add_perk_placeholder(text: String):
	var panel = PanelContainer.new()
	var label = Label.new()
	label.text = text + " - Not Selected"
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	panel.add_child(label)
	perks_container.add_child(panel)
