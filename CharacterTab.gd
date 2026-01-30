# CharacterTab.gd
extends VBoxContainer

# Primary Scores
@onready var agi_score: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AgiScore
@onready var app_score: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AppScore
@onready var brawn_score: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/BrawnScore
@onready var con_score: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/ConScore
@onready var int_score: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/IntScore
@onready var mem_score: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/MemScore

# Read-only display labels (add these in scene, next to name labels)
@onready var agi_display: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AgiDisplay
@onready var app_display: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AppDisplay
@onready var brawn_display: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/BrawnDisplay
@onready var con_display: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/ConDisplay
@onready var int_display: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/IntDisplay
@onready var mem_display: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/MemDisplay

# Read-only labels (add these in scene, same parents as spins/dropdowns)
@onready var race_display: Label = $HeaderPanel/HeaderGrid/RaceDisplay
@onready var origin_display: Label = $HeaderPanel/HeaderGrid/OriginDisplay
@onready var arche1_display: Label = $HeaderPanel/HeaderGrid/Arche1Display
@onready var arche2_display: Label = $HeaderPanel/HeaderGrid/Arche2Display
@onready var rank_display: Label = $HeaderPanel/HeaderGrid/RankDisplay

#attribute headers
@onready var attribute_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/Attribute
@onready var base_score_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/BaseScore
@onready var racial_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/Racial
@onready var final_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/Final
@onready var mod_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/Modifier

# Primary RO Labels (race + origin bonuses)
@onready var agi_ro: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AgiRO
@onready var app_ro: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AppRO
@onready var brawn_ro: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/BrawnRO
@onready var con_ro: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/ConRO
@onready var int_ro: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/IntRO
@onready var mem_ro: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/MemRO

# Primary Final Labels (rolled + RO)
@onready var agi_final: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AgiFinal
@onready var app_final: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AppFinal
@onready var brawn_final: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/BrawnFinal
@onready var con_final: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/ConFinal
@onready var int_final: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/IntFinal
@onready var mem_final: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/MemFinal

# Primary Mod Labels
@onready var agi_mod: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AgiMod
@onready var app_mod: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AppMod
@onready var brawn_mod: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/BrawnMod
@onready var con_mod: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/ConMod
@onready var int_mod: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/IntMod
@onready var mem_mod: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/MemMod

# Derived Labels
@onready var max_health: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid1/MaxHealth
@onready var max_stamina: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid1/MaxStamina
@onready var recovery_rate: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid1/RecoveryRate

@onready var ar: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid2/AR
@onready var initiative: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid2/Initiative
@onready var mca: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid2/MCA
@onready var mcb: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid2/MCB
@onready var rca: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid2/RCA
@onready var bcb: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid2/BCB
@onready var cdb: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid2/CDB
@onready var cbb: Label = $DerivedStatsPanel/HBoxContainer/DerivedGrid2/CBB

# Skills (full list)
@onready var arcana_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Arcana/ArcanaCheck
@onready var arcana_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Arcana/ArcanaValue

@onready var athletics_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Athletics/AthleticsCheck
@onready var athletics_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Athletics/AthleticsValue
@onready var athletics_attr_choice: OptionButton = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Athletics/AthleticsAttrChoice

@onready var awareness_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Awareness/AwarenessCheck
@onready var awareness_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Awareness/AwarenessValue

@onready var craft_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Craft/CraftCheck
@onready var craft_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Craft/CraftValue
@onready var craft_attr_choice: OptionButton = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Craft/CraftAttrChoice

@onready var deception_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Deception/DeceptionCheck
@onready var deception_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Deception/DeceptionValue

@onready var history_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/History/HistoryCheck
@onready var history_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/History/HistoryValue

@onready var inspection_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Inspection/InspectionCheck
@onready var inspection_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Inspection/InspectionValue
@onready var inspection_attr_choice: OptionButton = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Inspection/InspectionAttrChoice

@onready var occult_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Occult/OccultCheck
@onready var occult_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Occult/OccultValue

@onready var persuasion_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Persuasion/PersuasionCheck
@onready var persuasion_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Persuasion/PersuasionValue
@onready var persuasion_attr_choice: OptionButton = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Persuasion/PersuasionAttrChoice

@onready var religion_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Religion/ReligionCheck
@onready var religion_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Religion/ReligionValue

