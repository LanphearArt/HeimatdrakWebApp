# Data.gd
extends Node
#racial stat modifiers
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
#origin stat modifiers
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
#weapon notes
#Weapons: one_handed = true/false (false = two-handed)
#Shields are in ARMOR but can be selected as off-hand
const WEAPONS = {
	"Unarmed": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Jab", "action2": "Kick", "range": "Touch", "max_damage": 1},
	"Knife": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Backstab", "action2": "Shank", "range": "Touch", "max_damage": 4},
	"Short Sword": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Thrust", "action2": "Sweep", "range": "Touch", "max_damage": 6},
	"Rapier": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Thrust", "action2": "Riposte", "range": "Touch", "max_damage": 6},
	"Hand Axe": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Hack", "action2": "Toss", "range": "Touch,Short", "max_damage": 6},
	"Hammer": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Bash", "action2": "Toss", "range": "Touch,Short", "max_damage": 6},
	"Flail": {"one_handed": true, "accuracy_stat": "MCA", "action1": "Frontal Swing", "action2": "Overhead", "range": "Touch", "max_damage": 4},
	"Bow, Recurve": {"one_handed": false, "accuracy_stat": "RCA", "action1": "Snap Shot", "action2": "Long Shot", "range": "Long", "max_damage": 6},
	"Flintlock Pistol": {"one_handed": true, "accuracy_stat": "GCA", "action1": "Smoothbore", "action2": "Fan Fire", "range": "Short", "max_damage": 8},
	"Musket": {"one_handed": false, "accuracy_stat": "GCA", "action1": "Aimed Shot", "action2": "Bayonet Charge", "range": "Long", "max_damage": 12},
	"Spear": {"one_handed": false, "accuracy_stat": "MCA", "action1": "Thrust", "action2": "Brace", "range": "Touch/Short", "max_damage": 8},
	"Greatsword": {"one_handed": false, "accuracy_stat": "MCA", "action1": "Whirlwind", "action2": "Overhead Slash", "range": "Touch", "max_damage": 12},
	"Greataxe": {"one_handed": false, "accuracy_stat": "MCA", "action1": "Cleave", "action2": "Execute", "range": "Touch", "max_damage": 12},
	"Warhammer": {"one_handed": false, "accuracy_stat": "MCA", "action1": "Hammer Down", "action2": "Gravity Spin", "range": "Touch", "max_damage": 12}
}
#Detailed action descriptions/effects (for ActionsTab)
const ACTION_DETAILS = {
	#syntax
	## "":{"stamina_cost": 0,"action_cost": 0, "desc": ""},
	
	#Unarmed
	"Jab":{"stamina_cost": 3,"action_cost": 2, "desc": ""},
	"Kick":{"stamina_cost": 5,"action_cost": 2, "desc": ""},
	#Knife
	"Backstab": {"stamina_cost": 3,"action cost": 2, "desc": "utilizing ambush tactics, you attempt to sink your knife into the backside of your target"},
	"Shank": {"stamina_cost": 5,"action cost": 2, "desc": "Quick bleed-causing stab."},
	#Short Sword
	"Thrust":{"stamina_cost": 5,"action_cost": 2, "desc": "Jabbing forcefully with your Blade"},
	"Sweep":{"stamina_cost": 7,"action_cost": 4,"sweep": true, "desc": "Swinging out in a horizontal arc"},
	#Rapier
	"Poke":{"stamina_cost": 5,"action_cost": 2, "desc": "With grace, you attempt to thrust your Rapier into your target."},
	"Riposte":{"stamina_cost": 10,"reaction": true, "desc": "Turn your guard into a counter attack"},
	#Hand Axe
	"Hack":{"stamina_cost": 5,"action_cost": 2, "desc": "You attempt to hew a foe"},
	"Toss":{"stamina_cost": 7,"action_cost": 1, "desc": "With precision, you throw your Hand Axe"},
	#Hammer
	"Bash":{"stamina_cost": 5,"action_cost": 2, "desc": "You attempt to bash your foe"},
	"Hammer Toss":{"stamina_cost": 7,"action_cost": 1, "desc": "You attempt to hurl your hammer"},
	#Flail
	"Swing":{"stamina_cost": 5,"action_cost": 1,"sweep": true, "desc": "Using momentum to bludgeon multiple foes"},
	"Swipe":{"stamina_cost": 7,"action_cost": 2, "desc": "Swinging the Flail overhead"},
	#Bow, Recurve
	"Snap Shot":{"stamina_cost": 7,"action_cost": 2, "desc": "rapidly releases an arrow"},
	"Long Shot":{"stamina_cost": 10,"action_cost": 4, "desc": "arc your bow upward, releasing an arrow upon a distant target"},
	#Flintlock Pistol
	"Smoothbore":{"stamina_cost": 5,"action_cost": 1,"hit_penalty": 5,"desc": "Quick to fire, but not the most accurate"},
	"Simple Reload":{"stamina_cost": 0,"action_cost": 1,"reload": true,"desc": "Expend one Munition to quickly reload your firearm"},
	#Musket
	"Aimed Shot":{"stamina_cost": 15,"action_cost": 2, "desc": "lift your Musket to bear against a distant Target."},
	"Complex Reload":{"stamina_cost": 0,"action_cost": 4, "desc": "Expend one Munition to carefully reload your firearm"},
	#Spear
	"spear 1":{"stamina_cost": 0,"action_cost": 0, "desc": ""},
	"spear 2":{"stamina_cost": 0,"action_cost": 0, "desc": ""},
	#Greatsword
	"whirlwind":{"stamina_cost": 10,"action_cost": 4,"sweep": true, "desc": "You begin to spin, using your weapon as a counter weight"},
	"Overhead Slash":{"stamina_cost": 15,"action_cost": 2, "desc": "With a big push, you bring your weapon up ,over, and down upon your foe"},
	#Greataxe
	"Cleave":{"stamina_cost": 10,"action_cost": 2,"sweep": true, "desc": "You swing your axe out in a Horizontal Arc"},
	"Execute":{"stamina_cost": 15,"action_cost": 4, "desc": "With a big push, you bring your weapon up ,over, and down upon your foe"},
	#Warhammer
	"Hammer Down":{"stamina_cost": 10,"action_cost": 2, "desc": "Swinging overhead before coming down upon the target"},
	"Gravity Spin":{"stamina_cost": 15,"action_cost": 4,"sweep": true, "desc": "You begin to swing your hammer, allowing momentum to carry you into a heavy spin"},
}
const ARMOR = {
	"None": {"weight_class": "None", "ar": 0, "stamina_cost": 0, "weight_kg": 0},
	"Leather Armor": {"weight_class": "Light", "ar": 2, "stamina_cost": 0, "weight_kg": 3},
	"Padded Vest": {"weight_class": "Light", "ar": 3, "stamina_cost": 0, "weight_kg": 3},
	"Breastplate": {"weight_class": "Medium", "ar": 5, "stamina_cost": 1, "weight_kg": 10},
	"Chainmail": {"weight_class": "Medium", "ar": 7, "stamina_cost": 2, "weight_kg": 12},
	"Full Plate": {"weight_class": "Heavy", "ar": 10, "stamina_cost": 3, "weight_kg": 50},
	"Buckler": {"weight_class": "Light", "ar": 2, "stamina_cost": 0, "is_shield": true, "weight_kg": 3, "shield_action": "Parry"},
	"Rounded Shield": {"weight_class": "Medium", "ar": 2, "stamina_cost": 1, "is_shield": true, "weight_kg": 6, "shield_action": "Block"},
	"Tower Shield": {"weight_class": "Heavy", "ar": 3, "stamina_cost": 3, "is_shield": true, "weight_kg": 10, "shield_action": "Embed"}
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
const RACE_PERKS = {
	"Human": {
		"Independent Nature": {
			"desc": "Due to their tendency to forge their own path in life, Humans generally are more unique
			 then other denizens. For this reason, they earn an Extra Perk during creation, to show of their uniqueness."
		}
	},
	"Drakken": {
		"Breath of Undeath": {"desc": "The Drakken unleashes a cloud of black mist from their maw. 
		All inside the mist must make a DT12 Resilience Check or take 3d6 Necrotic damage."},
		"Gilded Presence": {"desc": "The Drakken channels their divine lineage to soothe their allies 
		wounds. Allies within short radius recieve 2d4 points of health. "},
		"Prismatic Knowledge": {"desc": "The Drakken calls upon their innate chaos, allowing them to 
		use prismatic as a damage type when casting Universal Offend (UO) Spells"}
	},
	"Construct": {
		"Iron Men": 
			{"desc":"Constructs by their inherent design, are built to withstand the many harrows of battle. 
			Constructs receives a +3 to their **Armor Rating**, even if they are **Unarmored.** It is also because 
			of their metallic form that they are unable to swim and will rapidly sink in almost any liquid, but 
			will not drown as they need no air."}
	},
	"Faceless": {
		"Visage": {
			"desc": "The Faceless, in order to hide their eerily pale true form, learned how to create masks that morph 
			them into the form of another humanoid. These Masks can change the User's physical size and shape but not the 
			User's physical capabilities. Carving a mask requires the Faceless to have a clear knowledge of the intended form 
			and takes roughly an hour to create. The mask will not work on anyone but the crafter of the mask."
		}
	},
	"Faeblen": {
		"Bound by Fate": {
			"desc": ""
		}
	},
	"Dwarf": {
		"Stocky": {
			"desc": "Dwarves are so naturally dense that they can withstand most attempts to knock them Off-Balance. 
			The User gains a +3 to Balance Checks and recovering from Off-Balance is a Simple-Action."
		}
	},
	"Elf": {
		"Ageless": {
			"desc": "Their longer lifespan compared to most races often makes an elf appear immortal. 
			The User is unaffected by Old Age and has +2 to History Checks."
		}
	},
	"Gnome": {
		"innovative": {
			"desc": "Their Inquisitive tendencies and natural inclination to tinker, has resulted in many gnomes leading 
			the way in many technological discoveries. The User has a +2 to any craft roll on any unique creation. 
			An Example would be developing a new flying machine and not a standard piece of armor or tool."
		}
	},
	"Halfling": {
		"Wanderlust": {
			"desc": ""
		}
	}
}
const ORIGIN_PERKS = {
	"Ahjitar": {"Storm Bjorn": {
		"desc": "From their years worshiping the endless storms of their Lord, 
		the User has built up an innate Tolerance to Lightning and even the ability to wield it. 
		The User has the ability to use Whip, as long as the element type is Lightning."
		}
	},
	"Aural": {"Gilded": {
		"desc": ""
		}
	},
	"Bardendorf": {"Rythmic": {
		 "desc": ""
		}
	},
	"Court of Faebles": {"Servant of Fate": {
		"desc": ""
		}
	},
	"Diebshol": {"Rebellious": {
		"desc": ""
		}
	},
	"Elfenstadt": {"Grounded": {
		"desc": ""
		}
	},
	"Festa Vale" : {"Brewmastery": {
		"desc": "The Festa Valen are widely known for their unique alcoholic brews. The User becomes a Journeyman in Craft - Brewing"
		}
	},
	"Finala": {"Nightbound": {
		"desc": ""
		}
	},
	"Grimm Wilds" : {"Fate Woven": {
		"desc": ""
		}
	},
	"Habinsel": {"Sea Legs": {
		"desc": "Many years at sea has weather the User into a capable member on any oceanic vessel. 
		When aboard a naval vessel, the User will not have to make Balance Saves under normal 
		conditions and will have +5 to Balance Saves if the vessel is struck."
		}
	},
	"Hammerheim": {"Homing Hammers": {
		"desc": ""
		}
	},
	"Muthir" : {"Bloodlust": {
		"desc": "The Follower of Muthir, The Mad King, are fueled a unending desire for bloodshed and violence. The User 
		when receiving or dealing a Bleeding Wound, the User gains a +1 to their Melee Combat Bonus for each instance, 
		up to a maximum of 5, until either the wound is treated or combat ends. The User also can Self-Cast Madness as 
		long as they have taken physical damage during the combat encounter"
		}
	},
	"Red River": {"Old Ways": {
		"desc": ""
		}
	},
	"Rumläufer" : {"Drunk Tank": {
		"desc": ""
		}
	},
	"Sahra's Blessing": {"Blessed": {
		"desc": ""
		}
	},
	"Svartberg" : {"Deep Below": {
		"desc": "Life without sun has adapted the Dwarves of Svartberg to have incredible sight in pure darkness. 
		The User can see as if in low-light when they are in Natural Darkness up to 40 meters and treats low-light 
		as if it is well-lit."
		}
	},
	"Symvoúlio": {"Well Red": {
		"desc": ""
		}
	},
	"Warteruhe": {"Artisan": {
		"desc": "In the City of Trade, Every Citizen makes their way by selling their labor. 
		The User may select any Craft and increase it to Expert."
		},
	}
}
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
	#etc.
}
const ARCHETYPE_PERKS = {
	#Syntax
	##"": {"rank": ,"stamina_cost": 0,"desc": ""},
	"Alchemist": {
		"Alchemy": {"rank": 1, "desc": "The User has become well acquainted with the field of Alchemy."},
		"In a Pinch": {"rank": 2, "desc": "The User's expertise and quick thinking has granted them the ability 
		to quickly concoct simple Salves and Ointments in the midst of intense conflict. 
		Simple Salves and Ointments can now be crafted at will using only a Standard Action."},
		"Bonus Perk 1": {"rank": 3,"desc": "The User, upon reaching Ranks 3, 6, and 9 of Alchemist, may add 
		a new perk from the General Perks List."},
		"Splash Zone": {"rank": 4,"desc": "The User has discovered that with the right mixture of gases and heating, 
		their Tinctures and Tonics can become aerosolized on impact allowing their effects to reach multiple targets 
		within a 2m Radius. This does not allow Salves or ointments to be aerosolized."},
		"Side Effects": {"rank": 5,"desc": "The User has learned to apply new methods to their mixtures that enable 
		them to unlock secondary effects in their alchemical creations."},
		"Bonus Perk 2": {"rank": 6,"desc": "The User, upon reaching Ranks 3, 6, and 9 of Alchemist, may add 
		a new perk from the General Perks List."},
		"Shaken or Stirred": {"rank": 7,"desc": "By combining the right catalyst to their mixture, the User has discovered a way to cut their brewing time in half."},
		"Subtle Substitution": {"rank": 8,"desc": "The User has discovered that they can substitute minor ingredients with alternatives that have similar properties."},
		"Bonus Perk 3": {"rank": 9,"desc": "The User, upon reaching Ranks 3, 6, and 9 of Alchemist, may add 
		a new perk from the General Perks List."},
		"Master Alchemist": {"rank": 10,"desc": "The User has become a master of Alchemy and has now enhanced some of their other skills.
		In a Pinch - The User can now craft simple potions on the fly through the usage of proper catalysts and the use of a half action.
		Splash Zone - The User has learned to expand the radius they can aerosolized to a 4m radius.
		Shaken or Stirred - The User has learned new techniques to cut brewing times to a quarter of the duration."},
	},
	"Archer": {
		"Trick Shot": {"rank": 1,"stamina_cost": 10,"action_cost": 4,"desc": "When the User is unable to make a clear shot within normal 
		line of sight, for example the target is behind full cover or around a corner in a hall, they can attempt to overcome this challenge 
		with a Trick Shot. They make a Ranged Attack Roll without any of their combat modifiers applied. If it hits the target they can 
		apply Damage as normal."},
		"Bonus Perk 1": {"rank": 2, "desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Archer, may add a new perk from the General Perks List."},
		"Called Shot": {"rank": 3,"stamina_cost": 15,"action_cost": 4,"desc": "When the User is feeling confident in their ability, 
		they may declare their shot to inflict a specific region (see Region Table below) of their target. They make a Ranged Attack Roll 
		with a penalty modifier, based on region, to their result. On a successful hit, the user will apply damage as normal on top of 
		additional effect determined by the region hit."},
		"Bonus Perk 2": {"rank": 4,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Archer, may add a new perk from the General Perks List."},
		"Multi Shot": {"rank": 5,"stamina_cost": 20,"action_cost": 4,"desc": "The User nocks additional arrows to hit multiple targets in 
		Short Range. They select up to a maximum of 5 Targets and for each target selected a -2 penalty is applied the Ranged Attack Roll. 
		Each Target hit takes half of the normal damage."},
		"Bonus Perk 3": {"rank": 6,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Archer, may add a new perk from the General Perks List."},
		"Improved Reflex": {"rank": 7,"desc": "The User's Instinct to avoid opposing Bow Fire has vastly improved. when making a Reflex Save 
		to dodge incoming Arrows, the User may add their Martial Career Bonus to the Result "},
		"Bonus Perk 4": {"rank": 8,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Archer, may add a new perk from the General Perks List."},
		"Expert Shot": {"rank": 9,"desc": "The Great Expertise of the User in Archery has resulted in improved technique for their skilled shots."},
		"Master Archer": {"rank": 10,"desc": "The User has mastered every aspect of Archery. When using any Skill Shots, the action cost is reduced from Complex to Standard.
		The User may also add their Martial Career Bonus to any Bow or Crossbow Damage."},
	},
	"Faithsworn": {
		"Oath": {"rank": 1,"desc": "You make an oath to your patron, swearing to uphold the virtues of their faith. 
		If you fail to uphold this oath, you will no longer be able to cast Prayer (P) Spells until you repent with your Patron "},
		"Patron's Blessing": {"rank": 1, "desc": "our Patron bestows you with it's blessing. This blessing will vary for each Patron 
		and helps to align you with their ideals"},
		"Zeal": {"rank": 2,"stamina_cost": 5,"action_cost": 0,"desc": "When making a Attack, the User may channel the strength 
		of their patron's will into their strike. Once per round the User may infuse a strike with (1d6 + Mental Career Bonus) 
		Radiant Damage. The User does not need to declare usage of Zeal before a hit is confirmed, but they must declare before damage 
		has been rolled."},
		"Bonus Perk 1": {"rank": 3,"desc": "The User, upon reaching Ranks 3, 6, 9 of Faithsworn, may add a new perk from the General Perks List."},
		"Patron's Prayer": {"rank": 4,"desc": "The User is able to invoke the ritual of their patron to receive a blessing. The required 
		components and nature of said Prayer is dependent on their patron"},
		"Armor of Faith": {"rank": 5,"daily_use": 1,"desc": "Knowing that their Patron is pulling for their victory, The User is assured that 
		even the most fatal of blows may not stop them. Once per Day, the User can ignore the damage of an attack that would be considered lethal. 
		The User will still incur any Injuries, Minor or Major, that the damage would have applied but delayed in effect after the combat has ended 
		or if they were to Pass Out."},
		"Bonus Perk 2": {"rank": 6,"desc": "The User, upon reaching Ranks 3, 6, 9 of Faithsworn, may add a new perk from the General Perks List."},
		"Patron's Voice": {"rank": 7,"desc": "The Patron's Words Channel through The User. When trying to persuade another with the lessons 
		of their patron, The User may add their Mental Career Bonus to the Roll. If the User rolls a Hard Critical, the target may convert to 
		their Patron."},
		"Inspire Faith": {"rank": 8,"daily_use": 1,"desc": "The User's Faith now reaches beyond their their own being, lifting the morale of all who 
		travel by their side. Armor of Faith now can be applied additionally once per day to an ally in short range of the User. The usage of this perk 
		is separate and doesn't expend the usage of Armor of Faith on the Use"},
		"Bonus Perk 3": {"rank": 9,"desc": "The User, upon reaching Ranks 3, 6, 9 of Faithsworn, may add a new perk from the General Perks List."},
		"Vessel of the Patron": {"rank": 10,"desc": "The Patron and the User have become One. The User's other powers are now enhanced. 
		Zeal now deals 1d6 + 2 x Mental Career Bonus Radiant Damage. 
		Patron's Blessing now can access the Greater Blessing. 
		Armor of Faith now prevents any potential injury, does apply to Inspire Faith"}
	},
	"Grappler": {
		"Wrestling Stance": {"rank": 1,"desc": "The User is able to access the Wrestling Stance. When in the Wrestling Stance, 
		the user gains a +2 bonus to any Grappling related rolls whether offensive or defensive in nature. Their round Recovery Rate 
		is increased by half their Physical Career Bonus, Rounded Up."},
		"Bonus Perk 1": {"rank": 2,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Grappler, may add a new perk from the General Perks List."},
		"Ground Game": {"rank": 3,"stamina_cost": 0,"desc": "The User, has improved their defensive reactions when forced to the ground. 
		When trying to break free of the Prone Stance when Pinned, the User can add their Physical Career Bonus to the roll. 
		On a Soft Critical, the User can turn the tables on their opponent and they become Pinned."},
		"Bonus Perk 2": {"rank": 4,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Grappler, may add a new perk from the General Perks List."},
		"Submission": {"rank": 5,"stamina_cost": 10,"action_cost": 4,"desc": "When the User has a target pinned and they have the Fatigued status, they can 
		attempt a submission. the User makes an opposed Grappling Check with their target, on a success the opponent takes 2d6 to their stamina. 
		on a Soft Critical the opponent takes 2d6 plus 10 to their stamina instead and the opponent is forced to move up to the next stage of 
		exhaustion. If the Opponent is Gassed Out prior to a Soft Critical, they become Passed Out. This only works on creatures of the same size 
		or smaller without the use of an object with enough length and integrity such as a rope or chains."},
		"Bonus Perk 3": {"rank": 6,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Grappler, may add a new perk from the General Perks List."},
		"Ground & Pound": {"rank": 7,"stamina_cost": 7,"action_cost": 4,"desc": "When the User has an Opponent that is grappled into a Prone 
		Stance, they press their advantage with a flurry of Fists. The User makes a number of attacks equal to their Physical Career Bonus. 
		For each successful hit, the target takes 1d4 +1 Bludgeoning Damage. On a Soft Critical the attack deals 1d6 + 2 Instead."},
		"Bonus Perk 4": {"rank": 8,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Grappler, may add a new perk from the General Perks List."},
		"Chokehold": {"rank": 9,"stamina_cost": 15,"action_cost": 4,"desc": "The User can make an opposed Grappling Check on an target that is Prone. 
		Upon a successful check, the Target takes 3d4 to their stamina and immediately moves to the Fatigued level. 
		On a Hard Critical, and if the Target is already Fatigued, they immediately Pass Out. 
		This only works on creatures of the same size or smaller without the use of an object with enough length or integrity such as a rope or chain."},
		"Master Grappler": {"rank": 10,"desc": "The Student has become the Master. The User's Grappler Perks are now Enhanced."},
	},
	"Gunsmith": {
		"Gunsmithing": {"rank": 1,"desc": "The User has gained a fair understanding of Blackpowder and it's many uses. 
		The User may now access to Gunsmithing"},
		"Rapid Reload": {"rank": 2,"desc": "The User has drastically improved in their reload efficiency. 
		When performing a reload check, if the User's roll is successful the reload uses a lower action cost 
		(i.e. a complex becomes standard, a standard becomes simple, and a simple becomes free). 
		If the User fails the roll, the gun simply doesn't jam and continues with normal action cost. "},
		"Bonus Perk 1": {"rank": 3,"desc": "The User, upon reaching Ranks 3, 6, 9 of Gunsmith, may add a new perk from the General Perks List."},
		"Quick Draw": {"rank": 4,"desc": "The User no longer needs any action cost to swap to or equip 1H Blackpowder Weapons. 
		If swapping to a rifle, the action becomes simple instead of standard"},
		"Diving Shot": {"rank": 5,"desc": "The User is capable of firing of rounds mid Dodge. 
		When using a reaction to dodge, the User can roll a Ranged Attack roll with a 1H Blackpowder Weapon with a -2 Penalty. 
		Regardless of the result, The User ends their dodge in the prone stance."},
		"Bonus Perk 2": {"rank": 6,"desc": "The User, upon reaching Ranks 3, 6, 9 of Gunsmith, may add a new perk from the General Perks List."},
		"Flash Powder": {"rank": 7,"desc": "The User learns to combine magnesium with their Blackpowder in order to create a blinding white 
		flash instead of piercing hot lead. The User can now craft Flash Munitions substituting Lead Balls used in Blackpowder Munitions for Flash Powder."},
		"Drakken's Breath": {"rank": 8,"desc": "The User learns to add steel wool and magnesium to their ammunition, creating the 
		equivalent of a Drakken's fiery breath. The User can now craft Drakken's Breath Munitions substituting Lead Balls used in 
		Blackpowder Munitions for Fire Mix."},
		"Bonus Perk 3": {"rank": 9,"desc": "The User, upon reaching Ranks 3, 6, 9 of Gunsmith, may add a new perk from the General Perks List."},
		"Master Gunsmith": {"rank": 10,"desc": ""},
	},
	"Magister": {
		"Quick Study": {"rank": 1,"desc": "The User has become quite experienced in their studies that even the unknown 
		feels familiar to them. when attempting to perform a skill check that they have no expertise in, they may add their 
		Mental Career Bonus to the result."},
		"Ritual Casting": {"rank": 1,"desc": "The User may now cast Ritual Spells (R). Ritual Spells are typically 
		non combat in nature and therefore require completion of specific rites to cast."},
		"Mental Fortitude": {"rank": 2,"desc": "The User has learned to shield their mind from the manipulation of others. 
		When Making a Mental Save, the User may add their Mental Career Bonus to Result. Additionally, The User may attempt to 
		reroll a failed Mental Save a number of times each day equal to half their career bonus rounded up."},
		"Bonus Perk 1": {"rank": 3,"desc": "The User, upon reaching Ranks 3, 6, and 9 of Magister, may add a new perk from the General Perk List."},
		"Quick Cast": {"rank": 4,"desc": "Their studies into the arcane and beyond has taught the User advanced casting techniques. 
		When casting Ritual (R) Spells, The User can forgo the required rites in combat as long as the can meet the required costs 
		or reserves and requires no crafting or sculpting"},
		"Aura of the Magi": {"rank": 5,"desc": "The User's understanding of the Arcane allows them to observe and manipulate the natural 
		ley lines that flow between all things. The User can channel this into different Auras"},
		"Bonus Perk 2": {"rank": 6,"desc": "The User, upon reaching Ranks 3, 6, and 9 of Magister, may add a new perk from the General Perk List."},
		"Arcane Senses": {"rank": 7,"desc": ""},
		"": {"rank": 8,"stamina_cost": 0,"desc": "The User's Arcane Research has taught them to peer beyond the surface and observe the 
		energies that emanate from within all things. The User can detect magical auras that come from enchanted objects or magical beings. 
		The User can also perform an Arcana Check, with the difficulty threshold set by the GM, to determine the nature of it's aura."},
		"Bonus Perk 3": {"rank": 9,"desc": "The User, upon reaching Ranks 3, 6, and 9 of Magister, may add a new perk from the General Perk List."},
		"Grand Magister": {"rank": 10,"desc": ""},
	},
	"Occultist": {
		"Dark Pact": {"rank": 1,"desc": "The User has made a deal with an Occult Being, be it demonic or ancient 
		in nature, and has received a boon with a cost. The User may select from the following Boons."},
		"Bonus Perk 1": {"rank": 2,"desc": "The User, upon reaching Ranks 2, 4, 6, and 8 of Occultist, may add a new perk from the General Perks List."},
		"Blood Sacrifice": {"rank": 3,"desc": "The User in their Study of the Occult has learned to Cast Sacrificial Spells (S)."},
		"Bonus Perk 2": {"rank": 4,"desc": "The User, upon reaching Ranks 2, 4, 6, and 8 of Occultist, may add a new perk from the General Perks List."},
		"Blood Sense": {"rank": 5,"health_reserve": 5,"action_cost": 4,"desc": "The User has learned to tracking other beings through the collection of 
		their Blood. Through a sacrifice of their own blood, and a sample of the target's blood, The User can sense the general direction 
		of their target as long as they are within a 2km range."},
		"Bonus Perk 3": {"rank": 6,"desc": "The User, upon reaching Ranks 2, 4, 6, and 8 of Occultist, may add a new perk from the General Perks List."},
		"Dark Aura": {"rank": 7,"desc": "The User has learned to harness power from the void. 
		The User may choose to unleash this in a Short Radius creating one of several effects."},
		"Bonus Perk 4": {"rank": 8,"desc": "The User, upon reaching Ranks 2, 4, 6, and 8 of Occultist, may add a new perk from the General Perks List."},
		"Inhumane Fortitude": {"rank": 9,"desc": "The User's research into the Occult has warped their body in unnatural ways. 
		The User has a +3 to any Medical Checks they might perform on themself. 
		The Recovery for Major Injuries is now Short instead of Long and Minor Injuries can recover after a Long Rest."},
		"Occultist Supreme": {"rank": 10,"desc": ""},
	},
	"Scoundrel": {
		"Misdirection": {"rank": 1,"desc": "The User's street smarts has made them very capable at tricking gullible saps with ease. 
		When attempting to strike a foe in melee, The User can attempt to feign a strike in order to expose them for their real strike. 
		The User makes a Skullduggery Check opposed by the targets Reflex Save. If they successfully overcome their Target's Reflex Save, 
		the Attack is a guaranteed Soft Critical Hit. Misdirection can be used a number of times each Combat equal to their 
		Martial Career Bonus"},
		"Bonus Perk 1": {"rank": 2,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Scoundrel, may add a new perk from the General Perks List."},
		"Cheap Shot": {"rank": 3,"desc": "The User's unsavory tactics lead them to resort to more devious measures then expected. 
		When the User secures a Soft Critical Hit on any attack, they add a number of d4 Dice equal to half their Martial Career Bonus, 
		rounded up, to the damage. This Effect can occur only once per Combat Round."},
		"Bonus Perk 2": {"rank": 4,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Scoundrel, may add a new perk from the General Perks List."},
		"Art of the Dodge": {"rank": 5,"desc": "The User's reflexes have greatly improved. 
		The User may add their Martial Career Bonus to the Result of any Dodge they perform. 
		Additionally, The User will only take half damage on a failed Dodge."},
		"Bonus Perk 3": {"rank": 6,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Scoundrel, may add a new perk from the General Perks List."},
		"Poison Craft": {"rank": 7,"desc": "The User has begun to experiment with more alchemical solutions to gain the upper hand. 
		The User has discovered how to craft unique poisons to enhance their strikes."},
		"Bonus Perk 4": {"rank": 8,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Scoundrel, may add a new perk from the General Perks List."},
		"Shadestalking": {"rank": 9,"desc": "The User has obtained a small amount of magical knowledge allowing them to melt into the shadows. 
		When the User is in a dimly lit or dark area, they can automatically succeed on a Hide Check. 
		Any attacks made from the shadows will add their Martial Career Bonus to the result and, 
		if successful, they are treated as a Soft Critical Hit."},
		"Master Thief": {"rank": 10,"desc": ""},
	},
	"Sellsword": {
		"Weapon Mastery": {"rank": 1,"stamina_cost": 0,"desc": ""},
		"Bonus Perk 1": {"rank": 2,"desc": "The User, upon reaching Ranks 2, 4, 6, 8, 10 of Sellsword, may add a new perk from the General Perks List."},
		"Jack of all Trades": {"rank": 3,"desc": "Expanding on their mastery of combat, the User can further grow their Expertise with 
		all martial forms as well as trades. The User gains additional mastery in weapons they haven't mastered. 
		For any weapon or tool the user has no Expertise or Weapon Mastery, they can add  half of their Martial Combat Bonus rounded up."},
		"Bonus Perk 2": {"rank": 4,"desc": "The User, upon reaching Ranks 2, 4, 6, 8, 10 of Sellsword, may add a new perk from the General Perks List."},
		"Greater Recovery": {"rank": 5,"stamina_cost": 0,"desc": "The User's ability to maintain composure in the tension of combat has 
		no equal. The User gains the doubled Recovery Rate of the Recovery Stance in all Stances. 
		Recovery Stance now has Tripled Recovery Rate."},
		"Bonus Perk 3": {"rank": 6,"desc": "The User, upon reaching Ranks 2, 4, 6, 8, 10 of Sellsword, may add a new perk from the General Perks List."},
		"Lead the Charge": {"rank": 7,"desc": "Always the first to rush the field, The User has great instinct on when a fight is about to 
		commence. The User adds their Martial Career Bonus to their Initiative and no longer able to be surprised by an Ambush."},
		"Bonus Perk 4": {"rank": 8,"desc": "The User, upon reaching Ranks 2, 4, 6, 8, 10 of Sellsword, may add a new perk from the General Perks List."},
		"Master of Arms": {"rank": 9,"desc": "The User has become incredibly effective in the field of combat. They have greatly improved their existing perks."},
		"Bonus Perk 5": {"rank": 10,"desc": "The User, upon reaching Ranks 2, 4, 6, 8, 10 of Sellsword, may add a new perk from the General Perks List."},
	},
	"Tinker": {
		"Tinkering": {"rank": 1,"desc": "The User has begun to learning the intricate trade of Tinkering."},
		"Innovation": {"rank": 2,"desc": "The User has a knack for sudden flashes of ingenuity. 
		When rolling Craft: Tinkering checks, if the User rolls a hard critical they can add one extra modification to the creation 
		with no extra cost."},
		"Bonus Perk 1": {"rank": 3,"desc": "The User may select a perk from the General Perk List."},
		"Nimble Hands": {"rank": 4,"desc": "The User excels at quick on the fly tinkering. 
		Craft: Basic Devices can now be created as a Standard Action at the cost of double the materials."},
		"Clockwork Pal": {"rank": 5,"desc": "The User has learned to imitate life itself through complex clockwork creation. 
		By combining a number of Tinker's kits, The User can create a Clockwork Imitation of a Beast of Medium size or smaller 
		that follows their commands."},
		"Bonus Perk 2": {"rank": 6,"desc": "The User may select a perk from the General Perk List."},
		"Dual Purpose": {"rank": 7,"desc": "The User learns to combine multiple inventions into a single invention. 
		the User can spend twice the required Tinker's Kits to combine two inventions into one, allowing them to fit 
		them in one location (i.e. Two Arms Slot Inventions in one). The Inventions still are activated separately."},
		"Mad Genius": {"rank": 8,"desc": "The User's Intellect has reached maddening levels. When rolling Craft: Tinkering, 
		the User can re-roll 1s and 2s once. If the roll still fails after re-rolling, they can still accomplish their craft 
		but with a Malfunction of the GM's choosing."},
		"Bonus Perk 3": {"rank": 9,"desc": "The User may select a perk from the General Perk List."},
		"Master Tinker": {"rank": 10,"desc": "The User has become a master of tinkering and has expanded their prior skills."},
	},
	"Warden": {
		"The Tower": {"rank": 1,"desc": "The User has received advanced training in Tower Shields. 
		Using a Tower Shield no longer has a penalty when attacking. Additionally, when using other shields, the User 
		gains a +1 to their Blocking Bonus."},
		"Bonus Perk 1": {"rank": 2,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Warden, may add a new perk from the General Perks List."},
		"Presence": {"rank": 3,"desc": "The User's mere existence on the field of battle can influence the outcome. 
		The User gains access to auras, called Presence, that can be swapped out as a Standard Action."},
		"Bonus Perk 2": {"rank": 4,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Warden, may add a new perk from the General Perks List."},
		"Armour Expertise": {"rank": 5,"desc": "The User's Proficiency in Armoured Combat has garnered them new expertise. 
		When equipped with Heavy Armour, the User can treat it as medium for weight purposes. When equipped with Medium or Light Armour, 
		The User treats it as Unarmoured for weight purposes."},
		"Bonus Perk 3": {"rank": 6,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Warden, may add a new perk from the General Perks List."},
		"Greater Presence": {"rank": 7,"desc": "The User's Presence has expanded it's reach. 
		Presence now affects creatures in a Medium Radius and they have access to new Presences."},
		"Bonus Perk 4": {"rank": 8,"desc": "The User, upon reaching Ranks 2, 4, 6, 8 of Warden, may add a new perk from the General Perks List."},
		"Intercept": {"rank": 9,"desc": "The User rushes to the aid of their allies no matter the peril. 
		when an ally within your base movement range is attacked, the user can spend their Reactive Action to move in front of their Ally 
		and take the blow head on with a Guard Roll."},
		"Master Warden": {"rank": 10,"desc": "The User is a master of the battlefield, and has improved many aspects of their Warden Perks."},
	},
}
