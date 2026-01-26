# GearTab.gd
extends VBoxContainer

signal equipped_changed(main_hand: String, off_hand: String)

@onready var main_hand_option: OptionButton = $EquippedHeader/MainHandOption
@onready var off_hand_option: OptionButton = $EquippedHeader/OffHandContainer/OffHandOption
@onready var armor_option: OptionButton = $EquippedHeader/ArmorOption

# Main Hand Stats Labels
@onready var main_hand_bonus: Label = $EquippedHeader/MainHandStatsGrid/MainHandBonus
@onready var main_hand_action1: Label = $EquippedHeader/MainHandStatsGrid/MainHandAction1
@onready var main_hand_action2: Label = $EquippedHeader/MainHandStatsGrid/MainHandAction2
@onready var main_hand_range: Label = $EquippedHeader/MainHandStatsGrid/MainHandRange

# Off Hand Stats Labels
@onready var off_hand_bonus: Label = $EquippedHeader/OffHandContainer/OffHandStatsGrid/OffHandBonus
@onready var off_hand_action1: Label = $EquippedHeader/OffHandContainer/OffHandStatsGrid/OffHandAction1
@onready var off_hand_action2_label: Label = $EquippedHeader/OffHandContainer/OffHandStatsGrid/Actions2Label
@onready var off_hand_action2: Label = $EquippedHeader/OffHandContainer/OffHandStatsGrid/OffHandAction2
@onready var off_hand_range: Label = $EquippedHeader/OffHandContainer/OffHandStatsGrid/OffHandRange

# Off-Hand container
@onready var off_hand_container: Control = $EquippedHeader/OffHandContainer

# Armor Stats Labels
@onready var armor_weight_class: Label = $EquippedHeader/ArmorStatsGrid/ArmorWeightClass
@onready var armor_ar: Label = $EquippedHeader/ArmorStatsGrid/ArmorAR

# Inventory
@onready var inventory_container: VBoxContainer = $InventoryScroll/InventoryContainer
@onready var total_weight_label: Label = $TotalWeightLabel
@onready var add_item_button: Button = $AddItemButton

var equipped_weight: float = 0.0

func _ready():
	add_item_button.pressed.connect(_on_add_item_pressed)
	call_deferred("add_inventory_row")

	# Populate main hand
	main_hand_option.add_item("None")
	for key in Data.WEAPONS.keys():
		main_hand_option.add_item(key)

	# Populate off-hand: one-handed weapons + shields
	off_hand_option.add_item("None")
	for key in Data.WEAPONS.keys():
		if Data.WEAPONS[key].get("one_handed", true):
			off_hand_option.add_item(key)
	for key in Data.ARMOR.keys():
		if Data.ARMOR[key].get("is_shield", false):
			off_hand_option.add_item(key)

	# Populate armor (non-shield armor)
	armor_option.add_item("None")
	for key in Data.ARMOR.keys():
		if not Data.ARMOR[key].get("is_shield", false):
			armor_option.add_item(key)

	# Connect signals
	main_hand_option.item_selected.connect(_on_main_hand_changed)
	off_hand_option.item_selected.connect(_on_off_hand_changed)
	armor_option.item_selected.connect(_on_armor_changed)

	# Initial update
	_on_main_hand_changed(main_hand_option.selected)
	_on_off_hand_changed(off_hand_option.selected)
	_on_armor_changed(armor_option.selected)
	_update_equipped_weight()

func _on_main_hand_changed(idx: int):
	var item = main_hand_option.get_item_text(idx)
	_update_main_hand_stats(idx)

	var is_two_handed = item != "None" and Data.WEAPONS.has(item) and not Data.WEAPONS[item].get("one_handed", true)
	off_hand_container.visible = not is_two_handed

	if is_two_handed:
		off_hand_option.selected = 0
		_on_off_hand_changed(0)

	emit_signal("equipped_changed", item, off_hand_option.get_item_text(off_hand_option.selected))
	_update_equipped_weight()

func _on_off_hand_changed(idx: int):
	var item = off_hand_option.get_item_text(idx)
	_update_off_hand_stats(idx)
	emit_signal("equipped_changed", main_hand_option.get_item_text(main_hand_option.selected), item)
	_update_equipped_weight()

func _on_armor_changed(idx: int):
	var _item = armor_option.get_item_text(idx)
	_update_armor_stats(idx)
	_update_equipped_weight()

func _update_main_hand_stats(idx: int):
	var item = main_hand_option.get_item_text(idx)
	if item == "None" or not Data.WEAPONS.has(item):
		main_hand_bonus.text = ""
		main_hand_bonus.tooltip_text = ""
		main_hand_action1.text = ""
		main_hand_action2.text = ""
		main_hand_range.text = ""
		return

	var stats = Data.WEAPONS[item]
	main_hand_bonus.text = stats.get("accuracy_stat", "")
	main_hand_bonus.tooltip_text = "Uses this accuracy stat"
	main_hand_action1.text = stats.get("action1", "")
	main_hand_action2.text = stats.get("action2", "")
	main_hand_range.text = stats.get("range", "")

