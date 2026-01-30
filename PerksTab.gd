# PerksTab.gd
extends VBoxContainer

signal active_perks_changed(active_perks: Array[Dictionary])

@onready var race_perk_title: Label = $Header/RacePerkTitle
@onready var race_perk_desc: Label = $Header/RacePerkDesc
@onready var origin_perk_title: Label = $Header/OriginPerkTitle
@onready var origin_perk_desc: Label = $Header/OriginPerkDesc
@onready var header_container: VBoxContainer = $Header


@onready var perk_tabs: TabContainer = $PerkTabs
@onready var archetype1_container: VBoxContainer = $PerkTabs/Archetype1/ArchetypePerksSection/ScrollContainer/Archetype1Container
@onready var archetype2_container: VBoxContainer = $PerkTabs/Archetype2/ArchetypePerksSection/ScrollContainer/Archetype2Container


# New paths under PerkTabs
@onready var archetype_perks_container: VBoxContainer = $PerkTabs/Archetype/ArchetypePerksSection/ScrollContainer/ArchetypePerksContainer
@onready var selected_perks_container: VBoxContainer = $PerkTabs/Selected/SelectedPerksSection/ScrollContainer/SelectedPerksContainer

var selected_general_perks: Array[String] = []  # Global for greying duplicates
var bonus_selections: Dictionary = {}  # slot_key -> selected general perk name
var selected_perks: Array[String] = []
var bonus_choices: Dictionary = {}  # slot_key -> chosen general perk name (or "")
var is_edit_mode: bool = true  # TODO: Connect to a toggle button/signal for locking sheet
var current_race: String = ""

func _ready() -> void:
	perk_tabs.current_tab = 0
	
	var spacing: int = 10
	archetype1_container.add_theme_constant_override("separation", spacing)
	archetype2_container.add_theme_constant_override("separation", spacing)
	pass  # Connections handled in MainScript

func update_header_perks(race: String, origin: String) -> void:
	current_race = race
	
	# Clear dynamic dropdown if present (for unique racial choices only)
	var old_dropdown = header_container.get_node_or_null("RacePerkDropdown")
	if old_dropdown:
		old_dropdown.queue_free()
	
	race_perk_title.text = ""
	race_perk_desc.text = ""
	
	var race_data = Data.RACE_DATA.get(race, {"type": "none"})
	
	if race_data["type"] == "standard":
		race_perk_title.text = race_data.get("perk", "No Perk")
		race_perk_desc.text = "See ruleset for details."
	elif race_data["type"] == "choose_general":  # Human
		race_perk_title.text = "Bonus General Perk"
		race_perk_desc.text = "See Archetype tab for choice dropdown (racial bonus slot)."
	elif race_data["type"] == "unique":
		race_perk_title.text = "Choose Unique Perk"
		race_perk_desc.text = "Select from dropdown below."
		
		var dropdown = OptionButton.new()
		dropdown.name = "RacePerkDropdown"
		dropdown.disabled = not is_edit_mode
		for perk in race_data["perks"]:
			dropdown.add_item(perk)
		dropdown.item_selected.connect(func(idx):
			if not is_edit_mode: return
			var chosen = dropdown.get_item_text(idx)
			race_perk_title.text = chosen
			race_perk_desc.text = "See ruleset for details."
			if not selected_perks.has(chosen):
				selected_perks.append(chosen)
				_refresh_selected_tab()
		)
		header_container.add_child(dropdown)
	else:
		race_perk_title.text = "No Racial Perk"
	
	# Origin (unchanged)
	var origin_data = Data.ORIGIN_DATA.get(origin, {"perk": "No Origin Perk", "desc": ""})
	origin_perk_title.text = origin_data["perk"]
	origin_perk_desc.text = origin_data["desc"]

