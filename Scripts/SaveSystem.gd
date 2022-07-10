extends Node
var save_path = "user://boatplacement.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)
var positions = []
var xpositions = []
var targetvalues = []


signal UpdateGrid
signal UpdateTarget
var board = []

func _ready():
	pass

func saveShips(section, key, grid):
	config.set_value(section, key, grid)
	config.save(save_path)

func loadShips(section, key):
	var err = config.load(save_path)
	if err != OK:
		return
	positions = config.get_value(section, key, positions)
	emit_signal("UpdateGrid", positions)

func saveTargets(targetvalues):
		config.set_value("Positions", "Targets", targetvalues)
		config.save(save_path)
		
func loadTargets():
	var err = config.load(save_path)
	if err != OK:
		return
	targetvalues = config.get_value("Positions", "Targets", targetvalues)
	emit_signal("UpdateTarget", targetvalues)
	
func saveMessages(msg):
	config.set_value("Positions", "Messages", msg)
	config.save(save_path)