@onready var resilience_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Resilience/ResilienceCheck
@onready var resilience_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Resilience/ResilienceValue

@onready var skullduggery_check: CheckBox = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Skullduggery/SkullduggeryCheck
@onready var skullduggery_value: Label = $AttributesSkillsPanel/HBoxContainer/Skills/SkillScroll/SkillsVBox/Skullduggery/SkullduggeryValue

# Header
@onready var race_option: OptionButton = $HeaderPanel/HeaderGrid/Race
@onready var origin_option: OptionButton = $HeaderPanel/HeaderGrid/Origin
@onready var arche1_option: OptionButton = $HeaderPanel/HeaderGrid/Arche1
@onready var arche2_option: OptionButton = $HeaderPanel/HeaderGrid/Arche2
@onready var rank_option: OptionButton = $HeaderPanel/HeaderGrid/Rank

# Buttons (save/load moved to MainScript, but roll/reset stay here)
@onready var roll_button: Button = $ActionContainer/ActionHBox/Roll_Attributes
@onready var point_buy_button: Button = $ActionContainer/ActionHBox/PointBuyReset

# Career bonuses
@onready var crafter_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/CrafterLabel
@onready var crafter_bonus: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/Crafter
@onready var martial_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/MartialLabel
@onready var martial_bonus: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/Martial
@onready var mental_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/MentalLabel
@onready var mental_bonus: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/Mental
@onready var occult_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/OccultLabel
@onready var occult_bonus: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/Occult
@onready var physical_label: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/PhysicalLabel
@onready var physical_bonus: Label = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/CareerGrid/Physical

# Edit Mode
@onready var edit_toggle_button: Button = $ActionContainer/ActionHBox/EditToggleButton  # Add this button in scene

# Editable controls (SpinBoxes, OptionButtons)
@onready var agi_spin: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AgiScore
@onready var app_spin: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/AppScore
@onready var brawn_spin: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/BrawnScore
@onready var con_spin: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/ConScore
@onready var int_spin: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/IntScore
@onready var mem_spin: SpinBox = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid/MemScore

var current_mcb: int = 0

var is_edit_mode: bool = false

signal stats_updated(final_stats: Dictionary)
signal race_origin_changed(race: String, origin: String)
signal archetype_changed(arche1: String, arche2: String, rank: int)

func get_rank() -> int:
	return rank_option.selected + 1 if rank_option.get_item_count() > 0 else 1

func get_modifier(score: float) -> int:
	return floori((score - 10) / 2)

func format_bonus(val: int) -> String:
	return "%+d" % val if val != 0 else "+0"

func get_chosen_mod(choice_node: OptionButton, mod1: int, mod2: int) -> int:
	if choice_node == null or choice_node.selected == -1:
		return mod1
	return [mod1, mod2][choice_node.selected]

func update_arche_options():
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

	if arche1_selected == -1:
		arche1_selected = 0
	if arche2_selected == -1:
		arche2_selected = 0

	arche1_option.selected = arche1_selected
	arche2_option.selected = arche2_selected

func _on_race_selected(idx: int):
	var race = race_option.get_item_text(idx)
	_update_origin_options(race)  # Your restriction logic
	emit_signal("race_origin_changed", race, origin_option.get_item_text(origin_option.selected) if origin_option.selected != -1 else "None")

func _on_origin_selected(idx: int):
	var origin = origin_option.get_item_text(idx)
	emit_signal("race_origin_changed", race_option.get_item_text(race_option.selected), origin)

func _update_origin_options(race: String):
	origin_option.clear()
	if race == "Construct":
		origin_option.add_item("Warteruhe")
		origin_option.selected = 0
	elif race == "Faceless":
		origin_option.add_item("Court of Fables")
		origin_option.selected = 0
	else:
		for key in Data.ORIGINS.keys():
			origin_option.add_item(key)

