extends Node

var HEALTH = 3
var EMPTY = preload("res://tex/mined bg.png")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if HEALTH <= 0 && self.get_child_count() > 1:
		var collider = self.get_child(1)
		var coord = self.name.split("Dirt")[1].split("-")
		
		# Find destroy all blocks in a circle
		const neighbors = [
			[-2, -1], [-2, 0], [-2, 1],
			[-1, -2], [-1, -1], [-1, 0], [-1, 1], [-1, 2],
			[0, -2], [0, -1], [0, 0], [0, 1], [0, 2],
			[1, -2], [1, -1], [1, 0], [1, 1], [1, 2],
			[2, -1], [2, 0], [2, 1]
		];
		
		for n in neighbors:
			var x = int(coord[0]) + n[0]
			var y = int(coord[1]) + n[1]
			var block = get_node("/root/Node2D/SubViewportContainer/SubViewport/Dirt" + str(x) + "-" + str(y))
			var blk_collide = block.get_child(1)
		
			if blk_collide != null:
				blk_collide.queue_free()
			
			var sprite = block.get_child(0)
			
			if sprite != null:
				sprite.texture = EMPTY
				sprite.z_index = -1
		
		if collider != null:
			collider.queue_free()
		
		var sprite = self.get_child(0)
		
		if sprite != null:
			sprite.texture = EMPTY
			sprite.z_index = -1
		
	pass
