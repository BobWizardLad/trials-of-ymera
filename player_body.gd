extends CharacterBody2D
class_name PlayerBody

var beam_spine_asset: PackedScene = load("res://beam_spine.tscn")
var clone_asset: PackedScene = load("res://clone.tscn")

@onready var ABILITYTIMER: Timer = $AbilityTimer
@export var ability_delay: float = 7.00
@onready var PRIMARYTIMER: Timer = $PrimaryTimer
@export var primary_delay: float = 5.00

const SPEED: float = 300.0
var direction: Vector2 = Vector2.ZERO
var look_at: Vector2 = Vector2.ZERO
var beam: Line2D
var clone: Clone

func _process(delta:float):
	# When active attack, activate ability
	if Input.is_action_just_pressed("active_1") and PRIMARYTIMER.is_stopped():
		beam = beam_spine_asset.instantiate()
		beam.look_at(get_global_mouse_position())
		add_child(beam)
		if clone != null:
			clone.add_child(beam.duplicate())
		PRIMARYTIMER.start(primary_delay)
	
	# When mobility kit, activate ability
	if Input.is_action_just_pressed("active_2") and ABILITYTIMER.is_stopped():
		clone_spawn()
		ABILITYTIMER.start(ability_delay)

func _physics_process(delta: float) -> void:
	# Look at mouse
	look_at = get_global_mouse_position()
	transform = transform.looking_at(look_at)
	
	# Get axis input
	direction.x = Input.get_axis("player_left", "player_right")
	direction.y = Input.get_axis("player_up", "player_down")
	
	# Define player move direction normal vector
	direction = direction.normalized()
	velocity = direction * SPEED
	
	# Move and Slide and Reset
	move_and_slide()
	direction = Vector2.ZERO

func clone_spawn() -> void:
	clone = clone_asset.instantiate()
	clone.position = get_global_mouse_position()
	get_parent().add_child(clone)
