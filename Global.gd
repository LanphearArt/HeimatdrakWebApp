# Global.gd (autoload)
extends Node

var character_creation_data: Dictionary = {}  # Empty by default
var character_data: Dictionary = {}

func clear_creation_data():
	character_creation_data = {}
