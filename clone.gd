extends Area2D
class_name Clone

var beam_spine_asset: PackedScene = load("res://beam_spine.tscn")

@onready var CLONETIMER: Timer = $CloneTimer
@export var clone_duration: float = 4.00

var beam: Line2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("PEW!")

func _on_clone_timer_timeout() -> void:
	queue_free()
