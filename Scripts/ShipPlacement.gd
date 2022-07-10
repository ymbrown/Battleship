extends Node2D
var ShipNum = 4
var AircraftNum = 6
var CruiserNum = 4
var SubmarineNum = 3
var DestroyerNum = 2
var GridTotal = 36
var GridRowLength = 6

var shipplacement = []
# Called when the node enters the scene tree for the first time.
func _ready():
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
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
