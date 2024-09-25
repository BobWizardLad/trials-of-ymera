extends Line2D

@onready var LIFESPAN: Timer = $Lifespan
@export var lifespan_duration: float = 4.00

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LIFESPAN.start(lifespan_duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Adjust length to mouse pos
	for each in range(0, points.size()):
		points[each] = each * get_local_mouse_position() * 1.1

func _on_lifespan_timeout() -> void:
	queue_free()