func _ready():
	for key in Data.RACES.keys():
		race_option.add_item(key)

	for key in Data.ORIGINS.keys():
		origin_option.add_item(key)

	update_arche_options()
	if arche1_option and not arche1_option.item_selected.is_connected(_update_archetype_perks):
		arche1_option.item_selected.connect(_update_archetype_perks)
	if arche2_option and not arche2_option.item_selected.is_connected(_update_archetype_perks):
		arche2_option.item_selected.connect(_update_archetype_perks)
	if rank_option and not rank_option.item_selected.is_connected(_update_archetype_perks):
		rank_option.item_selected.connect(_update_archetype_perks)
	athletics_attr_choice.add_item("Agility")
	athletics_attr_choice.add_item("Brawn")
	athletics_attr_choice.selected = 0

	craft_attr_choice.add_item("Memory")
	craft_attr_choice.add_item("Intuition")
	craft_attr_choice.selected = 0

	inspection_attr_choice.add_item("Intuition")
	inspection_attr_choice.add_item("Memory")
	inspection_attr_choice.selected = 0

	persuasion_attr_choice.add_item("Appeal")
	persuasion_attr_choice.add_item("Brawn")
	persuasion_attr_choice.selected = 0

	var primaries = [agi_score, app_score, brawn_score, con_score, int_score, mem_score]
	for spin in primaries:
		spin.value_changed.connect(_update_all)

	var skill_checks = [
		arcana_check, athletics_check, awareness_check, craft_check, deception_check,
		history_check, inspection_check, occult_check, persuasion_check, religion_check,
		resilience_check, skullduggery_check
	]
	for check in skill_checks:
		check.toggled.connect(_update_all)

	var attr_choices = [athletics_attr_choice, craft_attr_choice, inspection_attr_choice, persuasion_attr_choice]
	for choice in attr_choices:
		choice.item_selected.connect(_update_all)

	race_option.item_selected.connect(_update_all)
	origin_option.item_selected.connect(_update_all)
	arche1_option.item_selected.connect(_update_archetype_perks)
	arche2_option.item_selected.connect(_update_archetype_perks)
	rank_option.item_selected.connect(_update_archetype_perks)

	roll_button.pressed.connect(_on_roll_attributes_pressed)
	point_buy_button.pressed.connect(_on_point_buy_reset_pressed)
	race_option.item_selected.connect(_on_race_selected)
	origin_option.item_selected.connect(_on_origin_selected)

	if edit_toggle_button == null:
		push_warning("EditToggleButton missing! Creating fallback button.")
		edit_toggle_button = Button.new()
		edit_toggle_button.name = "EditToggleButton"
		edit_toggle_button.text = "Edit Mode: Off (Fallback)"
		# Optional: add to scene tree (e.g., ActionHBox)
		$ActionContainer/ActionHBox.add_child(edit_toggle_button)
		edit_toggle_button.owner = self  # For scene saving if needed

	edit_toggle_button.pressed.connect(_toggle_edit_mode)
	edit_toggle_button.text = "Edit Mode: Off"
	_update_archetype_perks()
	_toggle_edit_mode()  # Start read-only
	_update_all()

