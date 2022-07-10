extends Control

onready var boatmessage1 = $CenterContainer/VBoxContainer/MessageSelect
onready var boatmessage2 = $CenterContainer/VBoxContainer/MessageSelect2
onready var boatmessage3 = $CenterContainer/VBoxContainer/MessageSelect3
onready var boatmessage4 = $CenterContainer/VBoxContainer/MessageSelect4
signal saveMessages
var section = "Messages"
var key = "msg"


var msg = []
var placements = []
var make_array = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_SetMessages_pressed():
	make_msg_array()


func make_msg_array():
	var boat_counter = [0,0,0,0]
	for number in placements:
		match number:
			2:
				msg.append(boatmessage4.get_msg_part(boat_counter[0]))
				boat_counter[0] = boat_counter[0] + 1
			3:
				msg.append(boatmessage3.get_msg_part(boat_counter[1]))
				boat_counter[1] = boat_counter[1] + 1
			4:
				msg.append(boatmessage2.get_msg_part(boat_counter[2]))
				boat_counter[2] = boat_counter[2] + 1
			6:
				msg.append(boatmessage1.get_msg_part(boat_counter[3]))
				boat_counter[3] = boat_counter[3] + 1
			_:
				msg.append(0)
	print(msg)
	emit_signal("saveMessages", section, key, msg)

func update_msg_array():
	pass
