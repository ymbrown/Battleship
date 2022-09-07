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
onready var savesystem = $SaveSystem
onready var prevent = $Prevention

var block = false
var targetOn = false
var MessageOn = false
var reloadGame = false
var test
var PYTHONPATH = "/usr/bin/python3"
var RADIOPATH = ["/local_disk/code/BattleshipDemo/Backend/Transmitter/TX_main.py"]

func _ready():
	
	# set environment variables
	setENV()
	var output = []
	#OS.execute(PYTHONPATH, RADIOPATH, true, output)
	#print(output)
	# Hide everything but main menu
	prevent.visible = false
	UI.visible = false
	targetsystem.visible = false
	shipsystem.visible = false
	messagesystem.visible = false
	endgame.visible = false
	
	# Connect all needed signals
	shipsystem.connect("saveShipPositions", self, "enablescreens")
	shipsystem.connect("loseCondition", self, "LoseEvent")
	
	NewGame.connect("NewGame", self, "startGame")
	NewGame.connect("Back", self, "MainMenuBack")
	
	BacktoMainMenu.connect("pressed",self,"ShowMainMenu")
	
	messagesystem.connect("showTarget", self,"ShowTargetGrid")
	
	targetsystem.connect("winCondition", self, "WinEvent")
	targetsystem.connect("sendFile", self, "sendData")
	
	endgameButton.connect("pressed", self, "startGame")
	
	client.connect("serverMSG", self, "rxServerMsg")

# Shows start menu
func startGame():
	if !reloadGame:
		UI.visible = true
		shipsystem.visible = true
		NewGame.visible = false
		reloadGame = true
	else:
		test = get_tree().reload_current_scene()

# Enables Target system
func ShowTargetGrid():
	targetsystem.visible = true
	targetOn = true
	
# Go from game to main menu
func ShowMainMenu():
	NewGame.visible = true
	targetsystem.visible = false
	messagesystem.visible = false
	shipsystem.visible = false
	UI.visible = false

# From main menu back to game
func MainMenuBack():
	NewGame.visible = false
	shipsystem.visible = true
	UI.visible = true
	if MessageOn:
		messagesystem.visible = true
	
	if targetOn:
		targetsystem.visible = true
	
	if block:
		prevent.visible = true


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
	
func sendData():
	var content = savesystem.getConfigContents()
	client.sendMsg(content)

func rxServerMsg(msg):
	var output = []
	var part = msg.substr(0,4)
	if part == "USRP":
		savesystem.saveValues("Player", "state", "T")
		print("USRP start")
		OS.execute(PYTHONPATH, RADIOPATH, true, output)
		print(output)
	elif part == "JAM ":
		print("Jamming Started")
		savesystem.saveValues("Player", "state", "A")	
		OS.execute(PYTHONPATH, RADIOPATH, true, output)
		print(output)
	elif part == "[Pla":
		savesystem.OverWrite(msg)
		print("Got config Contents", msg)
		savesystem.DetermineHitShips()
		savesystem.DetermineTargetState()
	elif part == "Bloc":
		prevent.visible = true
		block = true
	elif part == "Unbl":
		savesystem.DetermineHitShips()
		savesystem.DetermineTargetState()
		prevent.visible = false
		block = false
	else:
		print(msg)

func setENV():
	OS.set_environment("LIBRARY_PATH","/local_disk/install/lib")
	OS.set_environment("LD_LIBRARY_PATH", "/local_disk/install/lib:/local_disk/install/lib64:/usr/local/lib:/usr/local/lib64:/usr/local/lib")
	OS.set_environment("GR_CONF_GRC_GLOBAL_BLOCKS_PATH", "/local_disk/install/share/gnuradio/grc/blocks")
	OS.set_environment("PYTHONPATH", "/local_disk/install/lib/python3/site-packages/:/local_disk/install/lib/python3/dist-packages/:/usr/local/lib/python3.8/dist-packages/:/local_disk/install/lib/python3.8/site-packages/")