func _update_all(_dummy = null):
	var agi = agi_score.value
	var app = app_score.value
	var bra = brawn_score.value
	var con = con_score.value
	var intu = int_score.value
	var mem = mem_score.value

	var bonus_agi = 0
	var bonus_app = 0
	var bonus_bra = 0
	var bonus_con = 0
	var bonus_intu = 0
	var bonus_mem = 0
	
	var race_text = race_option.get_item_text(race_option.selected)
	if Data.RACES.has(race_text):
		var r = Data.RACES[race_text]
		bonus_agi += r["Agility"]
		bonus_app += r["Appeal"]
		bonus_bra += r["Brawn"]
		bonus_con += r["Con"]
		bonus_intu += r["Intu"]
		bonus_mem += r["Mem"]

	var origin_text = origin_option.get_item_text(origin_option.selected)
	if Data.ORIGINS.has(origin_text):
		var o = Data.ORIGINS[origin_text]
		bonus_agi += o["Agility"]
		bonus_app += o["Appeal"]
		bonus_bra += o["Brawn"]
		bonus_con += o["Con"]
		bonus_intu += o["Intu"]
		bonus_mem += o["Mem"]

	agi_ro.text = format_bonus(bonus_agi)
	app_ro.text = format_bonus(bonus_app)
	brawn_ro.text = format_bonus(bonus_bra)
	con_ro.text = format_bonus(bonus_con)
	int_ro.text = format_bonus(bonus_intu)
	mem_ro.text = format_bonus(bonus_mem)

	var final_agi = int(agi + bonus_agi)
	var final_app = int(app + bonus_app)
	var final_bra = int(bra + bonus_bra)
	var final_con = int(con + bonus_con)
	var final_intu = int(intu + bonus_intu)
	var final_mem = int(mem + bonus_mem)

	agi_final.text = str(final_agi)
	app_final.text = str(final_app)
	brawn_final.text = str(final_bra)
	con_final.text = str(final_con)
	int_final.text = str(final_intu)
	mem_final.text = str(final_mem)

	var active_careers = []
	var arche1_text = arche1_option.get_item_text(arche1_option.selected)
	if Data.ARCHETYPES.has(arche1_text):
		var type1 = Data.ARCHETYPES[arche1_text]["Career Bonus"]
		if not active_careers.has(type1):
			active_careers.append(type1)

	var arche2_text = arche2_option.get_item_text(arche2_option.selected)
	if Data.ARCHETYPES.has(arche2_text) and arche1_text != arche2_text:
		var type2 = Data.ARCHETYPES[arche2_text]["Career Bonus"]
		if not active_careers.has(type2):
			active_careers.append(type2)

	var current_rank = get_rank()
	var mental_bonus_val = Data.CAREER_CHART["Mental"][current_rank] if active_careers.has("Mental") else 0
	var martial_bonus_val = Data.CAREER_CHART["Martial"][current_rank] if active_careers.has("Martial") else 0
	var physical_bonus_val = Data.CAREER_CHART["Physical"][current_rank] if active_careers.has("Physical") else 0
	var crafter_bonus_val = Data.CAREER_CHART["Crafter"][current_rank] if active_careers.has("Crafter") else 0
	var occult_bonus_val = Data.CAREER_CHART["Occult"][current_rank] if active_careers.has("Occult") else 0

	crafter_bonus.text = str(crafter_bonus_val)
	crafter_label.visible = crafter_bonus_val > 0
	crafter_bonus.visible = crafter_bonus_val > 0

	martial_bonus.text = str(martial_bonus_val)
	martial_label.visible = martial_bonus_val > 0
	martial_bonus.visible = martial_bonus_val > 0

	mental_bonus.text = str(mental_bonus_val)
	mental_label.visible = mental_bonus_val > 0
	mental_bonus.visible = mental_bonus_val > 0

	occult_bonus.text = str(occult_bonus_val)
	occult_label.visible = occult_bonus_val > 0
	occult_bonus.visible = occult_bonus_val > 0

	physical_bonus.text = str(physical_bonus_val)
	physical_label.visible = physical_bonus_val > 0
	physical_bonus.visible = physical_bonus_val > 0

	var agi_m = get_modifier(final_agi)
	var app_m = get_modifier(final_app)
	var bra_m = get_modifier(final_bra)
	var con_m = get_modifier(final_con)
	var intu_m = get_modifier(final_intu)
	var mem_m = get_modifier(final_mem)

	agi_mod.text = format_bonus(agi_m)
	app_mod.text = format_bonus(app_m)
	brawn_mod.text = format_bonus(bra_m)
	con_mod.text = format_bonus(con_m)
	int_mod.text = format_bonus(intu_m)
	mem_mod.text = format_bonus(mem_m)

	max_health.text = str(int(final_con * 2 + final_bra + physical_bonus_val + (occult_bonus_val * 2)))
	max_stamina.text = str(int(final_con + final_agi * 2 + physical_bonus_val + occult_bonus_val))
	recovery_rate.text = format_bonus(bra_m + agi_m + physical_bonus_val + martial_bonus_val)

	ar.text = "0"

	var init_base = floori((agi_m + intu_m) / 2.0)
	initiative.text = format_bonus(init_base + martial_bonus_val)

	var bra_half = floori(bra_m / 2.0)

	mca.text = format_bonus(agi_m + bra_half + martial_bonus_val)
	mcb.text = format_bonus(bra_m + agi_m)
	rca.text = format_bonus(intu_m + bra_half + physical_bonus_val)
	bcb.text = format_bonus(bra_m)
	cdb.text = format_bonus(agi_m + intu_m)
	cbb.text = format_bonus(con_m + bra_m + physical_bonus_val)

	var prof_bonus = current_rank

	arcana_value.text = format_bonus(mem_m + (mental_bonus_val + prof_bonus if arcana_check.button_pressed else 0))
	var athletics_mod = get_chosen_mod(athletics_attr_choice, agi_m, bra_m)
	athletics_value.text = format_bonus(athletics_mod + (physical_bonus_val + prof_bonus if athletics_check.button_pressed else 0))
	awareness_value.text = format_bonus(intu_m + (prof_bonus if awareness_check.button_pressed else 0))
	var craft_mod = get_chosen_mod(craft_attr_choice, mem_m, intu_m)
	craft_value.text = format_bonus(craft_mod + (crafter_bonus_val + prof_bonus if craft_check.button_pressed else 0))
	deception_value.text = format_bonus(app_m + (prof_bonus if deception_check.button_pressed else 0))
	history_value.text = format_bonus(mem_m + (mental_bonus_val + prof_bonus if history_check.button_pressed else 0))
	var inspection_mod = get_chosen_mod(inspection_attr_choice, intu_m, mem_m)
	inspection_value.text = format_bonus(inspection_mod + (mental_bonus_val + prof_bonus if inspection_check.button_pressed else 0))
	occult_value.text = format_bonus(mem_m + (occult_bonus_val + prof_bonus if occult_check.button_pressed else 0))
	var persuasion_mod = get_chosen_mod(persuasion_attr_choice, app_m, bra_m)
	var persuasion_extra = prof_bonus
	if persuasion_attr_choice.selected == 1:
		persuasion_extra += physical_bonus_val + martial_bonus_val
	persuasion_value.text = format_bonus(persuasion_mod + (persuasion_extra if persuasion_check.button_pressed else 0))
	religion_value.text = format_bonus(mem_m + (mental_bonus_val + prof_bonus if religion_check.button_pressed else 0))
	resilience_value.text = format_bonus(bra_m + (physical_bonus_val + martial_bonus_val + prof_bonus if resilience_check.button_pressed else 0))
	skullduggery_value.text = format_bonus(agi_m + (martial_bonus_val + prof_bonus if skullduggery_check.button_pressed else 0))
	
	current_mcb = get_modifier(final_bra) + get_modifier(final_agi)
	
	if not is_edit_mode:
			# Quick refresh displays
			_refresh_readonly_displays()
	_save_to_global()
	emit_signal("stats_updated", {
		"agi": final_agi,
		"app": final_app,
		"brawn": final_bra,
		"con": final_con,
		"int": final_intu,
		"mem": final_mem,
		"mcb": current_mcb,
	})

