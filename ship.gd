extends Area2D

signal dead
signal leveledup

var speed = 150
var cooldown = 0.25
var can_shoot = true
var exploding = false
@export var bullet_scence : PackedScene

@onready var screensize = get_viewport_rect().size

func _ready():
	hide()
	$Guncooldown.wait_time = cooldown

func start():
	exploding = false
	position = Vector2(screensize.x / 2, screensize.y - 64)
	speed = 150
	show()

func _process(delta):
	if exploding:
		return
	
	if Input.is_action_pressed("shoot"):
		shoot()
	var input = Input.get_vector("left", "right", "up", "down")
	if input.x > 0:
		$AnimationPlayer.play("right")
	elif input.x < 0:
		$AnimationPlayer.play("left")
	else: 
		$AnimationPlayer.play("normal")
	
	position += input * speed * delta
	position = position.clamp(Vector2(8,7), screensize - Vector2(8,7))

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$Guncooldown.start()
	var new_bullet = bullet_scence.instantiate()
	get_tree().root.add_child(new_bullet)
	new_bullet.start(position + Vector2(0, -10))

func _on_guncooldown_timeout():
	can_shoot = true

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.explode()
		explode()

func explode():
	exploding = true
	$AnimationPlayer.play("explode")
	set_deferred ("monitorable", false)
	await $AnimationPlayer.animation_finished
	hide()
	dead.emit()


func levelup():
	speed += 50
	leveledup.emit()
