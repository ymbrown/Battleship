extends Node2D

var targets = []
var targetvalues = []
var TargetReady = false
signal save
var section = "Positions"
var key = "Targets"
var enableUpdate

func _ready():
	targets = get_tree().get_nodes_in_group("target")
	var ReadyTarget = $TargetUI/SaveTarget
	ReadyTarget.connect("pressed", self, "saveTarget")
	for i in 36:
		targetvalues.append(0)

func saveTarget():
	var num = 0;
	var i = 0;
	for child in targets:
		if child.targeted == 1:
			num += 1
			if num > 1:
				return
		targetvalues[i] = child.targeted
		i += 1
	TargetReady = true
	emit_signal("save", section, key, targetvalues)
	
func Update(targetposition):
	targetvalues = targetposition
	var i  = 0;
	for child in targets:
		child.targeted = targetvalues[i]
		child.UpdateColor()
		i += 1
