extends Area2D
var speed = 200
const EXPLOSION = preload("uid://dgq121db1ykfc")
const HEALTH_UP = preload("uid://cv4c6q8ed1gjw")

func _process(delta: float) -> void:
	translate(Vector2.LEFT * speed * delta)
	position.y += sin(position.x * delta) * 0.6

func _on_area_entered(area: Area2D) -> void:
	if  area.is_in_group("Projectile"):
		area.queue_free()
		explode()
		
func explode():
		var explosion = EXPLOSION.instantiate()
		get_parent().add_child(explosion)
		explosion.global_position = global_position
		queue_free()
		if randi_range(0,7) == 0:
			var healthup = HEALTH_UP.instantiate()
			get_parent().add_child(healthup)
			healthup.global_position = global_position
