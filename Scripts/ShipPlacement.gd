extends Node2D

var ShipNum = 4
var AircraftNum = 6
var CruiserNum = 4
var SubmarineNum = 3
var DestroyerNum = 2
var GridTotal = 36
var GridRowLength = 6
signal loseCondition

# Variables Related to Saving the Values
var ShipHitIndicators = []
var section = "Positions"
var key = "Ships"
var shipplacement = []
var ShipsLocked = false
signal saveShipPositions
# Called when the node enters the scene tree for the first time.
func _ready():
	ShipHitIndicators = get_tree().get_nodes_in_group("ShipHitIndicator")
	var ReadyShips = $ShipUI/ReadyShips
	ReadyShips.connect("button_down", self, "CheckPlacement")
	var LockShips = $ShipUI/LockShips
	LockShips.connect("confirmed", self, "DetermineShipPositions")
	

func CheckPlacement():
	var total = $AircraftCarrier.OnGrid + $Cruiser.OnGrid + $Submarine.OnGrid + $Destroyer.OnGrid
	if total == ShipNum:
		$ShipUI/LockShips.visible = true
	else:
		$ShipUI/InvalidShipPopup.visible = true

func DetermineShipPositions():
	ShipsLocked = true
	var offset = $ShipGrid.get_child_count() - GridTotal
	print(offset)
	var ships = get_tree().get_nodes_in_group("gridship")
	var index
	var grididx
	var rotated
	var count = 0
	var boat_num = [AircraftNum,CruiserNum,SubmarineNum,DestroyerNum]
	var boat_counter = 0
	var bindex

	for k in 36:
		shipplacement.append(0)
	
	# Lock Ship into Position and Determine Position of Ships on Grid
	for aShip in ships:
		aShip.ShipLocked = true
		index = aShip.PosName
		rotated = aShip.At90
		bindex = boat_num[boat_counter]
		count = 0
		if rotated:
			for i in bindex:
				grididx = index-offset+count*GridRowLength
				shipplacement[grididx] = bindex
				count = count + 1
		else:
			for i in bindex:
				grididx = index-offset+count
				shipplacement[grididx] = bindex
				count = count + 1
		boat_counter = boat_counter + 1

	print(shipplacement)
	emit_signal("saveShipPositions", section, key, shipplacement)

func IndicateHitShips(ShipHitPositions):
	var num = len(ShipHitPositions)
	var lose_counter = 0;
	if num == 36:
		for i in num:
			if ShipHitPositions[i] > 50:
				ShipHitIndicators[i].putX()
				lose_counter += 1
		print("Updated Ship Hit Indicators")
	else:
		return
	if lose_counter >= 15:
		emit_signal("loseCondition")
