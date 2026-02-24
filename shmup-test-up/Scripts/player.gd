extends CharacterBody2D

@export var health = 5
@export var speed = 100
const PROJECTILE = preload("uid://bovg4ligwys5a")
@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar

func _ready():
	progress_bar.max_value = health
	progress_bar.value = health
	
func _process(delta: float) -> void:
	var move = Input.get_vector("left","right","up","down")
	if move:
		velocity = move * speed
	else: 
		velocity = Vector2.ZERO
	move_and_slide()

	if Input.is_action_just_pressed("shoot"):
		var new_projectile = PROJECTILE.instantiate()
		get_parent().add_child(new_projectile)
		new_projectile.global_position = global_position


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		health -= 1
		area.explode()
		progress_bar.value = health
		if health <= 0:
			get_tree().reload_current_scene()
			
	if area.is_in_group("healthup"):
		health += 1
		area.queue_free()
		if health > progress_bar.max_value:
			health = progress_bar.max_value
		progress_bar.value = health
			#get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
