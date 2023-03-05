extends Node

# ignore this pls
var HEALTH = 99
var IS_LAVA = true

func kill(player):
	player.DEAD = true
	
	var top_win = get_node("/root/Node2D/TopWin")
	var bottom_win = get_node("/root/Node2D/BottomWin")
	
	if player.name == "RightPlayer":
		top_win.visible = true
	else:
		bottom_win.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
