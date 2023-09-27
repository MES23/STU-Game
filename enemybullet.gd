extends Area2D

var speed = 150

func start(pos):
	position = pos


func _process(delta):
	position.y += speed * delta


func _on_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
		area.explode()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
