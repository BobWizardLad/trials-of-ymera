extends CharacterBody2D
class_name PlayerBody

var beam_spine_asset: PackedScene = load("res://beam_spine.tscn")

const SPEED: float = 300.0
var direction: Vector2 = Vector2.ZERO
var look_at: Vector2 = Vector2.ZERO
var is_clone: bool = false

var clones: Array[PlayerBody] = []

func _process(delta:float):
	# When active attack, activate ability
	if Input.is_action_just_pressed("active_1"):
		pass
	
	# When mobility kit, activate ability
	if Input.is_action_just_pressed("active_2"):
		var clone = self.duplicate()
		clone.position = get_global_mouse_position()
		get_parent().add_child(clone)
		clone.is_clone = true
		clones.append(clone)

func _physics_process(delta: float) -> void:
	# Look at mouse
	look_at = get_global_mouse_position()
	transform = transform.looking_at(look_at)
	
	if not is_clone:
		# Get axis input
		direction.x = Input.get_axis("player_left", "player_right")
		direction.y = Input.get_axis("player_up", "player_down")
		
		# Define player move direction normal vector
		direction = direction.normalized()
		velocity = direction * SPEED
		
		# Move and Slide and Reset
		move_and_slide()
		direction = Vector2.ZERO