func _update_off_hand_stats(idx: int):
	var item = off_hand_option.get_item_text(idx)
	if item == "None":
		off_hand_bonus.text = ""
		off_hand_bonus.tooltip_text = ""
		off_hand_action1.text = ""
		off_hand_action2_label.visible = false
		off_hand_action2.text = ""
		off_hand_action2.visible = false
		off_hand_range.text = ""
		return

	if Data.WEAPONS.has(item):
		var stats = Data.WEAPONS[item]
		off_hand_bonus.text = stats.get("accuracy_stat", "")
		off_hand_bonus.tooltip_text = "Uses this accuracy stat"
		off_hand_action1.text = stats.get("action1", "")
		off_hand_action2_label.visible = true
		off_hand_action2.text = stats.get("action2", "")
		off_hand_action2.visible = true
		off_hand_range.text = stats.get("range", "")
	elif Data.ARMOR.has(item) and Data.ARMOR[item].get("is_shield", false):
		var shield_stats = Data.ARMOR[item]
		off_hand_bonus.text = "Shield"
		off_hand_bonus.tooltip_text = "Defensive item"
		off_hand_action1.text = shield_stats.get("shield_action", "Block")
		off_hand_action2_label.visible = false
		off_hand_action2.text = ""
		off_hand_action2.visible = false
		off_hand_range.text = "Close"

func _update_armor_stats(idx: int):
	var item = armor_option.get_item_text(idx)
	if item == "None" or not Data.ARMOR.has(item):
		armor_weight_class.text = ""
		armor_ar.text = ""
		return

	var stats = Data.ARMOR[item]
	armor_weight_class.text = stats.get("weight_class", "")
	armor_ar.text = str(stats.get("ar", 0))

func _update_equipped_weight():
	equipped_weight = 0.0

	var armor_item = armor_option.get_item_text(armor_option.selected)
	if armor_item != "None" and Data.ARMOR.has(armor_item):
		equipped_weight += Data.ARMOR[armor_item].get("weight_kg", 0.0)

	if off_hand_container.visible:
		var off_item = off_hand_option.get_item_text(off_hand_option.selected)
		if off_item != "None" and Data.ARMOR.has(off_item) and Data.ARMOR[off_item].get("is_shield", false):
			equipped_weight += Data.ARMOR[off_item].get("weight_kg", 0.0)

	update_total_weight()

func update_total_weight():
	var inventory_total: float = 0.0
	for row in inventory_container.get_children():
		if row is HBoxContainer and row.get_child_count() >= 3:
			inventory_total += row.get_child(0).value * row.get_child(2).value

	var grand_total = inventory_total + equipped_weight
	total_weight_label.text = "Total Weight: %.1f kg" % grand_total

func _on_add_item_pressed():
	add_inventory_row()

func add_inventory_row(qty: int = 1, item_name: String = "", weight: float = 0.0):
	var row = HBoxContainer.new()
	row.alignment = BoxContainer.ALIGNMENT_CENTER

	var qty_spin = SpinBox.new()
	qty_spin.min_value = 0
	qty_spin.max_value = 999
	qty_spin.value = qty
	qty_spin.prefix = "Qty:"
	qty_spin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	qty_spin.value_changed.connect(func(_v): update_total_weight())

	var name_edit = LineEdit.new()
	name_edit.placeholder_text = "Item name"
	name_edit.text = item_name
	name_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_edit.size_flags_stretch_ratio = 3

	var weight_spin = SpinBox.new()
	weight_spin.min_value = 0.0
	weight_spin.max_value = 999.9
	weight_spin.step = 0.1
	weight_spin.value = weight
	weight_spin.suffix = "kg"
	weight_spin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	weight_spin.value_changed.connect(func(_v): update_total_weight())

	var delete_btn = Button.new()
	delete_btn.text = "X"
	delete_btn.tooltip_text = "Remove item"
	delete_btn.pressed.connect(func():
		row.queue_free()
		update_total_weight()
	)

	row.add_child(qty_spin)
	row.add_child(name_edit)
	row.add_child(weight_spin)
	row.add_child(delete_btn)

	inventory_container.add_child(row)
	update_total_weight()

func get_save_data() -> Dictionary:
	var inv_data = []
	for row in inventory_container.get_children():
		if row is HBoxContainer and row.get_child_count() >= 3:
			inv_data.append({
				"qty": row.get_child(0).value,
				"name": row.get_child(1).text,
				"weight": row.get_child(2).value
			})

	return {
		"main_hand": main_hand_option.get_item_text(main_hand_option.selected),
		"off_hand": off_hand_option.get_item_text(off_hand_option.selected),
		"armor": armor_option.get_item_text(armor_option.selected),
		"inventory": inv_data
	}

func load_data(data: Dictionary) -> void:
	# Equipped
	_select_option(main_hand_option, data.get("main_hand", "None"))
	_select_option(off_hand_option, data.get("off_hand", "None"))
	_select_option(armor_option, data.get("armor", "None"))
	_on_main_hand_changed(main_hand_option.selected)
	_on_off_hand_changed(off_hand_option.selected)
	_on_armor_changed(armor_option.selected)
	_update_equipped_weight()
	
	# Inventory - clear existing
	for child in inventory_container.get_children():
		child.queue_free()
	
	var inv_data = data.get("inventory", [])
	for item in inv_data:
		add_inventory_row(item.get("qty", 1), item.get("name", ""), item.get("weight", 0.0))

func _select_option(option: OptionButton, text: String):
	for i in option.get_item_count():
		if option.get_item_text(i) == text:
			option.selected = i
			return
	option.selected = 0  # Default to "None"
