# Data.gd
extends Node
const RACES = {
	"Construct": {"Agility": 0, "Appeal": 0, "Brawn": 1, "Con": 0, "Intu": 0, "Mem": 1},
	"Drakken": {"Agility": 0, "Appeal": -1, "Brawn": 1, "Con": 1, "Intu": 0, "Mem": 1},
	"Dwarf": {"Agility": 0, "Appeal": 0, "Brawn": 0, "Con": 2, "Intu": 0, "Mem": 1},
	"Elf": {"Agility": 2, "Appeal": 1, "Brawn": 0, "Con": 0, "Intu": 0, "Mem": 0},
	"Faceless": {"Agility": 0, "Appeal": 3, "Brawn": 0, "Con": -1, "Intu": 0, "Mem": 0},
	"Gnome": {"Agility": 0, "Appeal": 0, "Brawn": 0, "Con": -1, "Intu": 0, "Mem": 3},
	"Halfling": {"Agility": 2, "Appeal": 1, "Brawn": 0, "Con": 0, "Intu": 0, "Mem": 0},
	"Human": {"Agility": 0, "Appeal": 0, "Brawn": 0, "Con": 0, "Intu": 0, "Mem": 0},
	"Orc": {"Agility": 0, "Appeal": 0, "Brawn": 1, "Con": 1, "Intu": 0, "Mem": 0}
}

const ORIGINS = {
	"Ahjitar": {"Agility": 0, "Appeal": 1, "Brawn": 0, "Con": 1, "Intu": 1, "Mem": 0},
	"Aurul": {"Agility": 0, "Appeal": 2, "Brawn": 0, "Con": 0, "Intu": 0, "Mem": 0},
	"Bardendorf": {"Agility": 0, "Appeal": 1, "Brawn": 0, "Con": 0, "Intu": 0, "Mem": 1},
	"Diebshol": {"Agility": 1, "Appeal": 0, "Brawn": 0, "Con": 0, "Intu": 1, "Mem": 0},
	"Elfenstadt": {"Agility": 1, "Appeal": 1, "Brawn": 0, "Con": 0, "Intu": 0, "Mem": 0},
	"Festa Vale": {"Agility": 1, "Appeal": 0, "Brawn": 0, "Con": 0, "Intu": 1, "Mem": 0},
	"Finala": {"Agility": 0, "Appeal": 1, "Brawn": 0, "Con": 0, "Intu": 0, "Mem": 1},
	"Habinsel": {"Agility": 0, "Appeal": 1, "Brawn": 0, "Con": 1, "Intu": 0, "Mem": 0},
	"Hammerheim": {"Agility": 0, "Appeal": 0, "Brawn": 1, "Con": 1, "Intu": 0, "Mem": 0},
	"Muthir": {"Agility": 1, "Appeal": 0, "Brawn": 1, "Con": 0, "Intu": 0, "Mem": 0},
	"Red River": {"Agility": 0, "Appeal": 0, "Brawn": 1, "Con": 1, "Intu": 0, "Mem": 0},
	"Sahra's Blessing": {"Agility": 0, "Appeal": 0, "Brawn": 1, "Con": 1, "Intu": 0, "Mem": 0},
	"Svartberg": {"Agility": 0, "Appeal": 0, "Brawn": 1, "Con": 0, "Intu": 1, "Mem": 0},
	"Symvoúlio": {"Agility": 0, "Appeal": 0, "Brawn": 0, "Con": 0, "Intu": 0, "Mem": 1},
	"Warteruhe": {"Agility": 0, "Appeal": 1, "Brawn": 0, "Con": 0, "Intu": 1, "Mem": 0}
}

const ARCHETYPES = {
	"Alchemist": {"Career Bonus": "Crafter"},
	"Archer": {"Career Bonus": "Physical"},
	"Faithsworn": {"Career Bonus": "Mental"},
	"Grappler": {"Career Bonus": "Physical"},
	"Gunsmith": {"Career Bonus": "Crafter"},
	"Magister": {"Career Bonus": "Mental"},
	"Occultist": {"Career Bonus": "Occult"},
	"Scoundrel": {"Career Bonus": "Martial"},
	"Sellsword": {"Career Bonus": "Martial"},
	"Tinker": {"Career Bonus": "Crafter"},
	"Warden": {"Career Bonus": "Martial"}
}