func update_archetype_perks(arche1: String, arche2: String, rank: int) -> void:
	_clear_container(archetype1_container)
	_clear_container(archetype2_container)
	
	var arche1_perks: Array[Dictionary] = []
	var arche2_perks: Array[Dictionary] = []
	
	# Human racial bonus (always in Archetype 1 tab, rank 0)
	if current_race == "Human":
		arche1_perks.append({
			"name": "Bonus General Perk (Racial)",
			"desc": "Choose one additional general perk.",
			"rank": 0,
			"is_bonus": true,
			"slot_key": "Human_Racial"
		})
	
	# Archetype 1 perks
	if arche1 and arche1 != "None":
		var perks_dict = Data.ARCHETYPE_PERKS.get(arche1, {})
		for perk_name: String in perks_dict.keys():
			var p_data = perks_dict[perk_name]
			if p_data.get("rank", 1) <= rank:
				if perk_name.begins_with("Bonus Perk"):
					arche1_perks.append({
						"name": perk_name,
						"desc": p_data.get("desc", "Choose a general perk."),
						"rank": p_data.get("rank", 1),
						"is_bonus": true,
						"slot_key": arche1 + "_" + perk_name
					})
				else:
					arche1_perks.append({
						"name": perk_name,
						"desc": p_data.get("desc", "No description."),
						"rank": p_data.get("rank", 1),
						"is_bonus": false
					})
	
	# Archetype 2 perks (same logic)
	if arche2 and arche2 != "None" and arche2 != arche1:
		var perks_dict = Data.ARCHETYPE_PERKS.get(arche2, {})
		for perk_name: String in perks_dict.keys():
			var p_data = perks_dict[perk_name]
			if p_data.get("rank", 1) <= rank:
				if perk_name.begins_with("Bonus Perk"):
					arche2_perks.append({
						"name": perk_name,
						"desc": p_data.get("desc", "Choose a general perk."),
						"rank": p_data.get("rank", 1),
						"is_bonus": true,
						"slot_key": arche2 + "_" + perk_name
					})
				else:
					arche2_perks.append({
						"name": perk_name,
						"desc": p_data.get("desc", "No description."),
						"rank": p_data.get("rank", 1),
						"is_bonus": false
					})
	var active_perks: Array[Dictionary] = []
	
	# Add earned non-bonus perks with effects
	for perk_list in [arche1_perks, arche2_perks]:
		for p in perk_list:
			if not p.is_bonus:
				var perk_data = Data.ARCHETYPE_PERKS.get(arche1 if perk_list == arche1_perks else arche2, {}).get(p.name, {})
				if perk_data.has("skill_bonuses") or perk_data.get("is_action", false):
					active_perks.append({"name": p.name, "data": perk_data})
	
	# Add selected general perks (from bonus_selections)
	for selected_name in bonus_selections.values():
		if selected_name != "None" and selected_name != "":
			var g_data = Data.GENERAL_PERKS.get(selected_name, {})
			if g_data.has("skill_bonuses") or g_data.get("is_action", false):
				active_perks.append({"name": selected_name, "data": g_data})
	
	emit_signal("active_perks_changed", active_perks)
	# Sort each list by rank
	arche1_perks.sort_custom(func(a, b): return a.rank < b.rank)
	arche2_perks.sort_custom(func(a, b): return a.rank < b.rank)
	
	# Build Archetype 1 tab
	_build_perk_list(archetype1_container, arche1_perks)
	
	# Build Archetype 2 tab + rename/hide logic
	_build_perk_list(archetype2_container, arche2_perks)
	
	perk_tabs.set_tab_title(0, arche1 if arche1 != "None" else "No Primary Archetype")
	if arche2 and arche2 != "None":
		perk_tabs.set_tab_title(1, arche2)
		perk_tabs.set_tab_hidden(1, false)
	else:
		perk_tabs.set_tab_title(1, "No Second Archetype")
		perk_tabs.set_tab_hidden(1, true)  # Hide if no dual

func _clear_container(container: VBoxContainer) -> void:
	if container:
		for child in container.get_children():
			child.queue_free()

func _add_selected_perk(perk_name: String) -> void:
	var label = Label.new()
	label.text = "%s: %s" % [perk_name, Data.GENERAL_PERKS.get(perk_name, {}).get("desc", "No description available.")]
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART  # Better wrapping
	
	var panel = _create_panel_entry(label)
	selected_perks_container.add_child(panel)
	
	# Live refresh all bonus dropdowns to remove the chosen perk
	_refresh_bonus_dropdowns()

func _populate_general_dropdown(dropdown: OptionButton) -> void:
	dropdown.add_item("None")
	for perk in Data.GENERAL_PERKS.keys():
		if not selected_perks.has(perk):
			dropdown.add_item(perk)
func _create_panel_entry(content: Node) -> PanelContainer:
	var panel = PanelContainer.new()
	var margin = MarginContainer.new()
	margin.add_theme_constant_override("margin_top", 8)
	margin.add_theme_constant_override("margin_bottom", 8)
	margin.add_theme_constant_override("margin_left", 12)
	margin.add_theme_constant_override("margin_right", 12)
	
	margin.add_child(content)
	panel.add_child(margin)
	return panel
func _populate_bonus_dropdown(dropdown: OptionButton, slot_key: String, desc_label: Label) -> void:
	dropdown.clear()
	dropdown.add_item("None")
	
	var current = bonus_selections.get(slot_key, "None")
	var select_idx = 0
	
	var idx = 1
	for g_perk in Data.GENERAL_PERKS.keys():
		dropdown.add_item(g_perk)
		if selected_general_perks.has(g_perk):
			dropdown.set_item_disabled(idx, true)
		if g_perk == current:
			select_idx = idx
		idx += 1
	
	dropdown.select(select_idx)
	
	# Initial desc update
	if current != "None":
		desc_label.text = "%s: %s" % [current, Data.GENERAL_PERKS.get(current, {}).get("desc", "No description.")]
	else:
		desc_label.text = "No selection"
	
	dropdown.item_selected.connect(func(new_idx):
		if not is_edit_mode: return
		var new_choice = dropdown.get_item_text(new_idx)
		var old_choice = bonus_selections.get(slot_key, "None")
		
		if new_choice == old_choice: return
		
		if new_choice != "None" and selected_general_perks.has(new_choice):
			# Revert
			dropdown.select(dropdown.get_item_index(old_choice) if old_choice != "None" else 0)
			return
		
		# Free old
		if old_choice != "None":
			selected_general_perks.erase(old_choice)
		
		# Assign new
		if new_choice != "None":
			selected_general_perks.append(new_choice)
			bonus_selections[slot_key] = new_choice
		else:
			bonus_selections.erase(slot_key)
		
		# Update this card's desc
		if new_choice != "None":
			desc_label.text = "%s: %s" % [new_choice, Data.GENERAL_PERKS.get(new_choice, {}).get("desc", "No description.")]
		else:
			desc_label.text = "No selection"
		
		_refresh_all_bonus_dropdowns()  # Grey taken globally
	)
