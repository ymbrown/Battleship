extends Node2D

var RestPoint_resource = preload("res://Nodes/DropZone.tscn")
var Hit_resource = preload("res://Nodes/ShipX.tscn")
var Inst
var ShipLocked = false

var GridSize = 36
var GridEdgeNum = 5
var MidPt2PtDist = 80
var FirstPtDistFromGridCenter = -200

func _ready():
	SpawnGridInstance(Hit_resource)
	SpawnGridInstance(RestPoint_resource)
	

func SpawnGridInstance(resource):
	# Find the local positon of the center of the grid sprite
	var StartPos = $grid.position + Vector2(FirstPtDistFromGridCenter,FirstPtDistFromGridCenter)
	var Pos = StartPos
	var counter = 0
	
	# Add First Drop Zone
	Inst = resource.instance()
	Inst.position = StartPos
	add_child(Inst)
	
	# Spawn DropZone points on grid in positions relative to grid center
	for i in GridSize - 1:
		Inst = resource.instance()
		if counter < GridEdgeNum:
			Pos += Vector2(MidPt2PtDist,0)
			counter += 1
		else:
			Pos = Vector2(StartPos.x,Pos.y+MidPt2PtDist)
			counter = 0
		Inst.position = Pos
		add_child(Inst)
	
