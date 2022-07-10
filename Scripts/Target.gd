extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var locked = false
var selected = 0
var xpositions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color.transparent
	var updatetarget = get_tree().get_root().find_node("ReadytoTarget", true, false)
	updatetarget.connect("UpdateColor", self, "Update")


func _draw():
	var cen = Vector2.ZERO
	var rad = 30
	var col = Color.white
	draw_circle(cen, rad, col)

func _on_Area2D_input_event(_viewport, _event, _shape_idx):
	if selected <= 1:
		if Input.is_action_just_pressed("left"):
			xpositions = get_tree().get_nodes_in_group("targets")
			for child in xpositions:
				if child.selected == 1:
					child.selected = 0
					child.Update()
			modulate = Color.cornflower
			selected = 1
		if Input.is_action_just_pressed("right"):
			modulate = Color.transparent
			selected = 0

func Update():
	if selected == 1:
		modulate = Color.cornflower
	elif selected == 2:
		modulate = Color.gray
	elif selected == 3:
		modulate = Color.red
	else:
		modulate = Color.transparent