func _refresh_bonus_dropdowns() -> void:
	for child in archetype_perks_container.get_children():
		if child is PanelContainer:
			var margin = child.get_child(0) as MarginContainer
			if margin and margin.get_child_count() > 0:
				var content = margin.get_child(0)
				if content is HBoxContainer and content.get_child_count() > 1:
					var dropdown = content.get_child(1) as OptionButton
					if dropdown:
						var _current_idx: int = dropdown.selected  # Unused but kept for clarity; prefixed to silence warning
						var current_text: String = dropdown.get_item_text(dropdown.selected) if dropdown.selected > -1 else "None"
						
						# Rebuild items with updated disabled state
						dropdown.clear()
						dropdown.add_item("None")
						var item_idx: int = 1
						var new_select_idx: int = 0
						for g_perk in Data.GENERAL_PERKS.keys():
							dropdown.add_item(g_perk)
							if selected_perks.has(g_perk):
								dropdown.set_item_disabled(item_idx, true)
							if g_perk == current_text:
								new_select_idx = item_idx
							item_idx += 1
						
						dropdown.select(new_select_idx if current_text != "None" or new_select_idx > 0 else 0)

func _refresh_selected_tab() -> void:
	_clear_container(selected_perks_container)
	selected_perks.clear()
	
	var choices = bonus_choices.values()
	for choice in choices:
		if choice != "" and choice != "None" and not selected_perks.has(choice):
			selected_perks.append(choice)
	
	for perk in selected_perks:
		var label = Label.new()
		label.text = "%s: %s" % [perk, Data.GENERAL_PERKS.get(perk, {}).get("desc", "No description available.")]
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		var panel = _create_panel_entry(label)
		selected_perks_container.add_child(panel)

func _build_perk_list(container: VBoxContainer, perks: Array) -> void:
	for p in perks:
		var main_vbox = VBoxContainer.new()
		
		var name_label = Label.new()
		name_label.text = "%s (Rank %d)" % [p.name, p.rank]
		main_vbox.add_child(name_label)
		
		var desc_label = Label.new()
		desc_label.text = p.desc
		desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		main_vbox.add_child(desc_label)
		
		var selected_desc_label = Label.new()
		selected_desc_label.text = "No selection"
		selected_desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		selected_desc_label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))  # Subtle gray
		
		if p.is_bonus:
			var dropdown = OptionButton.new()
			dropdown.disabled = not is_edit_mode
			_populate_bonus_dropdown(dropdown, p.slot_key, selected_desc_label)
			
			main_vbox.add_child(dropdown)  # Index 2
			main_vbox.add_child(selected_desc_label)  # Index 3
		else:
			selected_desc_label.queue_free()  # No need for normal perks
		
		var panel = _create_panel_entry(main_vbox)
		container.add_child(panel)

func _refresh_all_bonus_dropdowns() -> void:
	# Process both tabs' containers
	for container in [archetype1_container, archetype2_container]:
		for child in container.get_children():
			if child is PanelContainer:
				var margin = child.get_child(0) as MarginContainer
				if margin and margin.get_child_count() > 0:
					var main_vbox = margin.get_child(0) as VBoxContainer
					if main_vbox and main_vbox.get_child_count() >= 3:  # Has dropdown + desc label
						var dropdown = main_vbox.get_child(2) as OptionButton  # Index 2 = dropdown (0=name, 1=desc, 2=dropdown, 3=selected_desc)
						var desc_label = main_vbox.get_child(3) as Label
						if dropdown and desc_label:
							# Grab current choice before rebuild
							var current_text: String = dropdown.get_item_text(dropdown.selected) if dropdown.selected > -1 else "None"
							
							# Find slot_key (stored in dropdown's metadata or rebuild fully—here we repopulate generically)
							# Since slot_key isn't stored on dropdown, we repopulate preserving text (works fine)
							dropdown.clear()
							dropdown.add_item("None")
							
							var idx: int = 1
							var new_select_idx: int = 0
							for g_perk in Data.GENERAL_PERKS.keys():
								dropdown.add_item(g_perk)
								if selected_general_perks.has(g_perk):
									dropdown.set_item_disabled(idx, true)
								if g_perk == current_text:
									new_select_idx = idx
								idx += 1
							
							dropdown.select(new_select_idx)
							
							# Update local desc (in case grey-out changed visibility)
							if current_text != "None":
								desc_label.text = "%s: %s" % [current_text, Data.GENERAL_PERKS.get(current_text, {}).get("desc", "No description.")]
							else:
								desc_label.text = "No selection"
