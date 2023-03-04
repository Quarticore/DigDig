extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	const dirt_script = preload("res://scr/block.gd")
	const dirt_tex = preload("res://tex/dirt.png")
	const tilesize = 16
	const tile_scale = 2
	
	const rows = 40
	const cols = 80
	
	var world = $SubViewportContainer/SubViewport
	
	# Create a bunch of tileNodes
	for r in rows:
		for c in cols:
			var row = r - (rows / 2)
			var col = c - (cols / 2)

			var tileNode = RigidBody2D.new()
			var tileSprite = Sprite2D.new()
			var position = Vector2(16 * tile_scale * col, 16 * tile_scale * row)

			tileNode.set_position(position)

			tileSprite.scale = Vector2(tile_scale, tile_scale)
			tileSprite.texture = dirt_tex
			tileSprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

			tileNode.add_child(tileSprite)
			tileNode.name = "Dirt" + str(c) + "-" + str(r)

			tileNode.gravity_scale = 0
			tileNode.freeze = true

			var tileCol = CollisionShape2D.new()
			var tileRect = RectangleShape2D.new()

			tileRect.size = Vector2(32, 32)
			tileCol.shape = tileRect

			tileNode.set_script(dirt_script)
			tileNode.add_child(tileCol)

			world.add_child(tileNode)
	print("Genertion finished!")
	
	get_node("SubViewportContainer2/SubViewport").world_2d = get_node("SubViewportContainer/SubViewport").world_2d
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
