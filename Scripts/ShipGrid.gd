extends Node2D

var RestPoint_resource = preload("res://Nodes/DropZone.tscn")
var RestPoint

var GridSize = 36
var GridEdgeNum = 5
var RPt2RPtDist = 80
var FirstRPtDistFromCenter = -200

func _ready():
	SpawnDropZones()

func SpawnDropZones():
	# Find the local positon of the center of the grid sprite
	var StartPos = $grid.position + Vector2(FirstRPtDistFromCenter,FirstRPtDistFromCenter)
	var Pos = StartPos
	var counter = 0
	
	# Add First Drop Zone
	RestPoint = RestPoint_resource.instance()
	RestPoint.position = StartPos
	add_child(RestPoint)
	
	# Spawn DropZone points on grid in positions relative to grid center
	for i in GridSize - 1:
		RestPoint = RestPoint_resource.instance()
		if counter < GridEdgeNum:
			Pos += Vector2(RPt2RPtDist,0)
			counter += 1
		else:
			Pos = Vector2(StartPos.x,Pos.y+RPt2RPtDist)
			counter = 0
		RestPoint.position = Pos
		add_child(RestPoint)
	
