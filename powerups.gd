extends Area2D

var speed = -20


func _on_area_entered(area):
	speed = 0
	$AnimationPlayer.play("collected")
	await $AnimationPlayer.animation_finished
	queue_free()
	area.levelup()
