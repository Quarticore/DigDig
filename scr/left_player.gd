extends Node

const JUMP_FORCE = 350
const DIG_COOLDOWN = 100

var SIDE_MAX = 6
var SIDE_CUR = 0

var LAST_DIG = Time.get_unix_time_from_system()
var ANIM = "default"
var DIGGING = false
var RAYCAST = null
var LAST_MOVED_SIDE = Time.get_unix_time_from_system()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(s):
	var cur_time = Time.get_unix_time_from_system()
	var sprite = get_node("LeftSprite")
	var right_cast_high = get_node("RightCastHigh")
	var right_cast_low = get_node("RightCastLow")
	var left_cast_high = get_node("LeftCastHigh")
	var left_cast_low = get_node("LeftCastLow")
	var lv = s.get_linear_velocity()
	var t = s.get_transform()

	# Left/right controlling
	if cur_time >= LAST_MOVED_SIDE + 0.2:
		if !right_cast_high.is_colliding() and !right_cast_low.is_colliding() and Input.is_action_pressed("move_right_2", true) and SIDE_CUR < SIDE_MAX:
			t.origin.x += 32
			s.set_transform(t)
			sprite.set_flip_h(false)
				
			LAST_MOVED_SIDE = cur_time
			SIDE_CUR += 1

		if !left_cast_high.is_colliding() and !left_cast_low.is_colliding() and Input.is_action_pressed("move_left_2", true) and SIDE_CUR > -SIDE_MAX:
			t.origin.x -= 32
			s.set_transform(t)
			sprite.set_flip_h(true)
				
			LAST_MOVED_SIDE = cur_time
			SIDE_CUR -= 1
	
	if lv.y == 0 and Input.is_action_pressed("move_up_2", true):
		lv.y -= 350
		
	if lv.y != 0 and Input.is_action_pressed("move_down_2", true):
		# Activate drilling mode
		ANIM = "digging"
		DIGGING = true
		
	if !Input.is_action_pressed("move_down_2", true):
		ANIM = "default"
		DIGGING = false
		
	if DIGGING:
		var raycast = get_node("FloorCast")
		
		if cur_time >= LAST_DIG + 0.2 and raycast.is_colliding():
			LAST_DIG = cur_time
			
			lv.y = -150
			var block = raycast.get_collider()
			
			block.HEALTH -= 1
			
	# Side digging
	if !DIGGING and (right_cast_high.is_colliding() or right_cast_low.is_colliding()) and Input.is_action_pressed("move_right_2", true):
		# Set anim
		ANIM = "dig_side"
		sprite.set_flip_h(false)
		
		var high_cast = right_cast_high
		var low_cast = right_cast_low
		var did_dig = false
		
		if cur_time >= LAST_DIG + 0.2 and high_cast.is_colliding():
			var block = high_cast.get_collider()
			
			block.HEALTH -= 1
			did_dig = true
			
		if cur_time >= LAST_DIG + 0.2 and low_cast.is_colliding():
			var block = low_cast.get_collider()
			block.HEALTH -= 1
			did_dig = true
			
		if did_dig:
			LAST_DIG = cur_time
		
	if !DIGGING and (left_cast_high.is_colliding() or left_cast_low.is_colliding()) and Input.is_action_pressed("move_left_2", true):
		# Set anim
		ANIM = "dig_side"
		sprite.set_flip_h(true)
		
		var high_cast = left_cast_high
		var low_cast = left_cast_low
		var did_dig = false
		
		if cur_time >= LAST_DIG + 0.2 and high_cast.is_colliding():
			var block = high_cast.get_collider()
			
			block.HEALTH -= 1
			did_dig = true
			
		if cur_time >= LAST_DIG + 0.2 and low_cast.is_colliding():
			var block = low_cast.get_collider()
			
			block.HEALTH -= 1
			did_dig = true
			
		if did_dig:
			LAST_DIG = cur_time
		
	s.set_linear_velocity(lv)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sprite = get_node("LeftSprite")
	var raycast = get_node("FloorCast")
	var block = raycast.get_collider()
	
	if block and block.has_method("kill"):
		block.kill(self)
	
	if ANIM != sprite.animation:
		sprite.animation = ANIM
	pass