func _on_roll_attributes_pressed():
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

	_update_all()

func _on_point_buy_reset_pressed():
	var primaries = [agi_score, app_score, brawn_score, con_score, int_score, mem_score]
	for spin in primaries:
		spin.value = 1
	_update_all()

func get_save_data():
	return {
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
		"rank": rank_option.selected,
		"arcana": arcana_check.button_pressed,
		"athletics": athletics_check.button_pressed,
		"awareness": awareness_check.button_pressed,
		"craft": craft_check.button_pressed,
		"deception": deception_check.button_pressed,
		"history": history_check.button_pressed,
		"inspection": inspection_check.button_pressed,
		"occult": occult_check.button_pressed,
		"persuasion": persuasion_check.button_pressed,
		"religion": religion_check.button_pressed,
		"resilience": resilience_check.button_pressed,
		"skullduggery": skullduggery_check.button_pressed,
		"athletics_attr": athletics_attr_choice.selected,
		"craft_attr": craft_attr_choice.selected,
		"inspection_attr": inspection_attr_choice.selected,
		"persuasion_attr": persuasion_attr_choice.selected
	}

func load_data(data):
	agi_score.value = data.get("agi", 10)
	app_score.value = data.get("app", 10)
	brawn_score.value = data.get("brawn", 10)
	con_score.value = data.get("con", 10)
	int_score.value = data.get("intu", 10)
	mem_score.value = data.get("mem", 10)
	race_option.selected = data.get("race", -1)
	origin_option.selected = data.get("origin", -1)
	arche1_option.selected = data.get("arche1", -1)
	arche2_option.selected = data.get("arche2", -1)
	rank_option.selected = data.get("rank", -1)

	arcana_check.button_pressed = data.get("arcana", false)
	athletics_check.button_pressed = data.get("athletics", false)
	awareness_check.button_pressed = data.get("awareness", false)
	craft_check.button_pressed = data.get("craft", false)
	deception_check.button_pressed = data.get("deception", false)
	history_check.button_pressed = data.get("history", false)
	inspection_check.button_pressed = data.get("inspection", false)
	occult_check.button_pressed = data.get("occult", false)
	persuasion_check.button_pressed = data.get("persuasion", false)
	religion_check.button_pressed = data.get("religion", false)
	resilience_check.button_pressed = data.get("resilience", false)
	skullduggery_check.button_pressed = data.get("skullduggery", false)

	athletics_attr_choice.selected = data.get("athletics_attr", 0)
	craft_attr_choice.selected = data.get("craft_attr", 0)
	inspection_attr_choice.selected = data.get("inspection_attr", 0)
	persuasion_attr_choice.selected = data.get("persuasion_attr", 0)

	update_arche_options()
	_update_all()

