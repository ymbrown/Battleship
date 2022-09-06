extends HBoxContainer

onready var label = get_node("Label")
onready var dropdown = get_node("OptionButton")
export(String, "Aircraft Carrier", "Cruiser", "Submarine", "Destroyer") var boatname
var num_tiles = 1;
var text_arry = [];


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = boatname
	add_items()
		

func add_items():
	match boatname:
		"Aircraft Carrier": #6
			dropdown.add_item("November One Two Three Four Golf", 0)
			dropdown.add_item("After departure, climb straight ahead London 2 DME", 1)
			dropdown.add_item("Cleared to land runway", 2)
			num_tiles = 6
		"Cruiser": #4
			dropdown.add_item("Mayday Mayday Mayday", 0)
			dropdown.add_item("Manned and Ready", 1)
			dropdown.add_item("Stand Easy", 2)
			num_tiles = 4
		"Submarine": #3
			dropdown.add_item("Set depth at one two feet", 0)
			dropdown.add_item("Carry on", 1)
			dropdown.add_item("Man your stations", 2)
			num_tiles = 3
		"Destroyer": #2
			dropdown.add_item("All clear", 0)
			dropdown.add_item("SOS", 1)
			dropdown.add_item("Stations", 2)
			num_tiles = 2
	
func get_msg_part(num):
	var msg = dropdown.get_item_text(dropdown.get_selected_id())
	var msglen = len(msg)
	var split = msglen / num_tiles
	var a
	var indx_start = split*num
	if num < num_tiles - 1:
		a = msg.substr(indx_start, split)
	else:
		a = msg.substr(indx_start, msglen - 1)
	return a

func disable_options():
	var value = dropdown.get_selected_id()
	for i in [0, 1, 2]:
		if i != value:
			dropdown.set_item_disabled(i, true)
	
