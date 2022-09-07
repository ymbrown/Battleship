extends Node2D

var selected = false
var rest_point
var DropZones = []
var StartPointPos
var overlap = 0;
var At90 = false;
var turn = false;
var ShipLocked = false;
var PosName
var OnGrid = 0
var shortest_dist = 60
var mouse = false

func _ready():
	# Set Ship to starting position
	StartPointPos = $StartPoint.get_global_position()
	rest_point = StartPointPos
	DropZones = get_tree().get_nodes_in_group("zone")
	
func _on_Area2D_input_event(_viewport, _event, _shape_idx):
	if ShipLocked == false:
		if Input.is_action_just_pressed("left"):
			selected = true
		#if Input.is_action_just_pressed("right") and global_position.distance_to(StartPointPos) < 10:
			#turn = true
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)
	if mouse == true:
		if Input.is_action_just_pressed("keyr") and global_position.distance_to(StartPointPos) < 10:
			turn = true
	if turn:
		if At90 == false:
			rotate(PI/2)
			At90 = true
		else:
			rotate(-PI/2)
			At90 = false
		turn = false

func _input(event):
	if ShipLocked == false:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and not event.pressed:
				selected = false
				var counter =  0
				for child in DropZones:
					var distance = global_position.distance_to(child.global_position)
					var start_distance = global_position.distance_to(StartPointPos)
					if overlap == 0: 
						if distance < shortest_dist and distance < start_distance:
							rest_point = child.global_position
							PosName = child.get_index()
							OnGrid = 1
							return
						elif start_distance < shortest_dist:
							rest_point = StartPointPos
							OnGrid = 0
							return
						elif counter == 35:
							if start_distance < distance:
								rest_point = StartPointPos
								OnGrid = 0
								return
						counter += 1

func _on_Area2D_area_entered(area):
	if area.is_in_group("ship"):
		overlap = overlap + 1
	
func _on_Area2D_area_exited(area):
	if area.is_in_group("ship"):
		overlap = overlap - 1

func _on_Area2D_mouse_entered():
	mouse = true


func _on_Area2D_mouse_exited():
	mouse = false