func _toggle_edit_mode():
	is_edit_mode = not is_edit_mode
	if edit_toggle_button:
		edit_toggle_button.text = "Edit Mode: " + ("On" if is_edit_mode else "Off")

	# Toggle visibility
	attribute_label.visible = is_edit_mode
	base_score_label.visible = is_edit_mode
	racial_label.visible = is_edit_mode
	final_label.visible = is_edit_mode
	mod_label.visible = is_edit_mode	
	
	agi_spin.visible = is_edit_mode
	agi_display.visible = not is_edit_mode
	agi_ro.visible = is_edit_mode
	agi_final.visible = is_edit_mode
	agi_mod.visible = is_edit_mode
	
	app_spin.visible = is_edit_mode
	app_display.visible = not is_edit_mode
	app_ro.visible = is_edit_mode
	app_final.visible = is_edit_mode
	app_mod.visible = is_edit_mode
	
	brawn_spin.visible = is_edit_mode
	brawn_display.visible = not is_edit_mode
	brawn_ro.visible = is_edit_mode
	brawn_final.visible = is_edit_mode
	brawn_mod.visible = is_edit_mode
	
	con_spin.visible = is_edit_mode
	con_display.visible = not is_edit_mode
	con_ro.visible = is_edit_mode
	con_final.visible = is_edit_mode
	con_mod.visible = is_edit_mode
	
	int_spin.visible = is_edit_mode
	int_display.visible = not is_edit_mode
	int_ro.visible = is_edit_mode
	int_final.visible = is_edit_mode
	int_mod.visible = is_edit_mode
	
	mem_spin.visible = is_edit_mode
	mem_display.visible = not is_edit_mode
	mem_ro.visible = is_edit_mode
	mem_final.visible = is_edit_mode
	mem_mod.visible = is_edit_mode
	
	race_option.visible = is_edit_mode
	race_display.visible = not is_edit_mode
	origin_option.visible = is_edit_mode
	origin_display.visible = not is_edit_mode
	arche1_option.visible = is_edit_mode
	arche1_display.visible = not is_edit_mode
	arche2_option.visible = is_edit_mode
	arche2_display.visible = not is_edit_mode
	rank_option.visible = is_edit_mode
	rank_display.visible = not is_edit_mode
	roll_button.visible = is_edit_mode
	point_buy_button.visible = is_edit_mode
	

	var attr_grid = $AttributesSkillsPanel/HBoxContainer/VBoxContainer/AttrGrid
	attr_grid.columns = 5 if is_edit_mode else 2

	# Update labels with current values when turning off edit mode
	if not is_edit_mode:
		_refresh_readonly_displays()

		_save_to_global()  # Update global

func _save_to_global():
	Global.character_data = {
		"agi": agi_spin.value,
		"app": app_spin.value,
		"brawn": brawn_spin.value,
		"con": con_spin.value,
		"intu": int_spin.value,
		"mem": mem_spin.value,
		"race": race_option.selected,
		"origin": origin_option.selected,
		"arche1": arche1_option.selected,
		"arche2": arche2_option.selected,
		"rank": rank_option.selected
	}
	print("Updated global data")

