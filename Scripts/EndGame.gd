extends Control

onready var winLabel = $Win
onready var loseLabel = $Lose
var lost = false
var won  = false

func ShowEndGameScreen():
	if lost:
		loseLabel.visible = true
	elif won:
		winLabel.visible = true
