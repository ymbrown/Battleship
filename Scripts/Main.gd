extends Node2D

onready var targetsystem = $SaveSystem/TargetSystem
onready var shipsystem = $SaveSystem/ShipPlacement
onready var messagesystem = $SaveSystem/MessageMenu
onready var NewGame = $MainMenu
onready var BacktoMainMenu = $MainUI/BacktoMenu
onready var UI = $MainUI
var targetOn = false
var MessageOn = false

func _ready():
	UI.visible = false
	targetsystem.visible = false
	shipsystem.visible = false
	messagesystem.visible = false
	var shipslocked = $SaveSystem/ShipPlacement
	shipslocked.connect("saveShipPositions", self, "enablescreens")
	NewGame.connect("NewGame", self, "startGame")
	NewGame.connect("Back", self, "MainMenuBack")
	BacktoMainMenu.connect("pressed",self,"ShowMainMenu")
	messagesystem.connect("showTarget", self,"ShowTargetGrid")
	
func startGame():
	UI.visible = true
	shipsystem.visible = true
	NewGame.visible = false

func ShowTargetGrid():
	targetsystem.visible = true
	targetOn = true
	
func ShowMainMenu():
	NewGame.visible = true
	targetsystem.visible = false
	messagesystem.visible = false
	shipsystem.visible = false

func MainMenuBack():
	NewGame.visible = false
	shipsystem.visible = true
	if MessageOn:
		messagesystem.visible = true
	
	if targetOn:
		targetsystem.visible = true
	
func enablescreens(_section, _key, _shipplacement):
	messagesystem.visible = true
	MessageOn = true
	