func _refresh_readonly_displays():
	var finals = get_final_attributes()
	
	var displays = {
		"agi": agi_display,
		"app": app_display,
		"brawn": brawn_display,
		"con": con_display,
		"intu": int_display,
		"mem": mem_display
	}
	
	for attr in finals.keys():
		var display = displays.get(attr)
		if display:
			display.text = str(finals[attr].score) + " (" + format_bonus(finals[attr].mod) + ")"
			display.add_theme_color_override("font_color",
				Color(0.2, 0.8, 0.2) if finals[attr].mod > 0 else
				Color(0.8, 0.2, 0.2) if finals[attr].mod < 0 else
				Color(1,1,1))
		else:
			push_warning("Display label for " + attr + " is null - skipping")
	# --- Header section displays (race, origin, archetypes, rank) ---
	var header_displays = {
		"race": race_display,
		"origin": origin_display,
		"arche1": arche1_display,
		"arche2": arche2_display,
		"rank": rank_display
	}
	
	var header_values = {
		"race": race_option.get_item_text(race_option.selected) if race_option.selected != -1 else "None",
		"origin": origin_option.get_item_text(origin_option.selected) if origin_option.selected != -1 else "None",
		"arche1": arche1_option.get_item_text(arche1_option.selected) if arche1_option.selected != -1 else "None",
		"arche2": arche2_option.get_item_text(arche2_option.selected) if arche2_option.selected != -1 else "None",
		"rank": "Rank " + str(rank_option.selected + 1) if rank_option.selected != -1 else "None"
	}
	
	for key in header_displays.keys():
		var display = header_displays[key]
		if display:
			display.text = header_values[key]
			# Optional: style header displays differently
			display.add_theme_font_size_override("font_size", 16)
		else:
			push_warning("Header display for " + key + " is null")

func get_final_attributes() -> Dictionary:
	var finals = {}
	
	# Get current race and origin text
	var race_text = race_option.get_item_text(race_option.selected)
	var origin_text = origin_option.get_item_text(origin_option.selected)
	
	# Calculate bonuses (same logic as in _update_all)
	var bonus_agi = 0
	var bonus_app = 0
	var bonus_bra = 0
	var bonus_con = 0
	var bonus_intu = 0
	var bonus_mem = 0
	
	if Data.RACES.has(race_text):
		var r = Data.RACES[race_text]
		bonus_agi += r["Agility"]
		bonus_app += r["Appeal"]
		bonus_bra += r["Brawn"]
		bonus_con += r["Con"]
		bonus_intu += r["Intu"]
		bonus_mem += r["Mem"]
	
	if Data.ORIGINS.has(origin_text):
		var o = Data.ORIGINS[origin_text]
		bonus_agi += o["Agility"]
		bonus_app += o["Appeal"]
		bonus_bra += o["Brawn"]
		bonus_con += o["Con"]
		bonus_intu += o["Intu"]
		bonus_mem += o["Mem"]
	
	# Now compute finals and mods
	finals["agi"] = {
		"score": int(agi_score.value + bonus_agi),
		"mod": get_modifier(int(agi_score.value + bonus_agi))
	}
	
	finals["app"] = {
		"score": int(app_score.value + bonus_app),
		"mod": get_modifier(int(app_score.value + bonus_app))
	}
	
	finals["brawn"] = {
		"score": int(brawn_score.value + bonus_bra),
		"mod": get_modifier(int(brawn_score.value + bonus_bra))
	}
	
	finals["con"] = {
		"score": int(con_score.value + bonus_con),
		"mod": get_modifier(int(con_score.value + bonus_con))
	}
	
	finals["intu"] = {
		"score": int(int_score.value + bonus_intu),
		"mod": get_modifier(int(int_score.value + bonus_intu))
	}
	
	finals["mem"] = {
		"score": int(mem_score.value + bonus_mem),
		"mod": get_modifier(int(mem_score.value + bonus_mem))
	}
	
	return finals
func _update_archetype_perks(_index: int = -1) -> void:  # <-- accepts the arg, ignores it
	var arche1: String = "None"
	var arche2: String = "None"
	var rank: int = 1
	
	if arche1_option and arche1_option.selected > -1:
		arche1 = arche1_option.get_item_text(arche1_option.selected)
	if arche2_option and arche2_option.selected > -1:
		arche2 = arche2_option.get_item_text(arche2_option.selected)
	if rank_option and rank_option.selected > -1:
		var rank_text: String = rank_option.get_item_text(rank_option.selected)
		# Adjust parsing if your rank items are "Rank 1", "1", etc.
		rank = int(rank_text.replace("Rank ", "").strip_edges())
	print("CharacterTab emitting archetype_changed: ", arche1, arche2, rank)
	emit_signal("archetype_changed", arche1, arche2, rank)
