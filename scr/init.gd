extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var dirt_tex = preload("res://tex/dirt.png")
	var tilesize = 16
	var tile_scale = 2
	
	var rows = 30
	var cols = 20
	
	var right_spawn = 0 - (rows / 2)
	var left_spawn = rows - (rows / 2)
	
	# Create a bunch of tileNodes
	for r in rows:
		for c in cols:
			var row = r - (rows / 2)
			var col = c - (cols / 2)
			var tileNode = Sprite2D.new()
			var position = Vector2(16 * tile_scale * col, 16 * tile_scale * row)
			
			tileNode.scale = Vector2(tile_scale, tile_scale)
			tileNode.set_position(position)
			tileNode.texture = dirt_tex
			tileNode.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			
			tileNode.add_child(RigidBody2D.new())
			tileNode.name = "Dirt" + str(c) + "-" + str(r)
			
			add_child(tileNode)
			
	print_tree()
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
