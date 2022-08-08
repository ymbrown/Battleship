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
			dropdown.add_item("This  is the aircarft message", 0)
			dropdown.add_item("This will be the second aircraft message", 1)
			dropdown.add_item("aircarft message three", 2)
			num_tiles = 5
		"Cruiser": #4
			dropdown.add_item("This is the first cruiser message", 0)
			dropdown.add_item("message number two for cruiser", 1)
			dropdown.add_item("and cruiser message three", 2)
			num_tiles = 3
		"Submarine": #3
			dropdown.add_item("First submarine message", 0)
			dropdown.add_item("sub message two", 1)
			dropdown.add_item("submarine message three", 2)
			num_tiles = 2
		"Destroyer": #2
			dropdown.add_item("Mayday Mayday", 0)
			dropdown.add_item("Word Two", 1)
			dropdown.add_item("Send Help", 2)
			num_tiles = 1
	
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
	