const CAREER_CHART = {
	"Mental": [0, 2, 2, 2, 4, 4, 4, 6, 6, 6, 8],
	"Martial": [0, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5],
	"Physical": [0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 6],
	"Crafter": [0, 1, 1, 2, 2, 3, 3, 4, 5, 5, 6],
	"Occult": [0, 1, 2, 2, 3, 3, 5, 5, 7, 7, 9]
}

# Weapons: one_handed = true/false (false = two-handed)
# Shields are in ARMOR but can be selected as off-hand
const WEAPONS = {
	"Unarmed": {"one_handed": true, "accuracy_stat": "MCA", "Jab": "None", "action2": "Kick", "range": "Touch", "max_damage": 1},
	"Knife": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Backstab", "action2": "Shank", "range": "Touch", "max_damage": 4},
	"Short Sword": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Thrust", "action2": "Sweep", "range": "Touch", "max_damage": 6},
	"Rapier": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Thrust", "action2": "Riposte", "range": "Touch", "max_damage": 6},
	"Hand Axe": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Hack", "action2": "Toss", "range": "Touch,Short", "max_damage": 6},
	"Hammer": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Bash", "action2": "Toss", "range": "Touch,Short", "max_damage": 6},
	"Flail": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Frontal Swing", "action2": "Toss", "Overhead": "Touch", "max_damage": 4},
	"Bow, Recurve": {"one_handed": false, "accuracy_stat": "RCA", "action1": "Snap Shot", "action2": "Long Shot", "range": "Long", "max_damage": 6},
	"Flintlock Pistol": {"one_handed": true, "accuracy_stat": "GCA", "action1": "Smoothbore", "action2": "Standard Reload", "range": "Short", "max_damage": 8},
	"Musket": {"one_handed": false, "accuracy_stat": "GCA", "action1": "Aimed Shot", "action2": "Complex Reload", "range": "Long", "max_damage": 12},
	"Spear": {"one_handed": false,"accuracy_stat": "MCA", "action1": "TEMP", "action2": "TEMP","range": "Touch/Short", "max_damage": 8},
	"Greatsword": {"one-handed": false,"accuracy_stat": "MCA","action1": "Whirlwind","action2": "Overhead Slash","range": "Touch", "max_damage": 12},
	"Greataxe": {"one-handed": false,"accuracy_stat": "MCA","action1": "Cleave","action2": "Execute","range": "Touch", "max_damage": 12},
	"Warhammer": {"one-handed": false,"accuracy_stat": "MCA","action1": "Hammer Down","action2": "Gravity Spin","range": "Touch", "max_damage": 12}
}

