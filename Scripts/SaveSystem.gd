extends Node
var save_path = "user://boatplacement.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)
var positions = []
var targetvalues = []
var messages = []
var Ships
var Targets
func _ready():
	# clear previous contents of the config file
	config.clear()
	config.save(save_path)

	Ships = $ShipPlacement
	Ships.connect("saveShipPositions", self, "saveValues")
	
	var UpdateShips = $ShipPlacement/ShipUI/UpdateShips
	UpdateShips.connect("pressed", self, "DetermineHitShips")
	
	Targets = $TargetSystem
	Targets.connect("save", self, "saveValues")
	
	var UpdateTargets = $TargetSystem/TargetUI/UpdateTarget
	UpdateTargets.connect("pressed", self, "DetermineTargetState")

func DetermineHitShips():
	var hitpositions = []
	if Ships.ShipsLocked == true:
		hitpositions = loadValues(Ships.section, Ships.key)
		Ships.IndicateHitShips(hitpositions)
	else:
		return
	
func DetermineTargetState():
	var targetpositions = []
	if Targets.TargetReady == true:
		targetpositions = loadValues(Targets.section, Targets.key)
		Targets.Update(targetpositions)
	else:
		return

func saveValues(section, key, value):
	config.set_value(section, key, value)
	config.save(save_path)

func loadValues(section, key):
	var err = config.load(save_path)
	var value
	if err != OK:
		return
	value = config.get_value(section, key, value)
	return value
