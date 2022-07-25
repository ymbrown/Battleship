extends Node2D
var PlayerNum
signal NewGame
signal Back
var GameStarted = false

func _ready():
	PlayerNum = 1


func _on_BackButton_pressed():
	emit_signal("Back")


func _on_NewGame_pressed():
	emit_signal("NewGame")
	GameStarted = true