const ARMOR = {
	"None": {"weight_class": "None", "ar": 0,"stamina_cost": 0,"weight_kg": 0},
	"Leather Armor": {"weight_class": "Light", "ar": 2,"stamina_cost": 0,"weight_kg": 3},
	"Padded Vest": {"weight_class": "Light", "ar": 3,"stamina_cost": 0,"weight_kg": 3},
	"Breastplate": {"weight_class": "Medium", "ar": 5,"stamina_cost": 1,"weight_kg": 10},
	"Chainmail": {"weight_class": "Medium", "ar": 7,"stamina_cost": 2,"weight_kg": 12},
	"Full Plate": {"weight_class": "Heavy", "ar": 10,"stamina_cost": 3,"weight_kg": 50},
	"Buckler": {"weight_class": "Light", "ar": 2,"stamina_cost": 0, "is_shield": true,"weight_kg": 3,"shield_action": "Parry"},
	"Rounded Shield": {"weight_class": "Medium", "ar": 2,"stamina_cost": 1, "is_shield": true,"weight_kg": 6,"shield_action": "Block"},
	"Tower Shield": {"weight_class": "Heavy", "ar": 3,"stamina_cost": 3, "is_shield": true,"weight_kg": 10,"shield_action": "Embed"}
	# Add more
}
const RACE_DATA = {
	"Human": {"type": "choose_general"},
	"Drakken": {"type": "unique", "perks": ["Breath of Undeath", "Gilded Presence", "Prismatic Knowledge"]},
	"Orc": {"type": "none", "restricted_origins": ["Ahjitar", "Muthir"]},
	"Construct": {"type": "standard", "perk": "Iron Men", "locked_origin": "Warteruhe"},
	"Faceless": {"type": "standard", "perk": "Visage", "restricted_origins": ["Diebshol","Rumläufer","Grimm Wilds"]},
	"Faeblen": {"type": "standard", "perk": "Bound by Fate", "restricted_origins": ["Court of Faebles","Grimm Wilds"]},
	"Dwarf": {"type": "standard", "perk": "Stocky","restricted_origins": ["Hammerheim", "Svartberg","Warteruhe"]},
	"Elf": {"type": "standard", "perk": "Ageless","restricted_origins": ["Aural", "Elfenstadt","Finala"]},
	"Gnome": {"type": "standard", "perk": "Innovative","locked_origin": "Symvoúlio"},
	"Halfling": {"type": "standard", "perk": "Wanderlust", "locked_origin": "Festa Vale"}
}
#const RACE_PERKS = {
	#"Human": "",
	#"Drakken": "",
	#"Construct": "",
	#"Faceless": "",
	#"Faeblen": "",
	#"Dwarf": "",
	#"Elf": "",
	#"Gnome": "",
	#"Halfling": ""
