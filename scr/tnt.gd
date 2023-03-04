extends Node

var HEALTH = 3
var EMPTY = preload("res://tex/mined bg.png")
var rng = RandomNumberGenerator.new()

func explode():
	var collider = self.get_child(1)
	var coord = self.name.split("Dirt")[1].split("-")
	
	if collider == null:
		return
		
	collider.queue_free()
		
	var sprite = self.get_child(0)
		
	if sprite != null:
		sprite.texture = EMPTY
		sprite.z_index = -1
		
	# Find destroy all blocks in a circle
	const neighbors = [
		[-2, -1], [-2, 0], [-2, 1],
		[-1, -2], [-1, -1], [-1, 0], [-1, 1], [-1, 2],
		[0, -2], [0, -1], [0, 1], [0, 2],
		[1, -2], [1, -1], [1, 0], [1, 1], [1, 2],
		[2, -1], [2, 0], [2, 1]
	];
		
	for n in neighbors:
		var x = int(coord[0]) + n[0]
		var y = int(coord[1]) + n[1]
		var block = get_node("/root/Node2D/SubViewportContainer/SubViewport/Dirt" + str(x) + "-" + str(y))
		
		if block.get_child_count() < 2:
			continue
		
		var blk_collide = block.get_child(1)
		
		if blk_collide != null:
			if block.has_method("explode") and block.HEALTH > 0:
				print("Exploding block: Dirt" + str(x) + "-" + str(y))
				block.HEALTH = 0
				continue
			
			blk_collide.queue_free()
			
			var blk_sprite = block.get_child(0)
			
			if blk_sprite != null:
				blk_sprite.texture = EMPTY
				blk_sprite.z_index = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if HEALTH <= 0 and self.get_child_count() > 1:
		explode()
	pass
