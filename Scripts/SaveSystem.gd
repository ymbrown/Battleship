extends Node
var save_path = "user://boatplacement.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)
var positions = []
var targetvalues = []
var messages = []
var Ships
var Targets
var Player  = "A"
func _ready():
	# clear previous contents of the config file
	config.clear()
	config.save(save_path)

	saveValues("Player", "State", Player)
	
	Ships = $ShipPlacement
	Ships.connect("saveShipPositions", self, "saveShipPos")
	
	#var UpdateShips = $ShipPlacement/ShipUI/UpdateShips
	#UpdateShips.connect("pressed", self, "DetermineHitShips")
	
	var Messages = $MessageMenu
	Messages.connect("saveMessages", self, "saveValues")
	
	Targets = $TargetSystem
	Targets.connect("save", self, "saveValues")
	
	#var UpdateTargets = $TargetSystem/TargetUI/UpdateTarget
	#UpdateTargets.connect("pressed", self, "DetermineTargetState")

func saveShipPos(section, key, value):
	saveValues(section, key, value)
	$MessageMenu.placements = value
	$ShipPlacement/ShipUI/ReadyShips.disabled = true
	

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

func OverWrite(msg):
	var file = File.new()
	file.open(save_path, File.WRITE)
	file.store_string(msg)
	file.close()
	
func getConfigContents():
	var file = File.new()
	file.open(save_path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content