#}
const GENERAL_PERKS = { 
	#syntax
	##"name": {
		##"tag": "combat/magic/versatile",
		##"requires": {},
		##"is_action": true,
		##"action_name": "name"
		##"stamina_cost" 0,
		##"desc": "",
	#Combat Perks
	"Bare Knuckler":{
		"tag": "combat",
		"required": { "arche": "Grappler","rank": 1},
		"is_action": true,
		"stamina_cost": 5,
		"action_name": "Bare Knuckler",
		"desc": "The User's ability to throw a punch is beyond normal. when making unarmed attacks, 
		the User deals 1d6 Blunt Damage. Additionally, they can perform guards while unarmored and without a shield. 
		When guarding in this way they can add their brawn modifier to the roll.",
		},
	"Breach Shot":{
		"tag": "combat",
		"required": {"arche": "Gunsmith", "rank": 3},
		"is_action": true,
		"action_name": "Breach Shot",
		"desc": "The User learns how to properly use their Blackpowder Weapon as a way to breach locked doors. 
		any locked door that is made of wood or non reinforced material can be open by making a ranged attack within 
		its touch range. This consumes 1 use of Blackpowder Munitions."
		},
	"Counter Strike":{
		"tag": "combat",
		"is_action": true,
		"required": {"Career": "Martial"},
		"desc": " The User takes advantage of even the worst situations, like taking a mace to the face. 
		When the User is hit by a melee attack, they can respond in kind with a melee of their own. 
		The User expends their Reactive Action to make a standard attack against their attacker. 
		Using this ability forgoes the use of any defensive actions, such as Dodge or Guard."
		},
	"Dagger Flurry":{
		"tag": "combat",
		"is_action": true,
		"action_name": "Dagger Flurry",
		"required": {"arche": "Scoundrel", "rank": 3, "weapons": ["Knife"]},
		"desc": "The User unleashes a volley of strikes with a dagger, knife or other small blade. 
		The User makes a number of standard attacks up to 5. Each attack has a compounding -2 penalty and deals normal damage on hit.",
		},
	"Feint Strike":{
		"type": "combat",
		"action": true,
		"action_cost": "standard",
		"stamina_cost": 10,
		"stamina_cost_2h": 15,
		"attack_penalty": -3,
		"damage_bonus": 5,
		"description": "The User attempts to trick their opponent into a premature reaction. 
		The User makes a Standard Attack against their target with a -3 penalty. 
		If successful the target will lose their reaction as well as take an extra +5 to the damage from the normal attack."
		},
	"Hook":{
		"type": "combat",
		"action": true,
		"action_cost": "complex",
		"stamina_cost_2h": 10,
		"required_arche": "Archer",
		"skill_shot": true,
		"required_rank": 3,
		"required_weapons": ["Bow, Recurve","Long Bow","Crossbow"],
		"description": "The User unleashes an arrow tied to a piece of rope at a target or location within short range. 
		The User makes a ranged attack against the target, with a DT10 if the target is a location and not a creature. 
		On a Successful hit, the target will take the normal damage applied by the weapon, and be bound by the length of rope attached to the arrow unless removed."
		},
	"Leaping Strike": {
		"type": "combat",
		"required_career": "Martial",
		"description": "Using their high ground advantage, the User Leaps down upon their target below.
		The User makes an Attack Roll against the target, with a guaranteed Soft Critical if the Target is unaware of them.
		On a successful hit, the target is knocked prone and takes an additional 1d6 bludgeoning damage.
		This attack does not prevent fall damage but does halve the damage as long as it is successful."
		},
	"Pistol Whip": {
		"type": "combat",
		"action": true,
		"action_cost": "simple",
		"stamina_cost": 3,
		"damage": "1d6",
		"soft_crit": "Scrambled Head",
		"required_arche": "Gunsmith",
		"required_rank": 1,
		"required_weapons": ["Flintlock Pistol"],
		"description": "The User attempts to strike their target with handle of their pistol. 
		The User makes a Standard Attack Roll against their target. 
		On a successful hit, the target takes 1d6 Bludgeoning Damage. 
		On a Soft Critical, the Target incurs a stack of Scrambled Head."
			},
	"Pocket Sand": {
		"type": "combat",
		"action": true,
		"action_cost": "simple",
		"stamina_cost": 3,
		"required_arche": "Scoundrel",
		"required_rank": 1,
		"description": "The User attempts to take a bit of fine sand from their pouch and pitch it into the eyes of a Target within Touch. 
		The Target must make a DT10 Reflex Save or become temporarily Blinded for one combat round."
		},
	"Reckless": {
		"type": "combat",
		"action": true,
		"action_cost": "standard",
		"stamina_cost": 7,
		"description": "The User strikes with reckless abandon, exposing them-self to further harm.
		The User makes a melee attack against a target in touch range adding +4 to their roll. 
		If Successful, the User applies normal damage for their weapon. regardless of success, the User has a -4 to any defensive action until their next turn."
		},
	"Shield Toss": {
		"type": "combat",
		"action": true,
		"action_cost": "standard",
		"range": "short",
		"stamina_cost": 7,
		"damage": "3d4",
		"soft_crit": "rebound",
		"required_career": "Martial",
		"required_brawn": 14,
		"required_weapons": ["Rounded Shield"],
		"description": "The User sacrifices the guard of their Shield in order to launch it at a target in Short Range, 
		the User makes a Ranged Attack against their Target. On a Successful hit, the Target takes 3d4 Bludgeoning Damage. 
		On a Soft Critical, the Shield rebounds back to the User."
		},
	"Shielded Shot": {
		"type": "combat",
		"action": false,
		"required_arche": "Gunsmith",
		"required_rank": 3,
		"required_weapons": ["Flintlock Pistol","Buckler","Rounded Shield","Tower Shield"],
		"description": "When the user is attacking, 
		they no longer garner any penalty to the Gun Combat Bonus when using a one handed Blackpowder weapon and a shield."
		},
	"Volley": {
		"type": "combat",
		"action": true,
		"action_cost": "simple/standard/complex",
		"range": "short",
		"stamina_cost_2h": 25,
		"damage": "1d6",
		"required_arche": "Archer",
		"skill_shot": true,
		"required_rank": 5,
		"required_weapons": ["Bow, Recurve","Long Bow"],
		"description": "The User unleashes a barrage of arrows at a short range location with a 5 meter radial spread. 
		Targets in the radius make a DT10 Reflex Save to avoid being struck. Failing the Reflex Save will result in a target taking 1d6 piercing damage."
		},
	#Magical Perks
	"Arcane Ammo": {
		"type": "magical",
		"action": true,
		"action_cost": "standard",
		"required_arche": "Magister",
		"required_rank": 1,
		"description": "The User manipulates the Void to replenish their ranged munitions. 
		The User gains a number of munitions equal to twice the stamina spent, and they deal an additional 1d4 points of elemental damage, 
		chosen by the user, when used. These munitions benefit from any bonuses towards casting Ritual (R) Spells."
		},
	"Bleeding Boon": {
		"type": "magical",
		"required_arche": "Occult",
		"required_rank": 0,
		"description": "The User finds strength in their wounds. When the User is affected by Bleeding, 
		They Gain a bonus to any Sacrificial (S) Spells Difficulty Threshold Rolls equal to the total stacks of Bleeding.  "
		},
	"Blessed Hands": {
		"type": "magical",
		"required_arche": "Faithsworn",
		"required_rank": 1,
		"description": "When casting Vitalizing (V) Spells, the User can add an additional point of HP healed for each rank they have in Faithsworn.
		This includes spells which steal health from a target."
		},
	"Blood Mad": {
		"type": "magical",
		"required_arche": "arche",
		"required_rank": 3,
		"description": "The User pushes sacrificial spell casting at the cost of their sanity. 
		when casting sacrificial spells in combat, they gain a +2 when performing their spell rolls. 
		Unfortunately this requires tapping in to knowledge that tempts madness with each cast. 
		after each cast of a sacrificial spell in combat, the User makes a DT1 Resilience Check. 
		Each time they cast a spell in a combat, the Difficulty Threshold (DT) increases by 1. 
		On a Failed Resilience Check, The Blood Madness consumes the User, forcing them to see all 
		creatures nearby as a foe for 5 rounds or until a successful Resilience Check is made at the end of their turn. 
		If the User takes a Recovery Stance for a round, the Difficulty Threshold (DT) reduces by 2."
		},
	"Blood Magic": {
		"type": "magical",
		"required_arche": "Occultist",
		"required_rank": 3,
		"description": "The User's knowledge into the occult practice of blood magic has taught them to enhance their more mundane magic. 
		When Casting Universal Spells, the User may treat them as Sacrificial, using instead hp of sp cost, and may use blood damage instead of a standard element. "
		},
	"Blood Munitions": {
		"type": "magical",
		"action": true,
		"action_cost": "simple",
		"health_cost": 1,
		"required_arche": "Occultist",
		"required_rank": 3,
		"description": "The User can extract the iron from their blood to manifest munitions for their ranged weaponry. 
		This process creates a number of munitions equal to twice the health expended. These Munitions benefit from any 
		bonus applied to casting Sacrificial (S) Spells earned by the User's other perks."
		},
	"Font of the Magi": {
		"type": "combat/magic/versatile",
		"action": true,
		"action_cost": "standard",
		"stamina_reserve": 10,
		"daily_usage": 1,
		"required_arche": "Magister",
		"required_rank": 3,
		"description": "The User conjures a chalice that soothes the fatigue of their allies. 
		When they or their ally drink from the chalice, the can eliminate exhaustion of Fatigued or Lower. 
		The Chalice can only be summoned once per day, and Users can only receive its effect once per day."
		},
	"Forbidden Knowledge": {
		"type": "magical",
		"required_career": ["Mental","Occult"],
		"description": "The User's thirst for knowledge has lead them to research beyond their normal studies. 
		The User may choose to gain access to casting spells of either Prayer, Ritual, or Sacrificial. 
		They may only select one type that they have no prior access to. If the User gains access to the chosen 
		type later through an archetype, they may choose another as replacement."
		},
	"Forged by Blood": {
		"type": "magical",
		"action": true,
		"action_cost": "complex",
		"health_reserve": 5,
		"required_arche": "Occultist",
		"required_rank": 3,
		"description": "The User's Knowledge into the Occult practices has taught them to manifest weapons bound to them by a blood pact. 
		The User may now summon mundane weapons that they have seen before and wield them in battle at the cost of a bit of their blood. 
		Once the pact has been formed the user can summon and unsummon the weapon in their hand at will for the rest of the day. 
		They cannot change this weapon without making a new pact the following day but they can make multiple pacts each day."
		},
	"Magister's Domain": {
		"type": "combat/magic/versatile",
		"action": true,
		"ritual": true,
		"action_cost": "complex",
		"stamina_reserve": 20,
		"required_arche": "Magister",
		"required_rank": 5,
		"description": "The User manipulates the Void between realms to create a pocket domain. 
		the entrance can take what ever form they desire but generally takes the visage of a door. 
		Inside is a 20ft x 20ft room designed by the User and can be used as a reprieve from their travels. 
		The door can be typically be opened only by the User but is not guarded from arcane interference. The Domain lasts for a day.",
		"ritual_name": "Domain",
		"ritual_mat": "Object of Focus, Arcane Chalk (5 Uses)",
		"ritual_desc": "The User will require an object to focus this domain around. 
		the object acts as the literal key to unlocking this domain and will work for any creature that wields it to summon said domain. 
		The User will need to spend 2 hours to imbue the object and forge the domain. Afterwards the Domain takes a standard 30 minute ritual to open said domain."
		},
	"Occult Recovery": {
		"type": "magical",
		"action": true,
		"damage": "2d4",
		"required_arche": "Occultist",
		"required_rank": 1,
		"description": "When dealing a fatal blow against their Foes, the User can extract the targets life force and recover 2d4 Health Points."
		},
	"Prayers Answered": {
		"type": "magical",
		"action": true,
		"recovery_usage": "long",
		"range": "short/medium/long",
		"required_arche": "Faithsworn",
		"required_rank": 3,
		"description": "The User when casting Prayer (P) Spells, can channel their faith, once per long recovery, 
		to automatically succeed on the cast. This will not effect Resurrect or similar spells of that nature."
		},
	"Righteous Rounds": {
		"type": "magical",
		"action": true,
		"action_cost": "complex",
		"stamina_reserve": 5,
		"required_arche": "Faithsworn",
		"required_rank": 1,
		"description": "The User can bless a number of munitions, whether it be Blackpowder, Bolt, or Arrow, equal to their Faithsworn Rank. 
		These rounds deal an additional d4 Radiant Damage. The Rounds stay blessed for until the next day. The blessed munitions can benefit 
		from any bonuses related to Prayer (P) Spell casting."
		},
	"Rushed Ritual": {
		"type": "magical",
		"required_arche": "Magister",
		"required_rank": 3,
		"description": "The User is able to manipulate the void to quicken their Ritual Casting. 
		Rituals (R) that are simple or standard, can be cast immediately and ignore the ritual requirement 
		so long as the cost or reserve is doubled. The ritual will then be treated as a normal spell with 
		the simple or standard casting action used instead."
		},
	"Sacred Soul": {
		"type": "magical",
		"required_arche": "Faithsworn",
		"required_rank": 3,
		"description": "when Resurrect is cast upon the user, the ritual DT becomes a DT8 and failures no longer 
		increase the DT of Resurrect. This Perk is only available once every two rank ups."
		},
	"Spell Forge": {
		"type": "magical",
		"action": true,
		"ritual": true,
		"action_cost": "standard",
		"stamina_reserve": 10,
		"required_arche": "Magister",
		"required_rank": 3,
		"description": "The User conjures an arcane workbench to perform various crafting necessities. 
		The workbench can shift and mold itself into the ideal space for a variety of crafting specialties 
		but once selected can not be changed unless cast again. The Workbench lasts for 4 hours before vanishing.",
		"ritual_name": "Forge",
		"ritual_mat": "pending",
		"ritual_desc": "pending"
		},
	"Warding Word": {
		"type": "magical",
		"action": true,
		"action_cost": "simple",
		"stamina_reserve": 5,
		"required_arche": "arche",
		"required_rank": 0,
		"description": "The User can call upon their patron to grant them a token emanating a ward of protection on 
		the holder. This Ward lasts for 1 day and grants the holder +2 to their Armor Rating (AR). The User can 
		create as many wards as their total Faithsworn Rank but only one token can affect the holder at a time."
		},
	#Versatile Perks
	"Combat Medicine": {
		"type": "versatile",
		"required_arche": "Alchemist",
		"required_rank": 3,
		"description": "The User has learned through their alchemical studies that applying their tinctures in just 
		the right way can speed up the their application and effects.  Tincture applications, even to your allies, 
		are now a simple action."
		},
	"Extra Endurance": {
		"type": "versatile",
		"required_agi": 10,
		"required_con": 10,
		"description": "The User's ability to endure through battle fatigue is unmatched. For every 2 ranks in any Archetype, 
		the User gains an extra point towards their maximum **Stamina Pool**. This is retroactively applied when added."
		},
	"Extra Reaction": {
		"type": "combat/magic/versatile",
		"required_agi": 10,
		"required_int": 10,
		"description": "The User's ability to react to their opponent's has vastly improved due to their lightning fast reflexes. 
		The User now gains an extra Reactive Action during each combat round."
		},
	"Extra Resilient": {
		"type": "versatile",
		"required_brawn": 10,
		"required_con": 10,
		"description": "The User's physique is the pinnacle of fortitude. For every 2 Ranks in any Archetype, 
		they gain 1 additional point towards their maximum Health Pool. This is retroactively applied when added."
		},
	"Living Weapon": {
		"type": "versatile",
		"required_arche": "Tinker",
		"required_race": "Construct",
		"description": "The User can now spend a Tinker's Kit and 1 hour to create a weapon or tool that folds into their arm. 
		Requires one to have obtained the chosen tool. Each arm can store only one weapon or tool at a time but can been replaced using this perk again. "
		},
	"Mind over Mortality": {
		"type": "versatile",
		"required_mem": 14,
		"recovery_usage": "long",
		"description": "The User perseveres through agonizing pain, by shear will and mental fortitude. 
		when the user drops to zero Health, they return to 1 health and remain standing. This can occur once every long recovery."
		},
	"Perfect Physique": {
	"type": "versatile",
	"required_brawn": 20,
	"description": "The User has molded their physique to levels of perfection thought unattainable. 
	When attempting to persuade or influence a target through flirtation or charm, the User may add their Brawn modifier to the result."
	},
}
const ORIGIN_DATA = {
	"Ahjitar": {"perk": "Storm Bjorn"},
	"Aural": {"perk": "Gilded"},
	"Bardendorf": {"perk": "Rythmic"},
	"Court of Faebles": {"perk": "Servant of Fate"},
	"Diebshol": {"perk": "Rebellious"},
	"Elfenstadt": {"perk": "Grounded"},
	"Festa Vale": {"perk": "Brewmastery"},
	"Finala": {"perk": "Nightbound"},
	"Grimm Wilds": {"perk": "Fate Woven"},
	"Habinsel": {"perk": "Sea Legs"},
	"Hammerheim": {"perk": "Homing Hammers"},
	"Muthir": {"perk": "Bloodlust"},
	"Red River": {"perk": "Old Ways"},
	"Rumläufer": {"perk": "Drunk Tank"},
	"Sahra's Blessing": {"perk": "Blessed"},
	"Svartberg": {"perk": "Deep Below"},
	"Symvoúlio": {"perk": "Well Red"},
	"Warteruhe": {"perk": "Artisan"},
	# etc.
}
const ORIGIN_PERKS = {
	"Storm Bjorn": "",
	"Gilded": "",
	"Rythmic": "",
	"Servant of Fate": "",
	"Rebellious": "",
	"Grounded": "",
	"Brewmastery": "",
	"Nightbound": "",
	"Fate Woven": "",
	"Sea Legs": "",
	"Homing Hammers": "",
	"Bloodlust": "",
	"Old Ways": "",
	"Drunk Tank": "",
	"Blessed": "",
	"Deep Below": "",
	"Well Red": "",
	"Artisan": ""
}
