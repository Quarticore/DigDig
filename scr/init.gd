extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	const dirt_script = preload("res://scr/block.gd")
	const tnt_script = preload("res://scr/tnt.gd")
	const dirt_tex = preload("res://tex/dirt.png")
	const grass_tex = preload("res://tex/grassblock.png")
	const tuft1 = preload("res://tex/blades.png")
	const tuft2 = preload("res://tex/blades2.png")
	const tnt_tex = preload("res://tex/tnt.png")
	
	const tilesize = 16
	const tile_scale = 2
	
	const rows = 40
	const cols = 80
	
	var world = $SubViewportContainer/SubViewport
	
	# Draw some grass tufts
	for c in cols:
		var row = -(rows / 2) - 1
		var col = c - (cols / 2)
		var num = rng.randi_range(0, 3)
		
		# Create a sprite node
		var draw = false
		var sprite = Sprite2D.new()
		
		if num == 1:
			sprite.texture = tuft1
			draw = true
			
		if num == 3:
			sprite.texture = tuft2
			draw = true
			
		if draw:
			sprite.position = Vector2(16 * tile_scale * col, 16 * tile_scale * row)
			sprite.scale = Vector2(tile_scale, tile_scale)
			sprite.z_index = -1
			sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			world.add_child(sprite)
		
	
	# Create a bunch of tileNodes
	for r in rows:
		for c in cols:
			var row = r - (rows / 2)
			var col = c - (cols / 2)
			# 1/75 chance to spawn TNT
			var spawn_tnt = rng.randi_range(0, 75)

			var tileNode = RigidBody2D.new()
			var tileSprite = Sprite2D.new()
			var position = Vector2(16 * tile_scale * col, 16 * tile_scale * row)

			tileNode.set_position(position)

			tileSprite.scale = Vector2(tile_scale, tile_scale)
			
			if r == 0:
				tileSprite.texture = grass_tex
			else:
				tileSprite.texture = dirt_tex
				
			if spawn_tnt == 1 and r > 1:
				tileSprite.texture = tnt_tex
				tileNode.set_script(tnt_script)
			
			tileSprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

			tileNode.add_child(tileSprite)
			tileNode.name = "Dirt" + str(c) + "-" + str(r)

			tileNode.gravity_scale = 0
			tileNode.freeze = true

			var tileCol = CollisionShape2D.new()
			var tileRect = RectangleShape2D.new()

			tileRect.size = Vector2(32, 32)
			tileCol.shape = tileRect

			if tileNode.get_script() == null:
				tileNode.set_script(dirt_script)
			
			tileNode.add_child(tileCol)

			world.add_child(tileNode)
	
	print("Genertion finished!")
	
	get_node("SubViewportContainer2/SubViewport").world_2d = get_node("SubViewportContainer/SubViewport").world_2d
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
