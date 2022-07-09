extends Node2D

var RestPoint_resource = preload("res://Nodes/DropZone.tscn")
var RestPoint

var GridSize = 36
var GridEdgeNum = 6
var RPt2RPtDist = 80
var FirstRPtDistFromCenter = -200

func _ready():
	# Find the local positon of the center of the grid sprite
	var StartPos = $grid.position + Vector2(FirstRPtDistFromCenter,FirstRPtDistFromCenter)
	var Pos = StartPos
	print(StartPos)
	print($grid.position)
	var counter = 0
	
	# Spawn DropZone points on grid in positions relative to grid center
	for i in GridSize:
		RestPoint = RestPoint_resource.instance()
		RestPoint.position = StartPos
		add_child(RestPoint)
		if counter < GridEdgeNum:
			Pos += Vector2(RPt2RPtDist,0)
			counter += 1
		else:
			Pos = Vector2(StartPos.x,Pos.y+RPt2RPtDist)
			counter = 0
	
