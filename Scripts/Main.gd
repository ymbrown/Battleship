extends Node2D

onready var targetsystem = $SaveSystem/TargetSystem
onready var shipsystem = $SaveSystem/ShipPlacement
onready var messagesystem = $SaveSystem/MessageMenu
onready var NewGame = $MainMenu
onready var BacktoMainMenu = $MainUI/BacktoMenu
onready var UI = $MainUI
onready var endgameButton = $EndGame/EndGameNewGame
onready var endgame = $EndGame
onready var client = $ClientHandler

var targetOn = false
var MessageOn = false
var reloadGame = false
var test

func _ready():
	setENV()
	UI.visible = false
	targetsystem.visible = false
	shipsystem.visible = false
	messagesystem.visible = false
	endgame.visible = false
	shipsystem.connect("saveShipPositions", self, "enablescreens")
	NewGame.connect("NewGame", self, "startGame")
	NewGame.connect("Back", self, "MainMenuBack")
	BacktoMainMenu.connect("pressed",self,"ShowMainMenu")
	messagesystem.connect("showTarget", self,"ShowTargetGrid")
	targetsystem.connect("winCondition", self, "WinEvent")
	shipsystem.connect("loseCondition", self, "LoseEvent")
	endgameButton.connect("pressed", self, "startGame")
	client.connect("serverMSG", self, "rxServerMsg")
	
func setENV():
	pass
	
func startGame():
	if !reloadGame:
		UI.visible = true
		shipsystem.visible = true
		NewGame.visible = false
		reloadGame = true
	else:
		test = get_tree().reload_current_scene()

func ShowTargetGrid():
	targetsystem.visible = true
	targetOn = true
	
func ShowMainMenu():
	NewGame.visible = true
	targetsystem.visible = false
	messagesystem.visible = false
	shipsystem.visible = false
	UI.visible = false

func MainMenuBack():
	NewGame.visible = false
	shipsystem.visible = true
	UI.visible = false
	if MessageOn:
		messagesystem.visible = true
	
	if targetOn:
		targetsystem.visible = true
	
func enablescreens(_section, _key, _shipplacement):
	messagesystem.visible = true
	MessageOn = true
	
func WinEvent():
	endgame.visible = true
	UI.visible = false
	targetsystem.visible = false
	shipsystem.visible = false
	messagesystem.visible = false
	endgame.won = true
	endgame.ShowEndGameScreen()

func LoseEvent():
	endgame.visible = true
	UI.visible = false
	targetsystem.visible = false
	shipsystem.visible = false
	messagesystem.visible = false
	endgame.lost = true
	endgame.ShowEndGameScreen()
	
func rxServerMsg(msg):
	var part = msg.substr(0,4)
	if part == "USRP":
		pass
		#OS.execute("pythonpath", ["filepath"], false)
		print("USRP start")
	elif part == "[Pla":
		$SaveSystem.OverWrite(msg)
		print(msg)
