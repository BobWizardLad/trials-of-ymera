extends StaticBody2D

@onready var NAV_AGENT: NavigationAgent2D = $NavigationAgent2D

@export var speed: float = 5.0

var next_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NAV_AGENT.target_position = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if NAV_AGENT.target_position != Vector2.ZERO:
		if next_position == position:
			next_position = NAV_AGENT.get_next_path_position()
		else:
			position = Vector2(
				move_toward(position.x, next_position.x, speed), move_toward(position.y, next_position.y, speed))

func _move_to(target: Vector2):
	NAV_AGENT.target_position = target
	next_position = NAV_AGENT.get_next_path_position()
