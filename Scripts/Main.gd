extends Node2D

onready var targetsystem = $SaveSystem/TargetSystem
onready var shipsystem = $SaveSystem/ShipPlacement
onready var messagesystem = $SaveSystem/MessageMenu


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	targetsystem.visible = false
	messagesystem.visible = false
	var shipslocked = $SaveSystem/ShipPlacement
	shipslocked.connect("saveShipPositions", self, "enablescreens")
	
func enablescreens(_section, _key, _shipplacement):
	targetsystem.visible = true
	messagesystem.visible = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
