extends Position2D

var locked = false
var targeted = 0
var xpositions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color.transparent


func _draw():
	var cen = Vector2.ZERO
	var rad = 30
	var col = Color.white
	draw_circle(cen, rad, col)

func _on_Area2D_input_event(_viewport, _event, _shape_idx):
	if targeted <= 1:
		if Input.is_action_just_pressed("left"):
			xpositions = get_tree().get_nodes_in_group("target")
			for child in xpositions:
				if child.targeted == 1:
					child.targeted = 0
					child.UpdateColor()
			modulate = Color.cornflower
			targeted = 1
		if Input.is_action_just_pressed("right"):
			modulate = Color.transparent
			targeted = 0

func UpdateColor():
	if targeted == 1:
		modulate = Color.cornflower
	elif targeted == 2:
		modulate = Color.gray
	elif targeted == 3:
		modulate = Color.red
	else:
		modulate = Color.transparent
