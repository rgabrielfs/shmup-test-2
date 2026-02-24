extends Area2D

var speed = 700

func _process(delta: float) -> void:
	translate(Vector2.RIGHT * speed * delta)
